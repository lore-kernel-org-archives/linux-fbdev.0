From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 19 Dec 2017 12:23:13 +0000
Subject: Re: [RFC PATCH v2 03/13] bootsplash: Flush framebuffer after drawing
Message-Id: <20171219122313.GE26573@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171213194755.3409-4-mstaudt@suse.de>
 <20171213213506.GD26573@phenom.ffwll.local>
 <d66a994a-cb3a-c1fb-8f91-adbd475a40f0@suse.de>
In-Reply-To: <d66a994a-cb3a-c1fb-8f91-adbd475a40f0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Staudt <mstaudt@suse.de>
Cc: linux-fbdev@vger.kernel.org, michal@markovi.net, b.zolnierkie@samsung.com, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, philm@manjaro.org, bernhard.rosenkranzer@linaro.org

On Thu, Dec 14, 2017 at 04:36:49PM +0100, Max Staudt wrote:
> On 12/13/2017 10:35 PM, Daniel Vetter wrote:
> > Using drm directly would allow you to flush the contents without the fake
> > (and tbh, really expensive on most drivers) copy op. If you insist on
> > using fbdev for this stuff, then at least add a new hook to flush cpu
> > rendering.
> 
> My reasoning is as follows:
> 
> 1) The splash screen is meant to appear as early as possible in the boot
> process, and even on devices that don't have a DRM driver. For example,
> an ARM box with only efifb. Thus, the choice to work on top of FB.
> 
> 2) We need to go out of the way when a graphical application starts, and
> come back when it's done. fbcon already has the logic for this, and
> fbcon is also the thing we're trying to hide. So it seems natural to add
> the splash on top of fbcon - at least for now.

And this "automatically disappear" semantics is horribly ill-defined
between fbdev and native kms. So you're not really solving a problem,
you're just not noticing the hacks because they're one layer removed (in
the fbdev emulation code).

> 3) I can't use DRM from the kernel, for the same reason for which there
> is no "drmcon" to supplant fbcon: There is no interface to reserve
> framebuffer memory from kernel space: To get memory for a framebuffer,
> one needs to have a struct file that is passed through the DRM stack
> down into the drivers.

On recent kernels you only need a struct drm_file, not a struct file. That
can be NULL. We've done this to make drmcon possible/easier.

> If this interface existed, then there could be a generic "fb2drm"
> translation layer, and we would no longer need FB compatibility code in
> each KMS driver. Actually, I tried to implement this translation layer a
> year ago, and hit too many walls.

We're pretty much there already I think. The reason it's not entirely gone
is that there's some nasty interactions between drm and the fbdev
emulation, and just having a pile of drivers that aren't too trivial to
convert.

> I've prepared the code for a future in which fbdev no longer exists: My
> sysfs interface is generically called "bootsplash", in the hope that it
> will one day move on top of KMS. The hooks into fbcon are minimal and
> the code is straightforward to port to KMS operations rather than FB.
> But that's for another day, as far as I can see.
> 
> 4) I don't fully understand what you'd like me to do. Last time I tried
> to add a new entry to the fbops struct (namely fb_open_adj_file()), you
> told me not to touch the framebuffer subsystem anymore, as it is meant
> to die and driver developers shall use KMS instead. Have I
> misunderstood?

I still don't like anyone adding features to fbdev :-)

> Something like fb->flush() to finish kernel space accesses would be nice
> to have, but would need to be implemented for all affected drivers
> separately. The copy op hack is ugly, but solves the problem
> generically.

Well, with defio being the hack it is (and because of that, a bunch of drm
drivers not really supporting it) I'm not sure things actually work better
without all this.

> What shall I do?
> 
> Shall I add a new FB op for flushing when writing to the raw memory from the kernel?
> As far as I can see, it would be needed for defio drivers only, is that correct?

Yes, which are kinda horrible anyway. I guess you could at least not do
all these hacks if it's not a defio driver.
-Daniel

> 
> 
> >> +	 *
> >> +	 * A few DRM drivers' FB implementations are broken by not using
> >> +	 * deferred_io when they really should - we match on the known
> >> +	 * bad ones manually for now.
> >> +	 */
> >> +	if (info->fbdefio
> >> +	    || !strcmp(info->fix.id, "astdrmfb")
> >> +	    || !strcmp(info->fix.id, "cirrusdrmfb")
> >> +	    || !strcmp(info->fix.id, "mgadrmfb")) {
> > 
> > We have a shared defio implementation now in drm_fb_helper.c, there's not
> > really many excuses to not fix up these drivers to just use those ...
> 
> I'll look into it.
> 
> 
> Thanks!
> Max
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
