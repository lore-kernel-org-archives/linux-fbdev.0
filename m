From: Miles Lane <miles.lane@attbi.com>
Subject: console_struct.h:97: `MAX_NR_CONSOLES' undeclared here
Date: Tue, 03 Dec 2002 20:44:05 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3DED8815.8000408@attbi.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from rwcrmhc51.attbi.com ([204.127.198.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18JROQ-0008Dv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 03 Dec 2002 20:44:14 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net

I applied the patch from tonight to 2.5.50 and got this build error:
http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz 
<http://phoenix.infradead.org/%7Ejsimmons/fbdev.diff.gz> 

gcc -Wp,-MD,kernel/.suspend.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon 
-Iarch/i386/mach-generic -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=suspend -DKBUILD_MODNAME=suspend -DEXPORT_SYMTAB  -c 
-o kernel/suspend.o kernel/suspend.c
In file included from include/linux/vt_kern.h:12,
                 from kernel/suspend.c:46:
include/linux/console_struct.h:97: `MAX_NR_CONSOLES' undeclared here 
(not in a function)
kernel/suspend.c:294:2: warning: #warning This might be broken. We need 
to somehow wait for data to reach the disk
kernel/suspend.c: In function `count_and_copy_data_pages':
kernel/suspend.c:516: warning: passing arg 1 of `mmx_copy_page' makes 
pointer from integer without a cast
kernel/suspend.c:516: warning: passing arg 2 of `mmx_copy_page' makes 
pointer from integer without a cast
make[2]: *** [kernel/suspend.o] Error 1

CONFIG_MK7=y

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
CONFIG_FB_RIVA=y

CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
# CONFIG_FBCON_ADVANCED is not set
# CONFIG_FONTWIDTH8_ONLY is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y





-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
