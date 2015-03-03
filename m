From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Tue, 03 Mar 2015 19:04:29 +0000
Subject: Re: [PATCHv2 02/10] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <20150303200429.1925afe1@maestro.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
	<1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
	<1425248883-25367-3-git-send-email-niederp@physik.uni-kl.de>
	<20150303085255.GB4911@lukather>
In-Reply-To: <20150303085255.GB4911@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Am Tue, 3 Mar 2015 09:52:55 +0100
schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:

> Hi,
> 
> On Sun, Mar 01, 2015 at 11:27:55PM +0100, Thomas Niederprüm wrote:
> > It makes sense to use vmalloc to allocate the video buffer since it
> > has to be page aligned memory for using it with mmap. Also deffered
> > io seems buggy in combination with kmalloc'ed memory (crash on
> > unloading the module).
> > 
> > Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
> > ---
> >  drivers/video/fbdev/ssd1307fb.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/fbdev/ssd1307fb.c
> > b/drivers/video/fbdev/ssd1307fb.c index 61e0ce8..25dd08d 100644
> > --- a/drivers/video/fbdev/ssd1307fb.c
> > +++ b/drivers/video/fbdev/ssd1307fb.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/fb.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/vmalloc.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of_gpio.h>
> >  #include <linux/pwm.h>
> > @@ -489,7 +490,7 @@ static int ssd1307fb_probe(struct i2c_client
> > *client, 
> >  	vmem_size = par->width * par->height / 8;
> >  
> > -	vmem = devm_kzalloc(&client->dev, vmem_size, GFP_KERNEL);
> > +	vmem = vzalloc(vmem_size);
> >  	if (!vmem) {
> >  		dev_err(&client->dev, "Couldn't allocate graphical
> > memory.\n"); ret = -ENOMEM;
> > @@ -559,6 +560,7 @@ panel_init_error:
> >  		par->ops->remove(par);
> >  reset_oled_error:
> >  	fb_deferred_io_cleanup(info);
> > +	vfree(vmem);
> >  fb_alloc_error:
> >  	framebuffer_release(info);
> >  	return ret;
> 
> Don't you need the vfree in the remove too?

Yes, of course. Memory will be freed in v3

> 
> Maxime
> 

