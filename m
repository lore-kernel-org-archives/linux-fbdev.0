From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 13 Feb 2013 10:40:27 +0000
Subject: [PATCH 4/5] fb: hx8357: Remove trailing period
Message-Id: <1360752028-7301-5-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360752028-7301-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1360752028-7301-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: joe@perches.com, Andrew Morton <akpm@linux-foundation.org>, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-kernel@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/video/backlight/hx8357.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index 7c82561..6da8ebe 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -120,7 +120,7 @@ static int hx8357_spi_write_then_read(struct lcd_device *lcdev,
 
 	ret = spi_sync(lcd->spi, &msg);
 	if (ret < 0)
-		dev_err(&lcdev->dev, "Couldn't send SPI data.\n");
+		dev_err(&lcdev->dev, "Couldn't send SPI data\n");
 
 	if (txlen)
 		kfree(local_txbuf);
-- 
1.7.10.4

