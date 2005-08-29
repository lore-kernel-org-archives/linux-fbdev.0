From: Olaf Hering <olh@suse.de>
Subject: [PATCH] better error handing in savagefb_probe
Date: Mon, 29 Aug 2005 21:42:28 +0200
Message-ID: <20050829194228.GA16954@suse.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E9pWi-0000Hp-Fk
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Aug 2005 12:42:40 -0700
Received: from mx2.suse.de ([195.135.220.15])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E9pWi-0002km-8K
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Aug 2005 12:42:40 -0700
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net


err remains uninitialized of pci_request_regions fails.

Found by Thorsten Kukuk, I added a few more checks.


Signed-off-by: Olaf Hering <olh@suse.de>

 drivers/video/savage/savagefb_driver.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.13-savage/drivers/video/savage/savagefb_driver.c
===================================================================
--- linux-2.6.13-savage.orig/drivers/video/savage/savagefb_driver.c
+++ linux-2.6.13-savage/drivers/video/savage/savagefb_driver.c
@@ -1899,12 +1899,11 @@ static int __devinit savage_init_fb_info
 		info->pixmap.buf_align = 4;
 		info->pixmap.access_align = 32;
 
-		fb_alloc_cmap (&info->cmap, NR_PALETTE, 0);
+		err = fb_alloc_cmap (&info->cmap, NR_PALETTE, 0);
+		if (!err)
 		info->flags |= FBINFO_HWACCEL_COPYAREA |
 	                       FBINFO_HWACCEL_FILLRECT |
 		               FBINFO_HWACCEL_IMAGEBLIT;
-
-		err = 0;
 	}
 #endif
 	return err;
@@ -1932,14 +1931,14 @@ static int __devinit savagefb_probe (str
 	if (err)
 		goto failed_enable;
 
-	if (pci_request_regions(dev, "savagefb")) {
+	if ((err = pci_request_regions(dev, "savagefb"))) {
 		printk(KERN_ERR "cannot request PCI regions\n");
 		goto failed_enable;
 	}
 
 	err = -ENOMEM;
 
-	if (savage_init_fb_info(info, dev, id))
+	if ((err = savage_init_fb_info(info, dev, id)))
 		goto failed_init;
 
 	err = savage_map_mmio(info);
@@ -1947,6 +1946,7 @@ static int __devinit savagefb_probe (str
 		goto failed_mmio;
 
 	video_len = savage_init_hw(par);
+	/* FIXME: cant be negative */
 	if (video_len < 0) {
 		err = video_len;
 		goto failed_mmio;


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
