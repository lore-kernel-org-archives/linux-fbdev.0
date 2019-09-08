From: Andreas Kemnade <andreas@kemnade.info>
Date: Sun, 08 Sep 2019 20:37:02 +0000
Subject: [PATCH 0/2] backlight_lm3630a: add enable_gpios property
Message-Id: <20190908203704.30147-1-andreas@kemnade.info>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Andreas Kemnade <andreas@kemnade.info>

To be able to handle the HWEN pin of the lm3630a, add
an enable gpio to the driver and a property.

Tested on Kobo Clara HD

Andreas Kemnade (2):
  backlight: lm3630a: add an enable gpio for the HWEN pin
  dt-bindings: backlight: lm3630a: add enable_gpios

 .../leds/backlight/lm3630a-backlight.yaml      |  4 ++++
 drivers/video/backlight/lm3630a_bl.c           | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

-- 
2.20.1
