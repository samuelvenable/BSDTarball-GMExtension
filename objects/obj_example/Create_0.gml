function tar_encode(infile, outfile) {
  var f = (string_count(" ", outfile)) ? "\"" + string_replace_all(outfile, "\\", "\\\\") + "\"" : outfile;
  var d = (string_count(" ", infile)) ? "\"" + string_replace_all(filename_dir(filename_dir(infile)), "\\", "\\\\") + "\"" : filename_dir(filename_dir(infile));
  var n = (string_count(" ", infile)) ? "\"" + filename_name(filename_dir(infile)) + "\"" : filename_name(filename_dir(infile));
  return ProcessExecute("tar -cvf " + f + " -C " + d + " " + n);
}

function tar_decode(infile, outfile) {
  var f = (string_count(" ", outfile)) ? "\"" + string_replace_all(outfile, "\\", "\\\\") + "\"" : outfile;
  var d = (string_count(" ", infile)) ? "\"" + string_replace_all(infile, "\\", "\\\\") + "\"" : infile;
  return ProcessExecute("tar -xvf " + d + " -C " + f);
}

var pid = 0;
widget_set_button_name(btn_yes, "Create");
widget_set_button_name(btn_no, "Extract");
widget_set_icon(working_directory + "icon.png");
var action = show_question("What would you like to do?"), filter = "Tarballs (*.tar)|*.tar";
var infile = (action) ? get_directory("") : get_open_filename_ext(filter, "", "", ""); if (infile == "") { game_end(); exit; }
var outfile = (action) ? get_save_filename_ext(filter, "", "", "") : get_directory(""); if (outfile == "") { game_end(); exit; }
if (action) { pid = tar_encode(infile, outfile); }
else { pid = tar_decode(infile, outfile); }

if (pid != 0) {
  show_debug_message(ExecutedProcessReadFromStandardOutput(pid));
  FreeExecutedProcessStandardOutput(pid);
  FreeExecutedProcessStandardInput(pid);
}

game_end();