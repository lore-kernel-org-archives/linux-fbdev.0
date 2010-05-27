From: =?KOI8-R?B?4czFy9PBzsTSIOTP0snG?= <dorif11@gmail.com>
Date: Thu, 27 May 2010 17:52:37 +0000
Subject: efifb warnings.
Message-Id: <AANLkTimf9o3cIQHmf7pRHb29oH4X24I6V4RmEwG6Ciw9@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello! I tried to compile kernel v.2.6.34-12 and got these messages:
WARNING: drivers/video/built-in.o(.devinit.text+0xda1): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xdae): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xdb5): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_fix
The function __devinit efifb_probe() references
a variable __initdata efifb_fix.
If efifb_fix is only used by efifb_probe then
annotate efifb_fix with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xdbb): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_defined
The function __devinit efifb_probe() references
a variable __initdata efifb_defined.
If efifb_defined is only used by efifb_probe then
annotate efifb_defined with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xdcb): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_defined
The function __devinit efifb_probe() references
a variable __initdata efifb_defined.
If efifb_defined is only used by efifb_probe then
annotate efifb_defined with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xe0c): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xe23): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_fix
The function __devinit efifb_probe() references
a variable __initdata efifb_fix.
If efifb_fix is only used by efifb_probe then
annotate efifb_fix with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xf03): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_fix
The function __devinit efifb_probe() references
a variable __initdata efifb_fix.
If efifb_fix is only used by efifb_probe then
annotate efifb_fix with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xf18): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xf30): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_fix
The function __devinit efifb_probe() references
a variable __initdata efifb_fix.
If efifb_fix is only used by efifb_probe then
annotate efifb_fix with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xf36): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xf54): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_fix
The function __devinit efifb_probe() references
a variable __initdata efifb_fix.
If efifb_fix is only used by efifb_probe then
annotate efifb_fix with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xf73): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_defined
The function __devinit efifb_probe() references
a variable __initdata efifb_defined.
If efifb_defined is only used by efifb_probe then
annotate efifb_defined with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xf87): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xf94): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xf9a): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_defined
The function __devinit efifb_probe() references
a variable __initdata efifb_defined.
If efifb_defined is only used by efifb_probe then
annotate efifb_defined with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xfa2): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_defined
The function __devinit efifb_probe() references
a variable __initdata efifb_defined.
If efifb_defined is only used by efifb_probe then
annotate efifb_defined with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xfad): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_defined
The function __devinit efifb_probe() references
a variable __initdata efifb_defined.
If efifb_defined is only used by efifb_probe then
annotate efifb_defined with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xfbc): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_defined
The function __devinit efifb_probe() references
a variable __initdata efifb_defined.
If efifb_defined is only used by efifb_probe then
annotate efifb_defined with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xfc2): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xfc8): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xfce): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_defined
The function __devinit efifb_probe() references
a variable __initdata efifb_defined.
If efifb_defined is only used by efifb_probe then
annotate efifb_defined with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0xfdb): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_defined
The function __devinit efifb_probe() references
a variable __initdata efifb_defined.
If efifb_defined is only used by efifb_probe then
annotate efifb_defined with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x1008): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_defined
The function __devinit efifb_probe() references
a variable __initdata efifb_defined.
If efifb_defined is only used by efifb_probe then
annotate efifb_defined with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x101b): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_defined
The function __devinit efifb_probe() references
a variable __initdata efifb_defined.
If efifb_defined is only used by efifb_probe then
annotate efifb_defined with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x1023): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x1029): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x1045): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x104c): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x1053): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x105a): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x106b): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_defined
The function __devinit efifb_probe() references
a variable __initdata efifb_defined.
If efifb_defined is only used by efifb_probe then
annotate efifb_defined with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x1078): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x107e): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x1084): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_defined
The function __devinit efifb_probe() references
a variable __initdata efifb_defined.
If efifb_defined is only used by efifb_probe then
annotate efifb_defined with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x1092): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x1098): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x10a5): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x10b6): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x10bf): Section
mismatch in reference from the function efifb_probe() to the (unknown
reference) .init.data:(unknown)
The function __devinit efifb_probe() references
a (unknown reference) __initdata (unknown).
If (unknown) is only used by efifb_probe then
annotate (unknown) with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x10e8): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_fix
The function __devinit efifb_probe() references
a variable __initdata efifb_fix.
If efifb_fix is only used by efifb_probe then
annotate efifb_fix with a matching annotation.

WARNING: drivers/video/built-in.o(.devinit.text+0x1183): Section
mismatch in reference from the function efifb_probe() to the variable
.init.data:efifb_fix
The function __devinit efifb_probe() references
a variable __initdata efifb_fix.
If efifb_fix is only used by efifb_probe then
annotate efifb_fix with a matching annotation.

I hope, it'll be corrected soon. My system: Fedora 13 x86_64, gcc 4.4.4
P.S.:Was my message useful
