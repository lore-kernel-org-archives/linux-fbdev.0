From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH 4/11] kyro: eliminate bad section references
Date: Wed, 9 Mar 2005 10:17:37 -0800
Message-ID: <20050309101737.7041301a.rddunlap@osdl.org>
References: <20050309100825.0d77ded8.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D95vx-0001Gf-F3
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:25 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D95vv-0007gK-6j
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:24 -0800
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


Fix kyro sections references by changing __initdata
  to __devinitdata.

Error: ./drivers/video/kyro/fbdev.o .text refers to 0000000000000692 R_X86_64_PC32     .init.data+0x000000000000090c
Error: ./drivers/video/kyro/fbdev.o .text refers to 00000000000006c2 R_X86_64_PC32     .init.data+0x0000000000000914
Error: ./drivers/video/kyro/fbdev.o .text refers to 00000000000006d1 R_X86_64_PC32     .init.data+0x0000000000000934
Error: ./drivers/video/kyro/fbdev.o .text refers to 0000000000000709 R_X86_64_PC32     .init.data+0x0000000000000934
Error: ./drivers/video/kyro/fbdev.o .text refers to 0000000000000711 R_X86_64_PC32     .init.data+0x000000000000093c
Error: ./drivers/video/kyro/fbdev.o .text refers to 0000000000000727 R_X86_64_PC32     .init.data+0x000000000000090c
Error: ./drivers/video/kyro/fbdev.o .text refers to 000000000000072d R_X86_64_PC32     .init.data+0x0000000000000914
Error: ./drivers/video/kyro/fbdev.o .text refers to 000000000000073f R_X86_64_PC32     .init.data+0x00000000000008eb
Error: ./drivers/video/kyro/fbdev.o .text refers to 0000000000000748 R_X86_64_PC32     .init.data+0x0000000000000914
Error: ./drivers/video/kyro/fbdev.o .text refers to 000000000000075b R_X86_64_PC32     .init.data+0x000000000000090c
Error: ./drivers/video/kyro/fbdev.o .text refers to 0000000000000778 R_X86_64_32S      .init.data+0x0000000000000900
Error: ./drivers/video/kyro/fbdev.o .text refers to 000000000000077e R_X86_64_PC32     .init.data+0x00000000000008e7
Error: ./drivers/video/kyro/fbdev.o .text refers to 0000000000000793 R_X86_64_PC32     .init.data+0x0000000000000926
Error: ./drivers/video/kyro/fbdev.o .text refers to 000000000000079b R_X86_64_PC32     .init.data+0x00000000000008e3
Error: ./drivers/video/kyro/fbdev.o .text refers to 00000000000007a6 R_X86_64_PC32     .init.data+0x0000000000000928
Error: ./drivers/video/kyro/fbdev.o .text refers to 00000000000007f1 R_X86_64_PC32     .init.data+0x00000000000008dc
Error: ./drivers/video/kyro/fbdev.o .text refers to 00000000000007f8 R_X86_64_32S      .init.data+0x0000000000000420
Error: ./drivers/video/kyro/fbdev.o .text refers to 0000000000000805 R_X86_64_32S      .init.data+0x00000000000000a0
Error: ./drivers/video/kyro/fbdev.o .text refers to 0000000000000834 R_X86_64_32S      .init.data

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/kyro/fbdev.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff -Naurp ./drivers/video/kyro/fbdev.c~video_kyro_sections ./drivers/video/kyro/fbdev.c
--- ./drivers/video/kyro/fbdev.c~video_kyro_sections	2005-03-01 23:37:31.000000000 -0800
+++ ./drivers/video/kyro/fbdev.c	2005-03-08 13:57:10.000000000 -0800
@@ -43,14 +43,14 @@
 #define KHZ2PICOS(a) (1000000000UL/(a))
 
 /****************************************************************************/
-static struct fb_fix_screeninfo kyro_fix __initdata = {
+static struct fb_fix_screeninfo kyro_fix __devinitdata = {
 	.id		= "ST Kyro",
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_TRUECOLOR,
 	.accel		= FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo kyro_var __initdata = {
+static struct fb_var_screeninfo kyro_var __devinitdata = {
 	/* 640x480, 16bpp @ 60 Hz */
 	.xres		= 640,
 	.yres		= 480,
@@ -86,18 +86,18 @@ typedef struct {
 /* global graphics card info structure (one per card) */
 static device_info_t deviceInfo;
 
-static char *mode_option __initdata = NULL;
-static int nopan __initdata = 0;
-static int nowrap __initdata = 1;
+static char *mode_option __devinitdata = NULL;
+static int nopan __devinitdata = 0;
+static int nowrap __devinitdata = 1;
 #ifdef CONFIG_MTRR
-static int nomtrr __initdata = 0;
+static int nomtrr __devinitdata = 0;
 #endif
 
 /* PCI driver prototypes */
 static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
 static void kyrofb_remove(struct pci_dev *pdev);
 
-static struct fb_videomode kyro_modedb[] __initdata = {
+static struct fb_videomode kyro_modedb[] __devinitdata = {
 	{
 		/* 640x350 @ 85Hz */
 		NULL, 85, 640, 350, KHZ2PICOS(31500),


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
