From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: Who is stomping PCI config space?
Date: Tue, 08 Mar 2005 14:21:53 +1100
Message-ID: <1110252113.13608.235.camel@gaston>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<9e473391050303161559c17955@mail.gmail.com>
	<9e47339105030319037f083f7@mail.gmail.com>
	<1109918459.5610.273.camel@gaston>
	<16936.20345.249542.65736@xf14.local>
	<9e47339105030409352803c7e1@mail.gmail.com>
	<1109976157.5680.309.camel@gaston> <16938.847.772446.757968@xf14.local>
	<1110062539.13594.74.camel@gaston>
	<16940.14502.277774.189552@xf14.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <16940.14502.277774.189552@xf14.local>
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
Cc: Egbert Eich <eich@suse.de>, Xserver development <xorg@freedesktop.org>, Egbert Eich <eich@pdx.freedesktop.org>

On Mon, 2005-03-07 at 12:19 +0100, Egbert Eich wrote:
> Benjamin Herrenschmidt writes:
>  > 
>  > > How do we deal with interrupts from VGA cards that we don't have a 
>  > > driver for? 
>  > 
>  > We don't get any, do we ? If we get an interrupt we don't have a driver
>  > for, the system dies usually ;) Well, unless it's an edge interrupt, in
>  > which case we can just drop it on the floor, but PCI interrupts are
>  > level.
> 
> Usually VGA chips are capable of sending interrupts. At least the VGA
> specs had a bit where interrupts can be enabled/disabled.
> I'm surprised that this has not been an issue yet as I'm not sure if
> the BIOS POST always leaves them disabled. For PCI chips they probalbly
> do.

I would be surprised if a BIOS left it enabled ... it would be a really
bad thing to do...
