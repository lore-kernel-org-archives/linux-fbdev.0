From: Michael Kummer <michael@kummer.cc>
Subject: Linux v2.5.46 (compile error) (rivafb) (fwd)
Date: Tue, 5 Nov 2002 13:12:12 +0100 (CET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211051311540.244-100000@epo>
Reply-To: michael@kummer.cc
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from kryton.mki.bz ([195.58.191.168] helo=mx0.mki.bz)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1892ZJ-0003kK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 05 Nov 2002 04:12:30 -0800
Received: from nandrolon (nandrolon [195.58.191.164])
	by mx0.mki.bz (Postfix) with ESMTP id 0EF2B108C7
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  5 Nov 2002 13:16:06 +0100 (CET)
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
To: linux-fbdev-devel@lists.sourceforge.net

make -f scripts/Makefile.build obj=drivers/video/riva
  gcc -Wp,-MD,drivers/video/riva/.fbdev.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4 -Iarch/i386/mach-generic -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=fbdev   -c -o
drivers/video/riva/fbdev.o drivers/video/riva/fbdev.c
drivers/video/riva/fbdev.c: In function `riva_set_dispsw':
drivers/video/riva/fbdev.c:665: structure has no member named `type'
drivers/video/riva/fbdev.c:666: structure has no member named `type_aux'
drivers/video/riva/fbdev.c:667: structure has no member named `ypanstep'
drivers/video/riva/fbdev.c:668: structure has no member named `ywrapstep'
drivers/video/riva/fbdev.c:677: structure has no member named
`line_length'
drivers/video/riva/fbdev.c:678: structure has no member named `visual'
drivers/video/riva/fbdev.c:686: structure has no member named
`line_length'
drivers/video/riva/fbdev.c:687: structure has no member named `visual'
drivers/video/riva/fbdev.c:695: structure has no member named
`line_length'
drivers/video/riva/fbdev.c:696: structure has no member named `visual'
drivers/video/riva/fbdev.c: In function `rivafb_get_fix':
drivers/video/riva/fbdev.c:1294: structure has no member named `type'
drivers/video/riva/fbdev.c:1295: structure has no member named `type_aux'
drivers/video/riva/fbdev.c:1296: structure has no member named `visual'
drivers/video/riva/fbdev.c:1302: structure has no member named
`line_length'
drivers/video/riva/fbdev.c: In function `rivafb_pan_display':
drivers/video/riva/fbdev.c:1611: structure has no member named
`line_length'
drivers/video/riva/fbdev.c:1586: warning: `base' might be used
uninitialized in this function
drivers/video/riva/fbdev.c: At top level:
drivers/video/riva/fbdev.c:1748: unknown field `fb_get_fix' specified in
initializer
drivers/video/riva/fbdev.c:1748: warning: initialization from incompatible
pointer type
drivers/video/riva/fbdev.c:1749: unknown field `fb_get_var' specified in
initializer
drivers/video/riva/fbdev.c:1749: warning: initialization from incompatible
pointer type
make[3]: *** [drivers/video/riva/fbdev.o] Error 1
make[2]: *** [drivers/video/riva] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2


-- 
best regards


Michael Kummer

--
Michael Kummer - [A]ustrian [E]lite [S]printer
Lieferinger-Hauptstrasse 47 - A 5020 Salzburg
Mobile: +43 664 3333995
EMail: michael@kummer.cc
Web: http://www.sprinter.cc





-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
