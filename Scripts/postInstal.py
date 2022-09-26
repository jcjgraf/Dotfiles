#!/bin/env python

import os
import sys

storrage_dir = sys.argv[1]

new_files = sys.argv[2]
new_files = new_files[1:-1].split(",")
new_files = [f.strip() for f in new_files]

compact = sys.argv[3]

new_files_order = dict()

# Dictionary is indexed using the base path, the elements are a list of all file names in that path
for path in new_files:
    base_path, file_name = os.path.split(path)

    try:
        new_files_order[str(base_path)].append(file_name)
    except KeyError:
        new_files_order[str(base_path)] = [file_name]

if not compact:

    for base_path in new_files_order:

        dir_name = os.path.basename(base_path)

        branch_name = f"import/{dir_name}"

        os.system(f"cd {storrage_dir} && git checkout master && git checkout -b {branch_name} 0288d6e6c64f7c45332c8182c52bcfde41084f6d && git rm -rf .")

        for file_name in new_files_order[base_path]:
            os.system(f"cd {base_path} && git annex add {file_name}")

        os.system(f"cd {base_path} && git commit -m 'NEW: Image Import'")

else:

    base_name = os.path.basename(os.path.dirname(new_files[0]))

    branch_name = f"import/{base_name}"

    os.system(f"cd {storrage_dir} && git checkout master && git checkout -b {branch_name} 0288d6e6c64f7c45332c8182c52bcfde41084f6d && git rm -rf .")

    for base_path in new_files_order:

        dir_name = os.path.basename(base_path)

        for file_name in new_files_order[base_path]:
            os.system(f"cd {base_path} && git annex add {file_name}")

        os.system(f"cd {base_path} && git commit -m 'NEW: Image Import'")
