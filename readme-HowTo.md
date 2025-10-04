---
defaults: github-markdown
toc: false
---
<!-- *********************************************************************** -->
# HowTo: Remastering with archive and container files
- matrixxx has two remastering file types
    1. 'update' archives (update_\*.tar.gz  update_\*.taz update_\*.zip)
       which can be overlayed over '/' (root)
        - shortly before the system init call of the initramfs
    2. a squasfs image file which will be included in the union fs
- generation of both forms are made possible by this scripts

### File structure:
- the scripts expect a specific file structure
```
├── LIST_*                                  - general 'LIST' directory
│   ├── A0-get_dir_list.sh                  - script for creating the 'dir' auxiliary file *)
│   ├── dir                                 - contains all directory names (and symbolic links)
│   │                                         contained in the List_* directory
│   │                                         (after script call)
│   ├── list                                - contains an array 'DIR_LIST' containing the directories
│   │                                         to be processed [*) auxiliary file -> for filling the array]
│   └── lxpanel_corrected                   - a sample directory
│       └── rootfs.tar.gz                     - With the associated rootfs.tar.gz archive
└── LIST_99                                 - special 'LIST' directory (99 is only an example)
    ├── A0-get_dir_list.sh
    ├── A1-get_deb_files.sh                 - script for copying *.deb files
    │                                         from the /var/cache/apt/archives directory
    ├── archives -> /var/cache/apt/archives - symbolic link to /var/cache/apt/archives
    ├── dir
    └── list
```

### Script structure:
```
├── 01-generate_single_archives.sh          - creates a separate archive file from each selected
│                                             subdirectory
├── 02-generate_common_archives.sh          - creates an archive file from all selected subdirectories
├── 03-mk-squashfs-image.sh                 - creates a squasFS image file from all selected
│                                             subdirectories
├── A1-script-targz2dir.sh                  - creates a rootfs directory in all selected subdirectories
│                                             with the contents of the rootfs.tar.gz archive contained
│                                             therein
├── A2-script-dir2targz.sh                  - creates a new rootfs.tar.gz archive from the
│                                             rootfs directory in all selected subdirectories
│                                             - rootfs directory is then deleted
├── A3-script-deb2targz.sh                  - creates a rootfs.tar.gz file from all *.deb files
│                                             contained in a subdirectory
│                                             (see special 'LIST' Directory)
├── init--process-control                   - configuration file
└── lib
    ├── func_get-dir-list                   - functions for creating a auxiliary file *)
    ├── func_mk-squasfs-image-handling      - function for creating a squasFS image file
    └── func_update-archive-handling        - functions for handling the file structure and creating
                                              'update_' archives
```

### Selection for processing
- Selecting the 'LIST' directories to be processed:
  - In the configuration file **init--process-control**, the 'LIST' directories
    are selected for the respective processes by entering them in the
    corresponding arrays 'LIST_DIR_NO_ARRAY'
    (only the postfix - and all characters are allowed, not just numbers).

| Possible processes:   | Associated script:             |
| --------------------- | ---------------------------    |
| SINGLE_ARCHIVE        | 01-generate_single_archives.sh |
| COMMON_ARCHIVE        | 02-generate_common_archives.sh |
| COMMON_CONTAINER      | 03-mk-squashfs-image.sh        |
| TARGZ_to_DIR          | A1-script-targz2dir.sh         |
| DIR_to_TARGZ          | A2-script-dir2targz.sh         |
| DEB_to_TARGZ          | A3-script-deb2targz.sh         |

- Selecting the subdirectories to be processed:
  - In the 'list' file of a 'LIST' directory, all subdirectories contained
    therein that are to be processed must be entered into the corresponding
    'DIR_LIST' array.

********************************************************************************
> [!WARNING]
> **DISCLAIMER:** THIS IS EXPERIMENTAL SOFTWARE. USE AT YOUR OWN RISK. THE
> AUTHOR CAN NOT BE HELD LIABLE UNDER ANY CIRCUMSTANCES FOR DAMAGE TO HARDWARE
> OR SOFTWARE, LOST DATA, OR OTHER DIRECT OR INDIRECT DAMAGE RESULTING FROM THE
> USE OF THIS SOFTWARE.
> YOU ARE RESPONSIBLE FOR YOUR OWN COMPLIANCE WITH ALL APPLICABLE LAWS.


********************************************************************************
# Anleitung: Remastering mit Archiv- und Containerdateien
- matrixxx bietet zwei Remastering-Dateitypen:
  1. Update-Archive (update_\*.tar.gz update_\*.taz update_\*.zip)
     die über das Root-Verzeichnis '/' gelegt werden können
      - kurz vor dem System 'init' Aufruf des InitramFS
  2. eine squasFS Image-Datei, die in das Union FS eingebunden wird
- Die Generierung beider Formate wird durch diese Skripte ermöglicht

### Dateistruktur:
- die Skripte erwarten eine spezielle Dateistruktur
```
├── LIST_*                                  - Allgemeines 'LIST' Verzeichnis
│   ├── A0-get_dir_list.sh                  - Skript zum Erzeugen der 'dir' Hilfsdatei *)
│   ├── dir                                 - enthält alle im List_* Verzeichnis enthaltene
│   │                                         Verzeichnisnamen (und symbolische Links auf solche)
│   │                                         (nach Skriptaufruf)
│   ├── list                                - enthält ein Array 'DIR_LIST', welches die zu verarbeitenden
│   │                                         Verzeichnisse enthält [*) Hilfsdatei -> Befüllen des Arrays]
│   └── lxpanel_corrected                   - ein Beispiel Verzeichnis
│       └── rootfs.tar.gz                     - mit zugehörigem rootfs.tar.gz Archiv
└── LIST_99                                 - Spezielles 'LIST' Verzeichnis
    │                                         (99 ist wahlfrei und hier nur ein Beispiel)
    ├── A0-get_dir_list.sh
    ├── A1-get_deb_files.sh                 - Skript zum Kopieren von *.deb Dateien
    │                                         aus dem Verzeichnis /var/cache/apt/archives
    ├── archives -> /var/cache/apt/archives - symbolischer Link zu /var/cache/apt/archives
    ├── dir
    └── list
```

### Skriptstruktur:
```
├── 01-generate_single_archives.sh          - Erzeugt aus jedem selektierten Unterverzeichniss
│                                             eine seperate Archiv Datei
├── 02-generate_common_archives.sh          - Erzeugt aus allen selektierten Unterverzeichnissen
│                                             eine Archiv Datei
├── 03-mk-squashfs-image.sh                 - Erzeugt aus allen selektierten Unterverzeichnissen
│                                             einer squasFS Imagedatei
├── A1-script-targz2dir.sh                  - Erzeugt in allen selektierten Unterverzeichnissen ein
│                                             Verzeichnis rootfs mit dem Inhalt des dort enthaltenen
│                                             rootfs.tar.gz Archiv
├── A2-script-dir2targz.sh                  - Erzeugt in allen selektierten Unterverzeichnissen aus
│                                             dem Verzeichnis rootfs ein neues rootfs.tar.gz Archiv
│                                             - Verzeichnis rootfs wird danach gelöscht
├── A3-script-deb2targz.sh                  - Erzeugt aus allen in einem Unterverzeichniss enthaltenen
│                                             *.deb Dateien eine rootfs.tar.gz Datei
│                                             (siehe Spezielles 'LIST' Verzeichnis)
├── init--process-control                   - Konfigurationsdatei
└── lib
    ├── func_get-dir-list                   - Funktionen für die Erzeugung einer Hilfsdatei *)
    ├── func_mk-squasfs-image-handling      - Funktion für die Erzeugung einer squasFS Imagedatei
    └── func_update-archive-handling        - Funktionen für die Handhabung der Dateistuktur und
                                              der Erzeugung von 'update_' Archiven
```

### Selektierung für die Bearbeitung
- Selektierung der zu bearbeitenden 'LIST' Verzeichnissen:
  - In der Konfigurations Datei **init--process-control** werden die 'LIST'
    Verzeichnisse für die jeweiligen Prozesse ausgewählt in dem diese
    in dazu gehörigen Arrays 'LIST_DIR_NO_ARRAY' eingetragen werden
    (nur das Postfix - und es sind alle Zeichen erlaubt, nicht nur Zahlen)

| Mögliche Prozesse:  | Zugehöriges Skript:             |
| ------------------- | ---------------------------     |
| SINGLE_ARCHIVE      |  01-generate_single_archives.sh |
| COMMON_ARCHIVE      |  02-generate_common_archives.sh |
| COMMON_CONTAINER    |  03-mk-squashfs-image.sh        |
| TARGZ_to_DIR        |  A1-script-targz2dir.sh         |
| DIR_to_TARGZ        |  A2-script-dir2targz.sh         |
| DEB_to_TARGZ        |  A3-script-deb2targz.sh         |

- Selektierung der zu bearbeitenden Unterverzeichnissen:
  - in der 'list' Datei eines 'LIST' Verzeichnisses müssen alle zur Verarbeiung
    gewünschten darin enthaltenen Unterverzeichinsse in das zugehörige
    Array 'DIR_LIST' eingetragen werden

********************************************************************************
> [!WARNING]
> **DISCLAIMER:** DIES IST EXPERIMENTELLE SOFTWARE. DIE BENUTZUNG ERFOLGT AUF
> EIGENE GEFAHR. DER AUTOR KANN UNTER KEINEN UMSTÄNDEN HAFTBAR GEMACHT
> WERDEN FÜR SCHÄDEN AN HARD- UND SOFTWARE, VERLORENE DATEN UND ANDERE DIREKT
> ODER INDIREKT DURCH DIE BENUTZUNG DER SOFTWARE ENTSTEHENDE SCHÄDEN.
> FÜR DIE EINHALTUNG GESETZLICHER VORSCHRIFTEN SIND SIE SELBST VERANTWORTLICH.

********************************************************************************
















