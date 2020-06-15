From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 15 Jun 2020 14:16:04 +0000
Subject: [PATCH 0/2] pwm: Miscellaneous fixes for 64-bit support
Message-Id: <20200615141606.2814208-1-thierry.reding@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Guru Das Srinagesh <gurus@codeaurora.org>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

this contains a couple of fixes for issues that I ran into after
applying Guru's series to convert PWM period and duty-cycle to 64-bit.

Bartlomiej, can you provide an Acked-by on the first patch so that I can
take it through the PWM tree along with the rest of Guru's series?

Thanks,
Thierry

Thierry Reding (2):
  video: ssd1307fb: Print PWM period using 64-bit format specifier
  pwm: iqs620a: Use 64-bit division

 drivers/pwm/pwm-iqs620a.c       | 7 ++++---
 drivers/video/fbdev/ssd1307fb.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.24.1
