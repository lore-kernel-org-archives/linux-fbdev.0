From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 08 Apr 2020 18:02:16 +0000
Subject: Re: [PATCH] fbdev: mx3fb: avoid warning about psABI change
Message-Id: <20200408180216.GC24828@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200408162551.3928330-1-arnd@arndb.de> <87pnchhp2s.fsf@intel.com>
In-Reply-To: <87pnchhp2s.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Enrico Weigelt <info@metux.net>

Hi Jani & Laurent.

On Wed, Apr 08, 2020 at 08:20:11PM +0300, Jani Nikula wrote:
> On Wed, 08 Apr 2020, Arnd Bergmann <arnd@arndb.de> wrote:
> > The arm64 gcc-9 release warns about a change in the calling
> > conventions:
> >
> > drivers/video/fbdev/mx3fb.c: In function 'sdc_init_panel':
> > drivers/video/fbdev/mx3fb.c:506:12: note: parameter passing for argument of type 'struct ipu_di_signal_cfg' changed in GCC 9.1
> >   506 | static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
> >       |            ^~~~~~~~~~~~~~
> > drivers/video/fbdev/mx3fb.c: In function '__set_par':
> > drivers/video/fbdev/mx3fb.c:848:7: note: parameter passing for argument of type 'struct ipu_di_signal_cfg' changed in GCC 9.1
> >
> > Change the file to just pass the struct by reference, which is
> > unambiguous and avoids the warning.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/video/fbdev/mx3fb.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
> > index 4af28e4421e5..e13fea3a292f 100644
> > --- a/drivers/video/fbdev/mx3fb.c
> > +++ b/drivers/video/fbdev/mx3fb.c
> > @@ -509,7 +509,7 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
> >  			  uint16_t h_start_width, uint16_t h_sync_width,
> >  			  uint16_t h_end_width, uint16_t v_start_width,
> >  			  uint16_t v_sync_width, uint16_t v_end_width,
> > -			  struct ipu_di_signal_cfg sig)
> > +			  struct ipu_di_signal_cfg *sig)
> 
> I have no idea why get_maintainer.pl (I presume) is Cc'ing me... but
> since it is, I'll note that the pointer could be const, while the patch
> is
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

I was too quick to apply this - sorry.
I will follow-up with a const fix.

	Sam

> 
> either way.
> 
> >  {
> >  	unsigned long lock_flags;
> >  	uint32_t reg;
> > @@ -591,17 +591,17 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
> >  
> >  	/* DI settings */
> >  	old_conf = mx3fb_read_reg(mx3fb, DI_DISP_IF_CONF) & 0x78FFFFFF;
> > -	old_conf |= sig.datamask_en << DI_D3_DATAMSK_SHIFT |
> > -		sig.clksel_en << DI_D3_CLK_SEL_SHIFT |
> > -		sig.clkidle_en << DI_D3_CLK_IDLE_SHIFT;
> > +	old_conf |= sig->datamask_en << DI_D3_DATAMSK_SHIFT |
> > +		sig->clksel_en << DI_D3_CLK_SEL_SHIFT |
> > +		sig->clkidle_en << DI_D3_CLK_IDLE_SHIFT;
> >  	mx3fb_write_reg(mx3fb, old_conf, DI_DISP_IF_CONF);
> >  
> >  	old_conf = mx3fb_read_reg(mx3fb, DI_DISP_SIG_POL) & 0xE0FFFFFF;
> > -	old_conf |= sig.data_pol << DI_D3_DATA_POL_SHIFT |
> > -		sig.clk_pol << DI_D3_CLK_POL_SHIFT |
> > -		sig.enable_pol << DI_D3_DRDY_SHARP_POL_SHIFT |
> > -		sig.Hsync_pol << DI_D3_HSYNC_POL_SHIFT |
> > -		sig.Vsync_pol << DI_D3_VSYNC_POL_SHIFT;
> > +	old_conf |= sig->data_pol << DI_D3_DATA_POL_SHIFT |
> > +		sig->clk_pol << DI_D3_CLK_POL_SHIFT |
> > +		sig->enable_pol << DI_D3_DRDY_SHARP_POL_SHIFT |
> > +		sig->Hsync_pol << DI_D3_HSYNC_POL_SHIFT |
> > +		sig->Vsync_pol << DI_D3_VSYNC_POL_SHIFT;
> >  	mx3fb_write_reg(mx3fb, old_conf, DI_DISP_SIG_POL);
> >  
> >  	map = &di_mappings[mx3fb->disp_data_fmt];
> > @@ -855,7 +855,7 @@ static int __set_par(struct fb_info *fbi, bool lock)
> >  				   fbi->var.upper_margin,
> >  				   fbi->var.vsync_len,
> >  				   fbi->var.lower_margin +
> > -				   fbi->var.vsync_len, sig_cfg) != 0) {
> > +				   fbi->var.vsync_len, &sig_cfg) != 0) {
> >  			dev_err(fbi->device,
> >  				"mx3fb: Error initializing panel.\n");
> >  			return -EINVAL;
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
