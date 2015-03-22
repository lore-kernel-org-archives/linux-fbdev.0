From: Ondrej Zary <linux@rainbow-software.org>
Date: Sun, 22 Mar 2015 19:59:44 +0000
Subject: [PATCH 5/5] [resend 2] gxt4500: enable panning
Message-Id: <1427054384-26501-5-git-send-email-linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1427054384-26501-1-git-send-email-linux@rainbow-software.org>
In-Reply-To: <1427054384-26501-1-git-send-email-linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

The driver implements pan_display but the corresponding flags are not set.

Add FBINFO_HWACCEL_XPAN and FBINFO_HWACCEL_YPAN to flags to allow HW
accelerated panning (for fast scrolling).

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/video/fbdev/gxt4500.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/gxt4500.c b/drivers/video/fbdev/gxt4500.c
index f278c82..7f97c89 100644
--- a/drivers/video/fbdev/gxt4500.c
+++ b/drivers/video/fbdev/gxt4500.c
@@ -699,7 +699,8 @@ static int gxt4500_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 #endif
 
 	info->fbops = &gxt4500_ops;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_FLAG_DEFAULT | FBINFO_HWACCEL_XPAN |
+					    FBINFO_HWACCEL_YPAN;
 
 	err = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (err) {
-- 
Ondrej Zary

