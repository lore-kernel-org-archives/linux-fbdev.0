From: Max Staudt <mstaudt@suse.de>
Date: Tue, 19 Dec 2017 16:23:52 +0000
Subject: Re: [RFC PATCH v2 03/13] bootsplash: Flush framebuffer after drawing
Message-Id: <24fd8767-bdf2-0073-2161-a0cf3b61780d@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171213194755.3409-4-mstaudt@suse.de>
 <20171213213506.GD26573@phenom.ffwll.local>
 <d66a994a-cb3a-c1fb-8f91-adbd475a40f0@suse.de>
 <20171219122313.GE26573@phenom.ffwll.local>
 <8bbb0497-4a10-2f81-0040-6e7cd4e7353c@suse.de>
 <20171219135715.GG26573@phenom.ffwll.local>
 <8036b6a6-6ed5-2f34-e854-1c397a9f34d4@suse.de>
 <CAKMK7uHgPheSuGc6v3aSxzaJ_BNMGRs3zZ=Mv7M_us37QS8-sg@mail.gmail.com>
In-Reply-To: <CAKMK7uHgPheSuGc6v3aSxzaJ_BNMGRs3zZ=Mv7M_us37QS8-sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, michal@markovi.net, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, sndirsch@suse.com, Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, philm@manjaro.org, =?UTF-8?Q?Bero_Rosenkr=c3=a4nzer?= <bernhard.rosenkranzer@linaro.org>

On 12/19/2017 05:02 PM, Daniel Vetter wrote:
> On Tue, Dec 19, 2017 at 4:41 PM, Max Staudt <mstaudt@suse.de> wrote:
>> On 12/19/2017 02:57 PM, Daniel Vetter wrote:
>>> The problem is that defio is totally not how a real driver works.
>>
>> But they do exist and I can't ignore them.
>>
>> I'm afraid I don't understand - why are those, such as xenfb, not real drivers?
> 
> I mean kms drivers. The problem is that the magic mapping that fbdev
> expects is real pain. Everyone else, including kms, expects an
> explicit flush operation. So instead of hacking around even more with
> the defio corner cases that don't work, I'm suggesting we just add
> that flush operation. At least internally.
> 
> Fixing kms drivers to implement a better defio is probably not a
> reasonable investement of time.

Ah yes, I understand now, you mean that KMS drivers have explicit flush, and defio is a hack to retrofit such drivers to an API that never supported a flush operation (the fbdev API), but always used to expose the video memory directly. Right?

If yes, then I agree. Fixing the defio in the KMS drivers wouldn't even solve my problem - I'd still need to implement flush. So might as well care about the flush straight away, yep!


>>> So
>>> preferrably bootsplash would use kms directly, and use the explict dirtyfb
>>> callback.
>>
>> Sure, if I'd be hooking into drmcon, that would be great.
>>
>> But drmcon doesn't exist yet, so it doesn't get us further to talk about a bootsplash on KMS :(
>>
>> I'm hooking into the in-kernel terminal emulator, because the bootsplash is a functional extension of that. It just happens that fbcon sits on top of FB, so I work with what I get.
> 
> Why do you need a console for a boot splash? You're not drawing
> console output afaiui ... And even your current fbdev-based
> implementation only interfaces with fbcon insofar as you're making
> sure fbcon doesn't wreak your boot splash. Or I'm missing something
> somewhere.

Errr... true. I'll answer it below, where you ask again.


>> In fact, if I define fbops->flush(), defio drivers can still add their own proper flushing function, so everybody wins. I like that, see below.
> 
> tbh I'd forget about ever touching any of the existing fbdev drivers.
> Imo just not worth the time investement.

Fair point. It's optional anyway, and can still be done (quickly and painlessly) on demand.

Since my goal here is making a nice bootsplash, I'll touch as few drivers as I can.


>>>> So, what shall I do? As it is, the hack is already specific to devices that really, really need it.
>>>>
>>>> Would you like me to extend the FB API or not?
>>>
>>> Yes. Well for real I'd like you to do kms, so maybe you need to explain
>>> why exactly you absolutely have to use fbdev (aka which driver isn't
>>> supported by drm that you want to enable this on).
>>
>> See Oliver's reply - we have plenty of fb-only systems deployed in the real world. Think Xen. Think AArch64 with efifb. Think any system before the KMS driver is loaded (which is a case that the splash is supposed to handle).
> 
> And you need a real pretty boot-splash on those? That sounds all like
> servers, and I haven't yet seen a request for real pretty&fast boot
> splash for servers.

Yeah, every little helps.

And the vesafb/efifb case is valid for all of the desktop/laptop machines as well.


>> Also, where would I hook into KMS, were I to implement it on top of KMS right now? I'm not working on top of FB per se, but on top of fbcon. So in a KMS world I wouldn't work on KMS itself, but on top of... drmcon, which doesn't exist.
> 
> Hm, I guess I need to double check again, but I don't get why you need
> to sit on top of a console for the boot splash. I mean I understand
> that you need to shut up the console when the boot splash is on, but
> from a quick look you're not using fbcon to render anything or
> otherwise tie into it. Where's the connection?
Fair point.

So the case you're looking at is someone who wants to have a bootsplash, yet doesn't want to have fbcon. Correct?

I agree, this is a case that is not covered with the current code. However such a generic solution would require the definition of new semantics of both fbcon and the bootsplash fighting for the same FB device - well, as long as no graphical application uses it. Urgh... It is a lot simpler to just dual-purpose fbcon, since it knows when to shut up on its own.

And I simply assume that those who load a bootsplash file into their initramfs won't be short a few bytes to compile in fbcon as well.

So... I've hooked into fbcon for simplicity's sake, so I don't have up to three parties fighting for the same device, and so I don't have to define semantics and interfaces to solve that conflict.



Max
