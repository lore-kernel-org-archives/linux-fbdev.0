From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 13 Feb 2013 10:40:24 +0000
Subject: [PATCH 1/5] fb: hx8357: Change parameters of the write function to u8
Message-Id: <1360752028-7301-2-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360752028-7301-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1360752028-7301-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: joe@perches.com, Andrew Morton <akpm@linux-foundation.org>, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-kernel@vger.kernel.org

Moving from void* to u8* removes the need for castslater on in the
function.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/video/backlight/hx8357.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index 00925c0..071525c 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -79,8 +79,8 @@ struct hx8357_data {
 };
 
 static int hx8357_spi_write_then_read(struct lcd_device *lcdev,
-				void *txbuf, u16 txlen,
-				void *rxbuf, u16 rxlen)
+				u8 *txbuf, u16 txlen,
+				u8 *rxbuf, u16 rxlen)
 {
 	struct hx8357_data *lcd = lcd_get_data(lcdev);
 	struct spi_message msg;
@@ -102,7 +102,7 @@ static int hx8357_spi_write_then_read(struct lcd_device *lcdev,
 		}
 
 		for (i = 0; i < txlen; i++) {
-			local_txbuf[i] = ((u8 *)txbuf)[i];
+			local_txbuf[i] = txbuf[i];
 			if (i > 0)
 				local_txbuf[i] |= 1 << 8;
 		}
-- 
1.7.10.4

