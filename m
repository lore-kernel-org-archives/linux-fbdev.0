From: Ezequiel Garcia <ezequiel@collabora.com>
Date: Sun, 21 Jul 2019 23:00:44 +0000
Subject: Re: [PATCH] Enable backlight when trigger is activated
Message-Id: <22d7eca4ad8aa2e73933c4f83c92221ce6e0945a.camel@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190718190849.GA11409@amd>
In-Reply-To: <20190718190849.GA11409@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

Hi Pavel,

The commit log is lacking the proper "leds: triggers: ".

Also...

On Thu, 2019-07-18 at 21:08 +0200, Pavel Machek wrote:
> Configuring backlight trigger from dts results in backlight off during
> boot. Machine looks dead upon boot, which is not good.
> 
> Fix that by enabling LED on trigger activation.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/drivers/leds/trigger/ledtrig-backlight.c b/drivers/leds/trigger/ledtrig-backlight.c
> index 487577d..6e6bc78 100644
> --- a/drivers/leds/trigger/ledtrig-backlight.c
> +++ b/drivers/leds/trigger/ledtrig-backlight.c
> @@ -114,6 +114,8 @@ static int bl_trig_activate(struct led_classdev *led)
>  	n->old_status = UNBLANK;
>  	n->notifier.notifier_call = fb_notifier_callback;
>  
> +	led_set_brightness(led, LED_ON);
> +

This looks fishy.

Maybe you should use a default-state = "keep" instead? (and you'll have
to support it in the LED driver).

That'll give you proper "don't touch the LED if it was turned on" behavior,
which is what you seem to want.

Regards,
Eze
