#!/usr/bin/ruby
class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
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

if ARGV.length > 0
    # get the first argument
    arg0 = ARGV[0]

    # check if this argument is a valid directory
    # if it is not a valid directory, return with an error message, else, store
    
    if (Dir.exist?(arg0))
        dir = arg0
    else
        abort("Usage: #{File.basename($0, File.extname($0))} [dirname]")
    end
    
else
    dir = "."
end

def printDirContent(dir, prefix = "")
    entries = Dir.entries(dir)
    prevPrefix = prefix[0...-2]
    entries.each_with_index do |entry, index|
        if (!(entry == "." or entry == ".."))
            path = File.join(dir, entry)
            
            # print prefix
            if (prefix != "")
                if (index == entries.length - 1)
                    print((prevPrefix + "+-").yellow)
                else
                    print((prevPrefix + "|-").yellow)
                end
            end
            
            if (Dir.exist?(path))
                puts (entry + "/").green
                if (prefix != "" and index == entries.length - 1)
                    printDirContent(path, prevPrefix + "  " + "| ")
                else
                    printDirContent(path, prefix + "| ")
                end
            else
                puts entry
            end
        end
    end
end

# List all files and directories
printDirContent(dir)
