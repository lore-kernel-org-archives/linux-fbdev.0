From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] aty128fb: Disable AGP on suspend
Date: Tue, 01 Mar 2005 15:18:56 +1100
Message-ID: <1109650736.7670.9.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D5ysH-0005eA-GY
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Feb 2005 20:20:45 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D5ysG-0008TU-Qx
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Feb 2005 20:20:45 -0800
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi !

(for -mm only for now, need feedback from x86 users)

This patch improves reliability of suspend/resume by making sure AGP is
disabled on the Rage 128 chip before putting it into a suspend state. It
works in conjunction with the uninorth-agp suspend patch, but should
be harmless on machines with a different AGP bridge.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/aty/aty128fb.c
===================================================================
--- linux-work.orig/drivers/video/aty/aty128fb.c	2005-02-13 23:18:52.000000000 +1100
+++ linux-work/drivers/video/aty/aty128fb.c	2005-03-01 15:17:21.000000000 +1100
@@ -2334,6 +2334,7 @@
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par = info->par;
+	u8 agp;
 
 	/* We don't do anything but D2, for now we return 0, but
 	 * we may want to change that. How do we know if the BIOS
@@ -2371,6 +2372,27 @@
 	par->asleep = 1;
 	par->lock_blank = 1;
 
+	/* Disable AGP. The AGP host should have done it, but since ordering
+	 * isn't always properly guaranteed in this specific case, let's make
+	 * sure it's disabled on card side now. Ultimately, when merging fbdev
+	 * and dri into some common infrastructure, this will be handled
+	 * more nicely. The host bridge side will (or will not) be dealt with
+	 * by the bridge AGP driver, we don't attempt to touch it here.
+	 */
+	agp = pci_find_capability(pdev, PCI_CAP_ID_AGP);
+	if (agp) {
+		u32 cmd;
+
+		pci_read_config_dword(pdev, agp + PCI_AGP_COMMAND, &cmd);
+		if (cmd & PCI_AGP_COMMAND_AGP) {
+			printk(KERN_INFO "aty128fb: AGP was enabled, "
+			       "disabling ...\n");
+			cmd &= ~PCI_AGP_COMMAND_AGP;
+			pci_write_config_dword(pdev, agp + PCI_AGP_COMMAND,
+					       cmd);
+		}
+	}
+
 	/* We need a way to make sure the fbdev layer will _not_ touch the
 	 * framebuffer before we put the chip to suspend state. On 2.4, I
 	 * used dummy fb ops, 2.5 need proper support for this at the




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
