From: Pantelis Antoniou <panto@antoniou-consulting.com>
Date: Tue, 30 Oct 2012 18:14:53 +0000
Subject: [PATCH] da8xx: Fix revision check on the da8xx driver
Message-Id: <1351698984-4007-1-git-send-email-panto@antoniou-consulting.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org

The revision check fails for the beaglebone; Add new revision ID.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
---
 drivers/video/da8xx-fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 80665f6..866d804 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1283,6 +1283,7 @@ static int __devinit fb_probe(struct platform_device *device)
 		lcd_revision = LCD_VERSION_1;
 		break;
 	case 0x4F200800:
+	case 0x4F201000:
 		lcd_revision = LCD_VERSION_2;
 		break;
 	default:
-- 
1.7.12

