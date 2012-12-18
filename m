From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 18 Dec 2012 13:49:29 +0000
Subject: [PATCH] video: ssd1307fb: Fix bit order bug in the byte translation function
Message-Id: <1355838569-30225-1-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This was leading to a strange behaviour when using the fbcon driver on
top of this one: the letter were in the right order, but each letter was
having a vertical symmetry.

This was because the addressing was right for the byte, but the
addressing of each individual bit was inverted.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Brian Lilly <brian@crystalfontz.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Thomas Petazzoni <thomas@free-electrons.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/video/ssd1307fb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/ssd1307fb.c b/drivers/video/ssd1307fb.c
index 9e46633..7f5f824 100644
--- a/drivers/video/ssd1307fb.c
+++ b/drivers/video/ssd1307fb.c
@@ -145,8 +145,8 @@ static void ssd1307fb_update_display(struct ssd1307fb_par *par)
 				u32 page_length = SSD1307FB_WIDTH * i;
 				u32 index = page_length + (SSD1307FB_WIDTH * k + j) / 8;
 				u8 byte = *(vmem + index);
-				u8 bit = byte & (1 << (7 - (j % 8)));
-				bit = bit >> (7 - (j % 8));
+				u8 bit = byte & (1 << (j % 8));
+				bit = bit >> (j % 8);
 				buf |= bit << k;
 			}
 			ssd1307fb_write_data(par->client, buf);
-- 
1.7.9.5

