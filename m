From: Ariel <aslinux@dsgml.com>
Subject: kernel: matrox fb - missing files, doesn't compile
Date: Fri, 13 Dec 2002 01:13:13 -0500 (EST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.44.0212130106380.1353-100000@shell3.shore.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from relay2.primushost.com ([207.244.125.21])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Mj4i-00031g-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 12 Dec 2002 22:13:28 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vandrove@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net


Kernel 2.5.51.

I tried copying the fbcon*.h files from 2.2.19 kernel, but that didn't
help much.

Clip from .config:

# Graphics support
CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G100A=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=y
CONFIG_FB_MATROX_MAVEN=y

(I also have I2C on.)

Output of make:

make -f scripts/Makefile.build obj=drivers/video/matrox
  gcc -Wp,-MD,drivers/video/matrox/.matroxfb_base.o.d -D__KERNEL__
-Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=matroxfb_base
-DKBUILD_MODNAME=matroxfb_base -DEXPORT_SYMTAB  -c -o
drivers/video/matrox/matroxfb_base.o drivers/video/matrox/matroxfb_base.c
In file included from drivers/video/matrox/matroxfb_base.c:105:
drivers/video/matrox/matroxfb_base.h:52: video/fbcon.h: No such file or
directory
drivers/video/matrox/matroxfb_base.h:53: video/fbcon-cfb4.h: No such file
or directory
drivers/video/matrox/matroxfb_base.h:54: video/fbcon-cfb8.h: No such file
or directory
drivers/video/matrox/matroxfb_base.h:55: video/fbcon-cfb16.h: No such file
or directory
drivers/video/matrox/matroxfb_base.h:56: video/fbcon-cfb24.h: No such file
or directory
drivers/video/matrox/matroxfb_base.h:57: video/fbcon-cfb32.h: No such file
or directory
In file included from drivers/video/matrox/matroxfb_base.c:105:
drivers/video/matrox/matroxfb_base.h:341: warning: `struct display'
declared inside parameter list
drivers/video/matrox/matroxfb_base.h:341: warning: its scope is only this
definition or declaration, which is probably not what you want.
drivers/video/matrox/matroxfb_base.h:342: warning: `struct display'
declared inside parameter list
drivers/video/matrox/matroxfb_base.h:558: field `dispsw' has incomplete
type
drivers/video/matrox/matroxfb_base.c:148: warning: braces around scalar
initializer
drivers/video/matrox/matroxfb_base.c:148: warning: (near initialization
for `vesafb_defined.rotate')
drivers/video/matrox/matroxfb_base.c:148: warning: excess elements in
scalar initializer
drivers/video/matrox/matroxfb_base.c:148: warning: (near initialization
for `vesafb_defined.rotate')
drivers/video/matrox/matroxfb_base.c:148: warning: excess elements in
scalar initializer
drivers/video/matrox/matroxfb_base.c:148: warning: (near initialization
for `vesafb_defined.rotate')
drivers/video/matrox/matroxfb_base.c:148: warning: excess elements in
scalar initializer
drivers/video/matrox/matroxfb_base.c:148: warning: (near initialization
for `vesafb_defined.rotate')
drivers/video/matrox/matroxfb_base.c:148: warning: excess elements in
scalar initializer
drivers/video/matrox/matroxfb_base.c:148: warning: (near initialization
for `vesafb_defined.rotate')
drivers/video/matrox/matroxfb_base.c:148: warning: excess elements in
scalar initializer
drivers/video/matrox/matroxfb_base.c:148: warning: (near initialization
for `vesafb_defined.rotate')
drivers/video/matrox/matroxfb_base.c: In function `my_install_cmap':
drivers/video/matrox/matroxfb_base.c:158: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c: In function `matrox_pan_var':
drivers/video/matrox/matroxfb_base.c:186: warning: implicit declaration of
function `fontheight'
drivers/video/matrox/matroxfb_base.c:186: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:186: warning: implicit declaration of
function `fontwidth'
drivers/video/matrox/matroxfb_base.c:169: warning: `pos' might be used
uninitialized in this function
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_pan_display':
drivers/video/matrox/matroxfb_base.c:279: `fb_display' undeclared (first
use in this function)
drivers/video/matrox/matroxfb_base.c:279: (Each undeclared identifier is
reported only once
drivers/video/matrox/matroxfb_base.c:279: for each function it appears
in.)
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_updatevar':
drivers/video/matrox/matroxfb_base.c:303: `fb_display' undeclared (first
use in this function)
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_set_var':
drivers/video/matrox/matroxfb_base.c:688: `fb_display' undeclared (first
use in this function)
drivers/video/matrox/matroxfb_base.c:690: structure has no member named
`disp'
drivers/video/matrox/matroxfb_base.c:700: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:701: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:702: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:703: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:704: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:705: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:706: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:707: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:711: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:721: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:725: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:728: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:729: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:735: structure has no member named
`changevar'
drivers/video/matrox/matroxfb_base.c:736: structure has no member named
`changevar'
drivers/video/matrox/matroxfb_base.c:802: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:678: warning: `display' might be used
uninitialized in this function
drivers/video/matrox/matroxfb_base.c:738: warning: `pos' might be used
uninitialized in this function
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_get_cmap':
drivers/video/matrox/matroxfb_base.c:866: structure has no member named
`disp'
drivers/video/matrox/matroxfb_base.c:867: `fb_display' undeclared (first
use in this function)
drivers/video/matrox/matroxfb_base.c:876: warning: implicit declaration of
function `fb_get_cmap'
drivers/video/matrox/matroxfb_base.c:877: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:878: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:880: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_set_cmap':
drivers/video/matrox/matroxfb_base.c:890: structure has no member named
`disp'
drivers/video/matrox/matroxfb_base.c:890: `fb_display' undeclared (first
use in this function)
drivers/video/matrox/matroxfb_base.c:899: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:900: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:903: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:910: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_ioctl':
drivers/video/matrox/matroxfb_base.c:1009: structure has no member named
`switch_con'
drivers/video/matrox/matroxfb_base.c: At top level:
drivers/video/matrox/matroxfb_base.c:1188: unknown field `fb_set_var'
specified in initializer
drivers/video/matrox/matroxfb_base.c:1188: warning: initialization from
incompatible pointer type
drivers/video/matrox/matroxfb_base.c:1189: unknown field `fb_get_cmap'
specified in initializer
drivers/video/matrox/matroxfb_base.c:1189: warning: initialization from
incompatible pointer type
drivers/video/matrox/matroxfb_base.c:1190: unknown field `fb_set_cmap'
specified in initializer
drivers/video/matrox/matroxfb_base.c:1190: warning: initialization from
incompatible pointer type
drivers/video/matrox/matroxfb_base.c:1192: warning: initialization from
incompatible pointer type
drivers/video/matrox/matroxfb_base.c:1194: warning: initialization from
incompatible pointer type
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_switch':
drivers/video/matrox/matroxfb_base.c:1207: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:1222: structure has no member named
`disp'
drivers/video/matrox/matroxfb_base.c:1224: `fb_display' undeclared (first
use in this function)
drivers/video/matrox/matroxfb_base.c:1226: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:1235: derefe member named `changevar'
drivers/video/matrox/matroxfb_base.c:1757: structure has no member named
`disp'
drivers/video/matrox/matroxfb_base.c:1758: structure has no member named
`switch_con'
drivers/video/matrox/matroxfb_base.c:1759: structure has no member named
`updatevar'
drivers/video/matrox/matroxfb_base.c:1875: structure has no member named
`modename'
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_probe':
drivers/video/matrox/matroxfb_base.c:1986: storage size of `global_disp'
isn't known
drivers/video/matrox/matroxfb_base.c:2028: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:2028: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:2028: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:2028: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:2028: dereferencing pointer to
incomplete type
drivers/video/matrox/matroxfb_base.c:2028: dereferencing pointer to
incomplete type
driver might be used uninitialized in this function
make[3]: *** [drivers/video/matrox/matroxfb_base.o] Error 1
make[2]: *** [drivers/video/matrox] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2
root@blueberry:/usr/src/linux-2.5.51#


	-Ariel



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
