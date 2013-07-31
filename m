From: "Etheridge, Darren" <detheridge@ti.com>
Date: Wed, 31 Jul 2013 18:56:11 +0000
Subject: RE: [PATCH v2 10/24] video: da8xx-fb: fb_set_par support
Message-Id: <1A80A2FD7F34484786E5DF71F3968B6940F262F8@DLEE10.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375208791-15781-11-git-send-email-detheridge@ti.com>
In-Reply-To: <1375208791-15781-11-git-send-email-detheridge@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

> >
> > +static int da8xxfb_set_par(struct fb_info *info) {
> > +	struct da8xx_fb_par *par = info->par;
> > +	int ret;
> > +	bool raster = da8xx_fb_is_raster_enabled();
> > +
> > +	if (raster)
> > +		lcd_disable_raster(true);
> > +	else
> > +		lcd_disable_raster(false);
> 
> This looks odd. If raster is enabled, you disable it. And if raster is disabled,
> you disable it.

I corrected this one in patch 0011 - I agree this code is very confusing.

