From: Andrew Morton <akpm@osdl.org>
Subject: Fw: Rivafb I2C problem, new patch
Date: Mon, 12 Jul 2004 16:39:42 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040712163942.672d4047.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__12_Jul_2004_16_39_42_-0700_7gGbGfkixgVX2Dva"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BkALe-0007uQ-8W
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Jul 2004 16:36:38 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BkALd-0000JL-Qr
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Jul 2004 16:36:38 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Greg KH <greg@kroah.com>, Nicolas Boichat <nicolas@boichat.ch>

This is a multi-part message in MIME format.

--Multipart=_Mon__12_Jul_2004_16_39_42_-0700_7gGbGfkixgVX2Dva
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Maybe Greg, or the linux-fbdev-devel denizens can comment upon
this?


Begin forwarded message:

Date: Tue, 13 Jul 2004 01:24:02 +0200
From: Nicolas Boichat <nicolas@boichat.ch>
To: akpm@digeo.com
Subject: Rivafb I2C problem, new patch


Hello,

I'm currently writing a DDC/CI tool for Linux (DDC/CI is the protocol which permits to modify monitor parameters without using the OSD), see http://www.boichat.ch/nicolas/ddcci .

I use the new rivafb I2C support, but a problem appeared: the I2C bus is immediately deleted after the DDC2 EDID is read, but I need to access it from my application!

I attached a patch which fixes this problem: the bus is deleted only when the driver is unloaded (please note that the atyfb behave like my patched version). Could you add it to the next -mm kernel release ?

I also contacted the driver maintainer but he seems not to answer (I sent an e-mail to him about a week ago).

Best regards,

Nicolas Boichat


--Multipart=_Mon__12_Jul_2004_16_39_42_-0700_7gGbGfkixgVX2Dva
Content-Type: text/x-patch;
 name="riva-2.6.7-mm6.patch"
Content-Disposition: attachment;
 filename="riva-2.6.7-mm6.patch"
Content-Transfer-Encoding: 7bit

--- linux-2.6.7/drivers/video/riva.old/fbdev.c	2004-07-07 11:26:23.000000000 +0200
+++ linux-2.6.7/drivers/video/riva/fbdev.c	2004-07-07 11:36:47.008371568 +0200
@@ -1773,7 +1773,7 @@
 	struct riva_par *par = (struct riva_par *) info->par;
 	int i;
 
-	riva_create_i2c_busses(par);
+	//riva_create_i2c_busses(par);
 	for (i = par->bus; i >= 1; i--) {
 		riva_probe_i2c_connector(par, i, &par->EDID);
 		if (par->EDID) {
@@ -1781,7 +1781,7 @@
 			break;
 		}
 	}
-	riva_delete_i2c_busses(par);
+	//riva_delete_i2c_busses(par);
 #endif
 #endif
 }
@@ -1933,6 +1933,8 @@
 	}
 #endif /* CONFIG_MTRR */
 
+	riva_create_i2c_busses((struct riva_par *) info->par);
+
 	info->fbops = &riva_fb_ops;
 	info->fix = rivafb_fix;
 	riva_get_EDID(info, pd);
@@ -1961,6 +1963,7 @@
 	return 0;
 
 err_out_iounmap_fb:
+	riva_delete_i2c_busses((struct riva_par *) info->par);
 	iounmap(info->screen_base);
 err_out_free_base1:
 	if (default_par->riva.Architecture == NV_ARCH_03) 
@@ -1985,10 +1988,12 @@
 {
 	struct fb_info *info = pci_get_drvdata(pd);
 	struct riva_par *par = (struct riva_par *) info->par;
-	
+
 	if (!info)
 		return;
 
+	riva_delete_i2c_busses(par);
+
 	unregister_framebuffer(info);
 #ifdef CONFIG_MTRR
 	if (par->mtrr.vram_valid)


--Multipart=_Mon__12_Jul_2004_16_39_42_-0700_7gGbGfkixgVX2Dva--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
