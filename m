From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH 11/11] tdfxfb: eliminate bad section references
Date: Wed, 9 Mar 2005 10:27:41 -0800
Message-ID: <20050309102741.72bae5f6.rddunlap@osdl.org>
References: <20050309100825.0d77ded8.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D95w4-0001HY-JZ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:32 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D95w3-0005rN-LA
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:32 -0800
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
To: adaplas <adaplas@pol.net>, akpm <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


Fix tdfxfb section references:
  convert __initdata to __devinitdata.

Error: ./drivers/video/tdfxfb.o .text refers to 0000000000000e6f R_X86_64_PC32     .init.data+0xfffffffffffffffc
Error: ./drivers/video/tdfxfb.o .text refers to 0000000000000fea R_X86_64_32S      .init.data+0x00000000000000c0
Error: ./drivers/video/tdfxfb.o .text refers to 0000000000001006 R_X86_64_32S      .init.data+0x00000000000000c0
Error: ./drivers/video/tdfxfb.o .text refers to 0000000000001022 R_X86_64_32S      .init.data+0x00000000000000c0
Error: ./drivers/video/tdfxfb.o .text refers to 000000000000103c R_X86_64_PC32     .init.data+0x00000000000000f4
Error: ./drivers/video/tdfxfb.o .text refers to 0000000000001067 R_X86_64_PC32     .init.data+0x00000000000000f4
Error: ./drivers/video/tdfxfb.o .text refers to 000000000000106f R_X86_64_PC32     .init.data+0x00000000000000fc
Error: ./drivers/video/tdfxfb.o .text refers to 0000000000001084 R_X86_64_32S      .init.data+0x00000000000000c0
Error: ./drivers/video/tdfxfb.o .text refers to 00000000000010f1 R_X86_64_PC32     .init.data+0x00000000000000cc
Error: ./drivers/video/tdfxfb.o .text refers to 00000000000011b8 R_X86_64_PC32     .init.data+0x00000000000000d4
Error: ./drivers/video/tdfxfb.o .text refers to 00000000000011c1 R_X86_64_32S      .init.data+0x00000000000000c0
Error: ./drivers/video/tdfxfb.o .text refers to 000000000000122b R_X86_64_PC32     .init.data+0x00000000000000d4
Error: ./drivers/video/tdfxfb.o .text refers to 0000000000001232 R_X86_64_PC32     .init.data+0x00000000000000cc
Error: ./drivers/video/tdfxfb.o .text refers to 000000000000124a R_X86_64_32S      .init.data+0x00000000000000c0
Error: ./drivers/video/tdfxfb.o .text refers to 0000000000001320 R_X86_64_PC32     .init.data+0x00000000000000d4
Error: ./drivers/video/tdfxfb.o .text refers to 0000000000001327 R_X86_64_32S      .init.data+0x00000000000000c0
Error: ./drivers/video/tdfxfb.o .text refers to 000000000000134c R_X86_64_32S      .init.data+0x00000000000000c0
Error: ./drivers/video/tdfxfb.o .text refers to 000000000000136a R_X86_64_PC32     .init.data+0x00000000000000e6
Error: ./drivers/video/tdfxfb.o .text refers to 000000000000137d R_X86_64_PC32     .init.data+0x00000000000000e8
Error: ./drivers/video/tdfxfb.o .text refers to 00000000000013b1 R_X86_64_PC32     .init.data+0xfffffffffffffffc
Error: ./drivers/video/tdfxfb.o .text refers to 00000000000013c5 R_X86_64_PC32     .init.data+0xfffffffffffffffc
Error: ./drivers/video/tdfxfb.o .text refers to 00000000000013e4 R_X86_64_32S      .init.data+0x0000000000000020

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/tdfxfb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -Naurp ./drivers/video/tdfxfb.c~video_tdfxfb_sections ./drivers/video/tdfxfb.c
--- ./drivers/video/tdfxfb.c~video_tdfxfb_sections	2005-03-01 23:37:51.000000000 -0800
+++ ./drivers/video/tdfxfb.c	2005-03-08 13:37:00.000000000 -0800
@@ -89,7 +89,7 @@
 #define VOODOO3_MAX_PIXCLOCK 300000
 #define VOODOO5_MAX_PIXCLOCK 350000
 
-static struct fb_fix_screeninfo tdfx_fix __initdata = {
+static struct fb_fix_screeninfo tdfx_fix __devinitdata = {
 	.id =		"3Dfx",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR, 
@@ -98,7 +98,7 @@ static struct fb_fix_screeninfo tdfx_fix
 	.accel =	FB_ACCEL_3DFX_BANSHEE
 };
 
-static struct fb_var_screeninfo tdfx_var __initdata = {
+static struct fb_var_screeninfo tdfx_var __devinitdata = {
 	/* "640x480, 8 bpp @ 60 Hz */
 	.xres =		640,
 	.yres =		480,
@@ -202,7 +202,7 @@ static unsigned long do_lfb_size(struct 
  */
 static int  nopan   = 0;
 static int  nowrap  = 1;      // not implemented (yet)
-static char *mode_option __initdata = NULL;
+static char *mode_option __devinitdata = NULL;
 
 /* ------------------------------------------------------------------------- 
  *                      Hardware-specific funcions


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
