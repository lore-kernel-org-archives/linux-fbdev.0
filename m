From: Jeff Garzik <jeff@garzik.org>
Subject: [git patches] two warning fixes
Date: Wed, 18 Jul 2007 19:55:04 -0400
Message-ID: <20070718235504.GA9601@havoc.gtf.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBJMK-0001xf-Ct for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 16:55:08 -0700
Received: from havoc.gtf.org ([69.61.125.42])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IBJMI-0000WS-TL
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 16:55:08 -0700
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, adaplas@gmail.com, ak@suse.de


Please pull from 'warnings' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git warnings

to receive the following updates:

 drivers/video/aty/radeon_base.c |   23 ++++++++++++++++++-----
 include/asm-x86_64/tlbflush.h   |    6 +++++-
 2 files changed, 23 insertions(+), 6 deletions(-)

Jeff Garzik (2):
      drivers/video/aty/radeon_base: fix radeonfb_pci_register() err handling
      [X86-64] make flush_tlb_kernel_range() a static inline function

diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 47ca62f..5a5458b 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -2326,10 +2326,16 @@ static int __devinit radeonfb_pci_register (struct pci_dev *pdev,
 	radeon_check_modes(rinfo, mode_option);
 
 	/* Register some sysfs stuff (should be done better) */
-	if (rinfo->mon1_EDID)
-		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
-	if (rinfo->mon2_EDID)
-		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
+	if (rinfo->mon1_EDID) {
+		ret = sysfs_create_bin_file(&rinfo->pdev->dev.kobj,&edid1_attr);
+		if (ret)
+			goto err_unmap_fb;
+	}
+	if (rinfo->mon2_EDID) {
+		ret = sysfs_create_bin_file(&rinfo->pdev->dev.kobj,&edid2_attr);
+		if (ret)
+			goto err_free_mon1;
+	}
 
 	/* save current mode regs before we switch into the new one
 	 * so we can restore this upon __exit
@@ -2353,7 +2359,7 @@ static int __devinit radeonfb_pci_register (struct pci_dev *pdev,
 	if (ret < 0) {
 		printk (KERN_ERR "radeonfb (%s): could not register framebuffer\n",
 			pci_name(rinfo->pdev));
-		goto err_unmap_fb;
+		goto err_free_mon2;
 	}
 
 #ifdef CONFIG_MTRR
@@ -2372,6 +2378,13 @@ static int __devinit radeonfb_pci_register (struct pci_dev *pdev,
 	RTRACE("radeonfb_pci_register END\n");
 
 	return 0;
+
+err_free_mon2:
+	if (rinfo->mon2_EDID)
+		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
+err_free_mon1:
+	if (rinfo->mon1_EDID)
+		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
 err_unmap_fb:
 	iounmap(rinfo->fb_base);
 err_unmap_rom:
diff --git a/include/asm-x86_64/tlbflush.h b/include/asm-x86_64/tlbflush.h
index 8516225..a82464c 100644
--- a/include/asm-x86_64/tlbflush.h
+++ b/include/asm-x86_64/tlbflush.h
@@ -92,7 +92,11 @@ static inline void flush_tlb_range(struct vm_area_struct * vma, unsigned long st
 
 #endif
 
-#define flush_tlb_kernel_range(start, end) flush_tlb_all()
+static inline void flush_tlb_kernel_range(unsigned long start,
+					  unsigned long end)
+{
+	flush_tlb_all();
+}
 
 static inline void flush_tlb_pgtables(struct mm_struct *mm,
 				      unsigned long start, unsigned long end)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
