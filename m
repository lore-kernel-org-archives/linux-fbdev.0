From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Tue, 25 Aug 2015 06:31:10 +0000
Subject: [RESEND PATCH 0/7] Export I2C and OF module aliases in missing drivers
Message-Id: <1440484277-32675-1-git-send-email-javier@osg.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

This is a resend of the patches that were not picked from the series
"[PATCH 00/27] Export I2C and OF module aliases in missing drivers" [0]
posted about a month ago.

The patches have no dependencies and can be picked individually by the
relevant maintainer.

I preferred to resend instead of sending a naked ping for each patch
that I got no answer.

Best regards,
Javier


Javier Martinez Canillas (7):
  i2c: core: Export I2C module alias information in dummy driver
  backlight: tosa: Export I2C module alias information
  usb: phy: isp1301: Export I2C module alias information
  ALSA: ppc: keywest: Export I2C module alias information
  extcon: Export OF module alias information in missing drivers
  leds: Export OF module alias information in missing drivers
  regulator: isl9305: Export OF module alias information

 drivers/extcon/extcon-rt8973a.c   | 1 +
 drivers/extcon/extcon-sm5502.c    | 1 +
 drivers/i2c/i2c-core.c            | 1 +
 drivers/leds/leds-pca963x.c       | 1 +
 drivers/leds/leds-tca6507.c       | 1 +
 drivers/regulator/isl9305.c       | 1 +
 drivers/usb/phy/phy-isp1301.c     | 1 +
 drivers/video/backlight/tosa_bl.c | 1 +
 sound/ppc/keywest.c               | 1 +
 9 files changed, 9 insertions(+)

-- 
2.4.3

