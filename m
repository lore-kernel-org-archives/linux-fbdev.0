From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: Who is stomping PCI config space?
Date: Sat, 05 Mar 2005 09:45:04 +1100
Message-ID: <1109976305.5611.312.camel@gaston>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<9e473391050303161559c17955@mail.gmail.com>
	<9e47339105030319037f083f7@mail.gmail.com>
	<1109918459.5610.273.camel@gaston>
	<16936.20345.249542.65736@xf14.local>
	<9e473391050304095812a11208@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e473391050304095812a11208@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Egbert Eich <eich@suse.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Xserver development <xorg@freedesktop.org>, Jesse Barnes <jbarnes@sgi.com>

On Fri, 2005-03-04 at 12:58 -0500, Jon Smirl wrote:
> In the past Jesse Barnes has suggested a completely different approach
> to VGA sharing. Instead of each VT trying to control which VGA device
> is enabled we keep them all turned off. Then on each access we turn
> VGA support on just long enough for the access and then turn it back
> off.

That's what I had in mind too.

> To make this work we have to have a kernel based 'token' for who has
> the VGA at the moment. This scheme lets multiuser systems work. For
> big IA64 machines which can support multiple simultaneous VGAs we just
> have multiple tokens.

That means that the arbitrer must need to know how to enable/disable VGA
decoding on a per-card basis (when it's possible at all), or active
collaboration with the kernel driver. Also, you can't prevent the
interrupts from happening unless you also disable them on your card.

> We would just ban VGA access from interrupt context, if you really
> needed VGA access you would use a workqueue which can be scheduled
> from the interrupt. None of my driver work needs VGA access from
> interrupt context, is this true for all drivers? I need access to the
> video hardware, but not access to the VGA support.

It's not enough.

There is a variety of cases where the only way to turn off VGA access is
to turn off IO & MEM decoding completely on the card...

Ben.
