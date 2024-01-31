set disassembly-flavor intel
tui enable

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

start

