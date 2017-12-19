From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 19 Dec 2017 17:26:38 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <CAKMK7uEEVEHbvHifobaTdgKkbS5HbyVAqGRkHUQNpWWSr7dasg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
In-Reply-To: <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Staudt <mstaudt@suse.de>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, michal@markovi.net, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, sndirsch@suse.com, Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, philm@manjaro.org, =?UTF-8?Q?Bero_Rosenkr=C3=A4nzer?= <bernhard.rosenkranzer@linaro.org>

On Tue, Dec 19, 2017 at 6:04 PM, Max Staudt <mstaudt@suse.de> wrote:
> On 12/19/2017 05:16 PM, Daniel Vetter wrote:
>> On Wed, Dec 13, 2017 at 08:47:42PM +0100, Max Staudt wrote:
>>> Dear fbdev and fbcon developers,
>>>
>>> Thank you very much for your input for the first patch series.
>>>
>>> I've included your feedback into this second roll, and kindly ask for
>>> your opinion on the new patch series.
>>
>> Ok I've realized that my assumptions about why you need this aren't
>> holding up.
>>
>> So from reading these patches it sounded like you want an in-kernel boot
>> splash because that would be on the display faster than a userspace one
>> like plymouth. That's the only reasons I can see for this (if there's
>> another good justification, please bring it up).
>
> Yep, that's one of the reasons.
>
> You can find a lot more in the commit message for my first patch.
>
>
> For example, having a userspace splash that starts as early as it can (thus on vesafb/efifb on a PC) will cause the KMS driver to fail reserving the entirety of video RAM, and thus fail loading. This cannot be fixed.
>
> Reproducer:  https://bugzilla.opensuse.org/show_bug.cgi?id=980750

Aka fbdev is broken and can't actually be hotunplugged.

> Furthermore, Plymouth is quite broken. For example, it may lock (via VT_SETMODE) the VT even though Plymouth is in "disabled" state and X has already taken control of the VT. This causes the kernel to throw away X's PID as the VT owner, and thus chvt and Ctrl-Alt-Fx no longer work because X can neither release the console (VT_RELDISP fails), nor does the kernel send it the signal to do so. This is hard to impossible to fix.

Aka plymouth is broken.

> A third reason is that in practice, Plymouth's start is delayed for reasons such as the above. Yes, race conditions are being worked around with sleeps. It'd be nice to have a splash as early as possible, without having to worry about races.

Aka more breakage.

> So some issues are hard to fix, others are impossible to fix in userspace. I figured that rather than hacking back and forth and defining APIs in both the kernel and userspace (redoing a sizable part of Plymouth, or writing a replacement), I might as well put small and simple code in the kernel straight away.
>
> And if it's hooked into fbcon, we get stuff for free:
>  - It shows *really* early, even before userland is available.
>  - There are no fights, no races for the device. Of any kind.
>  - The code is small and simple.
>
>
> Further reasoning so far, from the comments to my v1 patch series:
>
>   https://lkml.org/lkml/2017/11/10/374
>   https://lkml.org/lkml/2017/11/9/324
>
>
>> I only know of very embedded setups (tv top boxes, in vehicle
>> entertainment) where that kind of "time to first image" really matters,
>> and those systems:
>> - have a real hw kms driver
>> - don't have fbcon or fbdev emulation enabled (except for some closed
>>   source stacks that are a bit slow to adapt to the new world, and we
>>   don't care about those in gfx).
>
> Well, those could enable fbcon if they want the bootsplash. Shouldn't make a difference anyway if they're powerful enough to run Linux. As long as the bootsplash is shown, no fbcon drawing operations are executed, so there is no expensive scrolling or such to hog the system.

It's too big, and those folks tend to be super picky about space.

>> But from discussions it sounds like you very much want to use this on
>> servers, which makes 0 sense to me. On a server something like plymouth
>> should do a perfectly reasonable job.
>
> As I said in the other thread, every little helps.
>
> For example, even on a server, a nice bootsplash makes a Linux system more attractive to novice users.
>
> On desktops, it's basically mandatory, as users seem to be scared of text scrolling by.
>
>
>> So, why exactly do we need this?
>
> For the aforementioned reasons, and to have a nice, unified bootsplash code on *all* devices.
>
>
>> (let's stop the other thread meanwhile, there's no point discussing
>> implementation details if the why? question isn't answered yet)
>
> Sure, I hope this helps.

So essentially you're telling me that on a current general purpose
distro the gfx driver loading is a dumpster fire, and we're fixing
this by ignoring it an adding a hole new layer on top. That doesn't
sound like any kind of good idea to me.

So if just using drm for everything isn't possible (since drm drivers
can at least in theory be hotunplugged), can we at least fix the
existing fbdev kernel bugs? Not being able to unplug a drm driver when
it's still open sounds like a rather serious issues that probably
should be fixed anyway ... so we're better able to hotunplug an fbdev
driver when it's in use.

Also I'm not clear at all on the "papering over races with sleeps"
part. DRM drivers shouldn't be racy when getting loaded ...

Or we get simpledrm merged (for efifb and vesafb support) and someone
types the xendrm driver (there is floating around, it's just old) and
we could forget about any real fbdev drivers except the drm based
ones.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
