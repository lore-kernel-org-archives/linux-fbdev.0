From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 22 Apr 2013 10:02:24 +0000
Subject: [PATCH 3/4] ssd1307fb: Speed up the communication with the controller
Message-Id: <1366624945-5708-4-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366624945-5708-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1366624945-5708-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The code until now was sending only 1pixel-wide page segment at once,
and started a new transfer every time. It has proven very inefficient,
because for one byte to display on the screen, we had to actually send 3
bytes over I2C: the address, the type of data that was going to the
controller, and then the actual data.

This patches changes that by sending a whole page at once, avoiding most
of this expensive overhead.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/video/ssd1307fb.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/video/ssd1307fb.c b/drivers/video/ssd1307fb.c
index 35f5348..cab5f7c 100644
--- a/drivers/video/ssd1307fb.c
+++ b/drivers/video/ssd1307fb.c
@@ -168,23 +168,28 @@ static void ssd1307fb_update_display(struct ssd1307fb_par *par)
 	 */
 
 	for (i = 0; i < (par->height / 8); i++) {
+		struct ssd1307fb_array *array;
 		ssd1307fb_write_cmd(par->client,
 				    SSD1307FB_START_PAGE_ADDRESS + i + par->page_offset);
 		ssd1307fb_write_cmd(par->client, 0x00);
 		ssd1307fb_write_cmd(par->client, 0x10);
 
+		array = ssd1307fb_alloc_array(par->width, SSD1307FB_DATA);
+
 		for (j = 0; j < par->width; j++) {
-			u8 buf = 0;
+			array->data[j] = 0;
 			for (k = 0; k < 8; k++) {
 				u32 page_length = par->width * i;
 				u32 index = page_length + (par->width * k + j) / 8;
 				u8 byte = *(vmem + index);
 				u8 bit = byte & (1 << (j % 8));
 				bit = bit >> (j % 8);
-				buf |= bit << k;
+				array->data[j] |= bit << k;
 			}
-			ssd1307fb_write_data(par->client, buf);
 		}
+
+		ssd1307fb_write_array(par->client, array, par->width);
+		kfree(array);
 	}
 }
 
-- 
1.7.10.4

