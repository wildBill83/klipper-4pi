/* sam3u4.ld - Linker script for the SAM3U4 microcontroller */

MEMORY
{
    rom (rx)  : ORIGIN = 0x00400000, LENGTH = 256K
    ram (rwx) : ORIGIN = 0x20000000, LENGTH = 64K
}

SECTIONS
{
    .text :
    {
        *(.vectors)
        *(.text*)
        *(.rodata*)
        *(.ARM.extab* .gnu.linkonce.armextab.*)
    } > rom

    .data : AT (ADDR(.text) + SIZEOF(.text))
    {
        _sdata = .;
        *(.data*)
        _edata = .;
    } > ram

    .bss :
    {
        _sbss = .;
        *(.bss*)
        *(COMMON)
        _ebss = .;
    } > ram

    .heap :
    {
        _sheap = .;
        . = . + 0x1000; /* 4K heap */
        _eheap = .;
    } > ram

    .stack :
    {
        _sstack = .;
        . = . + 0x1000; /* 4K stack */
        _estack = .;
    } > ram
}