From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: Who is stomping PCI config space?
Date: Sat, 05 Mar 2005 09:16:34 +1100
Message-ID: <1109974594.5611.287.camel@gaston>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<16936.17851.290824.371736@xf14.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <16936.17851.290824.371736@xf14.local>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Xserver development <xorg@freedesktop.org>

On Fri, 2005-03-04 at 12:25 +0100, Egbert Eich wrote:
> Benjamin Herrenschmidt writes:
>  > 
>  > I had a report of something similar with X and a mach64 ... I haven't
>  > yet investigated, but basically, X is using "fbdev" (so no specific
>  > driver) and seem to be disabling memory access to the card, thus blowing
>  > up the kernel fbdev.
>  > 
> 
> Benjamin,
> 
> I faintly remember adding code to the Xserver that it wouldn't do this
> when you only used fbdev drivers. 
> It may do this for setup (ie. probing) as it has no idea about the drivers
> it is going to encounter. With the new interface I've added we may actually
> change this. I'm already doing this to determine if I need to enable PIO.
> 
> I need to look at this code again, though.

Ok. In this case, the fbdev only uses mmio. Anyway, I'll investigate as
soon as I can install the repro case (FC3 distro) on an mach64 machine,
probably early next week.
