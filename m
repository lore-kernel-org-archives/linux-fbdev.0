From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 17 Jun 2018 15:32:35 +0000
Subject: [PATCH 2/2] efifb: Copy the ACPI BGRT boot graphics to the framebuffer
Message-Id: <20180617153235.16219-3-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180617153235.16219-1-hdegoede@redhat.com>
In-Reply-To: <20180617153235.16219-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org

On systems where fbcon is configured for deferred console takeover, the
intend is for the framebuffer to show the boot graphics (e.g a vendor
logo) until some message (e.g. an error) is printed or a graphical
session takes over.

Some firmware however relies on the OS to show the boot graphics
(indicated by bgrt_tab.status being 0) and the boot graphics may have
been destroyed by e.g. the grub boot menu.

This patch adds support to efifb to show the boot graphics and
automatically enables this when fbcon is configured for deferred
console takeover.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/fbdev/efifb.c | 147 ++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 46a4484e3da7..b041d936a438 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -9,16 +9,39 @@
 
 #include <linux/kernel.h>
 #include <linux/efi.h>
+#include <linux/efi-bgrt.h>
 #include <linux/errno.h>
 #include <linux/fb.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/printk.h>
 #include <linux/screen_info.h>
 #include <video/vga.h>
 #include <asm/efi.h>
 #include <drm/drm_utils.h> /* For drm_get_panel_orientation_quirk */
 #include <drm/drm_connector.h>  /* For DRM_MODE_PANEL_ORIENTATION_* */
 
+struct bmp_file_header {
+	u16 id;
+	u32 file_size;
+	u32 reserved;
+	u32 bitmap_offset;
+} __packed;
+
+struct bmp_dib_header {
+	u32 dib_header_size;
+	s32 width;
+	s32 height;
+	u16 planes;
+	u16 bpp;
+	u32 compression;
+	u32 bitmap_size;
+	u32 horz_resolution;
+	u32 vert_resolution;
+	u32 colors_used;
+	u32 colors_important;
+} __packed;
+
 static bool request_mem_succeeded = false;
 static bool nowc = false;
 
@@ -66,6 +89,128 @@ static int efifb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	return 0;
 }
 
+/*
+ * If fbcon deffered console takeover is configured, the intent is for the
+ * framebuffer to show the boot graphics (e.g. vendor logo) until there is some
+ * (error) message to display. But the boot graphics may have been destroyed by
+ * e.g. option ROM output, detect this and restore the boot graphics.
+ */
+#if defined CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER && \
+    defined CONFIG_ACPI_BGRT
+static void efifb_show_boot_graphics(struct fb_info *info)
+{
+	u32 *dst, bmp_width, bmp_height, bmp_pitch, screen_pitch;
+	struct screen_info *si = &screen_info;
+	struct bmp_file_header *file_header;
+	struct bmp_dib_header *dib_header;
+	void *bgrt_image = NULL;
+	u8 *src, r, g, b;
+	s32 x, y;
+
+	if (!bgrt_tab.image_address) {
+		pr_info("efifb: No BGRT, not showing boot graphics\n");
+		return;
+	}
+
+	/* Avoid flashing the logo if we're going to print std probe messages */
+	if (console_loglevel > CONSOLE_LOGLEVEL_QUIET)
+		return;
+
+	/*
+	 * We do not check bgrt_tab.status here because this seems to only
+	 * reflect if the firmware has shown the boot graphics at all, if it
+	 * later got destroyed by something status will still be 1.
+	 * Since we draw the exact same graphic at the exact same place this
+	 * will not lead to any tearing if the boot graphic is already there.
+	 */
+
+	if (si->lfb_depth != 32) {
+		pr_info("efifb: not 32 bits, not showing boot graphics\n");
+		return;
+	}
+
+	bgrt_image = memremap(bgrt_tab.image_address, bgrt_image_size,
+			      MEMREMAP_WB);
+	if (!bgrt_image) {
+		pr_warn("efifb: Ignoring BGRT: failed to map image memory\n");
+		return;
+	}
+
+	if (bgrt_image_size < (sizeof(*file_header) + sizeof(*dib_header)))
+		goto error;
+
+	file_header = bgrt_image;
+	if (file_header->id != 0x4d42 || file_header->reserved != 0)
+		goto error;
+
+	dib_header = bgrt_image + sizeof(*file_header);
+	if (dib_header->dib_header_size != 40 || dib_header->width < 0 ||
+	    dib_header->planes != 1 || dib_header->bpp != 24 ||
+	    dib_header->compression != 0)
+		goto error;
+
+	bmp_width = dib_header->width;
+	bmp_height = abs(dib_header->height);
+	bmp_pitch = round_up(3 * bmp_width, 4);
+	screen_pitch = si->lfb_linelength;
+
+	if ((file_header->bitmap_offset + bmp_pitch * bmp_height) >
+				bgrt_image_size)
+		goto error;
+
+	if ((bgrt_tab.image_offset_x + bmp_width) > si->lfb_width ||
+	    (bgrt_tab.image_offset_y + bmp_height) > si->lfb_height)
+		goto error;
+
+	pr_info("efifb: showing boot graphics\n");
+
+	src = bgrt_image + file_header->bitmap_offset;
+	bmp_pitch -= 3 * bmp_width;
+	if (dib_header->height < 0) {
+		for (y = 0; y < bmp_height; y++) {
+			dst = (u32 *)(
+				info->screen_base +
+				(bgrt_tab.image_offset_y + y) * screen_pitch +
+				bgrt_tab.image_offset_x * 4);
+			for (x = 0; x < bmp_width; x++) {
+				b = *src++;
+				g = *src++;
+				r = *src++;
+				*dst++ = (r << si->red_pos)   |
+					 (g << si->green_pos) |
+					 (b << si->blue_pos);
+			}
+			src += bmp_pitch;
+		}
+	} else {
+		for (y = (bmp_height - 1); y >= 0; y--) {
+			dst = (u32 *)(
+				info->screen_base +
+				(bgrt_tab.image_offset_y + y) * screen_pitch +
+				bgrt_tab.image_offset_x * 4);
+			for (x = 0; x < bmp_width; x++) {
+				b = *src++;
+				g = *src++;
+				r = *src++;
+				*dst++ = (r << si->red_pos)   |
+					 (g << si->green_pos) |
+					 (b << si->blue_pos);
+			}
+			src += bmp_pitch;
+		}
+	}
+
+	memunmap(bgrt_image);
+	return;
+
+error:
+	memunmap(bgrt_image);
+	pr_warn("efifb: Ignoring BGRT: unexpected or invalid BMP data\n");
+}
+#else
+static inline void efifb_show_boot_graphics(struct fb_info *info) {}
+#endif
+
 static void efifb_destroy(struct fb_info *info)
 {
 	if (info->screen_base)
@@ -283,6 +428,8 @@ static int efifb_probe(struct platform_device *dev)
 		goto err_release_fb;
 	}
 
+	efifb_show_boot_graphics(info);
+
 	pr_info("efifb: framebuffer at 0x%lx, using %dk, total %dk\n",
 	       efifb_fix.smem_start, size_remap/1024, size_total/1024);
 	pr_info("efifb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
-- 
2.17.1

