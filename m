From: Sasha Levin <sashal@kernel.org>
Date: Tue, 24 Sep 2019 16:51:59 +0000
Subject: [PATCH AUTOSEL 4.4 01/14] video: ssd1307fb: Start page range at page_offset
Message-Id: <20190924165214.28857-1-sashal@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Sasha Levin <sashal@kernel.org>, linux-fbdev@vger.kernel.org, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Marko Kohtala <marko.kohtala@okoko.fi>, Rob Herring <robh+dt@kernel.org>

From: Marko Kohtala <marko.kohtala@okoko.fi>

[ Upstream commit dd9782834dd9dde3624ff1acea8859f3d3e792d4 ]

The page_offset was only applied to the end of the page range. This caused
the display updates to cause a scrolling effect on the display because the
amount of data written to the display did not match the range display
expected.

Fixes: 301bc0675b67 ("video: ssd1307fb: Make use of horizontal addressing mode")
Signed-off-by: Marko Kohtala <marko.kohtala@okoko.fi>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: Michal Vokáč <michal.vokac@ysoft.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190618074111.9309-4-marko.kohtala@okoko.fi
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/ssd1307fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index fa3480815cdb6..88e0763edcc72 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -421,7 +421,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (ret < 0)
 		return ret;
 
-	ret = ssd1307fb_write_cmd(par->client, 0x0);
+	ret = ssd1307fb_write_cmd(par->client, par->page_offset);
 	if (ret < 0)
 		return ret;
 
-- 
2.20.1
