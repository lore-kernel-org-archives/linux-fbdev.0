From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 08 Oct 2015 13:55:46 +0000
Subject: Re: [PATCH] uvesafb: make scaling configurable on Nvidia cards
Message-Id: <alpine.LRH.2.02.1510080946190.20879@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1509021719170.12073@file01.intranet.prod.int.rdu2.redhat.com> <56163806.40608@ti.com> <alpine.LRH.2.02.1510080744170.20879@file01.intranet.prod.int.rdu2.redhat.com> <56165FCB.30504@ti.com>
In-Reply-To: <56165FCB.30504@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Michal Januszewski <spock@gentoo.org>, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org



On Thu, 8 Oct 2015, Tomi Valkeinen wrote:

> 
> On 08/10/15 14:51, Mikulas Patocka wrote:
> 
> >> I have to say I don't know much about x86 video, but isn't uvesafb
> >> supposed to be a generic driver? Adding nvidia specific features there
> >> doesn't sound like a right way to handle this.
> >>
> >>  Tomi
> > 
> > Where do you think that this functionality should be added? To Nouveau? - 
> > Nouveau can't be used with nVidia binary driver, and this functionality is 
> > useful especially with nVidia binary driver (it allows to get nice console 
> > with sharp fonts).
> 
> I don't know where is should be. But with a quick look I don't see any
> gfx card specific features in uvesafb, and the doc clearly says it's a
> generic driver. So if we add this nvidia feature there, shall we add
> other features for other cards also? It's a kind of slippery road.
> 
> So how does uvesafb work with nvidia driver? uvesafb is used for initial
> console, and nvidia driver takes over later when (and if) it's loaded?
> And it's not possible to change the scaling via nvidia's driver?

The nvidia binary driver doesn't handle console, it only handles Xwindow. 
You can use either the VGA 80x25 text console or you can set graphics 
console with uvesafb - in both cases, the video card hardware scales the 
screen and the console font is blurry. The patch allows to turn off the 
scaling.

> > BTW. I don't know if this BIOS function is supported on AMD or not. Could 
> > someone try it? I don't have an AMD card.
> 
> Quick googling shows that 0x4f14 might be used by other gfx cards (Epia)
> for something else. But I can't really say for sure. So in the minimum I
> think the parameter should be renamed to "nvidia_scaling" or similar.

Someone should try the patch on AMD card and say if it can set scaling 
there.

Mikulas

>  Tomi
> 
> 
