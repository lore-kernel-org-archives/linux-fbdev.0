From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 13 Feb 2013 10:40:25 +0000
Subject: [PATCH 2/5] fb: hx8357: Fix inverted parameters for kcalloc
Message-Id: <1360752028-7301-3-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360752028-7301-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1360752028-7301-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: joe@perches.com, Andrew Morton <akpm@linux-foundation.org>, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-kernel@vger.kernel.org

The element size and the number of elements was inverted in the kcalloc
call.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/video/backlight/hx8357.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index 071525c..2691fd6 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -94,7 +94,7 @@ static int hx8357_spi_write_then_read(struct lcd_device *lcdev,
 	if (txlen) {
 		int i;
 
-		local_txbuf = kcalloc(sizeof(*local_txbuf), txlen, GFP_KERNEL);
+		local_txbuf = kcalloc(txlen, sizeof(*local_txbuf), GFP_KERNEL);
 
 		if (!local_txbuf) {
 			dev_err(&lcdev->dev, "Couldn't allocate data buffer.\n");
-- 
1.7.10.4

