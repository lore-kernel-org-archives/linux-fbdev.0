From: Darren Etheridge <detheridge@ti.com>
Date: Thu, 01 Aug 2013 13:54:12 +0000
Subject: Re: [PATCH v2 10/24] video: da8xx-fb: fb_set_par support
Message-Id: <20130801135412.GB27598@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375208791-15781-11-git-send-email-detheridge@ti.com>
In-Reply-To: <1375208791-15781-11-git-send-email-detheridge@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> wrote on Wed [2013-Jul-31 14:38:52 +0300]:
> >  
> > +static inline bool da8xx_fb_is_raster_enabled(void)
> > +{
> > +	return !!(lcdc_read(LCD_RASTER_CTRL_REG) & LCD_RASTER_ENABLE);
> > +}
> 
> See Documentation/CodingStyle about inline.
> 
> I think, generally, it's better not to use inline at all in normal
> functions. Let the compiler decide. Even more so with funcs like
> da8xx_fb_is_raster_enabled(), which I guess is only used rarely.
> 
> There are some inlines added in other patches in the series also.
> 
I have added a new patch to the update series that removes the use of
inline from all offending places.

Darren

