From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 02 May 2014 15:15:23 +0000
Subject: Re: some divide by zero bugs in >fb_check_var() functions
Message-Id: <20140502151523.GI4963@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140124223503.GA4251@elgon.mountain>
In-Reply-To: <20140124223503.GA4251@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Anyone want to look through these again?  These of divide by
zero bugs in drivers/video/ are a massive pain.  Is there no way to
prevent these crashing bugs that doesn't involve adding hundreds of
conditions?

regards,
dan carpenter

On Wed, Jan 29, 2014 at 12:41:37AM +0300, Dan Carpenter wrote:
> On Tue, Jan 28, 2014 at 01:28:06PM -0800, Kees Cook wrote:
> > On Fri, Jan 24, 2014 at 2:35 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > My static checker find a number of divide by zero bugs in
> > > ->fb_check_var() functions.  The call tree looks like this:
> > >
> > >   do_fb_ioctl() <- get var from the user.
> > >   -> fb_set_var()
> > >      -> info->fbops->fb_check_var(var, info); <- divide by zero bugs
> > >
> > > I wonder if we could add some checking in fb_set_var() to prevent this.
> > >
> > > drivers/video/asiliantfb.c:230 asiliantfb_check_var() error: potential divide by zero bug '/ var->pixclock'.
> > > drivers/video/asiliantfb.c:231 asiliantfb_check_var() error: potential divide by zero bug '/ var->pixclock'.
> > > drivers/video/asiliantfb.c:232 asiliantfb_check_var() error: potential divide by zero bug '/ var->pixclock'.
> > > drivers/video/cirrusfb.c:535 cirrusfb_check_var() error: potential divide by zero bug '/ var->bits_per_pixel'.
> > > drivers/video/cirrusfb.c:581 cirrusfb_check_var() error: potential divide by zero bug '/ var->xres_virtual'.
> > > drivers/video/cyber2000fb.c:843 cyber2000fb_check_var() error: potential divide by zero bug '/ (var->bits_per_pixel * var->xres_virtual)'.
> > > drivers/video/imsttfb.c:843 imsttfb_check_var() error: potential divide by zero bug '/ var->xres_virtual'.
> > > drivers/video/neofb.c:594 neofb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> > > drivers/video/neofb.c:702 neofb_check_var() error: potential divide by zero bug '/ (var->xres_virtual * var->bits_per_pixel)'.
> > > drivers/video/pm2fb.c:624 pm2fb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> > > drivers/video/pm3fb.c:1007 pm3fb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> > > drivers/video/s3fb.c:601 s3fb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> > > drivers/video/savage/savagefb_driver.c:952 savagefb_check_var() error: potential divide by zero bug '/ (var->xres_virtual * var->bits_per_pixel)'.
> > > drivers/video/sstfb.c:359 sstfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> > > drivers/video/sstfb.c:361 sstfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> > > drivers/video/tdfxfb.c:518 tdfxfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> > > drivers/video/tdfxfb.c:519 tdfxfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> > > drivers/video/tridentfb.c:918 tridentfb_check_var() error: potential divide by zero bug '/ line_length'.
> > > drivers/video/tridentfb.c:973 tridentfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> > 
> > Is it ever valid to have pixclock, xres_virtual, or bits_per_pixel be
> > zero? Seems like it'd be trivial to check for those in fb_set_var()?
> > 
> 
> It's not so simple as testing for zero, you also have to consider the
> maximum and integer overflows so "var->xres_virtual * var->bits_per_pixel"
> isn't zero.
> 
> If I add another call to the call tree then there are more errors again.
> 
> regards,
> dan carpenter
> 
> drivers/video/savage/savagefb_driver.c:952 savagefb_check_var() error: potential divide by zero bug '/ (var->xres_virtual * var->bits_per_pixel)'.
> drivers/video/savage/savagefb_driver.c:952 savagefb_check_var() error: potential divide by zero bug '/ (var->xres_virtual * var->bits_per_pixel)'.
> drivers/video/fbmon.c:1147 fb_get_hblank_by_hfreq() error: potential divide by zero bug '/ hfreq'.
> drivers/video/fbmon.c:1147 fb_get_hblank_by_hfreq() error: potential divide by zero bug '/ hfreq'.
> drivers/video/fbmon.c:1232 fb_timings_hfreq() error: potential divide by zero bug '/ timings->vtotal'.
> drivers/video/fbmon.c:1232 fb_timings_hfreq() error: potential divide by zero bug '/ timings->vtotal'.
> drivers/video/fbmon.c:1244 fb_timings_dclk() error: potential divide by zero bug '/ timings->htotal'.
> drivers/video/fbmon.c:1244 fb_timings_dclk() error: potential divide by zero bug '/ timings->htotal'.
> drivers/video/fbmon.c:1247 fb_timings_dclk() error: potential divide by zero bug '/ timings->vtotal'.
> drivers/video/fbmon.c:1247 fb_timings_dclk() error: potential divide by zero bug '/ timings->vtotal'.
> drivers/video/fbmon.c:1364 fb_get_mode() error: potential divide by zero bug '/ (timings->dclk / 1000)'.
> drivers/video/fbmon.c:1364 fb_get_mode() error: potential divide by zero bug '/ (timings->dclk / 1000)'.
> drivers/video/fbmon.c:1544 fb_validate_mode() error: potential divide by zero bug '/ htotal'.
> drivers/video/fbmon.c:1544 fb_validate_mode() error: potential divide by zero bug '/ htotal'.
> drivers/video/fbmon.c:1547 fb_validate_mode() error: potential divide by zero bug '/ vtotal'.
> drivers/video/fbmon.c:1547 fb_validate_mode() error: potential divide by zero bug '/ vtotal'.
> drivers/video/via/viafbdev.c:196 get_var_refresh() error: potential divide by zero bug '/ (htotal * vtotal)'.
> drivers/video/via/viafbdev.c:196 get_var_refresh() error: potential divide by zero bug '/ (htotal * vtotal)'.
> drivers/video/via/viafbdev.c:196 get_var_refresh() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/via/viafbdev.c:196 get_var_refresh() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/pm3fb.c:338 pm3fb_init_engine() error: potential divide by zero bug '/ info->fix.line_length'.
> drivers/video/pm3fb.c:338 pm3fb_init_engine() error: potential divide by zero bug '/ info->fix.line_length'.
> drivers/video/pm3fb.c:834 pm3fb_write_mode() error: potential divide by zero bug '/ (info->var.pixclock)'.
> drivers/video/pm3fb.c:834 pm3fb_write_mode() error: potential divide by zero bug '/ (info->var.pixclock)'.
> drivers/video/pm3fb.c:1007 pm3fb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/pm3fb.c:1007 pm3fb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/tdfxfb.c:518 tdfxfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/tdfxfb.c:518 tdfxfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/tdfxfb.c:519 tdfxfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/tdfxfb.c:519 tdfxfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/tdfxfb.c:583 tdfxfb_set_par() error: potential divide by zero bug '/ (info->var.pixclock)'.
> drivers/video/tdfxfb.c:583 tdfxfb_set_par() error: potential divide by zero bug '/ (info->var.pixclock)'.
> drivers/video/sstfb.c:359 sstfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/sstfb.c:359 sstfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/sstfb.c:361 sstfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/sstfb.c:361 sstfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/sstfb.c:491 sstfb_set_par() error: potential divide by zero bug '/ (info->var.pixclock)'.
> drivers/video/sstfb.c:491 sstfb_set_par() error: potential divide by zero bug '/ (info->var.pixclock)'.
> drivers/video/sm501fb.c:263 sm501fb_ps_to_hz() error: potential divide by zero bug '/ __base'.
> drivers/video/sm501fb.c:263 sm501fb_ps_to_hz() error: potential divide by zero bug '/ __base'.
> drivers/video/sm501fb.c:263 sm501fb_ps_to_hz() error: potential divide by zero bug '/ __base'.
> drivers/video/sm501fb.c:263 sm501fb_ps_to_hz() error: potential divide by zero bug '/ __base'.
> drivers/video/sm501fb.c:593 sm501fb_pan_crt() error: potential divide by zero bug '/ bytes_pixel'.
> drivers/video/sm501fb.c:593 sm501fb_pan_crt() error: potential divide by zero bug '/ bytes_pixel'.
> drivers/video/cyber2000fb.c:843 cyber2000fb_check_var() error: potential divide by zero bug '/ (var->bits_per_pixel * var->xres_virtual)'.
> drivers/video/cyber2000fb.c:843 cyber2000fb_check_var() error: potential divide by zero bug '/ (var->bits_per_pixel * var->xres_virtual)'.
> drivers/video/kyro/STG4000OverlayDevice.c:379 SetOverlayViewPort() error: potential divide by zero bug '/ ulFxScale'.
> drivers/video/kyro/STG4000OverlayDevice.c:379 SetOverlayViewPort() error: potential divide by zero bug '/ ulFxScale'.
> drivers/video/kyro/STG4000OverlayDevice.c:477 SetOverlayViewPort() error: potential divide by zero bug '/ (ulRight - ulLeft + 2)'.
> drivers/video/kyro/STG4000OverlayDevice.c:477 SetOverlayViewPort() error: potential divide by zero bug '/ (ulRight - ulLeft + 2)'.
> drivers/video/kyro/STG4000OverlayDevice.c:481 SetOverlayViewPort() error: potential divide by zero bug '/ (ulRight - ulLeft + 2)'.
> drivers/video/kyro/STG4000OverlayDevice.c:481 SetOverlayViewPort() error: potential divide by zero bug '/ (ulRight - ulLeft + 2)'.
> drivers/video/kyro/fbdev.c:502 kyrofb_set_par() error: potential divide by zero bug '/ frameclock'.
> drivers/video/kyro/fbdev.c:502 kyrofb_set_par() error: potential divide by zero bug '/ frameclock'.
> drivers/video/kyro/fbdev.c:503 kyrofb_set_par() error: potential divide by zero bug '/ lineclock'.
> drivers/video/kyro/fbdev.c:503 kyrofb_set_par() error: potential divide by zero bug '/ lineclock'.
> drivers/video/kyro/fbdev.c:505 kyrofb_set_par() error: potential divide by zero bug '/ info->var.pixclock'.
> drivers/video/kyro/fbdev.c:505 kyrofb_set_par() error: potential divide by zero bug '/ info->var.pixclock'.
> drivers/video/modedb.c:809 fb_var_to_videomode() error: potential divide by zero bug '/ htotal'.
> drivers/video/modedb.c:809 fb_var_to_videomode() error: potential divide by zero bug '/ htotal'.
> drivers/video/modedb.c:810 fb_var_to_videomode() error: potential divide by zero bug '/ vtotal'.
> drivers/video/modedb.c:810 fb_var_to_videomode() error: potential divide by zero bug '/ vtotal'.
> drivers/video/mb862xx/mb862xxfbdrv.c:221 mb862xxfb_set_par() error: potential divide by zero bug '/ fbi->var.pixclock'.
> drivers/video/mb862xx/mb862xxfbdrv.c:221 mb862xxfb_set_par() error: potential divide by zero bug '/ fbi->var.pixclock'.
> drivers/video/smscufx.c:622 ufx_config_pix_clk() error: potential divide by zero bug '/ (pixclock)'.
> drivers/video/smscufx.c:622 ufx_config_pix_clk() error: potential divide by zero bug '/ (pixclock)'.
> drivers/video/s3fb.c:477 s3_set_pixclock() error: potential divide by zero bug '/ pixclock'.
> drivers/video/s3fb.c:477 s3_set_pixclock() error: potential divide by zero bug '/ pixclock'.
> drivers/video/s3fb.c:601 s3fb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/s3fb.c:601 s3fb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/imsttfb.c:843 imsttfb_check_var() error: potential divide by zero bug '/ var->xres_virtual'.
> drivers/video/imsttfb.c:843 imsttfb_check_var() error: potential divide by zero bug '/ var->xres_virtual'.
> drivers/video/asiliantfb.c:113 asiliant_calc_dclk2() error: potential divide by zero bug '/ pixclock'.
> drivers/video/asiliantfb.c:113 asiliant_calc_dclk2() error: potential divide by zero bug '/ pixclock'.
> drivers/video/asiliantfb.c:123 asiliant_calc_dclk2() error: potential divide by zero bug '/ pixclock'.
> drivers/video/asiliantfb.c:123 asiliant_calc_dclk2() error: potential divide by zero bug '/ pixclock'.
> drivers/video/asiliantfb.c:124 asiliant_calc_dclk2() error: potential divide by zero bug '/ pixclock'.
> drivers/video/asiliantfb.c:124 asiliant_calc_dclk2() error: potential divide by zero bug '/ pixclock'.
> drivers/video/asiliantfb.c:125 asiliant_calc_dclk2() error: potential divide by zero bug '/ pixclock'.
> drivers/video/asiliantfb.c:125 asiliant_calc_dclk2() error: potential divide by zero bug '/ pixclock'.
> drivers/video/asiliantfb.c:230 asiliantfb_check_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/asiliantfb.c:230 asiliantfb_check_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/asiliantfb.c:231 asiliantfb_check_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/asiliantfb.c:231 asiliantfb_check_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/asiliantfb.c:232 asiliantfb_check_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/asiliantfb.c:232 asiliantfb_check_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:435 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:435 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:437 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:437 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:444 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:444 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:446 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:446 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:453 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:453 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:455 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:455 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:461 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:461 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:463 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:463 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:655 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:655 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:662 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/i740fb.c:662 i740fb_decode_var() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/cirrusfb.c:482 cirrusfb_check_pixclock() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/cirrusfb.c:482 cirrusfb_check_pixclock() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/cirrusfb.c:535 cirrusfb_check_var() error: potential divide by zero bug '/ var->bits_per_pixel'.
> drivers/video/cirrusfb.c:535 cirrusfb_check_var() error: potential divide by zero bug '/ var->bits_per_pixel'.
> drivers/video/cirrusfb.c:581 cirrusfb_check_var() error: potential divide by zero bug '/ var->xres_virtual'.
> drivers/video/cirrusfb.c:581 cirrusfb_check_var() error: potential divide by zero bug '/ var->xres_virtual'.
> drivers/video/cirrusfb.c:836 cirrusfb_set_par_foo() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/cirrusfb.c:836 cirrusfb_set_par_foo() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/riva/fbdev.c:722 riva_load_video_mode() error: potential divide by zero bug '/ info->var.pixclock'.
> drivers/video/riva/fbdev.c:722 riva_load_video_mode() error: potential divide by zero bug '/ info->var.pixclock'.
> drivers/video/geode/lxfb_ops.c:169 lx_set_clock() error: potential divide by zero bug '/ info->var.pixclock'.
> drivers/video/geode/lxfb_ops.c:169 lx_set_clock() error: potential divide by zero bug '/ info->var.pixclock'.
> drivers/video/sis/sis_main.c:1082 sisfb_calc_maxyres() error: potential divide by zero bug '/ (var->xres_virtual * (var->bits_per_pixel >> 3))'.
> drivers/video/sis/sis_main.c:1082 sisfb_calc_maxyres() error: potential divide by zero bug '/ (var->xres_virtual * (var->bits_per_pixel >> 3))'.
> drivers/video/nvidia/nvidia.c:424 nvidia_calc_regs() error: potential divide by zero bug '/ info->var.pixclock'.
> drivers/video/nvidia/nvidia.c:424 nvidia_calc_regs() error: potential divide by zero bug '/ info->var.pixclock'.
> drivers/video/tridentfb.c:918 tridentfb_check_var() error: potential divide by zero bug '/ line_length'.
> drivers/video/tridentfb.c:918 tridentfb_check_var() error: potential divide by zero bug '/ line_length'.
> drivers/video/tridentfb.c:973 tridentfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/tridentfb.c:973 tridentfb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/tridentfb.c:1176 tridentfb_set_par() error: potential divide by zero bug '/ (info->var.pixclock)'.
> drivers/video/tridentfb.c:1176 tridentfb_set_par() error: potential divide by zero bug '/ (info->var.pixclock)'.
> drivers/video/neofb.c:594 neofb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/neofb.c:594 neofb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/neofb.c:702 neofb_check_var() error: potential divide by zero bug '/ (var->xres_virtual * var->bits_per_pixel)'.
> drivers/video/neofb.c:702 neofb_check_var() error: potential divide by zero bug '/ (var->xres_virtual * var->bits_per_pixel)'.
> drivers/video/neofb.c:952 neofb_set_par() error: potential divide by zero bug '/ (info->var.pixclock)'.
> drivers/video/neofb.c:952 neofb_set_par() error: potential divide by zero bug '/ (info->var.pixclock)'.
> drivers/video/arkfb.c:517 ark_set_pixclock() error: potential divide by zero bug '/ pixclock'.
> drivers/video/arkfb.c:517 ark_set_pixclock() error: potential divide by zero bug '/ pixclock'.
> drivers/video/udlfb.c:266 dlfb_set_vid_cmds() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/udlfb.c:266 dlfb_set_vid_cmds() error: potential divide by zero bug '/ var->pixclock'.
> drivers/video/uvesafb.c:1270 uvesafb_set_par() error: potential divide by zero bug '/ (crtc->vert_total * crtc->horiz_total)'.
> drivers/video/uvesafb.c:1270 uvesafb_set_par() error: potential divide by zero bug '/ (crtc->vert_total * crtc->horiz_total)'.
> drivers/video/pm2fb.c:624 pm2fb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/pm2fb.c:624 pm2fb_check_var() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/pm2fb.c:716 pm2fb_set_par() error: potential divide by zero bug '/ (info->var.pixclock)'.
> drivers/video/pm2fb.c:716 pm2fb_set_par() error: potential divide by zero bug '/ (info->var.pixclock)'.
> drivers/video/vermilion/vermilion.c:609 vmlfb_check_var_locked() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/vermilion/vermilion.c:609 vmlfb_check_var_locked() error: potential divide by zero bug '/ (var->pixclock)'.
> drivers/video/matrox/matroxfb_Ti3026.c:320 Ti3026_setpclk() error: potential divide by zero bug '/ Bpp'.
> drivers/video/matrox/matroxfb_Ti3026.c:320 Ti3026_setpclk() error: potential divide by zero bug '/ Bpp'.
> drivers/video/matrox/matroxfb_Ti3026.c:323 Ti3026_setpclk() error: potential divide by zero bug '/ Bpp'.
> drivers/video/matrox/matroxfb_Ti3026.c:323 Ti3026_setpclk() error: potential divide by zero bug '/ Bpp'.
> drivers/video/matrox/matroxfb_base.c:578 matroxfb_decode_var() error: potential divide by zero bug '/ (var->xres_virtual * bpp)'.
> drivers/video/matrox/matroxfb_base.c:578 matroxfb_decode_var() error: potential divide by zero bug '/ (var->xres_virtual * bpp)'.
> drivers/video/matrox/matroxfb_base.c:601 matroxfb_decode_var() error: potential divide by zero bug '/ m2'.
> drivers/video/matrox/matroxfb_base.c:601 matroxfb_decode_var() error: potential divide by zero bug '/ m2'.
> drivers/video/matrox/matroxfb_base.c:787 matroxfb_set_par() error: potential divide by zero bug '/ var->bits_per_pixel'.
> drivers/video/matrox/matroxfb_base.c:787 matroxfb_set_par() error: potential divide by zero bug '/ var->bits_per_pixel'.
> drivers/video/aty/radeon_base.c:1595 radeonfb_set_par() error: potential divide by zero bug '/ pixClock'.
> drivers/video/aty/radeon_base.c:1595 radeonfb_set_par() error: potential divide by zero bug '/ pixClock'.
> drivers/video/aty/radeon_base.c:1670 radeonfb_set_par() error: potential divide by zero bug '/ ((mode->bits_per_pixel + 1) / 8)'.
> drivers/video/aty/radeon_base.c:1670 radeonfb_set_par() error: potential divide by zero bug '/ ((mode->bits_per_pixel + 1) / 8)'.
> drivers/video/aty/atyfb_base.c:1575 set_off_pitch() error: potential divide by zero bug '/ bpp'.
> drivers/video/aty/atyfb_base.c:1575 set_off_pitch() error: potential divide by zero bug '/ bpp'.
> drivers/video/aty/mach64_accel.c:69 aty_init_engine() error: potential divide by zero bug '/ (info->var.bits_per_pixel / 8)'.
> drivers/video/aty/mach64_accel.c:69 aty_init_engine() error: potential divide by zero bug '/ (info->var.bits_per_pixel / 8)'.
> drivers/video/aty/aty128fb.c:1342 aty128_var_to_pll() error: potential divide by zero bug '/ period_in_ps'.
> drivers/video/aty/aty128fb.c:1342 aty128_var_to_pll() error: potential divide by zero bug '/ period_in_ps'.
> drivers/video/sysfillrect.c:267 sys_fillrect() error: potential divide by zero bug '/ bpp'.
> drivers/video/sysfillrect.c:267 sys_fillrect() error: potential divide by zero bug '/ bpp'.
> drivers/video/sysfillrect.c:321 sys_fillrect() error: potential divide by zero bug '/ bpp'.
> drivers/video/sysfillrect.c:321 sys_fillrect() error: potential divide by zero bug '/ bpp'.
> drivers/video/cfbfillrect.c:302 cfb_fillrect() error: potential divide by zero bug '/ bpp'.
> drivers/video/cfbfillrect.c:302 cfb_fillrect() error: potential divide by zero bug '/ bpp'.
> drivers/video/cfbfillrect.c:357 cfb_fillrect() error: potential divide by zero bug '/ bpp'.
> drivers/video/cfbfillrect.c:357 cfb_fillrect() error: potential divide by zero bug '/ bpp'.
> drivers/video/vt8623fb.c:267 vt8623_set_pixclock() error: potential divide by zero bug '/ pixclock'.
> drivers/video/vt8623fb.c:267 vt8623_set_pixclock() error: potential divide by zero bug '/ pixclock'.
> 
