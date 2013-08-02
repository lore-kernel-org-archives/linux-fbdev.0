From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 02 Aug 2013 12:05:21 +0000
Subject: [PATCH RESEND 2/8] fbdev: simplefb: mark as fw and allocate apertures
Message-Id: <1375445127-15480-3-git-send-email-dh.herrmann@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375445127-15480-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1375445127-15480-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, Geert Uytterhoeven <geert@linux-m68k.org>, Stephen Warren <swarren@wwwdotorg.org>, Peter Jones <pjones@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-fbdev@vger.kernel.org, akpm@linux-foundation.org, David Herrmann <dh.herrmann@gmail.com>

fbdev-core uses FBINFO_MISC_FIRMWARE to mark drivers that use firmware
framebuffers. Furthermore, we now allocate apertures for the fbinfo
device.
Both information is used by remove_conflicting_framebuffers() to remove a
fbdev device whenever a real driver is loaded. This is used heavily on x86
for VGA/vesa/EFI framebuffers, but is also of great use for all other
systems.

Especially with x86 support for simplefb, this information is needed to
unload simplefb before a real hw-driver (like i915, radeon, nouveau) is
loaded.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Tested-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/video/simplefb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 5886989..8d78106 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -202,8 +202,16 @@ static int simplefb_probe(struct platform_device *pdev)
 	info->var.blue = params.format->blue;
 	info->var.transp = params.format->transp;
 
+	info->apertures = alloc_apertures(1);
+	if (!info->apertures) {
+		framebuffer_release(info);
+		return -ENOMEM;
+	}
+	info->apertures->ranges[0].base = info->fix.smem_start;
+	info->apertures->ranges[0].size = info->fix.smem_len;
+
 	info->fbops = &simplefb_ops;
-	info->flags = FBINFO_DEFAULT;
+	info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
 	info->screen_base = devm_ioremap(&pdev->dev, info->fix.smem_start,
 					 info->fix.smem_len);
 	if (!info->screen_base) {
-- 
1.8.3.4

