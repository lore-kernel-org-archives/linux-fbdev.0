From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/9] fbdev: Resurrect hooks to get EDID from firmware
Date: Sat, 20 Aug 2005 00:32:31 +0800
Message-ID: <4306099F.80500@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E6HGv-0002Im-Od
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:31:41 -0700
Received: from wproxy.gmail.com ([64.233.184.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E6HGv-0000bN-BM
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:31:41 -0700
Received: by wproxy.gmail.com with SMTP id i3so655742wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Aug 2005 17:31:34 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    For the i386, code is already present in video.S that gets the
    EDID from the video BIOS.  Make this visible so drivers can also use
    this data as fallback when i2c does not work.

    To ensure that the EDID block is returned for the primary graphics adapter
    only, by check if the IORESOURCE_ROM_SHADOW flag is set.

    From: Antonino Daplas <adaplas@pol.net>
    Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 arch/i386/boot/video.S |    2 +-
 drivers/video/fbmon.c  |   35 ++++++++++++++++++++++++++++++++++-
 include/linux/fb.h     |    4 +++-
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/i386/boot/video.S b/arch/i386/boot/video.S
--- a/arch/i386/boot/video.S
+++ b/arch/i386/boot/video.S
@@ -1949,7 +1949,7 @@ store_edid:
 	movw	$0x4f15, %ax                    # do VBE/DDC
 	movw	$0x01, %bx
 	movw	$0x00, %cx
-	movw    $0x01, %dx
+	movw    $0x00, %dx
 	movw	$0x140, %di
 	int	$0x10
 
diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -29,6 +29,7 @@
 #include <linux/tty.h>
 #include <linux/fb.h>
 #include <linux/module.h>
+#include <video/edid.h>
 #ifdef CONFIG_PPC_OF
 #include <linux/pci.h>
 #include <asm/prom.h>
@@ -1251,9 +1252,41 @@ int fb_validate_mode(const struct fb_var
 		-EINVAL : 0;
 }
 
+#if defined(__i386__)
+#include <linux/pci.h>
+
+/*
+ * We need to ensure that the EDID block is only returned for
+ * the primary graphics adapter.
+ */
+
+const unsigned char *fb_firmware_edid(struct device *device)
+{
+	struct pci_dev *dev = NULL;
+	struct resource *res = NULL;
+	unsigned char *edid = NULL;
+
+	if (device)
+		dev = to_pci_dev(device);
+
+	if (dev)
+		res = &dev->resource[PCI_ROM_RESOURCE];
+
+	if (res && res->flags & IORESOURCE_ROM_SHADOW)
+		edid = edid_info.dummy;
+
+	return edid;
+}
+#else
+const unsigned char *fb_firmware_edid(struct device *device)
+{
+	return NULL;
+}
+#endif /* _i386_ */
+
 EXPORT_SYMBOL(fb_parse_edid);
 EXPORT_SYMBOL(fb_edid_to_monspecs);
-
+EXPORT_SYMBOL(fb_firmware_edid);
 EXPORT_SYMBOL(fb_get_mode);
 EXPORT_SYMBOL(fb_validate_mode);
 EXPORT_SYMBOL(fb_destroy_modedb);
diff --git a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -859,7 +859,9 @@ extern int fb_get_mode(int flags, u32 va
 extern int fb_validate_mode(const struct fb_var_screeninfo *var,
 			    struct fb_info *info);
 extern int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var);
-extern void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs);
+extern const unsigned char *fb_firmware_edid(struct device *device);
+extern void fb_edid_to_monspecs(unsigned char *edid,
+				struct fb_monspecs *specs);
 extern void fb_destroy_modedb(struct fb_videomode *modedb);
 
 /* drivers/video/modedb.c */



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
