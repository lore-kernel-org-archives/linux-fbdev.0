From: Max Staudt <mstaudt@suse.de>
Date: Wed, 20 Dec 2017 16:52:20 +0000
Subject: Re: [RFC PATCH v2 03/13] bootsplash: Flush framebuffer after drawing
Message-Id: <5bac221c-ca65-63ee-02cf-581ea0701c07@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171213194755.3409-4-mstaudt@suse.de>
 <20171213213506.GD26573@phenom.ffwll.local>
 <d66a994a-cb3a-c1fb-8f91-adbd475a40f0@suse.de>
 <20171219122313.GE26573@phenom.ffwll.local>
 <8bbb0497-4a10-2f81-0040-6e7cd4e7353c@suse.de>
 <20171219135715.GG26573@phenom.ffwll.local>
 <8036b6a6-6ed5-2f34-e854-1c397a9f34d4@suse.de>
 <CAA_UwzLoTDQMJUWTZq-U=crNpAKmc5DpBNwJtr3DOO2ywaTD7g@mail.gmail.com>
 <bf6607cf-d3e7-5873-1905-c37474e89fb3@suse.de>
 <CAA_Uwz+e=b9-TvFVUuL0er114XZuFDopGDhHORiZAmpisHeF8A@mail.gmail.com>
In-Reply-To: <CAA_Uwz+e=b9-TvFVUuL0er114XZuFDopGDhHORiZAmpisHeF8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ray Strode <halfline@gmail.com>
Cc: linux-fbdev@vger.kernel.org, michal@markovi.net, b.zolnierkie@samsung.com, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, philm@manjaro.org, =?UTF-8?Q?Bero_Rosenkr=c3=a4nzer?= <bernhard.rosenkranzer@linaro.org>

On 12/20/2017 04:35 PM, Ray Strode wrote:
> Hi,
> 
>> Actually, I don't want that :)
>>
>> This was a design decision that I've made to keep the code small and simple to audit.
>> As it is, the simple bootsplash code will make 99% of people happy.
> You think only 1% of linux users have more than one monitor or a 4k screen?

No, I think 99% will be glad to see a splash at all, and it's a 99% probabililty that the splash will look alright on at least one screen, if not more.

By the simple virtue that dual-monitor setups tend to use identical screens, it's okay if these are cloned while the splash is shown. So maybe 95% of these users are fine, as well.

As for 4k screens - a logo that looks okay on 800x600 will probably look fine, even though it's physically smaller, on a 4k screen.


If there really, really, really is a need, HiDPI can be retrofitted to the format later on.


>> I've made this decision from the point of view of someone who wants to ship a general
>> purpose distribution. If you have a look around and compare this to e.g. the Windows or
>> Mac OS X bootsplashes, the possibilities that my kernel code provides already
>> surpasses them.
> I haven't looked specifically, but I don't believe you :-)  You're
> telling me the apple boot
> splash isn't scaled up on machines with retina displays?  I don't use
> OSX (or windows),
> so I don't know, but I'd be really surprised.

Admittedly, my knowledge is aging as well. My pre-retina MacBook certainly didn't scale anything.

And Windows XP booted in 640x480, then went black, switched modes, and drew the desktop.


>> If you really want such sophisticated features, supplanting the initial bootsplash  with
>> Plymouth (or not using it at all) is a better solution. In my opinion, it is overengineering,
>> at least for kernel code.
> disagree..it's support for basic, commodity hardware these days.

Hmm. I guess it's a matter of taste, and we have to agree to disagree on this one. See above.

Also, like pointed out in the other email, it's meant as an alternative to Plymouth. Maybe I should have made this clear from the beginning - it's an option, not a replacement. We're in the FOSS ecosystem after all, where it's all about choice, and that choice exists because we admit that sometimes, not everyone can be made happy with the same solution.


>> As for HiDPI, if you're working on an embedded device with a fixed screen size -
>> say a phone - you can easily include a huge picture the size of the screen in the
>> bootsplash.
> I'm talking about a situation where you have a dell xps or whatever
> with an external
> monitor attached.  Each monitor should be able to show the splash
> without deforming
> it, and without making it huge or microscopic. pretty basic stuff...
See above. I doubt any other system cares.

And we can't even care before native driver KMS comes up, which may take a while, depending on the system.

I'd like to have this as an alternative to Plymouth in such setups.



Max
