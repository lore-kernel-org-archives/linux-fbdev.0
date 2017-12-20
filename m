From: Max Staudt <mstaudt@suse.de>
Date: Wed, 20 Dec 2017 14:10:54 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <3549c7c9-6d26-047a-ed4e-a2c81c44c079@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171219161630.GI26573@phenom.ffwll.local>
 <2f8a1a08-911d-a511-2968-4d89418ac212@suse.de>
 <CAKMK7uEEVEHbvHifobaTdgKkbS5HbyVAqGRkHUQNpWWSr7dasg@mail.gmail.com>
 <573d4050-7607-b8e4-7552-83966f551ba3@suse.de>
 <20171220094355.GJ26573@phenom.ffwll.local>
In-Reply-To: <20171220094355.GJ26573@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, michal@markovi.net, sndirsch@suse.com, Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Bero_Rosenkr=c3=a4nzer?= <bernhard.rosenkranzer@linaro.org>, philm@manjaro.org

On 12/20/2017 10:43 AM, Daniel Vetter wrote:
> On Tue, Dec 19, 2017 at 07:40:12PM +0100, Max Staudt wrote:
>> On 12/19/2017 06:26 PM, Daniel Vetter wrote:
>>> So essentially you're telling me that on a current general purpose
>>> distro the gfx driver loading is a dumpster fire, and we're fixing
>>> this by ignoring it an adding a hole new layer on top. That doesn't
>>> sound like any kind of good idea to me.
>>
>> Yes. It is a vast improvement over the status quo, and people are asking
>> for it. And the bootsplash layer can be moved elsewhere, just change the
>> hooks and keep the loading/rendering.
>>
>> Also, gfx driver loading isn't a dumpster fire, it mostly just works. It
>> just mustn't be done 100% carelessly.
> 
> You've talked about using sleep and stuff to paper over races. That
> doesn't sound good at all.

Sorry, I was unclear.

It's Plymouth's ShowDelay that, unintentionally, papers over this bug.

The driver loading bug will happen with any user based splash - it's not limited to Plymouth.

On the other hand, if you don't start a graphical application before having loaded the final graphics driver, everything is good and there is no race.

So, module loading works as intended ;)


>>> So if just using drm for everything isn't possible (since drm drivers
>>> can at least in theory be hotunplugged), can we at least fix the
>>> existing fbdev kernel bugs? Not being able to unplug a drm driver when
>>> it's still open sounds like a rather serious issues that probably
>>> should be fixed anyway ... so we're better able to hotunplug an fbdev
>>> driver when it's in use.
>>
>> I don't see it as a bug. The fbdev driver gets unloaded as much as
>> possible, but as long as a userspace application keeps the address_space
>> mmap()ed, there's nothing we can do, short of forcibly removing it and
>> segfaulting the process the next time it tries to render something. Am I
>> missing something?
> 
> I guess you could remap that too ... But yeah SIGBUS ftw. Wrap rendering
> in a sighandler and abort if you hit that. In drm we try to be a bit
> better and keep things around until userspace has gone.

Hmm. Are you sure it's okay to SIG these processes just because someone else has decided to unload a driver? That is counter to everything else that I've seen so far.

Also, is it even feasible, implementation wise?


>>> Or we get simpledrm merged (for efifb and vesafb support) and someone
>>> types the xendrm driver (there is floating around, it's just old) and
>>> we could forget about any real fbdev drivers except the drm based
>>> ones.
>>
>> And drmcon, unless we come up with a better idea than hooking into the *con driver.
> 
> If we have everything as drm drivers, you can just use plymouth (with no
> fbdev backend ofc) and everyone is happy. Including the efifb folks (it's
> simply going to be called efidrmfb or something like that). So no idea why
> you need a *con.

Hmm, that still makes us wait until userspace has appeared...

And the reason I built it into *con is because the logic for appearing/disappearing is basically the same, and in this chain it makes sense for the bootsplash show/hide logic to be chained behind *con.


>> Sure, that'd help a lot. But what do we do until then?
> 
> Make it happen? Twiddling thumbs is an option too ofc, but it tends to not
> result in results :-)

I'm afraid I don't have the time to write an in-kernel terminal emulator, thus the wish to build upon the existing one...
