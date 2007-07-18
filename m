From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 2/3] drivers/video/aty/radeon_base:
	fix	radeonfb_pci_register() err handling
Date: Wed, 18 Jul 2007 01:55:24 -0400
Message-ID: <20070718055524.GA5748@havoc.gtf.org>
References: <20070718055348.GA5734@havoc.gtf.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IB2VU-0005nG-BW for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Jul 2007 22:55:28 -0700
Received: from havoc.gtf.org ([69.61.125.42])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IB2VU-00026P-0e
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Jul 2007 22:55:28 -0700
Content-Disposition: inline
In-Reply-To: <20070718055348.GA5734@havoc.gtf.org>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com


The following change was checked into 'warnings' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

commit 61470a24062de01853fb922ec4a81dcd1c0ba1d0
Author: Jeff Garzik <jeff@garzik.org>
Date:   Wed Jul 18 01:43:05 2007 -0400

    drivers/video/aty/radeon_base: fix radeonfb_pci_register() err handling
    
    * silence warnings by handling failure of sysfs_create_bin_file()
    
    * fix leak-on-error if register_framebuffer() fails, and sysfs is active
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

 drivers/video/aty/radeon_base.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

61470a24062de01853fb922ec4a81dcd1c0ba1d0
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

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
