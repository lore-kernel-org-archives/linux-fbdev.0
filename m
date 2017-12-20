From: Max Staudt <mstaudt@suse.de>
Date: Wed, 20 Dec 2017 16:15:45 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <bb02d299-0ff7-0fc6-0828-9724889f9d44@suse.de>
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
In-Reply-To: <CAKMK7uE+4LrX0U6JWgQuFD3RLVOoNOi8oTAs8N3QjwqULv-fCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, michal@markovi.net, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, sndirsch@suse.com, Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Neil Armstrong <narmstrong@baylibre.com>, philm@manjaro.org, =?UTF-8?Q?Bero_Rosenkr=c3=a4nzer?= <bernhard.rosenkranzer@linaro.org>

On 12/20/2017 04:11 PM, Daniel Vetter wrote:
> So fundamentally I don't think an in-kernel bootsplash is a bad idea.
> But most likely you want this on a highly embedded system, which
> probably is compiled for your exact hw, with pretty much everything
> built in. Also, no fbcon, maybe even no vt subsystem at all.
> Definitely not your general purpose distro.

If an embedded distro can use it, then so can a general purpose distro that doesn't want to use Plymouth.

It's useful in many cases.


> Your proposal to work on top of fbcon doesn't fix that niche.

It does fix it very well - it's just that it also requires fbcon.
And I'm glad to fix this if you have a good idea for a cleaner alternative.


> Now for your problem, which seems to be to have a working bootsplash
> for a general purpose distro, specifically for the bug where plymouth
> prevents the real drm driver from loading: Adding an in-kernel
> bootsplash doesn't make any sense, at least not to me. Instead I think
> the right action is to fix the problem, both in the kernel and in
> userspace.

So we SIGBUS any process using the framebuffer just because we're loading an alternative driver, which uses a hack to kick out the old driver?

It's loading the new driver that should fail because the hardware resource is busy serving the old driver!
Not existing applications being killed. This is horribly broken semantics.

Just like unloading a driver that's still in use MUST fail. Not kill the processes using it!

And if it fails to load with -EBUSY, as it should, then the bug still stands.


> All the problems below have fairly simple solutions, but there's imo
> no point in talking technical solutions for specific problems when
> we're trying to fix the wrong problem.

The problem is that a splash in userspace brings horrible hacks and workarounds into the room. We're already discussing killing processes!

No, just no. Processes aren't ours to kill willy-nilly.



Max
