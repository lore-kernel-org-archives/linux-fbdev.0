From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Sat, 07 Feb 2015 16:12:11 +0000
Subject: Re: [PATCH 6/8]  fbdev: ssd1307fb: Add module parameter to set update delay of the  deffered io.
Message-Id: <20150207171211.773dc996@maestro.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
	<1423261694-5939-7-git-send-email-niederp@physik.uni-kl.de>
	<20150207112627.GP2079@lukather>
In-Reply-To: <20150207112627.GP2079@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org

Am Sat, 7 Feb 2015 12:26:27 +0100
schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:

> On Fri, Feb 06, 2015 at 11:28:12PM +0100, niederp@physik.uni-kl.de
> wrote:
> > From: Thomas Niederprüm <niederp@physik.uni-kl.de>
> > 
> > This patch adds the module parameter "delaydivider" to set delay
> > for the deferred io. Effectively this is setting the refresh rate
> > for mmap access to the framebuffer. The delay for the deferred io
> > is HZ/delaydivider.
> 
> So this is actually a refresh rate?
> 
> Maybe you could expose it as such, and pass a frequency in Hz as an
> argument.

Good idea! I'll try to do it that way.

> 
> Exposing the divider directly has some issues, since the bootloader
> that set the parameter won't know the HZ value, you'll end up with
> different rates for different configurations, without any way to do
> something about it.
> 
> > 
> > Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
> > ---
> >  drivers/video/fbdev/ssd1307fb.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/fbdev/ssd1307fb.c
> > b/drivers/video/fbdev/ssd1307fb.c index 1d81877..b38315d 100644
> > --- a/drivers/video/fbdev/ssd1307fb.c
> > +++ b/drivers/video/fbdev/ssd1307fb.c
> > @@ -44,10 +44,14 @@
> >  #define	SSD1307FB_SET_VCOMH		0xdb
> >  
> >  #define BITSPERPIXEL 1
> > +#define DELAYDIVIDER 20
> >  
> >  static u_int bitsperpixel = BITSPERPIXEL;
> >  module_param(bitsperpixel, uint, 0);
> >  
> > +static u_int delaydivider = DELAYDIVIDER;
> > +module_param(delaydivider, uint, 0);
> > +
> 
> You're breaking the existing behaviour.

True! I'll try to keep the existing behaviour when rewriting this to
use the refresh rate.

> 
> >  struct ssd1307fb_par;
> >  
> >  struct ssd1307fb_deviceinfo {
> > @@ -312,7 +316,7 @@ static void ssd1307fb_deferred_io(struct
> > fb_info *info, }
> >  
> >  static struct fb_deferred_io ssd1307fb_defio = {
> > -	.delay		= HZ,
> > +	.delay		= HZ/DELAYDIVIDER,
> >  	.deferred_io	= ssd1307fb_deferred_io,
> >  };
> >  
> > @@ -601,6 +605,7 @@ static int ssd1307fb_probe(struct i2c_client
> > *client, info->fix = ssd1307fb_fix;
> >  	info->fix.line_length = par->width * bitsperpixel / 8;
> >  	info->fbdefio = &ssd1307fb_defio;
> > +	info->fbdefio->delay = HZ/delaydivider;
> 
> That won't work with multiple instances of the same driver
> unfortunately.

Could you please elaborate why? I'm not seeing it...

> 
> >  
> >  	info->var = ssd1307fb_var;
> >  	info->var.bits_per_pixel = bitsperpixel;
> > -- 
> > 2.1.1
> > 
> 

