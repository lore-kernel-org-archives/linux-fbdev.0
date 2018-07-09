From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 09 Jul 2018 21:51:56 +0000
Subject: [PATCH] backlight: adp8860: Mark expected switch fall-through
Message-Id: <20180709215156.GA8782@embeddedor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hennerich <michael.hennerich@analog.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/backlight/adp8860_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
index 16119bd..f1dc41c 100644
--- a/drivers/video/backlight/adp8860_bl.c
+++ b/drivers/video/backlight/adp8860_bl.c
@@ -690,6 +690,7 @@ static int adp8860_probe(struct i2c_client *client,
 	switch (ADP8860_MANID(reg_val)) {
 	case ADP8863_MANUFID:
 		data->gdwn_dis = !!pdata->gdwn_dis;
+		/* fall through */
 	case ADP8860_MANUFID:
 		data->en_ambl_sens = !!pdata->en_ambl_sens;
 		break;
-- 
2.7.4

