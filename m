From: Max Staudt <mstaudt@suse.de>
Date: Wed, 20 Dec 2017 16:23:26 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <ca8f60f7-7372-c3ba-88d5-ba6958d8b45a@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
 <CAKMK7uEEVEHbvHifobaTdgKkbS5HbyVAqGRkHUQNpWWSr7dasg@mail.gmail.com>
 <573d4050-7607-b8e4-7552-83966f551ba3@suse.de>
 <20171220094355.GJ26573@phenom.ffwll.local>
 <e9734508-9b2c-0c18-f6ef-6ca984a33b32@baylibre.com>
 <20171220101421.GM26573@phenom.ffwll.local>
 <5dc7f218-9113-fad3-c0a8-883c4bae4e02@suse.de>
 <CAKMK7uE+4LrX0U6JWgQuFD3RLVOoNOi8oTAs8N3QjwqULv-fCQ@mail.gmail.com>
 <CAKMK7uHr9PSS81-u-ev0Q31vowhGQLb3rqgYykV1gOVb3mh1xQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHr9PSS81-u-ev0Q31vowhGQLb3rqgYykV1gOVb3mh1xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, michal@markovi.net, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, sndirsch@suse.com, Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Neil Armstrong <narmstrong@baylibre.com>, philm@manjaro.org, =?UTF-8?Q?Bero_Rosenkr=c3=a4nzer?= <bernhard.rosenkranzer@linaro.org>

On 12/20/2017 04:19 PM, Daniel Vetter wrote:
> On Wed, Dec 20, 2017 at 4:11 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Wed, Dec 20, 2017 at 3:55 PM, Max Staudt <mstaudt@suse.de> wrote:
>>> On 12/20/2017 11:14 AM, Daniel Vetter wrote:
>>>> btw since I'm probably sounding a bit too grumpy here: I'd very much
>>>> support this. I think bootsplash in kernel has a bunch of uses, and it
>>>> shouldn't be hard to get non-suse people to cheer for it (makes merging
>>>> easier if it's not just a one-off hack).
>>>
>>> Thank you!
>>>
>>> As it seems, other people and distros are already interested - for example Manjaro.
>>>
>>> It's also a chance to (maybe in the near future) integrate with a splash painted by EFI and/or GRUB, before userspace has even started.
>>
>> Maybe I've sounded too optimistic now.
>>
>> So fundamentally I don't think an in-kernel bootsplash is a bad idea.
>> But most likely you want this on a highly embedded system, which
>> probably is compiled for your exact hw, with pretty much everything
>> built in. Also, no fbcon, maybe even no vt subsystem at all.
>> Definitely not your general purpose distro.
>>
>> Your proposal to work on top of fbcon doesn't fix that niche.
>>
>> Now for your problem, which seems to be to have a working bootsplash
>> for a general purpose distro, specifically for the bug where plymouth
>> prevents the real drm driver from loading: Adding an in-kernel
>> bootsplash doesn't make any sense, at least not to me. Instead I think
>> the right action is to fix the problem, both in the kernel and in
>> userspace.
>>
>> All the problems below have fairly simple solutions, but there's imo
>> no point in talking technical solutions for specific problems when
>> we're trying to fix the wrong problem.
> 
> Aside: The problem you think you need the vt/console subsystem for is
> simple to fix with plain kms: kms works without fbdev, fbcon and the
> entire vt subsystem. Dislay ownership is controlled through the drm
> master concept. That's the exact same trick that we're using already
> to figure out whether fbdev (not just fbcon) is allowed to touch the
> display hw.

So when there is no DRM master, then the FB emulation becomes active.

Sure. But I still have to multiplex between the console and the splash.
It seemed cleanest to do this inside the console. If there's a good way outside, that's just as good for me, and I'm happy to implement it.
But please help me and point me at how to do it best. Ideally, in both FB and KMS contexts. Without using additional video RAM wherever possible.


> So yeah, there's a solution, and a modern system definitely would not
> want to get encumbered with the entire vt subsystem to be able to use
> a bootsplash. David Herrman had the entire pile prototyped btw,
> including userspace console on top of drm, emergency log on top of
> drm, and replacement for simpledrm. Adding an in-kernel boot splash
> would be fairly simple for this setup. It's just that no one else
> cared enough to get it merged.

So... the solution for being unable to implement a good splash in userspace is... to move the console into the userspace?

A ton of people will beg to differ. And I'm afraid I have to disagree as well.


To be clear, I dislike the nature of the VT subsystem as well. It's a hack. But it's such an incredibly useful hack that I'm willing to turn a blind eye to its ugliness. There's a good reason why we have a terminal emulator in the kernel itself, and I'd rather keep it around for a while longer.



Max
