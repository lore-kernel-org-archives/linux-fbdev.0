From: Johan Hovold <jhovold@gmail.com>
Date: Tue, 22 Oct 2013 17:26:50 +0000
Subject: [PATCH 0/9] backlight: atmel-pwm-bl: fixes and clean ups
Message-Id: <1382462819-28576-1-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

These patches fix a few issues and clean up the atmel-pwm-bl driver
somewhat.

Johan

Johan Hovold (9):
  backlight: atmel-pwm-bl: fix reported brightness
  backlight: atmel-pwm-bl: fix gpio polarity in remove
  backlight: atmel-pwm-bl: fix module autoload
  backlight: atmel-pwm-bl: clean up probe error handling
  backlight: atmel-pwm-bl: clean up get_intensity
  backlight: atmel-pwm-bl: remove unused include
  backlight: atmel-pwm-bl: use gpio_is_valid
  backlight: atmel-pwm-bl: refactor gpio_on handling
  backlight: atmel-pwm-bl: use gpio_request_one

 drivers/video/backlight/atmel-pwm-bl.c | 86 ++++++++++++++++------------------
 1 file changed, 40 insertions(+), 46 deletions(-)

-- 
1.8.4

