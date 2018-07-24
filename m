From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 24 Jul 2018 07:12:23 +0000
Subject: [PATCH v3] backlight: pwm_bl: Fix uninitialized variable
Message-Id: <20180724071223.18901-1-daniel.thompson@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
In-Reply-To: <20180716210241.9457-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, patches@linaro.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>

Currently, if the DT does not define num-interpolated-steps then
num_steps is undefined and the interpolation code will deploy randomly.
Fix with a simple initialize to zero.

Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
brightness-levels")
Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

Notes:
    v3:
     - Switch to the simplest fix and zero the uninitialized variable. git
       grep indicates that ~25% of calls to of_property_read_u32() use this
       pattern (pre-initialize optional properties with sane values and
       ignore the return code).
    
    v2:
     - Simplify SoB chain (with Marcel's permission)
     - Separate complex if statement and make other similar calls use same
       return code checking approach
     - Tidy up comment formatting and fix pre-existing grammar error

 drivers/video/backlight/pwm_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 9ee4c1b735b2..bdfcc0a71db1 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -250,7 +250,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
 	struct device_node *node = dev->of_node;
 	unsigned int num_levels = 0;
 	unsigned int levels_count;
-	unsigned int num_steps;
+	unsigned int num_steps = 0;
 	struct property *prop;
 	unsigned int *table;
 	int length;
--
2.17.1

