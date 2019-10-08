From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Tue, 08 Oct 2019 12:03:23 +0000
Subject: [PATCH v2 0/4] backlight: pwm_bl: optimizations and small fix for cie1913
Message-Id: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>

These patches optimize the cie1913() implementation by using fewer 64
bit divisions and multiplications. It also contains a minor fix for
the linear constant used.

v2:
- Drop patch 5.
- Fix thinko in patch 4, otherwise no code change.
- Better changelog in patch 3.
- Add Daniel's Reviewed-By to the four patches.

Daniel, I took the liberty of adding your R-B to patch 4 despite
changing it a little to fix a thinko - I should add 1<<31 and not
1<<15. Please tell me if that was inappropriate.

Rasmus Villemoes (4):
  backlight: pwm_bl: fix cie1913 comments and constant
  backlight: pwm_bl: eliminate a 64/32 division
  backlight: pwm_bl: drop use of int_pow()
  backlight: pwm_bl: switch to power-of-2 base for fixed-point math

 drivers/video/backlight/pwm_bl.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

-- 
2.20.1
