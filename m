From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] 3/3 Add I2C/DDC support to radeonfb
Date: Fri, 22 Aug 2003 18:25:14 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030822162513.GD4279@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail-4.tiscali.it ([195.130.225.150])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19qEk4-0007Kz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 22 Aug 2003 09:26:24 -0700
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Simmons <jsimmons@infradead.org>

Export EDID data through sysfs.


--- linux-2.6.vanilla/drivers/video/radeonfb.c	Fri Aug 22 17:36:29 2003
+++ linux-2.6/drivers/video/radeonfb.c	Fri Aug 22 17:36:52 2003
@@ -434,6 +434,36 @@
 };
 
 /*
+ * Sysfs
+ */
+
+ssize_t radeonfb_show_edid(struct kobject *kobj, char *buf, loff_t off, size_t count) {
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct radeonfb_info *rinfo = pci_get_drvdata(pdev);
+
+	if (off > EDID_LENGTH)
+		return 0;
+
+	if (off + count > EDID_LENGTH)
+		count = EDID_LENGTH - off;
+
+	memcpy(buf, rinfo->EDID + off, count);
+
+	return count;
+}
+
+static struct bin_attribute edid_attr = {
+	.attr   = {
+		.name	= "edid",
+		.owner	= THIS_MODULE,
+		.mode	= 0444,
+	},
+	.size	= EDID_LENGTH,
+	.read	= radeonfb_show_edid,
+};
+
+/*
  * IO macros
  */
 
@@ -3275,6 +3305,8 @@
 				rinfo->modedb = db;
 				rinfo->dbsize = i;
 			}
+
+			sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid_attr);
 		}
 
 		show_edid(rinfo->EDID);



-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Non capisco tutta questa eccitazione per il Multitasking: 
io sono anni che leggo in bagno.


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
