# script-collection
Collection of small, self-written scripts

---
### Content

1. [Bash](#bash)
	+ [imgbackup](#imgbackup)

---

### bash

##### imgbackup
Copys files from directorys with sub-directorys into a separate directory. Changes the filename to the md5-hash of the file. Sets the last-modified-date of the copy to the last-modified-date of the original. Can be used for all filetypes, I used it for pictures.
###### motivation
Multiple directorys with sub-directorys and no defined depth containing pictures. These pictures should be copyed to one directory, no picture should appear twice, pictures don't need to be stored redundant. I like to have the last-modified-date from the original on the copy to sort them by date.

###### usage

```sh
$ sh bash/imgbackup.sh <input dir> <output dir>
```
###### example
Let's assume I have a directory _old-photos_ with multiple sub-directorys and pictures like:
* old-photos
    + picture01.png [md5: 5f4d...]
    - subdir01
        + picture011.png [md5: cc3b...]
        + picture01 0.png [md5: 5aa7...] (yes with whitespace)
        - subdir011
            + picture0111.png [md5: 65d6...]
    - subdir01
        + picture021.png [md5: 1d83...]

```sh
$ sh bash/imgbackup.sh old-photos backup-photos
```

* backup-photos
    + 5f4d[...].png  
    + cc3b[...].png
    + 5aa7[...].png
    + 65d6[...].png
    + 1d83[...].png
