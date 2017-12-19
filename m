From: Max Staudt <mstaudt@suse.de>
Date: Tue, 19 Dec 2017 13:34:22 +0000
Subject: Re: [RFC PATCH v2 03/13] bootsplash: Flush framebuffer after drawing
Message-Id: <8bbb0497-4a10-2f81-0040-6e7cd4e7353c@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171213194755.3409-4-mstaudt@suse.de>
 <20171213213506.GD26573@phenom.ffwll.local>
 <d66a994a-cb3a-c1fb-8f91-adbd475a40f0@suse.de>
 <20171219122313.GE26573@phenom.ffwll.local>
In-Reply-To: <20171219122313.GE26573@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, michal@markovi.net, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, bernhard.rosenkranzer@linaro.org, philm@manjaro.org

On 12/19/2017 01:23 PM, Daniel Vetter wrote:
> On Thu, Dec 14, 2017 at 04:36:49PM +0100, Max Staudt wrote:
>> 2) We need to go out of the way when a graphical application starts, and
>> come back when it's done. fbcon already has the logic for this, and
>> fbcon is also the thing we're trying to hide. So it seems natural to add
>> the splash on top of fbcon - at least for now.
> 
> And this "automatically disappear" semantics is horribly ill-defined
> between fbdev and native kms. So you're not really solving a problem,
> you're just not noticing the hacks because they're one layer removed (in
> the fbdev emulation code).
That's a general complaint about fbcon and/or the fbdev emulation in KMS drivers, right?

I can't see how it relates to my bootsplash, as I'm just replacing fbcon's output, wherever fbcon desires to draw at the given moment, and in no other case.

So when a graphical application sets the VT mode to KD_GRAPHICS, we get a call to do_blank_screen(), and then fbcon -and thus the bootsplash- is muted. The ioctl API has always been like this, and it's not specific to the patch in question.

Similarly, when a graphical application allocates a framebuffer via the KMS ioctl()s, and selects it for scanout, the driver will display that instead of the framebuffer it has allocated internally for the fbdev emulation.


>> 3) I can't use DRM from the kernel, for the same reason for which there
>> is no "drmcon" to supplant fbcon: There is no interface to reserve
>> framebuffer memory from kernel space: To get memory for a framebuffer,
>> one needs to have a struct file that is passed through the DRM stack
>> down into the drivers.
> 
> On recent kernels you only need a struct drm_file, not a struct file. That
> can be NULL. We've done this to make drmcon possible/easier.

Oh that's cool, I missed that. Thanks!

Maybe a fb2drm compat layer will become reality, after all.

The bootsplash code is fairly straightforward to port to a future drmcon, and I'm happy to make the changes once drmcon is available.
But for now, we only have fbcon. And a *lot* of FB drivers. And we want them to show a bootsplash instead of text. So that's where the bootsplash needs to hook into.


>> If this interface existed, then there could be a generic "fb2drm"
>> translation layer, and we would no longer need FB compatibility code in
>> each KMS driver. Actually, I tried to implement this translation layer a
>> year ago, and hit too many walls.
> 
> We're pretty much there already I think. The reason it's not entirely gone
> is that there's some nasty interactions between drm and the fbdev
> emulation, and just having a pile of drivers that aren't too trivial to
> convert.

Sounds like the state of the art last year - drm_file in most cases, but struct file deep in the drivers :(


>> 4) I don't fully understand what you'd like me to do. Last time I tried
>> to add a new entry to the fbops struct (namely fb_open_adj_file()), you
>> told me not to touch the framebuffer subsystem anymore, as it is meant
>> to die and driver developers shall use KMS instead. Have I
>> misunderstood?
> 
> I still don't like anyone adding features to fbdev :-)

So I must not touch fbops, correct?


>> Something like fb->flush() to finish kernel space accesses would be nice
>> to have, but would need to be implemented for all affected drivers
>> separately. The copy op hack is ugly, but solves the problem
>> generically.
> 
> Well, with defio being the hack it is (and because of that, a bunch of drm
> drivers not really supporting it) I'm not sure things actually work better
> without all this.

I don't understand what you mean.

What I do know is that fb_defio is here, and it's here to stay because some drivers need it.

What I also know is that I need to flush the screen after drawing my bootsplash.


>> What shall I do?
>>
>> Shall I add a new FB op for flushing when writing to the raw memory from the kernel?
>> As far as I can see, it would be needed for defio drivers only, is that correct?
> 
> Yes, which are kinda horrible anyway. I guess you could at least not do
> all these hacks if it's not a defio driver.

Again, I don't understand.

In my patch (see below), I explicitly check for info->fbdefio, as well as three known broken drmfb emulations. I don't do the copy hack on any other device.


So, what shall I do? As it is, the hack is already specific to devices that really, really need it.

Would you like me to extend the FB API or not?



Max


> -Daniel
> 
>>
>>
>>>> +	 *
>>>> +	 * A few DRM drivers' FB implementations are broken by not using
>>>> +	 * deferred_io when they really should - we match on the known
>>>> +	 * bad ones manually for now.
>>>> +	 */
>>>> +	if (info->fbdefio
>>>> +	    || !strcmp(info->fix.id, "astdrmfb")
>>>> +	    || !strcmp(info->fix.id, "cirrusdrmfb")
>>>> +	    || !strcmp(info->fix.id, "mgadrmfb")) {
