From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH 8/11] riva: eliminate bad section references
Date: Wed, 9 Mar 2005 10:24:00 -0800
Message-ID: <20050309102400.4bb15e93.rddunlap@osdl.org>
References: <20050309100825.0d77ded8.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D95vy-0001Go-Fa
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:26 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D95vw-0005qi-Rp
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:26 -0800
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


Fix riva sections references:
  change __initdata to __devinitdata.

Error: ./drivers/video/riva/fbdev.o .text refers to 0000000000001e64 R_X86_64_32S      .init.data+0x0000000000000020
Error: ./drivers/video/riva/fbdev.o .text refers to 0000000000001e6f R_X86_64_PC32     .init.data+0x0000000000000004
Error: ./drivers/video/riva/fbdev.o .text refers to 0000000000001e7c R_X86_64_PC32     .init.data+0x0000000000000003
Error: ./drivers/video/riva/fbdev.o .text refers to 0000000000001e93 R_X86_64_PC32     .init.data
Error: ./drivers/video/riva/fbdev.o .text refers to 0000000000001ec6 R_X86_64_PC32     .init.data+0x000000000000005c
Error: ./drivers/video/riva/fbdev.o .text refers to 0000000000001ef2 R_X86_64_PC32     .init.data+0x0000000000000034
Error: ./drivers/video/riva/fbdev.o .text refers to 0000000000001f38 R_X86_64_PC32     .init.data+0x000000000000005c
Error: ./drivers/video/riva/fbdev.o .text refers to 0000000000001f41 R_X86_64_PC32     .init.data+0x0000000000000054
Error: ./drivers/video/riva/fbdev.o .text refers to 0000000000001f4f R_X86_64_PC32     .init.data+0x000000000000002c
Error: ./drivers/video/riva/fbdev.o .text refers to 0000000000001f94 R_X86_64_PC32     .init.data+0x000000000000002c
Error: ./drivers/video/riva/fbdev.o .text refers to 000000000000201a R_X86_64_PC32     .init.data+0x0000000000000034
Error: ./drivers/video/riva/fbdev.o .text refers to 0000000000002035 R_X86_64_PC32     .init.data+0x0000000000000034
Error: ./drivers/video/riva/fbdev.o .text refers to 000000000000203c R_X86_64_PC32     .init.data+0x000000000000002c
Error: ./drivers/video/riva/fbdev.o .text refers to 000000000000206b R_X86_64_PC32     .init.data+0xfffffffffffffffb
Error: ./drivers/video/riva/fbdev.o .text refers to 0000000000002074 R_X86_64_PC32     .init.data+0x0000000000000034
Error: ./drivers/video/riva/fbdev.o .text refers to 000000000000207b R_X86_64_PC32     .init.data+0x000000000000002c
Error: ./drivers/video/riva/fbdev.o .text refers to 00000000000020e7 R_X86_64_32S      .init.data+0x0000000000000020
Error: ./drivers/video/riva/fbdev.o .text refers to 00000000000021cb R_X86_64_32S      .init.data+0x0000000000000080
Error: ./drivers/video/riva/fbdev.o .text refers to 000000000000220f R_X86_64_PC32     .init.data+0x000000000000011c
Error: ./drivers/video/riva/fbdev.o .text refers to 000000000000228e R_X86_64_32S      .init.data+0x0000000000000080
Error: ./drivers/video/riva/fbdev.o .text refers to 00000000000022ea R_X86_64_PC32     .init.data+0x0000000000000007

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/riva/fbdev.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff -Naurp ./drivers/video/riva/fbdev.c~video_riva_sections ./drivers/video/riva/fbdev.c
--- ./drivers/video/riva/fbdev.c~video_riva_sections	2005-03-08 14:13:34.000000000 -0800
+++ ./drivers/video/riva/fbdev.c	2005-03-08 14:15:10.000000000 -0800
@@ -208,23 +208,23 @@ MODULE_DEVICE_TABLE(pci, rivafb_pci_tbl)
  * ------------------------------------------------------------------------- */
 
 /* command line data, set in rivafb_setup() */
-static int flatpanel __initdata = -1; /* Autodetect later */
-static int forceCRTC __initdata = -1;
-static int noaccel   __initdata = 0;
+static int flatpanel __devinitdata = -1; /* Autodetect later */
+static int forceCRTC __devinitdata = -1;
+static int noaccel   __devinitdata = 0;
 #ifdef CONFIG_MTRR
-static int nomtrr __initdata = 0;
+static int nomtrr __devinitdata = 0;
 #endif
 
-static char *mode_option __initdata = NULL;
+static char *mode_option __devinitdata = NULL;
 static int  strictmode       = 0;
 
-static struct fb_fix_screeninfo __initdata rivafb_fix = {
+static struct fb_fix_screeninfo __devinitdata rivafb_fix = {
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.xpanstep	= 1,
 	.ypanstep	= 1,
 };
 
-static struct fb_var_screeninfo __initdata rivafb_default_var = {
+static struct fb_var_screeninfo __devinitdata rivafb_default_var = {
 	.xres		= 640,
 	.yres		= 480,
 	.xres_virtual	= 640,


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
