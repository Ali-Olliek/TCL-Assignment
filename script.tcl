# https://www.tcl.tk/man/tcl8.6/TclCmd/string.htm#M10

# Utility Functions
proc isList value {
    if {[string match "{*}" $value]} {
        return 1
    }

    return 0
}

# Main
proc run filePath {
    # Open and read file's contents
    set file [open $filePath r]

    set stringLinesCount 0
    set intTotal 0

    # Lets read the file line by line using `gets` function
    while {[gets $file line] >= 0} {

        # remove any whitespaces
        set line [string trim $line]

        # Check if the line is a list 
        if {[isList $line]} {
            puts "INVALID\n"
            continue
        }

        # If Integers (Entier instead of integers as recommended in the docs)
        if {[string is entier -strict $line ]} {
            if {$line % 2 == 0} {
                set evenInt [expr {$line * 3}]
                set intTotal [expr $intTotal + $evenInt]
                puts "Original: $line \nProcessed: $evenInt\n"
                continue
            } else {
                set oddInt [expr {$line * 2}]
                set intTotal [expr $intTotal + $oddInt]
                puts "Original $line \nProcessed: $oddInt\n"
                continue
            }
        }

        # If double
        if {[string is double -strict $line]} {
            puts "This is a decimal: $line\n"
            continue
        }

        # If Alphabetical String 
        if {[string is ascii -strict $line]} {
            puts "This is a string: $line\n"
            set stringLinesCount [expr $stringLinesCount + 1]
            continue
        }

        # Finally if the line belongs to none of these types, we can exclude it as INVALID
        puts "INVALID\n"
    }

    puts "The intTotal of the integers after processing is: $intTotal"

    puts "The number of lines containing a string is $stringLinesCount"
}

# Run the script
run "eval.txt"