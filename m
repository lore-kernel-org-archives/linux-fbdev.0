From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/5] fbdev: Various mach64 changes
Date: Fri, 22 Oct 2004 00:57:22 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041022005722.6f90d3c4.akpm@osdl.org>
References: <200410200815.41690.adaplas@hotpop.com>
	<20041022005531.28218795.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKuKU-0007Tz-Od
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Oct 2004 00:59:18 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CKuKU-0002bc-2b
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Oct 2004 00:59:18 -0700
In-Reply-To: <20041022005531.28218795.akpm@osdl.org>
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
To: adaplas@pol.net, adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net, alex.kern@gmx.de, arnaud.fontaine@free.fr, geert@linux-m68k.org, jsimmons@infradead.org, nsouch@free.fr, syrjala@sci.fi


Actually, I'll use the below patch just to make it compile.



Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-sparc64-akpm/drivers/video/aty/atyfb_base.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff -puN drivers/video/aty/atyfb_base.c~fbdev-various-mach64-changes-sparc64-fix drivers/video/aty/atyfb_base.c
--- 25-sparc64/drivers/video/aty/atyfb_base.c~fbdev-various-mach64-changes-sparc64-fix	2004-10-22 00:47:03.000000000 -0700
+++ 25-sparc64-akpm/drivers/video/aty/atyfb_base.c	2004-10-22 00:56:18.377055112 -0700
@@ -2746,9 +2746,11 @@ static int atyfb_setcolreg(u_int regno, 
 
 #ifdef __sparc__
 
-static int __devinit atyfb_setup_sparc(struct pci_dev *pdev, struct fb_indo *info, unsigned long addr)
+extern void (*prom_palette) (int);
+
+static int __devinit atyfb_setup_sparc(struct pci_dev *pdev,
+			struct fb_info *info, unsigned long addr)
 {
-	extern void (*prom_palette) (int);
 	extern int con_is_present(void);
 
 	struct atyfb_par *par = info->par;
@@ -2764,7 +2766,7 @@ static int __devinit atyfb_setup_sparc(s
 	/*
 	 * Map memory-mapped registers.
 	 */
-	par->ati_regbase = addr + 0x7ffc00UL;
+	par->ati_regbase = (void *)addr + 0x7ffc00UL;
 	info->fix.mmio_start = addr + 0x7ffc00UL;
 
 	/*
@@ -2782,7 +2784,7 @@ static int __devinit atyfb_setup_sparc(s
 	j = i + 4;
 
 	par->mmap_map = kmalloc(j * sizeof(*par->mmap_map), GFP_ATOMIC);
-	if (!_par->mmap_map) {
+	if (!par->mmap_map) {
 		PRINTKE("atyfb_setup_sparc() can't alloc mmap_map\n");
 		return -ENOMEM;
 	}
@@ -3394,7 +3396,7 @@ static int __devinit atyfb_pci_probe(str
 	par->mmap_map[0].prot_mask = _PAGE_CACHE;
 	par->mmap_map[0].prot_flag = _PAGE_E;
 	par->mmap_map[1].voff = par->mmap_map[0].voff + info->fix.smem_len;
-	par->mmap_map[1].poff = par->ati_regbase & PAGE_MASK;
+	par->mmap_map[1].poff = (long)par->ati_regbase & PAGE_MASK;
 	par->mmap_map[1].size = PAGE_SIZE;
 	par->mmap_map[1].prot_mask = _PAGE_CACHE;
 	par->mmap_map[1].prot_flag = _PAGE_E;
_



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
