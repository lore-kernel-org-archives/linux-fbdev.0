From: Miles Lane <miles.lane@attbi.com>
Subject: 2.5.34 -- fbdev.c:665:  In function `riva_set_dispsw':  structure
 has no member named `type'
Date: 09 Sep 2002 15:34:30 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1031610870.11629.9.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sccrmhc01.attbi.com ([204.127.202.61])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17oX7f-0004l0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 09 Sep 2002 15:35:11 -0700
Received: from [192.168.1.101] ([12.228.129.64]) by sccrmhc01.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020909223504.DEBQ9751.sccrmhc01.attbi.com@[192.168.1.101]>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Mon, 9 Sep 2002 22:35:04 +0000
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

 gcc -Wp,-MD,./.fbdev.o.d -D__KERNEL__ -I/usr/src/linux-2.5.33/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=fbdev   -c -o fbdev.o fbdev.c
fbdev.c: In function `riva_set_dispsw':
fbdev.c:665: structure has no member named `type'
fbdev.c:666: structure has no member named `type_aux'
fbdev.c:667: structure has no member named `ypanstep'
fbdev.c:668: structure has no member named `ywrapstep'
fbdev.c:657: warning: unused variable `accel'
fbdev.c: In function `rivafb_setcolreg':
fbdev.c:1202: warning: unused variable `chip'
fbdev.c: In function `rivafb_get_fix':
fbdev.c:1294: structure has no member named `type'
fbdev.c:1295: structure has no member named `type_aux'
fbdev.c:1296: structure has no member named `visual'
fbdev.c:1302: structure has no member named `line_length'
fbdev.c: In function `rivafb_pan_display':
fbdev.c:1611: structure has no member named `line_length'
fbdev.c:1586: warning: `base' might be used uninitialized in this
function
fbdev.c: At top level:
fbdev.c:1748: unknown field `fb_get_fix' specified in initializer
fbdev.c:1748: warning: initialization from incompatible pointer type
fbdev.c:1749: unknown field `fb_get_var' specified in initializer
fbdev.c:1749: warning: initialization from incompatible pointer type
fbdev.c:732: warning: `riva_wclut' defined but not used
make[3]: *** [fbdev.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.33/drivers/video/riva'

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VESA=y
CONFIG_FB_VGA16=m
CONFIG_VIDEO_SELECT=y
CONFIG_FB_RIVA=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB16=m
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=m
CONFIG_FBCON_ACCEL=y
CONFIG_FBCON_VGA_PLANES=m
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
