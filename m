From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Sep 2011 07:47:00 +0000
Subject: How to use backlight device with fb device
Message-Id: <1316072820.1880.51.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

I'm a bit confused how a backlight device and a fb device should be
"connected".

In this particular case the OMAP 4430SDP board has an LCD panel
controlled by omapfb (and omapdss on the lower level) with a backlight
controlled by pwm_backlight (and twl6030-pwm on the lower level).

Both omapfb and pwm_backlight work fine, but they don't know anything
about each other, so, for example, blanking the fb via omapfb leaves the
backlight on.

Is there something I'm missing, or is the only solution to have some
custom code to connect the fb and the bl, and handle it that way?

 Tomi


