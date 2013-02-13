From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 13 Feb 2013 10:40:26 +0000
Subject: [PATCH 3/5] fb: hx8357: Remove useless error message
Message-Id: <1360752028-7301-4-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360752028-7301-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1360752028-7301-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: joe@perches.com, Andrew Morton <akpm@linux-foundation.org>, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-kernel@vger.kernel.org

In case of a failing allocation, a dump stack will be printed anyway, so
the dev_err is redundant.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/video/backlight/hx8357.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index 2691fd6..7c82561 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -96,10 +96,8 @@ static int hx8357_spi_write_then_read(struct lcd_device *lcdev,
 
 		local_txbuf = kcalloc(txlen, sizeof(*local_txbuf), GFP_KERNEL);
 
-		if (!local_txbuf) {
-			dev_err(&lcdev->dev, "Couldn't allocate data buffer.\n");
+		if (!local_txbuf)
 			return -ENOMEM;
-		}
 
 		for (i = 0; i < txlen; i++) {
 			local_txbuf[i] = txbuf[i];
-- 
1.7.10.4

