From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH 2/11] atyfb: eliminate bad section references
Date: Wed, 9 Mar 2005 10:11:47 -0800
Message-ID: <20050309101147.1f63a7ad.rddunlap@osdl.org>
References: <20050309100825.0d77ded8.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D95vy-0001Gi-3f
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:26 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D95vv-0005qG-Cg
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
To: adaplas@pol.net, akpm@osdl.org
Cc: linux-fbdev-devel@lists.sourceforge.net


Fix atyfb references to __initdata from .text code sections
  by changing __initdata to __devinitdata.

Error: ./drivers/video/aty/atyfb_base.o .text refers to 0000000000002416 R_X86_64_32S      .init.data+0x00000000000004a0
Error: ./drivers/video/aty/atyfb_base.o .text refers to 0000000000002514 R_X86_64_32S      .init.data
Error: ./drivers/video/aty/atyfb_base.o .text refers to 000000000000253e R_X86_64_32S      .init.data+0x0000000000000060
Error: ./drivers/video/aty/atyfb_base.o .text refers to 00000000000026c4 R_X86_64_32S      .init.data+0x00000000000004a0
Error: ./drivers/video/aty/atyfb_base.o .text refers to 00000000000026e7 R_X86_64_32S      .init.data+0x0000000000000070
Error: ./drivers/video/aty/atyfb_base.o .text refers to 00000000000026ee R_X86_64_32S      .init.data+0x0000000000000068
Error: ./drivers/video/aty/atyfb_base.o .text refers to 00000000000026fa R_X86_64_32S      .init.data+0x0000000000000074
Error: ./drivers/video/aty/atyfb_base.o .text refers to 0000000000002706 R_X86_64_32S      .init.data+0x0000000000000078
Error: ./drivers/video/aty/atyfb_base.o .text refers to 0000000000002712 R_X86_64_32S      .init.data+0x000000000000007c
Error: ./drivers/video/aty/atyfb_base.o .text refers to 0000000000002afb R_X86_64_32S      .init.data+0x0000000000000560
Error: ./drivers/video/aty/atyfb_base.o .text refers to 0000000000002baa R_X86_64_32S      .init.data+0x00000000000004c0

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/aty/atyfb_base.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff -Naurp ./drivers/video/aty/atyfb_base.c~video_atyfb_sections ./drivers/video/aty/atyfb_base.c
--- ./drivers/video/aty/atyfb_base.c~video_atyfb_sections	2005-03-01 23:38:13.000000000 -0800
+++ ./drivers/video/aty/atyfb_base.c	2005-03-08 15:37:10.000000000 -0800
@@ -209,7 +209,7 @@ struct pci_mmap_map {
 	unsigned long prot_mask;
 };
 
-static struct fb_fix_screeninfo atyfb_fix __initdata = {
+static struct fb_fix_screeninfo atyfb_fix __devinitdata = {
 	.id		= "ATY Mach64",
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_PSEUDOCOLOR,
@@ -361,7 +361,7 @@ static struct {
 	const char *name;
 	int pll, mclk, xclk;
 	u32 features;
-} aty_chips[] __initdata = {
+} aty_chips[] __devinitdata = {
 #ifdef CONFIG_FB_ATY_GX
 	/* Mach64 GX */
 	{ PCI_CHIP_MACH64GX, "ATI888GX00 (Mach64 GX)", 135, 50, 50, ATI_CHIP_88800GX },
@@ -492,31 +492,31 @@ static int __devinit correct_chipset(str
 	return 0;
 }
 
-static char ram_dram[] __initdata = "DRAM";
-static char ram_resv[] __initdata = "RESV";
+static char ram_dram[] __devinitdata = "DRAM";
+static char ram_resv[] __devinitdata = "RESV";
 #ifdef CONFIG_FB_ATY_GX
-static char ram_vram[] __initdata = "VRAM";
+static char ram_vram[] __devinitdata = "VRAM";
 #endif /* CONFIG_FB_ATY_GX */
 #ifdef CONFIG_FB_ATY_CT
-static char ram_edo[] __initdata = "EDO";
-static char ram_sdram[] __initdata = "SDRAM (1:1)";
-static char ram_sgram[] __initdata = "SGRAM (1:1)";
-static char ram_sdram32[] __initdata = "SDRAM (2:1) (32-bit)";
-static char ram_off[] __initdata = "OFF";
+static char ram_edo[] __devinitdata = "EDO";
+static char ram_sdram[] __devinitdata = "SDRAM (1:1)";
+static char ram_sgram[] __devinitdata = "SGRAM (1:1)";
+static char ram_sdram32[] __devinitdata = "SDRAM (2:1) (32-bit)";
+static char ram_off[] __devinitdata = "OFF";
 #endif /* CONFIG_FB_ATY_CT */
 
 
 static u32 pseudo_palette[17];
 
 #ifdef CONFIG_FB_ATY_GX
-static char *aty_gx_ram[8] __initdata = {
+static char *aty_gx_ram[8] __devinitdata = {
 	ram_dram, ram_vram, ram_vram, ram_dram,
 	ram_dram, ram_vram, ram_vram, ram_resv
 };
 #endif /* CONFIG_FB_ATY_GX */
 
 #ifdef CONFIG_FB_ATY_CT
-static char *aty_ct_ram[8] __initdata = {
+static char *aty_ct_ram[8] __devinitdata = {
 	ram_off, ram_dram, ram_edo, ram_edo,
 	ram_sdram, ram_sgram, ram_sdram32, ram_resv
 };


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
