From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 24 Jun 2020 14:57:20 +0000
Subject: [PATCH 7/8] backlight: lm3630a_bl: Remove invalid checks for unsigned int < 0
Message-Id: <20200624145721.2590327-8-lee.jones@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
In-Reply-To: <20200624145721.2590327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: daniel.thompson@linaro.org, jingoohan1@gmail.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, Daniel Jeong <gshark.jeong@gmail.com>, LDD MLP <ldd-mlp@list.ti.com>, stable@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

unsigned ints 'sources' and 'bank' cannot be less than LM3630A_SINK_0 (0)
and LM3630A_BANK_0 (0) respecitively, so change the logic to only check
for thier two possible valid values.

Fixes W=1 warnings:

 drivers/video/backlight/lm3630a_bl.c: In function ‘lm3630a_parse_led_sources’:
 drivers/video/backlight/lm3630a_bl.c:394:18: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
 394 | if (sources[i] < LM3630A_SINK_0 || sources[i] > LM3630A_SINK_1)
 | ^
 drivers/video/backlight/lm3630a_bl.c: In function ‘lm3630a_parse_bank’:
 drivers/video/backlight/lm3630a_bl.c:415:11: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
 415 | if (bank < LM3630A_BANK_0 || bank > LM3630A_BANK_1)
 | ^

Cc: <stable@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Jeong <gshark.jeong@gmail.com>
Cc: LDD MLP <ldd-mlp@list.ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/lm3630a_bl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index ee320883b7108..e88a2b0e59046 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -391,7 +391,7 @@ static int lm3630a_parse_led_sources(struct fwnode_handle *node,
 		return ret;
 
 	for (i = 0; i < num_sources; i++) {
-		if (sources[i] < LM3630A_SINK_0 || sources[i] > LM3630A_SINK_1)
+		if (sources[i] != LM3630A_SINK_0 && sources[i] != LM3630A_SINK_1)
 			return -EINVAL;
 
 		ret |= BIT(sources[i]);
@@ -412,7 +412,7 @@ static int lm3630a_parse_bank(struct lm3630a_platform_data *pdata,
 	if (ret)
 		return ret;
 
-	if (bank < LM3630A_BANK_0 || bank > LM3630A_BANK_1)
+	if (bank != LM3630A_BANK_0 && bank != LM3630A_BANK_1)
 		return -EINVAL;
 
 	led_sources = lm3630a_parse_led_sources(node, BIT(bank));
-- 
2.25.1
