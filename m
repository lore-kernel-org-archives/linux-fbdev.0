From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH 1/11] asiliantfb: eliminate bad section references
Date: Wed, 9 Mar 2005 10:10:55 -0800
Message-ID: <20050309101055.2ad16211.rddunlap@osdl.org>
References: <20050309100825.0d77ded8.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D95vw-0001GV-W6
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:29:24 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D95vv-0007fc-3o
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


asiliantfb refers to __initdata that should be __devinitdata
  and calls __init functions that should be __devinit;

Error: ./drivers/video/asiliantfb.o .text refers to 00000000000006ee R_X86_64_32S      .init.data+0x00000000000000a0
Error: ./drivers/video/asiliantfb.o .text refers to 0000000000000711 R_X86_64_32S      .init.data

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/asiliantfb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -Naurp ./drivers/video/asiliantfb.c~video_asil_sections ./drivers/video/asiliantfb.c
--- ./drivers/video/asiliantfb.c~video_asil_sections	2005-03-01 23:38:26.000000000 -0800
+++ ./drivers/video/asiliantfb.c	2005-03-07 20:30:12.000000000 -0800
@@ -465,7 +465,7 @@ static struct chips_init_reg chips_init_
 	{0xd1, 0x01},
 };
 
-static void __init chips_hw_init(struct fb_info *p)
+static void __devinit chips_hw_init(struct fb_info *p)
 {
 	int i;
 
@@ -488,7 +488,7 @@ static void __init chips_hw_init(struct 
 		write_fr(chips_init_fr[i].addr, chips_init_fr[i].data);
 }
 
-static struct fb_fix_screeninfo asiliantfb_fix __initdata = {
+static struct fb_fix_screeninfo asiliantfb_fix __devinitdata = {
 	.id =		"Asiliant 69000",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
@@ -497,7 +497,7 @@ static struct fb_fix_screeninfo asiliant
 	.smem_len =	0x200000,	/* 2MB */
 };
 
-static struct fb_var_screeninfo asiliantfb_var __initdata = {
+static struct fb_var_screeninfo asiliantfb_var __devinitdata = {
 	.xres 		= 640,
 	.yres 		= 480,
 	.xres_virtual 	= 640,
@@ -518,7 +518,7 @@ static struct fb_var_screeninfo asiliant
 	.vsync_len 	= 2,
 };
 
-static void __init init_asiliant(struct fb_info *p, unsigned long addr)
+static void __devinit init_asiliant(struct fb_info *p, unsigned long addr)
 {
 	p->fix			= asiliantfb_fix;
 	p->fix.smem_start	= addr;


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
