	.section __DWARF,__debug_frame,regular,debug
Lsection__debug_frame:
	.section __DWARF,__debug_info,regular,debug
Lsection__debug_info:
	.section __DWARF,__debug_abbrev,regular,debug
Lsection__debug_abbrev:
	.section __DWARF,__debug_aranges,regular,debug
Lsection__debug_aranges:
	.section __DWARF,__debug_macinfo,regular,debug
Lsection__debug_macinfo:
	.section __DWARF,__debug_line,regular,debug
Lsection__debug_line:
	.section __DWARF,__debug_loc,regular,debug
Lsection__debug_loc:
	.section __DWARF,__debug_pubnames,regular,debug
Lsection__debug_pubnames:
	.section __DWARF,__debug_pubtypes,regular,debug
Lsection__debug_pubtypes:
	.section __DWARF,__debug_str,regular,debug
Lsection__debug_str:
	.section __DWARF,__debug_ranges,regular,debug
Lsection__debug_ranges:
	.section __DWARF,__debug_abbrev,regular,debug
Ldebug_abbrev0:
	.section __DWARF,__debug_info,regular,debug
Ldebug_info0:
	.section __DWARF,__debug_line,regular,debug
Ldebug_line0:
	.text
Ltext0:
.globl _main
_main:
LFB2:
LM1:
	nop
	nop
	nop
	nop
	nop
	nop
	pushl	%ebp
LCFI0:
	movl	%esp, %ebp
LCFI1:
	subl	$24, %esp
LCFI2:
LM2:
	call	L_ASKInitialize$stub
LM3:
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	L_NSApplicationMain$stub
LM4:
	leave
	ret
LFE2:
	.objc_cat_cls_meth
	.objc_cat_inst_meth
	.objc_string_object
	.section __OBJC, __cstring_object, regular, no_dead_strip
	.objc_message_refs
	.section __OBJC, __sel_fixup, regular, no_dead_strip
	.objc_cls_refs
	.objc_class
	.objc_meta_class
	.objc_cls_meth
	.objc_inst_meth
	.objc_protocol
	.objc_class_names
	.objc_meth_var_types
	.objc_meth_var_names
	.objc_category
	.objc_class_vars
	.objc_instance_vars
	.objc_module_info
	.objc_symbols
	.section __OBJC, __protocol_ext, regular, no_dead_strip
	.section __OBJC, __class_ext, regular, no_dead_strip
	.section __OBJC, __property, regular, no_dead_strip
	.section __OBJC, __image_info, regular, no_dead_strip
	.align 2
L_OBJC_IMAGE_INFO:
	.space 8
	.section __DWARF,__debug_frame,regular,debug
Lframe0:
	.set L$set$0,LECIE0-LSCIE0
	.long L$set$0
LSCIE0:
	.long	0xffffffff
	.byte	0x1
	.ascii "\0"
	.byte	0x1
	.byte	0x7c
	.byte	0x8
	.byte	0xc
	.byte	0x4
	.byte	0x4
	.byte	0x88
	.byte	0x1
	.align 2
LECIE0:
LSFDE0:
	.set L$set$1,LEFDE0-LASFDE0
	.long L$set$1
LASFDE0:
	.set L$set$2,Lframe0-Lsection__debug_frame
	.long L$set$2
	.long	LFB2
	.set L$set$3,LFE2-LFB2
	.long L$set$3
	.byte	0x4
	.set L$set$4,LCFI0-LFB2
	.long L$set$4
	.byte	0xe
	.byte	0x8
	.byte	0x85
	.byte	0x2
	.byte	0x4
	.set L$set$5,LCFI1-LCFI0
	.long L$set$5
	.byte	0xd
	.byte	0x5
	.align 2
LEFDE0:
	.text
Letext0:
	.section __DWARF,__debug_info,regular,debug
	.long	0x12f
	.word	0x2
	.set L$set$6,Ldebug_abbrev0-Lsection__debug_abbrev
	.long L$set$6
	.byte	0x4
	.byte	0x1
	.ascii "GNU Objective-C 4.0.1 (Apple Inc. build 5490)\0"
	.byte	0x10
	.ascii "/Users/tedsr/Sites/bbeditclippings/PHP/source/Support Applications/Date Format Dialog/main.m\0"
	.long	Ltext0
	.long	Letext0
	.set L$set$7,Ldebug_line0-Lsection__debug_line
	.long L$set$7
	.byte	0x2
	.byte	0x1
	.ascii "main\0"
	.byte	0x1
	.byte	0x5
	.long	0xde
	.long	LFB2
	.long	LFE2
	.byte	0x1
	.byte	0x55
	.long	0xde
	.byte	0x3
	.ascii "argc\0"
	.byte	0x1
	.byte	0x4
	.long	0xde
	.byte	0x2
	.byte	0x75
	.byte	0x8
	.byte	0x3
	.ascii "argv\0"
	.byte	0x1
	.byte	0x4
	.long	0xe5
	.byte	0x2
	.byte	0x75
	.byte	0xc
	.byte	0x0
	.byte	0x4
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
	.byte	0x5
	.byte	0x4
	.long	0xeb
	.byte	0x5
	.byte	0x4
	.long	0xf1
	.byte	0x6
	.long	0xf6
	.byte	0x4
	.byte	0x1
	.byte	0x5
	.ascii "char\0"
	.byte	0x7
	.long	0xde
	.long	0x109
	.byte	0x8
	.byte	0x0
	.byte	0x9
	.ascii "__CFConstantStringClassReference\0"
	.long	0xfe
	.byte	0x1
	.byte	0x1
	.byte	0x1
	.byte	0x0
	.section __DWARF,__debug_abbrev,regular,debug
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x25
	.byte	0x8
	.byte	0x13
	.byte	0xb
	.byte	0x3
	.byte	0x8
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x1
	.byte	0x10
	.byte	0x6
	.byte	0x0
	.byte	0x0
	.byte	0x2
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0xc
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x1
	.byte	0x40
	.byte	0xa
	.byte	0x1
	.byte	0x13
	.byte	0x0
	.byte	0x0
	.byte	0x3
	.byte	0x5
	.byte	0x0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0xa
	.byte	0x0
	.byte	0x0
	.byte	0x4
	.byte	0x24
	.byte	0x0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0x8
	.byte	0x0
	.byte	0x0
	.byte	0x5
	.byte	0xf
	.byte	0x0
	.byte	0xb
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x0
	.byte	0x0
	.byte	0x6
	.byte	0x26
	.byte	0x0
	.byte	0x49
	.byte	0x13
	.byte	0x0
	.byte	0x0
	.byte	0x7
	.byte	0x1
	.byte	0x1
	.byte	0x49
	.byte	0x13
	.byte	0x1
	.byte	0x13
	.byte	0x0
	.byte	0x0
	.byte	0x8
	.byte	0x21
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.byte	0x9
	.byte	0x34
	.byte	0x0
	.byte	0x3
	.byte	0x8
	.byte	0x49
	.byte	0x13
	.byte	0x3f
	.byte	0xc
	.byte	0x34
	.byte	0xc
	.byte	0x3c
	.byte	0xc
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section __DWARF,__debug_pubnames,regular,debug
	.long	0x17
	.word	0x2
	.set L$set$8,Ldebug_info0-Lsection__debug_info
	.long L$set$8
	.long	0x133
	.long	0xa4
	.ascii "main\0"
	.long	0x0
	.section __DWARF,__debug_aranges,regular,debug
	.long	0x1c
	.word	0x2
	.set L$set$9,Ldebug_info0-Lsection__debug_info
	.long L$set$9
	.byte	0x4
	.byte	0x0
	.word	0x0
	.word	0x0
	.long	Ltext0
	.set L$set$10,Letext0-Ltext0
	.long L$set$10
	.long	0x0
	.long	0x0
	.section __DWARF,__debug_line,regular,debug
	.set L$set$11,LELT0-LSLT0
	.long L$set$11
LSLT0:
	.word	0x2
	.set L$set$12,LELTP0-LASLTP0
	.long L$set$12
LASLTP0:
	.byte	0x1
	.byte	0x1
	.byte	0xf6
	.byte	0xf5
	.byte	0xa
	.byte	0x0
	.byte	0x1
	.byte	0x1
	.byte	0x1
	.byte	0x1
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.byte	0x1
	.ascii "/Users/tedsr/Sites/bbeditclippings/PHP/source/Support Applications/Date Format Dialog"
	.byte	0
	.byte	0x0
	.ascii "main.m\0"
	.byte	0x1
	.byte	0x0
	.byte	0x0
	.byte	0x0
LELTP0:
	.byte	0x0
	.byte	0x5
	.byte	0x2
	.long	LM1
	.byte	0x18
	.byte	0x0
	.byte	0x5
	.byte	0x2
	.long	LM2
	.byte	0x15
	.byte	0x0
	.byte	0x5
	.byte	0x2
	.long	LM3
	.byte	0x16
	.byte	0x0
	.byte	0x5
	.byte	0x2
	.long	LM4
	.byte	0x15
	.byte	0x0
	.byte	0x5
	.byte	0x2
	.long	Letext0
	.byte	0x0
	.byte	0x1
	.byte	0x1
LELT0:
	.section __IMPORT,__jump_table,symbol_stubs,self_modifying_code+pure_instructions,5
L_NSApplicationMain$stub:
	.indirect_symbol _NSApplicationMain
	hlt ; hlt ; hlt ; hlt ; hlt
L_ASKInitialize$stub:
	.indirect_symbol _ASKInitialize
	hlt ; hlt ; hlt ; hlt ; hlt
	.subsections_via_symbols
