From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Sat, 07 Feb 2015 15:35:41 +0000
Subject: Re: [PATCH 4/8] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <20150207163541.30047a33@maestro.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
	<1423261694-5939-5-git-send-email-niederp@physik.uni-kl.de>
	<20150207111821.GN2079@lukather>
In-Reply-To: <20150207111821.GN2079@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org

Am Sat, 7 Feb 2015 12:18:21 +0100
schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:

> Hi,
> 
> On Fri, Feb 06, 2015 at 11:28:10PM +0100, niederp@physik.uni-kl.de
> wrote:
> > From: Thomas Niederprüm <niederp@physik.uni-kl.de>
> > 
> > It makes sense to use vmalloc to allocate the video buffer since it
> > has to be page aligned memory for using it with mmap.
> 
> Please wrap your commit log at 80 chars.

I'll try to do so in future, sorry for that.

> 
> It looks like there's numerous fbdev drivers using this (especially
> since you copy pasted that code, without mentionning it).

Yes, I should have mentioned that in the commit message. As
implicitly indicated in the cover letter the rvmalloc() and rvfree() are
copy pasted from the vfb driver. Honestly, I didn't give this one too
much thought. It seemed a viable solution to the mmap problem. For a
bit more history on that, see my comment below.

> 
> That should be turned into an allocator so that drivers all get this
> right.
> 
> > Also deffered io seems buggy in combination with kmalloc'ed memory
> > (crash on unloading the module).
> 
> And maybe that's the real issue to fix.

The problem is solved by using vmalloc ;)

> 
> > Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
> > ---
> >  drivers/video/fbdev/ssd1307fb.c | 43
> > +++++++++++++++++++++++++++++++++++++++-- 1 file changed, 41
> > insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/ssd1307fb.c
> > b/drivers/video/fbdev/ssd1307fb.c index 01cfb46..945ded9 100644
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
> > @@ -93,6 +94,43 @@ static struct fb_var_screeninfo ssd1307fb_var = {
> >  	.bits_per_pixel	= 1,
> >  };
> >  
> > +static void *rvmalloc(unsigned long size)
> > +{
> > +	void *mem;
> > +	unsigned long adr;
> > +
> > +	size = PAGE_ALIGN(size);
> 
> Isn't vmalloc already taking care of that?
> 
> > +	mem = vmalloc_32(size);
> 
> Why the 32 bits variant?
> 
> > +	if (!mem)
> > +		return NULL;
> > +
> > +	memset(mem, 0, size); /* Clear the ram out, no junk to the
> > user */
> > +	adr = (unsigned long) mem;
> > +	while (size > 0) {
> > +		SetPageReserved(vmalloc_to_page((void *)adr));
> 
> I'm not really sure it makes sense to mark all pages reserved if we're
> not even sure we're going to use mmap.
> 
> And why do you need to mark these pages reserved in the first place?
> 
> > +		adr += PAGE_SIZE;
> > +		size -= PAGE_SIZE;
> > +	}
> > +
> > +	return mem;
> > +}
> > +
> > +static void rvfree(void *mem, unsigned long size)
> > +{
> > +	unsigned long adr;
> > +
> > +	if (!mem)
> > +		return;
> > +
> > +	adr = (unsigned long) mem;
> > +	while ((long) size > 0) {
> > +		ClearPageReserved(vmalloc_to_page((void *)adr));
> > +		adr += PAGE_SIZE;
> > +		size -= PAGE_SIZE;
> > +	}
> > +	vfree(mem);
> > +}
> > +
> >  static struct ssd1307fb_array *ssd1307fb_alloc_array(u32 len, u8
> > type) {
> >  	struct ssd1307fb_array *array;
> > @@ -538,13 +576,13 @@ static int ssd1307fb_probe(struct i2c_client
> > *client, if (of_property_read_u32(node, "solomon,vcomh",
> > &par->vcomh)) par->vcomh = par->device_info->default_vcomh;
> >  
> > -	vmem = devm_kzalloc(&client->dev, vmem_size, GFP_KERNEL);
> >  	if (of_property_read_u32(node, "solomon,dclk-div",
> > &par->dclk_div)) par->dclk_div = par->device_info->default_dclk_div;
> >  
> >  	if (of_property_read_u32(node, "solomon,dclk-frq",
> > &par->dclk_frq)) par->dclk_frq  > > par->device_info->default_dclk_frq; 
> > +	vmem = rvmalloc(vmem_size);
> >  	if (!vmem) {
> >  		dev_err(&client->dev, "Couldn't allocate graphical
> > memory.\n"); ret = -ENOMEM;
> > @@ -570,7 +608,7 @@ static int ssd1307fb_probe(struct i2c_client
> > *client, info->var.blue.offset = 0;
> >  
> >  	info->screen_base = (u8 __force __iomem *)vmem;
> > -	info->fix.smem_start = (unsigned long)vmem;
> > +	info->fix.smem_start = __pa(vmem);
> 
> Why are you changing from virtual to physical address here?

Oh, good catch! This is still a residual of my attempts to get this
working with kmalloc'ed memory. In the current state the driver is
presenting a completely wrong memory address upon mmap. As reported in
[0] info->fix.smem_start has to hold the physical address of the video
memory if it was allocated using kmalloc. Correcting this let me run
into the problem that the kmalloc'ed memory was not page aligned but,
the memory address handed to userspace mmap was aligned to the next
full page, resulting in an inaccessable display region. At that point I
just copied the vmalloc approach from the vfb driver.

[0] http://stackoverflow.com/questions/22285151/kernel-panic-using-deferred-io-on-kmalloced-buffer

> 
> Maxime
> 

