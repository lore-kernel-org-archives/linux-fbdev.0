From: Scott Henson <shenson2@silvercoin.dyndns.org>
Subject: 2.5.47 RadeonFB compile error
Date: 11 Nov 2002 18:28:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1037057283.2657.2.camel@GreyGhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Cc: Ani Joshi <linux-fbdev-devel@lists.sourceforge.net>

I get this error while trying to compile the radeonfb on 2.4.47


  gcc -Wp,-MD,drivers/video/.radeonfb.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=radeonfb   -c -o drivers/video/radeonfb.o
drivers/video/radeonfb.c
drivers/video/radeonfb.c:605: unknown field `fb_get_fix' specified in
initializer
drivers/video/radeonfb.c:605: warning: initialization from incompatible
pointer type
drivers/video/radeonfb.c:606: unknown field `fb_get_var' specified in
initializer
drivers/video/radeonfb.c:606: warning: initialization from incompatible
pointer type
drivers/video/radeonfb.c: In function `radeon_set_dispsw':
drivers/video/radeonfb.c:1385: structure has no member named `type'
drivers/video/radeonfb.c:1386: structure has no member named `type_aux'
drivers/video/radeonfb.c:1387: structure has no member named `ypanstep'
drivers/video/radeonfb.c:1388: structure has no member named `ywrapstep'
drivers/video/radeonfb.c:1397: structure has no member named `visual'
drivers/video/radeonfb.c:1398: structure has no member named
`line_length'
drivers/video/radeonfb.c:1405: structure has no member named `visual'
drivers/video/radeonfb.c:1406: structure has no member named
`line_length'
drivers/video/radeonfb.c:1413: structure has no member named `visual'
drivers/video/radeonfb.c:1414: structure has no member named
`line_length'
drivers/video/radeonfb.c:1421: structure has no member named `visual'
drivers/video/radeonfb.c:1422: structure has no member named
`line_length'
drivers/video/radeonfb.c: In function `radeonfb_get_fix':
drivers/video/radeonfb.c:1514: structure has no member named `type'
drivers/video/radeonfb.c:1515: structure has no member named `type_aux'
drivers/video/radeonfb.c:1516: structure has no member named `visual'
drivers/video/radeonfb.c:1522: structure has no member named
`line_length'
drivers/video/radeonfb.c: In function `radeonfb_set_var':
drivers/video/radeonfb.c:1578: structure has no member named
`line_length'
drivers/video/radeonfb.c:1579: structure has no member named `visual'
drivers/video/radeonfb.c:1590: structure has no member named
`line_length'
drivers/video/radeonfb.c:1591: structure has no member named `visual'
drivers/video/radeonfb.c:1606: structure has no member named
`line_length'
drivers/video/radeonfb.c:1607: structure has no member named `visual'
drivers/video/radeonfb.c:1619: structure has no member named
`line_length'
drivers/video/radeonfb.c:1620: structure has no member named `visual'
drivers/video/radeonfb.c: At top level:
drivers/video/radeonfb.c:2487: warning: `fbcon_radeon8' defined but not
used
drivers/video/radeonfb.c:598: warning: `radeon_read_OF' declared
`static' but never defined
drivers/video/radeonfb.c:1710: warning: `radeonfb_set_cmap' defined but
not used
make[3]: *** [drivers/video/radeonfb.o] Error 1
make[2]: *** [drivers/video] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.47'
make: *** [stamp-build] Error 2
