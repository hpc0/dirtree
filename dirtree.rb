#!/usr/bin/ruby
class String
  # colorization
  def colorize(color_code)
    if ($flag_plain)
        return self
    else
        "\e[#{color_code}m#{self}\e[0m"
    end
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end


dir = nil
flag_ascii = false
$flag_dirs_only = false
$flag_plain = false

ARGV.each do |arg|
    if (arg == "/A")
        flag_ascii = true
    elsif (arg == "/D")
        $flag_dirs_only = true
    elsif (arg == "/P")
        $flag_plain = true
    else
        if (Dir.exist?(arg))
            dir = arg
        else
            abort("Usage: #{File.basename($0, File.extname($0))} [directory] [/D] [/A] [/P]\n\n   /D   Display only directories.\n   /A   Use ASCII instead of extended characters.\n   /P   Display plain output (no colors).")
        end
    end
end

if (dir == nil)
    dir = "."
end

$sym_L = "└"
$sym_T = "├"
$sym_bar = "│"
$sym_dash = "─"

if (flag_ascii)
    $sym_L = "+"
    $sym_T = "|"
    $sym_bar = "|"
    $sym_dash = "-"
end


def printDirContent(dir, prefix = "")
    entries = Dir.entries(dir)
    if ($flag_dirs_only)
        entries = entries.select do |entry|
            File.directory?(File.join(dir, entry))
        end
    end
    prevPrefix = prefix[0...-2]
    entries.each_with_index do |entry, index|
        if (!(entry == "." or entry == ".."))
            path = File.join(dir, entry)
            
            # print prefix
            if (prefix != "")
                if (index == entries.length - 1)
                    print((prevPrefix + $sym_L + $sym_dash).yellow)
                else
                    print((prevPrefix + $sym_T + $sym_dash).yellow)
                end
            end
            
            if (Dir.exist?(path))
                puts (entry + "/").green
                if (prefix != "" and index == entries.length - 1)
                    printDirContent(path, prevPrefix + "  " + $sym_bar + " ")
                else
                    printDirContent(path, prefix + $sym_bar + " ")
                end
            else
                puts entry
            end
        end
    end
end

# List all files and directories
printDirContent(dir)
