From: Ray Strode <halfline@gmail.com>
Date: Tue, 19 Dec 2017 21:01:24 +0000
Subject: Re: [RFC PATCH v2 03/13] bootsplash: Flush framebuffer after drawing
Message-Id: <CAA_UwzLoTDQMJUWTZq-U=crNpAKmc5DpBNwJtr3DOO2ywaTD7g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171213194755.3409-4-mstaudt@suse.de>
 <20171213213506.GD26573@phenom.ffwll.local>
 <d66a994a-cb3a-c1fb-8f91-adbd475a40f0@suse.de>
 <20171219122313.GE26573@phenom.ffwll.local>
 <8bbb0497-4a10-2f81-0040-6e7cd4e7353c@suse.de>
 <20171219135715.GG26573@phenom.ffwll.local>
 <8036b6a6-6ed5-2f34-e854-1c397a9f34d4@suse.de>
In-Reply-To: <8036b6a6-6ed5-2f34-e854-1c397a9f34d4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Staudt <mstaudt@suse.de>
Cc: linux-fbdev@vger.kernel.org, michal@markovi.net, b.zolnierkie@samsung.com, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, philm@manjaro.org, bernhard.rosenkranzer@linaro.org

Hi,

On Tue, Dec 19, 2017 at 10:41 AM, Max Staudt <mstaudt@suse.de> wrote:
> I'm hooking into the in-kernel terminal emulator, because the bootsplash is a
> functional extension of that. It just happens that fbcon sits on top of FB, so I
> work with what I get.
>
> And the console in turn happens to work on all FB and KMS drivers, so it
> makes users of all kinds of drivers happy. In fact, that's why the FB emulation
> in KMS drivers came to be in the first place, if I remember right - to ensure
> fbcon continues to work.

But what about multi-monitor? what about hidpi screens?  Ideally you want
each monitor to show the splash in a way that best fits that monitor.

You can't do that if you're drawing all over fbcon... and it's not like multiple
monitors and 4k screens are niche these days.

--Ray
