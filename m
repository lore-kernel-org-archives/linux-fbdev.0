From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH 6/11] pm2fb: eliminate bad section references
Date: Wed, 9 Mar 2005 10:19:15 -0800
Message-ID: <20050309101915.6d7b7ea6.rddunlap@osdl.org>
References: <20050309100825.0d77ded8.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D95vy-0001Gh-1e
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:26 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D95vx-0007gP-6I
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:25 -0800
In-Reply-To: <20050309100825.0d77ded8.rddunlap@osdl.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net, akpm@osdl.org
Cc: linux-fbdev-devel@lists.sourceforge.net


Fix pm2fb section references by changing referenced
  __initdata to __devinitdata.

Error: ./drivers/video/pm2fb.o .text refers to 0000000000000ad4 R_X86_64_PC32     .init.data+0x0000000000000007
Error: ./drivers/video/pm2fb.o .text refers to 0000000000000afc R_X86_64_PC32     .init.data+0x0000000000000003
Error: ./drivers/video/pm2fb.o .text refers to 000000000000147e R_X86_64_PC32     .init.data+0x00000000000000bc
Error: ./drivers/video/pm2fb.o .text refers to 0000000000001491 R_X86_64_PC32     .init.data+0x00000000000000c2
Error: ./drivers/video/pm2fb.o .text refers to 000000000000149a R_X86_64_PC32     .init.data+0x00000000000000bc
Error: ./drivers/video/pm2fb.o .text refers to 00000000000014aa R_X86_64_32S      .init.data+0x00000000000000c0
Error: ./drivers/video/pm2fb.o .text refers to 00000000000014e0 R_X86_64_PC32     .init.data+0x00000000000000f8
Error: ./drivers/video/pm2fb.o .text refers to 00000000000014eb R_X86_64_PC32     .init.data+0x00000000000000f4
Error: ./drivers/video/pm2fb.o .text refers to 000000000000150e R_X86_64_PC32     .init.data+0x00000000000000fc
Error: ./drivers/video/pm2fb.o .text refers to 0000000000001515 R_X86_64_PC32     .init.data+0x00000000000000f4
Error: ./drivers/video/pm2fb.o .text refers to 000000000000152d R_X86_64_32S      .init.data+0x00000000000000c0
Error: ./drivers/video/pm2fb.o .text refers to 00000000000015ce R_X86_64_PC32     .init.data+0x00000000000000cc
Error: ./drivers/video/pm2fb.o .text refers to 00000000000015d7 R_X86_64_PC32     .init.data+0x00000000000000d4
Error: ./drivers/video/pm2fb.o .text refers to 00000000000015fa R_X86_64_PC32     .init.data+0x00000000000000d4
Error: ./drivers/video/pm2fb.o .text refers to 0000000000001601 R_X86_64_PC32     .init.data+0x00000000000000cc
Error: ./drivers/video/pm2fb.o .text refers to 0000000000001644 R_X86_64_32S      .init.data+0x00000000000000c0
Error: ./drivers/video/pm2fb.o .text refers to 0000000000001674 R_X86_64_PC32     .init.data+0xfffffffffffffffc
Error: ./drivers/video/pm2fb.o .text refers to 000000000000168e R_X86_64_PC32     .init.data+0xfffffffffffffffc
Error: ./drivers/video/pm2fb.o .text refers to 00000000000016af R_X86_64_32S      .init.data+0x0000000000000020
Error: ./drivers/video/pm2fb.o .text refers to 0000000000001724 R_X86_64_PC32     .init.data+0x00000000000000d4
Error: ./drivers/video/pm2fb.o .text refers to 000000000000172b R_X86_64_PC32     .init.data+0x00000000000000cc
Error: ./drivers/video/pm2fb.o .text refers to 0000000000001746 R_X86_64_PC32     .init.data+0x00000000000000fc
Error: ./drivers/video/pm2fb.o .text refers to 000000000000174d R_X86_64_PC32     .init.data+0x00000000000000f4

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/pm2fb.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -Naurp ./drivers/video/pm2fb.c~video_pm2fb_sections ./drivers/video/pm2fb.c
--- ./drivers/video/pm2fb.c~video_pm2fb_sections	2005-03-01 23:38:33.000000000 -0800
+++ ./drivers/video/pm2fb.c	2005-03-08 13:51:26.000000000 -0800
@@ -62,7 +62,7 @@
 /*
  * Driver data 
  */
-static char *mode __initdata = NULL;
+static char *mode __devinitdata = NULL;
 
 /*
  * The XFree GLINT driver will (I think to implement hardware cursor
@@ -73,8 +73,8 @@ static char *mode __initdata = NULL;
  * these flags allow the user to specify that requests for +ve sync
  * should be silently turned in -ve sync.
  */
-static int lowhsync __initdata = 0;
-static int lowvsync __initdata = 0;	
+static int lowhsync __devinitdata = 0;
+static int lowvsync __devinitdata = 0;	
 
 /*
  * The hardware state of the graphics card that isn't part of the
@@ -97,7 +97,7 @@ struct pm2fb_par
  * Here we define the default structs fb_fix_screeninfo and fb_var_screeninfo
  * if we don't use modedb.
  */
-static struct fb_fix_screeninfo pm2fb_fix __initdata = {
+static struct fb_fix_screeninfo pm2fb_fix __devinitdata = {
 	.id =		"", 
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
@@ -110,7 +110,7 @@ static struct fb_fix_screeninfo pm2fb_fi
 /*
  * Default video mode. In case the modedb doesn't work.
  */
-static struct fb_var_screeninfo pm2fb_var __initdata = {
+static struct fb_var_screeninfo pm2fb_var __devinitdata = {
 	/* "640x480, 8 bpp @ 60 Hz */
 	.xres =		640,
 	.yres =		480,


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
