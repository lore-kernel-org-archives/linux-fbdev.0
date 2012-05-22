From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 22 May 2012 20:59:02 +0000
Subject: Re: [PATCH] backlight: initialize  struct backlight_properties properly
Message-Id: <20120522135902.90253d07.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1337585085-4891-1-git-send-email-corentin.chary@gmail.com>
In-Reply-To: <1337585085-4891-1-git-send-email-corentin.chary@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Tobias Schandinat <FlorianSchandinat@gmx.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, patches@opensource.wolfsonmicro.com, Florian@freedesktop.org, Dave@freedesktop.org, Richard Purdie <rpurdie@rpsys.net>, linux-fbdev@vger.kernel.org, Lars-Peter@freedesktop.org, Airlie <airlied@redhat.com>, Axel Lin <axel.lin@gmail.com>, linux-omap@vger.kernel.org, Matthew Garrett <mjg@redhat.com>

On Mon, 21 May 2012 09:24:35 +0200
Corentin Chary <corentin.chary@gmail.com> wrote:

> In all these files, the .power field was never correctly initialized.
> 
> ...
>
> --- a/drivers/gpu/drm/i915/intel_panel.c
> +++ b/drivers/gpu/drm/i915/intel_panel.c
> @@ -342,6 +342,7 @@ int intel_panel_setup_backlight(struct drm_device *dev)
>  	else
>  		return -ENODEV;
>  
> +	memset(&props, 0, sizeof(props));

This code is all still quite fragile.  What happens if we add a new
field to backlight_properties?  We need to go edit a zillion drivers?

There are two ways of fixing this:

a) write and use

void backlight_properties_init(struct backlight_properties *props,
				int type, int max_brightness, etc);

   or

b) edit all sites to do

	struct backlight_properties bl_props = {
		.type = BACKLIGHT_RAW,
		.max_brighness = intel_panel_get_max_backlight(dev),
		.power = FB_BLANK_UNBLANK,
	};

they're largely equivalent - the struct will be zeroed out and
then certain fields will be initialised.  a) is a bit better because
some future field may not want the all-zeroes pattern (eg, a spinlock).

But they're both better than what we have now!
