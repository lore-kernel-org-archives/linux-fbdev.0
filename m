From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 22 Apr 2020 08:30:35 +0000
Subject: Re: [PATCHv3 4/4] backlight: led_bl: fix led -> backlight brightness mapping
Message-Id: <20200422083035.wiujphrt5k7o244v@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200422065114.22164-1-tomi.valkeinen@ti.com>
 <20200422065114.22164-5-tomi.valkeinen@ti.com>
In-Reply-To: <20200422065114.22164-5-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Wed, Apr 22, 2020 at 09:51:14AM +0300, Tomi Valkeinen wrote:
> The code that maps the LED default brightness to backlight levels has
> two issues: 1) if the default brightness is the first backlight level
> (usually 0), the code fails to find it, and 2) when the code fails to
> find a backlight level, it ends up using max_brightness + 1 as the
> default brightness.
> 
> Fix these two issues.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
