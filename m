From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Fri, 29 Dec 2017 17:13:39 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <878tdlzccc.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
In-Reply-To: <20171219161630.GI26573@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>, Max Staudt <mstaudt@suse.de>
Cc: linux-fbdev@vger.kernel.org, michal@markovi.net, b.zolnierkie@samsung.com, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, bernhard.rosenkranzer@linaro.org, philm@manjaro.org

On Tue, 19 Dec 2017, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, Dec 13, 2017 at 08:47:42PM +0100, Max Staudt wrote:
>> Dear fbdev and fbcon developers,
>> 
>> Thank you very much for your input for the first patch series.
>> 
>> I've included your feedback into this second roll, and kindly ask for
>> your opinion on the new patch series.
>
> Ok I've realized that my assumptions about why you need this aren't
> holding up.
>
> So from reading these patches it sounded like you want an in-kernel boot
> splash because that would be on the display faster than a userspace one
> like plymouth. That's the only reasons I can see for this (if there's
> another good justification, please bring it up).
>
> I only know of very embedded setups (tv top boxes, in vehicle
> entertainment) where that kind of "time to first image" really matters,
> and those systems:
> - have a real hw kms driver
> - don't have fbcon or fbdev emulation enabled (except for some closed
>   source stacks that are a bit slow to adapt to the new world, and we
>   don't care about those in gfx).
>
> But from discussions it sounds like you very much want to use this on
> servers, which makes 0 sense to me. On a server something like plymouth
> should do a perfectly reasonable job.
>
> So, why exactly do we need this?

Okay, I'll take another step back from the implementation and most of
the discussion here, and look at what *I* would like to see on screen
when I have my user hat on and my kernel developer hat securely stowed
away.

I think the first issue is the boot manager (e.g. grub) messing up
whatever the BIOS or GOP or whatever drew. If I don't touch any buttons,
I'd prefer the Lenovo or VAIO or NUC or whatever logo stay there. IIRC
some BIOSes let you set up your own splash if you like, though that's
not really relevant for me. So already the boot manager takeover is a
problem.

The next issue is the framebuffer driver takeover. It's not unlike the
above, just one step further. If you like your grub image to stay there,
let it stay there. (Or, if the boot manager was nice enough to not mess
up the screen, let the BIOS image stay there.) All the way to KMS and
userspace.

IMHO the user friendly experience is already gone by the time we reach
any kernel/userspace bootsplash. We want our command-line tools to STFU
if they don't have anything interesting to say. As a user, 99.99+% of
the time I don't care what grub or dmesg have to say.

Of course, with the kernel developer hat on, I want all of the clues
every time in case something goes wrong. But this shouldn't have to be
mutually exclusive.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center
