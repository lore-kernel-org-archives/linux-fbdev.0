From: Daniel Jeong <gshark.jeong@gmail.com>
Date: Wed, 02 Oct 2013 08:39:43 +0000
Subject: [PATCH] backlight: lm3630: fix sparse warning.
Message-Id: <1380703183-19921-1-git-send-email-gshark.jeong@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Jingoo Han <jg1.han@samsung.com>
Cc: fengguang.wu@intel.com, Johannes Weiner <hannes@cmpxchg.org>, kbuild-all@01.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Jeong <gshark.jeong@gmail.com>

This patch is to fix sparse warning due to mixing different enum type.

Signed-off-by: Daniel Jeong <gshark.jeong@gmail.com>
---
 drivers/video/backlight/lm3630a_bl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index cf40cc8..1a76235 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -90,8 +90,8 @@ static int lm3630a_chip_init(struct lm3630a_chip *pchip)
 	/* set current B */
 	rval |= lm3630a_write(pchip, REG_I_B, 0x1F);
 	/* set control */
-	rval |-	    lm3630a_write(pchip, REG_CTRL, pdata->leda_ctrl | pdata->ledb_ctrl);
+	rval |= lm3630a_update(pchip, REG_CTRL, 0x14, pdata->leda_ctrl);
+	rval |= lm3630a_update(pchip, REG_CTRL, 0x0B, pdata->ledb_ctrl);
 	usleep_range(1000, 2000);
 	/* set brightness A and B */
 	rval |= lm3630a_write(pchip, REG_BRT_A, pdata->leda_init_brt);
-- 
1.7.9.5

