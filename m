From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 08:56:26 +0000
Subject: [PATCH v4 03/24] clk: pwm: use pwm_get_xxx() helpers where appropriate
Message-Id: <1447664207-24370-4-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use pwm_get_xxx() helpers instead of directly accessing the pwm->xxx field.
Doing that will ease adaptation of the PWM framework to support atomic
update.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Patch generated with the following coccinelle script:

--->8---
virtual patch

@@
struct pwm_device *p;
expression e;
@@
(
-(p)->polarity = e;
+pwm_set_polarity((p), e);
|
-(p)->polarity
+pwm_get_polarity((p))
|
-(p)->period = e;
+pwm_set_period((p), e);
|
-(p)->period
+pwm_get_period((p))
|
-(p)->duty_cycle = e;
+pwm_set_duty_cycle((p), e);
|
-(p)->duty_cycle
+pwm_get_duty_cycle((p))
)
--->8---
---
 drivers/clk/clk-pwm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index 328fcfc..b6306a2 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -71,22 +71,23 @@ static int clk_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm))
 		return PTR_ERR(pwm);
 
-	if (!pwm->period) {
+	if (!pwm_get_period((pwm))) {
 		dev_err(&pdev->dev, "invalid PWM period\n");
 		return -EINVAL;
 	}
 
 	if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
-		clk_pwm->fixed_rate = NSEC_PER_SEC / pwm->period;
+		clk_pwm->fixed_rate = NSEC_PER_SEC / pwm_get_period((pwm));
 
-	if (pwm->period != NSEC_PER_SEC / clk_pwm->fixed_rate &&
-	    pwm->period != DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {
+	if (pwm_get_period((pwm)) != NSEC_PER_SEC / clk_pwm->fixed_rate &&
+	    pwm_get_period((pwm)) != DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {
 		dev_err(&pdev->dev,
 			"clock-frequency does not match PWM period\n");
 		return -EINVAL;
 	}
 
-	ret = pwm_config(pwm, (pwm->period + 1) >> 1, pwm->period);
+	ret = pwm_config(pwm, (pwm_get_period((pwm)) + 1) >> 1,
+			 pwm_get_period((pwm)));
 	if (ret < 0)
 		return ret;
 
-- 
2.1.4

