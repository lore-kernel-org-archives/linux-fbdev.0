From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: New radeonfb, mostly untested
Date: Sun, 7 Sep 2003 19:48:02 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030907174802.GA5945@dreamland.darkstar.lan>
References: <1062952639.655.6.camel@gaston>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19w3et-0005Lq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Sep 2003 10:49:07 -0700
Received: from mail-6.tiscali.it ([195.130.225.152])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19w3es-0001Ae-JW
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Sep 2003 10:49:06 -0700
Content-Disposition: inline
In-Reply-To: <1062952639.655.6.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Sun, Sep 07, 2003 at 06:37:20PM +0200, Benjamin Herrenschmidt ha scritto: 
> Ok, enough for today, my head hurts, it builds, it detects my
> PowerBook's internal panel properly, I didn't test anything else
> yet nor x86, let me know what you think...


+unmap_rom:	
+	if (rinfo->mon1_EDID)
+	    kfree(rinfo->mon1_EDID);
+	if (rinfo->mon2_EDID)
+	    kfree(rinfo->mon2_EDID);
+	if (rinfo->mon1_modedb)
+		fb_destroy_modedb(rinfo->mon1_modedb);
+	radeon_delete_i2c_busses(rinfo);
+	if (rinfo->bios_seg)
+		radeon_unmap_ROM(rinfo, pdev);
+	iounmap ((void*)rinfo->mmio_base);
+release_mmio:
+	release_mem_region (rinfo->mmio_base_phys,
+			    pci_resource_len(pdev, 2));
+release_fb:	
+	release_mem_region (rinfo->fb_base_phys,
+			    pci_resource_len(pdev, 0));
+free_rinfo:	
+	kfree (rinfo);
+	return -ENODEV;
+}
+
+
+
+static void __devexit radeonfb_pci_unregister (struct pci_dev *pdev)
+{
+        struct radeonfb_info *rinfo = pci_get_drvdata(pdev);
+ 
+        if (!rinfo)
+                return;
+ 
+	/* restore original state
+	 * 
+	 * Doesn't quite work yet, possibly because of the PPC hacking
+	 * I do on startup, disable for now. --BenH
+	 */
+        radeon_write_mode (rinfo, &rinfo->init_state);
+ 
+#ifdef CONFIG_MTRR
+	if (rinfo->mtrr_hdl >= 0)
+		mtrr_del(rinfo->mtrr_hdl, 0, 0);
+#endif
+
+        unregister_framebuffer ((struct fb_info *) rinfo);
+
+        iounmap ((void*)rinfo->mmio_base);
+        iounmap ((void*)rinfo->fb_base);
+ 
+	release_mem_region (rinfo->mmio_base_phys,
+			    pci_resource_len(pdev, 2));
+	release_mem_region (rinfo->fb_base_phys,
+			    pci_resource_len(pdev, 0));
+
+	if (rinfo->mon1_EDID)
+		kfree(rinfo->mon1_EDID);
+	if (rinfo->mon2_EDID)
+		kfree(rinfo->mon2_EDID);
+	if (rinfo->mon1_modedb)
+		fb_destroy_modedb(rinfo->mon1_modedb);
+	radeon_delete_i2c_busses(rinfo);
+        
+        kfree (rinfo);
+}
 
There's a problem here: sysfs attributes are unregistered after
radeonfb_pci_unregister returns, so we have a small windows where
mon1_EDID and mon2_EDID are invalid and edid1 and edid2 are still
there in sysfs. Ditto for pci_register.

Oh, you didn't update aty/Makefile ;)

obj-$(CONFIG_FB_RADEON) += radeonfb.o
radeonfb-y += radeon_base.o radeon_monitor.o radeon_pm.o
radeonfb-$(CONFIG_FB_RADEON_I2C) += radeon_i2c.o

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Software is like sex; it's better when it's free.
Linus Torvalds


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
