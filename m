From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 08 Oct 2015 11:51:50 +0000
Subject: Re: [PATCH] uvesafb: make scaling configurable on Nvidia cards
Message-Id: <alpine.LRH.2.02.1510080744170.20879@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1509021719170.12073@file01.intranet.prod.int.rdu2.redhat.com> <56163806.40608@ti.com>
In-Reply-To: <56163806.40608@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Michal Januszewski <spock@gentoo.org>, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org



On Thu, 8 Oct 2015, Tomi Valkeinen wrote:

> 
> On 03/09/15 00:23, Mikulas Patocka wrote:
> > [ I sent this some times ago, but didn't get any response ]
> > 
> > 
> > Nvidia cards have a BIOS function 0x4f14 that allows to set flat panel
> > scaling. This patch adds a module parameter "scaling" that uses this
> > function to set the scaling. By default, the parameter is -1, so that the
> > driver doesn't attempt to call the scaling function.
> > 
> > This patch is useful when using the binary Nvidia graphics driver - in
> > that case, the console may be only in text mode or VESA mode. By default,
> > the video card does scaling that degrades font quality and changes aspect
> > ratio. This patch makes it possible to turn off the scaling and improve
> > font quality on the console.
> > 
> > The allowed values depend on VESA BIOS. On my card, the following values
> > are allowed:
> > -1	- do not change the scaling
> > 0	- scale to full screen
> > 1, 2	- don't scale
> > 3	- scale and preserve aspect ratio
> > 4	- scale with black border around
> > 
> > Example use:
> > echo 1 >/sys/module/uvesafb/parameters/scaling; fbset 1280x1024-60 -depth 32 -a
> > - this sets unscaled 1280x1024 video mode that has much sharper font than
> >   the scaled modes.
> 
> I have to say I don't know much about x86 video, but isn't uvesafb
> supposed to be a generic driver? Adding nvidia specific features there
> doesn't sound like a right way to handle this.
> 
>  Tomi

Where do you think that this functionality should be added? To Nouveau? - 
Nouveau can't be used with nVidia binary driver, and this functionality is 
useful especially with nVidia binary driver (it allows to get nice console 
with sharp fonts).

BTW. I don't know if this BIOS function is supported on AMD or not. Could 
someone try it? I don't have an AMD card.

Mikulas
