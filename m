From: Darren Etheridge <detheridge@ti.com>
Date: Thu, 01 Aug 2013 20:30:17 +0000
Subject: Re: [PATCH v2 10/24] video: da8xx-fb: fb_set_par support
Message-Id: <20130801203017.GC17271@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375208791-15781-11-git-send-email-detheridge@ti.com>
In-Reply-To: <1375208791-15781-11-git-send-email-detheridge@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> wrote on Thu [2013-Aug-01 08:44:00 +0300]:
> On 31/07/13 21:56, Etheridge, Darren wrote:
> >>>
> >>> +static int da8xxfb_set_par(struct fb_info *info) {
> >>> +	struct da8xx_fb_par *par = info->par;
> >>> +	int ret;
> >>> +	bool raster = da8xx_fb_is_raster_enabled();
> >>> +
> >>> +	if (raster)
> >>> +		lcd_disable_raster(true);
> >>> +	else
> >>> +		lcd_disable_raster(false);
> >>
> >> This looks odd. If raster is enabled, you disable it. And if raster is disabled,
> >> you disable it.
> > 
> > I corrected this one in patch 0011 - I agree this code is very confusing.
> 
> In patch 11 you add the enum. I wasn't referring to that. My point was
> that even if raster is already disabled,
> lcd_disable_raster(dont-wait-for-framedone) is called.
Agreed and removed, the lcd_disable_raster function does the same
check as da8xx_fb_is_raster_enabled() and the immediately exits if not
enabled so this path of the conditional appears completely redundant.

Darren

