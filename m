From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] 2/3 Add I2C/DDC support to radeonfb (resend)
Date: Fri, 22 Aug 2003 19:10:24 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030822171024.GB5757@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail-3.tiscali.it ([195.130.225.149])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19qFQd-0006Nq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 22 Aug 2003 10:10:24 -0700
Received: from dreamland.darkstar.lan (217.133.180.117) by mail-3.tiscali.it (6.7.019)
        id 3F33543C0050E023 for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Aug 2003 19:10:14 +0200
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

[This is a resend, it seems that original mail got lost]
Register i2c bus. Parse EDID block.

--- linux-2.6.vanilla/drivers/video/radeonfb.c	Fri Aug 22 17:33:45 2003
+++ linux-2.6/drivers/video/radeonfb.c	Fri Aug 22 17:36:29 2003
@@ -418,6 +418,10 @@
 #ifdef CONFIG_FB_RADEON_I2C
 	u32 DDCReg;
 #endif
+	/* ModeDB from EDID */
+	struct fb_videomode *modedb;
+	int dbsize;
+	
 	struct radeonfb_info *next;
 };
 
@@ -1597,7 +1601,7 @@
 #ifndef MODULE
         if (mode_option)
                 fb_find_mode (var, &rinfo->info, mode_option,
-                              NULL, 0, NULL, 8);
+                              rinfo->modedb, rinfo->dbsize, NULL, 8);
         else
 #endif
 	if (rinfo->use_default_var)
@@ -3248,7 +3252,33 @@
 	}
 #endif
 
+	/* Register I2C bus */
+	if (!radeonfb_i2c_bus_reg(rinfo))
+		i2c_ready = 1;
+
 	radeon_get_EDID(rinfo);
+	if (rinfo->EDID) {
+		struct fb_var_screeninfo var;
+		struct fb_videomode *db;
+		int i;
+
+		if (parse_edid(rinfo->EDID, &var)) {
+			kfree(rinfo->EDID);
+			rinfo->EDID = NULL;
+		} else {
+			/* Update default with EDID info */
+			radeonfb_default_var = var;
+			rinfo->use_default_var = 1;
+
+			/* Create a modedb */
+			if ((db = fb_create_modedb(rinfo->EDID, &i))) {
+				rinfo->modedb = db;
+				rinfo->dbsize = i;
+			}
+		}
+
+		show_edid(rinfo->EDID);
+	}
 
 	if ((rinfo->dviDisp_type == MT_DFP) || (rinfo->dviDisp_type == MT_LCD) ||
 	    (rinfo->crtDisp_type == MT_DFP)) {
@@ -3258,6 +3288,10 @@
 					    pci_resource_len(pdev, 2));
 			release_mem_region (rinfo->fb_base_phys,
 					    pci_resource_len(pdev, 0));
+			if (rinfo->EDID)
+				kfree(rinfo->EDID);
+			fb_destroy_modedb(rinfo->modedb);
+			radeonfb_i2c_bus_del();
 			kfree (rinfo);
 			return -ENODEV;
 		}
@@ -3271,6 +3305,10 @@
 				    pci_resource_len(pdev, 2));
 		release_mem_region (rinfo->fb_base_phys,
 				    pci_resource_len(pdev, 0));
+		if (rinfo->EDID)
+			kfree(rinfo->EDID);
+		fb_destroy_modedb(rinfo->modedb);
+		radeonfb_i2c_bus_del();
 		kfree (rinfo);
 		return -ENODEV;
 	}
@@ -3329,6 +3367,10 @@
 				    pci_resource_len(pdev, 2));
 		release_mem_region (rinfo->fb_base_phys,
 				    pci_resource_len(pdev, 0));
+		if (rinfo->EDID)
+			kfree(rinfo->EDID);
+		fb_destroy_modedb(rinfo->modedb);
+		radeonfb_i2c_bus_del();
 		kfree (rinfo);
 		return -ENODEV;
 	}
@@ -3400,6 +3442,12 @@
 			    pci_resource_len(pdev, 2));
 	release_mem_region (rinfo->fb_base_phys,
 			    pci_resource_len(pdev, 0));
+
+	if (rinfo->EDID)
+		kfree(rinfo->EDID);
+
+	fb_destroy_modedb(rinfo->modedb);
+	radeonfb_i2c_bus_del();
         
         kfree (rinfo);
 }



-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Windows NT: Designed for the Internet. The Internet: Designed for Unix.


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
