From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Who is stomping PCI config space?
Date: Thu, 3 Mar 2005 19:15:06 -0500
Message-ID: <9e473391050303161559c17955@mail.gmail.com>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <1109891245.5611.246.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, Xserver development <xorg@freedesktop.org>

My understanding of the X source code is limited, can anyone tell me
where X is turning off secondary cards on VT switch?

The patch looks like it keeps X from getting secondary cards onto the
list of cards to begin with.

Can anyone explain why X is disabling cards on VT switch that it does
not have drivers loaded for? This behavior just toasts my fbdev
driver. My driver is getting interrupts, now I switch VTs to X and the
card's MMIO window disappears. Of course my driver messes up, it go
into a hard loop servicing an interrupt it can't acknowledge.


On Fri, 04 Mar 2005 10:07:25 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2005-03-03 at 14:03 -0500, Jon Smirl wrote:
> > I have two video cards:
> > PCI Rage128
> > AGP Radeon
> >
> > X is loaded on the Rage128 on VT7
> > X is not configured to support the radeon
> >
> > I switch to VT1 and load radeonfb
> > This works fine.
> >
> > Now I switch to VT7 and dump PCI config space for the radeon
> >
> > [root@jonsmirl 0000:01:00.0]# hexdump config >/foo
> > [root@jonsmirl 0000:01:00.0]# diff /foo /bar
> > 1c1
> > < 0000000 1002 4966 0080 02b0 0001 0300 4010 0080
> > ---
> > > 0000000 1002 4966 0083 02b0 0001 0300 4010 0080
> > 4c4
> > < 0000030 0000 fea0 0058 0000 0000 0000 010b 0008
> > ---
> > > 0000030 0000 fe90 0058 0000 0000 0000 010b 0008
> > [root@jonsmirl 0000:01:00.0]#
> >
> > Somebody is changing PCI command from 83 to 80 and disabling my
> > radeon's memory and iospace. Who is doing this? It has to be X since
> > it doesn't happen if I switch to VT6 or VT8.
> >
> > Why is X mucking with a card it doesn't have a driver loaded for?
> > Where is this happening in the X code?
> 
> I had a report of something similar with X and a mach64 ... I haven't
> yet investigated, but basically, X is using "fbdev" (so no specific
> driver) and seem to be disabling memory access to the card, thus blowing
> up the kernel fbdev.
> 
> Ben.
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
