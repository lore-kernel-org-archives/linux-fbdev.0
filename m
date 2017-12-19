From: Max Staudt <mstaudt@suse.de>
Date: Tue, 19 Dec 2017 15:41:52 +0000
Subject: Re: [RFC PATCH v2 03/13] bootsplash: Flush framebuffer after drawing
Message-Id: <8036b6a6-6ed5-2f34-e854-1c397a9f34d4@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171213194755.3409-4-mstaudt@suse.de>
 <20171213213506.GD26573@phenom.ffwll.local>
 <d66a994a-cb3a-c1fb-8f91-adbd475a40f0@suse.de>
 <20171219122313.GE26573@phenom.ffwll.local>
 <8bbb0497-4a10-2f81-0040-6e7cd4e7353c@suse.de>
 <20171219135715.GG26573@phenom.ffwll.local>
In-Reply-To: <20171219135715.GG26573@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, michal@markovi.net, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, bernhard.rosenkranzer@linaro.org, philm@manjaro.org

On 12/19/2017 02:57 PM, Daniel Vetter wrote:
> Where do drivers deal with struct file deep down?

As an example, I remembered this to be the case in nouveau's code for allocating a framebuffer. So I checked, and it's much better now.

So I was mistaken about this - sorry.

Thanks a lot for cleaning up this part of DRM, I'm looking forward to a nicer future! Hopefully we can get unify the FB emulation in a single place at some point, but that's just my dreams and is going off-topic, so I'll stop here.


> The problem is that defio is totally not how a real driver works.

But they do exist and I can't ignore them.

I'm afraid I don't understand - why are those, such as xenfb, not real drivers?


> So
> preferrably bootsplash would use kms directly, and use the explict dirtyfb
> callback.

Sure, if I'd be hooking into drmcon, that would be great.

But drmcon doesn't exist yet, so it doesn't get us further to talk about a bootsplash on KMS :(

I'm hooking into the in-kernel terminal emulator, because the bootsplash is a functional extension of that. It just happens that fbcon sits on top of FB, so I work with what I get.

And the console in turn happens to work on all FB and KMS drivers, so it makes users of all kinds of drivers happy. In fact, that's why the FB emulation in KMS drivers came to be in the first place, if I remember right - to ensure fbcon continues to work.

Thus, once drmcon exists and becomes dominant over fbcon, moving the bootsplash to it makes sense. On the other hand, hooking into a raw video subsystem doesn't make sense as far as I can see, so a bootsplash on top of raw KMS is just as meaningless as a bootsplash on top of raw FB. So I have no choice but to work on top of fbcon, and thus use the FB subsystem.


> But if you insist on using fbdev, then I think the beast course
> here is to wire up a new fb_ops->flush callback.

Okay, makes sense. Thanks!


> Note that you only need to type the 1 trivial implementation for the drm
> fbdev emulation, as long as the callback is optional. Trying to make defio
> work correctly, as fbdev assumes it should work, in all cases, on top of
> drm is imo an entirely pointless endeavour.

I'll look into it.


> Yes, so lets ignore defio and do the flushing correctly, at least for kms
> drivers.

I agree.

In fact, if I define fbops->flush(), defio drivers can still add their own proper flushing function, so everybody wins. I like that, see below.


>>>> What shall I do?
>>>>
>>>> Shall I add a new FB op for flushing when writing to the raw memory from the kernel?
>>>> As far as I can see, it would be needed for defio drivers only, is that correct?
>>>
>>> Yes, which are kinda horrible anyway. I guess you could at least not do
>>> all these hacks if it's not a defio driver.
>>
>> Again, I don't understand.
>>
>> In my patch (see below), I explicitly check for info->fbdefio, as well
>> as three known broken drmfb emulations. I don't do the copy hack on any
>> other device.
> 
> Yeah, and if we'd to the explicit flush, you wouldn't even need to check
> for that. So
> 
> if (fbops->flush)
> 	fbops->flush(); /* this covers all drm drivers */
> else if (fb->defio)
> 	copyarea hack, if you really still need to support some defio
> 	fbdev drivers, but really I think that's questionable

I need to support xenfb, thus I might as well support all defio drivers.

Also, I like that your suggestion allows for affected drivers to implement their own, more efficient fbops->flush() directly, while ensuring that those that don't still have a fallback, so there is some performance to be gained.

I'll look into implementing this.


> else
> 	; /* nothing */
> 
>> So, what shall I do? As it is, the hack is already specific to devices that really, really need it.
>>
>> Would you like me to extend the FB API or not?
> 
> Yes. Well for real I'd like you to do kms, so maybe you need to explain
> why exactly you absolutely have to use fbdev (aka which driver isn't
> supported by drm that you want to enable this on).

See Oliver's reply - we have plenty of fb-only systems deployed in the real world. Think Xen. Think AArch64 with efifb. Think any system before the KMS driver is loaded (which is a case that the splash is supposed to handle).

Also, where would I hook into KMS, were I to implement it on top of KMS right now? I'm not working on top of FB per se, but on top of fbcon. So in a KMS world I wouldn't work on KMS itself, but on top of... drmcon, which doesn't exist.



Max
