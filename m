From: Johan Hovold <jhovold@gmail.com>
Date: Thu, 31 Oct 2013 17:57:35 +0000
Subject: [PATCH v3 0/9] backlight: atmel-pwm-bl: fixes and clean ups
Message-Id: <1383242264-7652-1-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383064064-4983-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1383064064-4983-1-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

These patches fix a few issues and clean up the atmel-pwm-bl driver
somewhat.

Acks from Jingoo Han retained on all patches but the slightly modified
first and final patch.

Johan

v2:
 - mask returned brightness rather than cast it to u16 (patch 1/9)
v3
 - use unsigned long for gpio flags (patch 9/9)

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
1.8.4.2

