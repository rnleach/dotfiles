set history save on
set history size 1000
set history remove-duplicates 100

set auto-load safe-path /

set print pretty on

set confirm off
set verbose off
set pagination off

set disassembly-flavor intel
tui enable

# Printing 128-bit SIMD variables.
define p128c
    print /s *(char *)&$arg0@16
end

define p128x
    print /x *(uint8_t *)&$arg0@16
end

define p128u8
    print /u *(uint8_t *)&$arg0@16
end

define p128i8
    print /d *(int8_t *)&$arg0@16
end

define p128i16
    print /d *(int16_t *)&$arg0@8
end

define p128i32
    print /d *(int32_t *)&$arg0@4
end

define p128i64
    print /d *(int64_t *)&$arg0@2
end

# Printing 256-bit SIMD variables.
define p256c
    print /s *(char *)&$arg0@32
end

define p256x
    print /x *(uint8_t *)&$arg0@32
end

define p256u8
    print /u *(uint8_t *)&$arg0@32
end

define p256i8
    print /d *(int8_t *)&$arg0@32
end

define p256i16
    print /d *(int16_t *)&$arg0@16
end

define p256i32
    print /d *(int32_t *)&$arg0@8
end

define p256i64
    print /d *(int64_t *)&$arg0@4
end

