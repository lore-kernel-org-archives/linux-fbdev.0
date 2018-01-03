From: Max Staudt <mstaudt@suse.de>
Date: Wed, 03 Jan 2018 17:38:47 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <af4600fc-ad5d-411c-d899-9fe557a79add@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local> <878tdlzccc.fsf@intel.com>
In-Reply-To: <878tdlzccc.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, michal@markovi.net, b.zolnierkie@samsung.com, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, philm@manjaro.org, bernhard.rosenkranzer@linaro.org

On 12/29/2017 06:13 PM, Jani Nikula wrote:
> I think the first issue is the boot manager (e.g. grub) messing up
> whatever the BIOS or GOP or whatever drew. If I don't touch any buttons,
> I'd prefer the Lenovo or VAIO or NUC or whatever logo stay there. IIRC
> some BIOSes let you set up your own splash if you like, though that's
> not really relevant for me. So already the boot manager takeover is a
> problem.
> 
> The next issue is the framebuffer driver takeover. It's not unlike the
> above, just one step further. If you like your grub image to stay there,
> let it stay there. (Or, if the boot manager was nice enough to not mess
> up the screen, let the BIOS image stay there.) All the way to KMS and
> userspace.
> 
> IMHO the user friendly experience is already gone by the time we reach
> any kernel/userspace bootsplash. We want our command-line tools to STFU
> if they don't have anything interesting to say. As a user, 99.99+% of
> the time I don't care what grub or dmesg have to say.

Agreed - the kernel should go out of the user's way if they want it to be silent. It's already possible, as long as KMS is not in use (since that automatically sets a mode and thus usually clears the screen).

What you want is really the opposite of the kernel splash, or any splash on top of Linux (kernel or userspace) at all.

Returning to cases where a splash running on Linux may be desired:
I see adding to the initial logo as an interesting use case. An animation to show that the kernel hasn't crashed while booting is quite useful. Something like adding a spinning wheel underneath the initial logo helps. Macs do (or used to do) that after showing the apple, IIRC. I think this is where something simple and kernel based is helpful, vs. something userspace based. Maybe they can even build on top of each other, just like LILO used to print each letter as a confirmation of successfully executing a part of itself.


Thinking of it: Loading a KMS driver basically always necessitates a mode change on variable resolution platforms such as PCs. And changing mode requires clearing the screen. Now, what if we could preload the new framebuffer with a splash, rather than a blank screen?

That's not generally feasible (for example, double buffering is an implicit requirement), but who knows, maybe in the future. Just an odd idea.


> Of course, with the kernel developer hat on, I want all of the clues
> every time in case something goes wrong. But this shouldn't have to be
> mutually exclusive.

I agree - that's why it's important to be able to disable the bootsplash by changing the kernel cmdline.


Max
