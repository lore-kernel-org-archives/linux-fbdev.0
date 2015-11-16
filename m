From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 08:56:37 +0000
Subject: [PATCH v4 14/24] clk: pwm: use pwm_get/set_default_xxx() helpers where appropriate
Message-Id: <1447664207-24370-15-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

pwm_set/get_default_xxx() helpers have been introduced to differentiate
the default PWM states (those retrieved through DT, PWM lookup table or
statically assigned by the driver) and the current ones.
Make use of those helpers where appropriate.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/clk/clk-pwm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index b6306a2..642a49a 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -71,23 +71,23 @@ static int clk_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm))
 		return PTR_ERR(pwm);
 
-	if (!pwm_get_period((pwm))) {
+	if (!pwm_get_default_period((pwm))) {
 		dev_err(&pdev->dev, "invalid PWM period\n");
 		return -EINVAL;
 	}
 
 	if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
-		clk_pwm->fixed_rate = NSEC_PER_SEC / pwm_get_period((pwm));
+		clk_pwm->fixed_rate = NSEC_PER_SEC / pwm_get_default_period((pwm));
 
-	if (pwm_get_period((pwm)) != NSEC_PER_SEC / clk_pwm->fixed_rate &&
-	    pwm_get_period((pwm)) != DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {
+	if (pwm_get_default_period((pwm)) != NSEC_PER_SEC / clk_pwm->fixed_rate &&
+	    pwm_get_default_period((pwm)) != DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {
 		dev_err(&pdev->dev,
 			"clock-frequency does not match PWM period\n");
 		return -EINVAL;
 	}
 
-	ret = pwm_config(pwm, (pwm_get_period((pwm)) + 1) >> 1,
-			 pwm_get_period((pwm)));
+	ret = pwm_config(pwm, (pwm_get_default_period((pwm)) + 1) >> 1,
+			 pwm_get_default_period((pwm)));
 	if (ret < 0)
 		return ret;
 
-- 
2.1.4

