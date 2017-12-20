From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 20 Dec 2017 10:14:21 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <20171220101421.GM26573@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
 <CAKMK7uEEVEHbvHifobaTdgKkbS5HbyVAqGRkHUQNpWWSr7dasg@mail.gmail.com>
 <573d4050-7607-b8e4-7552-83966f551ba3@suse.de>
 <20171220094355.GJ26573@phenom.ffwll.local>
 <e9734508-9b2c-0c18-f6ef-6ca984a33b32@baylibre.com>
In-Reply-To: <e9734508-9b2c-0c18-f6ef-6ca984a33b32@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, michal@markovi.net, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, sndirsch@suse.com, Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Max Staudt <mstaudt@suse.de>, philm@manjaro.org, Bero =?iso-8859-1?Q?Rosenkr=E4nzer?= <bernhard.rosenkranzer@linaro.org>

On Wed, Dec 20, 2017 at 11:06:34AM +0100, Neil Armstrong wrote:
> On 20/12/2017 10:43, Daniel Vetter wrote:
> > On Tue, Dec 19, 2017 at 07:40:12PM +0100, Max Staudt wrote:
> >> On 12/19/2017 06:26 PM, Daniel Vetter wrote:
> >>> On Tue, Dec 19, 2017 at 6:04 PM, Max Staudt <mstaudt@suse.de> wrote:
> >>>> Well, those could enable fbcon if they want the bootsplash. Shouldn't make a difference anyway if they're powerful enough to run Linux. As long as the bootsplash is shown, no fbcon drawing operations are executed, so there is no expensive scrolling or such to hog the system.
> >>>
> >>> It's too big, and those folks tend to be super picky about space.
> >>
> >> I know, they really are.
> >>
> >> However, given just how big and clunky modern systems have become, I
> >> raise my doubts about a few extra KB for fbcon code to be relevant.
> >>
> >> My feeling is that the kernel splash probably saves even more space on
> >> the userspace side than it adds on the kernel side, thus netting a
> >> reduction in overall code size.
> >>
> >>
> >>> So essentially you're telling me that on a current general purpose
> >>> distro the gfx driver loading is a dumpster fire, and we're fixing
> >>> this by ignoring it an adding a hole new layer on top. That doesn't
> >>> sound like any kind of good idea to me.
> >>
> >> Yes. It is a vast improvement over the status quo, and people are asking
> >> for it. And the bootsplash layer can be moved elsewhere, just change the
> >> hooks and keep the loading/rendering.
> >>
> >> Also, gfx driver loading isn't a dumpster fire, it mostly just works. It
> >> just mustn't be done 100% carelessly.
> > 
> > You've talked about using sleep and stuff to paper over races. That
> > doesn't sound good at all.
> > 
> >>> So if just using drm for everything isn't possible (since drm drivers
> >>> can at least in theory be hotunplugged), can we at least fix the
> >>> existing fbdev kernel bugs? Not being able to unplug a drm driver when
> >>> it's still open sounds like a rather serious issues that probably
> >>> should be fixed anyway ... so we're better able to hotunplug an fbdev
> >>> driver when it's in use.
> >>
> >> I don't see it as a bug. The fbdev driver gets unloaded as much as
> >> possible, but as long as a userspace application keeps the address_space
> >> mmap()ed, there's nothing we can do, short of forcibly removing it and
> >> segfaulting the process the next time it tries to render something. Am I
> >> missing something?
> > 
> > I guess you could remap that too ... But yeah SIGBUS ftw. Wrap rendering
> > in a sighandler and abort if you hit that. In drm we try to be a bit
> > better and keep things around until userspace has gone.
> > 
> >>> Also I'm not clear at all on the "papering over races with sleeps"
> >>> part. DRM drivers shouldn't be racy when getting loaded ...
> >>
> >> The DRM driver loading isn't racy, but the fbdev can't be fully unloaded
> >> while Plymouth has the address_space mmap()ed. If Plymouth sleeps until
> >> drivers that are included in initramfs are (hopefully) loaded, then it
> >> will forego using its FB backend.
> >>
> >> A solution we've experimented with is dropping the FB backend from
> >> Plymouth. It instantly fixed the busy video RAM bug. However it made the
> >> folks relying on efifb very, very unhappy.
> >>
> >>
> >>> Or we get simpledrm merged (for efifb and vesafb support) and someone
> >>> types the xendrm driver (there is floating around, it's just old) and
> >>> we could forget about any real fbdev drivers except the drm based
> >>> ones.
> >>
> >> And drmcon, unless we come up with a better idea than hooking into the *con driver.
> > 
> > If we have everything as drm drivers, you can just use plymouth (with no
> > fbdev backend ofc) and everyone is happy. Including the efifb folks (it's
> > simply going to be called efidrmfb or something like that). So no idea why
> > you need a *con.
> > 
> >> Sure, that'd help a lot. But what do we do until then?
> > 
> > Make it happen? Twiddling thumbs is an option too ofc, but it tends to not
> > result in results :-)
> > 
> > Cheers, Daniel
> > 
> 
> My 2cents about this patchset:
> You did a good job about all the animation and splash logic, but for me all this fbcon
> stuff is a huge hack, please use a standard and modern display subsystem en leave fbcon
> die alone....
> 
> My DRM ARM systems would love to have such bootsplash, so please, make it happen using DRM
> then leave the fbcon based stuff like efifb migrate to DRM in a second time !

btw since I'm probably sounding a bit too grumpy here: I'd very much
support this. I think bootsplash in kernel has a bunch of uses, and it
shouldn't be hard to get non-suse people to cheer for it (makes merging
easier if it's not just a one-off hack).

But I'm really not sold on the current integration path being anywhere
near close to a good idea long-term.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
