let g:pandoc#command#prefer_pdf = 1
let g:pandoc#command#autoexec_on_writes = 0
let g:pandoc#command#autoexec_command = "Pandoc pdf"

command PandocStart Pandoc! pdf
command PandocEnable let g:pandoc#command#autoexec_on_writes=1
