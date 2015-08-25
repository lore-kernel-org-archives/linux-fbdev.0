From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 25 Aug 2015 12:39:52 +0000
Subject: Re: [PATCH 2/3] backlight: add led-backlight driver
Message-Id: <20150825123952.GA18009@lunn.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
 <1440502442-19531-3-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1440502442-19531-3-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, Aug 25, 2015 at 02:34:01PM +0300, Tomi Valkeinen wrote:
> This patch adds a led-backlight driver (led_bl), which is similar to
> pwm_bl except the driver uses a LED class driver to adjust the
> brightness in the HW.

Shouldn't this be sending an event to drivers/leds/trigger/kedtrig-backlight.c

Calling led_set_brightness() from outside of drivers/leds is pretty
much unheard of. It is normal to have a trigger to do this. So why not
use the exiting backlight trigger?

      Andrew
