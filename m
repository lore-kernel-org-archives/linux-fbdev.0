From: Ray Strode <halfline@gmail.com>
Date: Wed, 20 Dec 2017 15:35:56 +0000
Subject: Re: [RFC PATCH v2 03/13] bootsplash: Flush framebuffer after drawing
Message-Id: <CAA_Uwz+e=b9-TvFVUuL0er114XZuFDopGDhHORiZAmpisHeF8A@mail.gmail.com>
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
In-Reply-To: <bf6607cf-d3e7-5873-1905-c37474e89fb3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Staudt <mstaudt@suse.de>
Cc: linux-fbdev@vger.kernel.org, michal@markovi.net, b.zolnierkie@samsung.com, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, philm@manjaro.org, =?UTF-8?Q?Bero_Rosenkr=C3=A4nzer?= <bernhard.rosenkranzer@linaro.org>

Hi,

> Actually, I don't want that :)
>
> This was a design decision that I've made to keep the code small and simple to audit.
> As it is, the simple bootsplash code will make 99% of people happy.
You think only 1% of linux users have more than one monitor or a 4k screen?

> I've made this decision from the point of view of someone who wants to ship a general
> purpose distribution. If you have a look around and compare this to e.g. the Windows or
> Mac OS X bootsplashes, the possibilities that my kernel code provides already
> surpasses them.
I haven't looked specifically, but I don't believe you :-)  You're
telling me the apple boot
splash isn't scaled up on machines with retina displays?  I don't use
OSX (or windows),
so I don't know, but I'd be really surprised.

> If you really want such sophisticated features, supplanting the initial bootsplash  with
> Plymouth (or not using it at all) is a better solution. In my opinion, it is overengineering,
> at least for kernel code.
disagree..it's support for basic, commodity hardware these days.

> As for HiDPI, if you're working on an embedded device with a fixed screen size -
> say a phone - you can easily include a huge picture the size of the screen in the
> bootsplash.
I'm talking about a situation where you have a dell xps or whatever
with an external
monitor attached.  Each monitor should be able to show the splash
without deforming
it, and without making it huge or microscopic. pretty basic stuff...

--Ray
