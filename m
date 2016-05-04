From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 04 May 2016 11:13:23 +0000
Subject: Re: [PATCH v2 1/3] video: fbdev: imxfb: fix semantic of .get_power and .set_power
Message-Id: <1462360403.3536.2.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1462354998-5792-2-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1462354998-5792-2-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Am Mittwoch, den 04.05.2016, 11:43 +0200 schrieb Uwe Kleine-König:
> .set_power gets passed an FB_BLANK_XXX value, not a bool. So 0 signals
> on; and >1 means off. The same applies for return values of .get_power.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

