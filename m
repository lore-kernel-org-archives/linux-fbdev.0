From: Max Staudt <mstaudt@suse.de>
Date: Wed, 20 Dec 2017 14:55:28 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <5dc7f218-9113-fad3-c0a8-883c4bae4e02@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
 <CAKMK7uEEVEHbvHifobaTdgKkbS5HbyVAqGRkHUQNpWWSr7dasg@mail.gmail.com>
 <573d4050-7607-b8e4-7552-83966f551ba3@suse.de>
 <20171220094355.GJ26573@phenom.ffwll.local>
 <e9734508-9b2c-0c18-f6ef-6ca984a33b32@baylibre.com>
 <20171220101421.GM26573@phenom.ffwll.local>
In-Reply-To: <20171220101421.GM26573@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, michal@markovi.net, sndirsch@suse.com, Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Bero_Rosenkr=c3=a4nzer?= <bernhard.rosenkranzer@linaro.org>, philm@manjaro.org

On 12/20/2017 11:14 AM, Daniel Vetter wrote:
> btw since I'm probably sounding a bit too grumpy here: I'd very much
> support this. I think bootsplash in kernel has a bunch of uses, and it
> shouldn't be hard to get non-suse people to cheer for it (makes merging
> easier if it's not just a one-off hack).

Thank you!

As it seems, other people and distros are already interested - for example Manjaro.

It's also a chance to (maybe in the near future) integrate with a splash painted by EFI and/or GRUB, before userspace has even started.


> But I'm really not sold on the current integration path being anywhere
> near close to a good idea long-term.
Sure, that's a valid concern.

So there's two questions I understand from you here:

1. Do I really need to build on top of the console driver?
2. If not (1), then can I build on top of KMS instead?


Let's look at this...

1. The starting point was that the kernel's built-in terminal emulator, fbcon, is the "fallback" thing to display when no graphical application is running. It is hidden automatically as soon as a program switches to KD_GRAPHICS, and reappears as soon as that program switches back to KD_TEXT, or dies.
It seemed desirable to me to want the same behavior for a splash screen.

Furthermore, when fbcon runs, there is already a mode set. Whatever mode that may be, it's good enough for us.
It makes sense to re-use the same mode.
(This isn't really important for FB, but would be important when talking about drmcon).

Since fbcon and the splash will never be shown at the same time, it makes sense to re-use whatever framebuffer fbcon is writing into, and silence fbcon during this time (that's what my dummyops do).

When the splash is disabled, it needs to show the text that was hidden. So what I do is to call update_screen(vc_cons[fg_console].d) and also restore the original fbcon character rendering operations, thus allowing it to re-render the screen.


It thus seemed sensible to me to work inside of fbcon.


Let's stay at the FB level for the sake of taking things step by step. How would I solve this without hooking into fbcon?

To shut up fbcon, I could play with do_console_blank() and do_console_unblank(). These are called when changing between KD_GRAPHICS and KD_TEXT. I'd then have to introduce additional logic for the KD_TEXT state, which switches between showing fbcon and showing the splash. I haven't tried this, but fair enough.

To decide when to render, I'd have to have a hook that tells me when an FB mode changes, or the device disappears, or a new device appears. With fbcon, I can simply draw my splash in the fbcon_switch() function, not needing to care about whether this is a good time and whether I have a device underneath my feet. If fbcon can draw, then so can I.


2. Let's assume we follow the ideas from the final paragraphs of (1) above, and also move to KMS. How would I deal with setting modes, etc.? I wouldn't want to change modes, and I also can't always get a new framebuffer for background buffering - think devices that only have a single framebuffer, such as a fictional efidrm, or devices with little VRAM. So if these semantics get figured out for a future drmcon, then it makes sense to just double-purpose its framebuffer. After all, the console framebuffer is the one shown as a fallback, when no other process is using the graphics mode. Otherwise, I'd have to check which one to show: The splash, or the text?



So... it seemed helpful to me to build on top of the graphical console driver and double-purpose it, because it takes away the need to think about "what mode do I use", "which framebuffer to draw on", "when is it safe to draw", and so forth.

If you disagree with that, or even think that it's easier to do outside fbcon, I'd be grateful to hear ideas on how to implement it. Maybe it wasn't the best decision - but as the old saying goes, "it seemed like a very good idea at the time".


As for the FB/KMS discussion:
Since I decided to build on top of the only graphical console driver that we have, I have no choice: fbcon builds on fbdev, and thus the bootsplash is on fbdev, too. Complaining that it's not on KMS is a red herring - after all, it does work on KMS drivers, and people are happy with fbcon on KMS as well.


If integration and future paths are to be discussed, let's first talk about whether to move the splash inside/outside the console driver (fbcon).



Max
