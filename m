From: Miles Lane <miles.lane@attbi.com>
Subject: 2.5.34 -- vga16fb.c:177: In function `vga16fb_set_disp': structure
 has no member named `visual'
Date: 09 Sep 2002 15:40:15 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1031611215.11629.12.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from rwcrmhc52.attbi.com ([216.148.227.88])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17oXDD-0006Bw-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 09 Sep 2002 15:40:55 -0700
Received: from [192.168.1.101] ([12.228.129.64]) by rwcrmhc52.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020909224049.NEIV14182.rwcrmhc52.attbi.com@[192.168.1.101]>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Mon, 9 Sep 2002 22:40:49 +0000
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

gcc -Wp,-MD,./.vga16fb.o.d -D__KERNEL__ -I/usr/src/linux-2.5.33/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -nostdinc -iwithprefix include
-DKBUILD_BASENAME=vga16fb   -c -o vga16fb.o vga16fb.c
vga16fb.c: In function `vga16fb_set_disp':
vga16fb.c:177: structure has no member named `visual'
vga16fb.c:178: structure has no member named `type'
vga16fb.c:179: structure has no member named `type_aux'
vga16fb.c:180: structure has no member named `ypanstep'
vga16fb.c:181: structure has no member named `ywrapstep'
vga16fb.c:182: structure has no member named `line_length'
vga16fb.c: In function `vga_vesa_blank':
vga16fb.c:664: warning: implicit declaration of function `cli'
vga16fb.c:671: warning: implicit declaration of function `sti'
vga16fb.c: At top level:
vga16fb.c:814: unknown field `fb_get_fix' specified in initializer
vga16fb.c:814: warning: initialization from incompatible pointer type
vga16fb.c:815: unknown field `fb_get_var' specified in initializer
vga16fb.c:815: warning: initialization from incompatible pointer type
make[2]: *** [vga16fb.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.33/drivers/video'



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
