From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 29 May 2019 15:46:35 +0000
Subject: [PATCH] efifb: BGRT: Add check for new BGRT status field rotation bits
Message-Id: <20190529154635.2659-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-efi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, Peter Jones <pjones@redhat.com>, dri-devel@lists.freedesktop.org

Starting with ACPI 6.2 bits 1 and 2 of the BGRT status field are no longer
reserved. These bits are now used to indicate if the image needs to be
rotated before being displayed.

The efifb code does not support rotating the image before copying it to
the screen.

This commit adds a check for these new bits and if they are set leaves the
fb contents as is instead of trying to use the un-rotated BGRT image.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/fbdev/efifb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 9f39f0c360e0..dfa8dd47d19d 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -169,6 +169,11 @@ static void efifb_show_boot_graphics(struct fb_info *info)
 		return;
 	}
 
+	if (bgrt_tab.status & 0x06) {
+		pr_info("efifb: BGRT rotation bits set, not showing boot graphics\n");
+		return;
+	}
+
 	/* Avoid flashing the logo if we're going to print std probe messages */
 	if (console_loglevel > CONSOLE_LOGLEVEL_QUIET)
 		return;
-- 
2.21.0
