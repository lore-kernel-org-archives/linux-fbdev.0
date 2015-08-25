From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 25 Aug 2015 12:18:53 +0000
Subject: Re: [PATCH 1/3] leds: Add of_led_get() and led_put()
Message-Id: <20150825121853.GB14871@lunn.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
 <1440502442-19531-2-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1440502442-19531-2-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, Aug 25, 2015 at 02:34:00PM +0300, Tomi Valkeinen wrote:
> This patch adds basic support for a kernel driver to get a LED device.
> This will be used by the led-backlight driver.
> 
> Only OF version is implemented for now, and the behavior is similar to
> PWM's of_pwm_get() and pwm_put().

Hi Tomi

Is this the correct way to do it?  I would of expected an xlate
function.

I'm also wondering if this is the right place, in the class. Don't you
just need the core?

     Andrew
