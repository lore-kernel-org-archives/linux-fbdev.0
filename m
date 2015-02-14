From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Sat, 14 Feb 2015 14:22:12 +0000
Subject: Re: [PATCH 4/8] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <20150214152212.1643da7d@maestro.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
	<1423261694-5939-5-git-send-email-niederp@physik.uni-kl.de>
	<20150207111821.GN2079@lukather>
	<20150207163541.30047a33@maestro.intranet>
	<20150212151121.GJ2079@lukather>
In-Reply-To: <20150212151121.GJ2079@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org

Am Thu, 12 Feb 2015 16:11:21 +0100
schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:

> On Sat, Feb 07, 2015 at 04:35:41PM +0100, Thomas Niederprüm wrote:
> > Am Sat, 7 Feb 2015 12:18:21 +0100
> > schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
> > 
> > > Hi,
> > > 
> > > On Fri, Feb 06, 2015 at 11:28:10PM +0100, niederp@physik.uni-kl.de
> > > wrote:
> > > > From: Thomas Niederprüm <niederp@physik.uni-kl.de>
> > > > 
> > > > It makes sense to use vmalloc to allocate the video buffer
> > > > since it has to be page aligned memory for using it with mmap.
> > > 
> > > Please wrap your commit log at 80 chars.
> > 
> > I'll try to do so in future, sorry for that.
> > 
> > > 
> > > It looks like there's numerous fbdev drivers using this
> > > (especially since you copy pasted that code, without mentionning
> > > it).
> > 
> > Yes, I should have mentioned that in the commit message. As
> > implicitly indicated in the cover letter the rvmalloc() and
> > rvfree() are copy pasted from the vfb driver. Honestly, I didn't
> > give this one too much thought. It seemed a viable solution to the
> > mmap problem. For a bit more history on that, see my comment below.
> > 
> > > 
> > > That should be turned into an allocator so that drivers all get
> > > this right.
> > > 
> > > > Also deffered io seems buggy in combination with kmalloc'ed
> > > > memory (crash on unloading the module).
> > > 
> > > And maybe that's the real issue to fix.
> > 
> > The problem is solved by using vmalloc ;)
> 
> Yep, but why do you need to mark the reserved pages?
> 
> ...

As far as I understood mmaped memory is marked as userspace memory in
the page table and is therefore subject to swapping. The pages are
marked reserved to make clear that this memory can not be swapped and
thus lock the pages in memory. See discussions [0,1,2]. 

[0]http://stackoverflow.com/questions/10760479/mmap-kernel-buffer-to-user-space
[1]http://www.linuxquestions.org/questions/linux-kernel-70/why-why-setpagereserved-is-needed-when-map-a-kernel-space-to-user-space-885176/
[2]https://sites.google.com/site/skartikeyan/mmap.html

> 
> > > > @@ -570,7 +608,7 @@ static int ssd1307fb_probe(struct i2c_client
> > > > *client, info->var.blue.offset = 0;
> > > >  
> > > >  	info->screen_base = (u8 __force __iomem *)vmem;
> > > > -	info->fix.smem_start = (unsigned long)vmem;
> > > > +	info->fix.smem_start = __pa(vmem);
> > > 
> > > Why are you changing from virtual to physical address here?
> > 
> > Oh, good catch! This is still a residual of my attempts to get this
> > working with kmalloc'ed memory. In the current state the driver is
> > presenting a completely wrong memory address upon mmap. As reported
> > in [0] info->fix.smem_start has to hold the physical address of the
> > video memory if it was allocated using kmalloc. Correcting this let
> > me run into the problem that the kmalloc'ed memory was not page
> > aligned but, the memory address handed to userspace mmap was
> > aligned to the next full page, resulting in an inaccessable display
> > region. At that point I just copied the vmalloc approach from the
> > vfb driver.
> > 
> > [0]
> > http://stackoverflow.com/questions/22285151/kernel-panic-using-deferred-io-on-kmalloced-buffer
> 
> And the documentation of fb_fix_screeninfo indeed state that this
> should be the physical address:
> http://lxr.free-electrons.com/source/include/uapi/linux/fb.h#L158
> 
> Could you make that a separate patch?

Will be a separate patch in v2.

> 
> Thanks,
> Maxime
> 

Thomas

