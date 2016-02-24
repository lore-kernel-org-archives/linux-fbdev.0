From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 24 Feb 2016 11:35:49 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <20160224113549.GN19428@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <56CC546A.9070705@ti.com>
 <20160224104638.GL19428@n2100.arm.linux.org.uk>
 <56CD924F.50108@ti.com>
In-Reply-To: <56CD924F.50108@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Feb 24, 2016 at 01:21:51PM +0200, Tomi Valkeinen wrote:
> On 24/02/16 12:46, Russell King - ARM Linux wrote:
> > On Tue, Feb 23, 2016 at 02:45:30PM +0200, Tomi Valkeinen wrote:
> >> My opinion is that the bootloader should be responsible for telling the
> >> kernel what hardware there is on the board. For busses like PCI we have
> >> proper probing mechanism with global unique identifiers for the devices,
> >> and nothing is needed from the bootloader.
> > 
> > Exactly, but that is _NOT_ the case here, because we're not talking
> > about an on-board display.
> 
> Ok, what is it then? I'm not familiar with the boards in question.
> 
> When does a display become an on-board display? All the panels I have
> can be disconnected quite easily, but I still consider them as on-board
> displays.

The difference to me is quite clear.

If the connector is a flexi-strip or LVDS connector designed to be
connected directly to a panel, it is not designed as a user connector,
and the display can be regarded as part of the board: the connector
probably isn't rated for a large number of mating cycles.

If the connector is a board-edge external-unit connector, then the
panel is not part of the board.

In the case of Versatile, it's the latter: the connector is situated
at the board edge, next to the serial port connectors, and is designed
to connect to an external box housing the display.

> > That argument does not stack up.  Just because you've plugged in a
> > network device does not mean that the kernel can drive it: the kernel
> > needs a device specific driver, which is determined by looking at the
> > IDs.  There is no standard network driver PCI interface.
> 
> Yes, but you can connect the network device to any board with a PCI bus
> and it works. Here, if I'm not mistaken, the displays are built for this
> single board, making them board specific.

It only works because Linux has a rich array of network drivers supporting
all that hardware, and the appropriate network driver is bound depending
on the hardware ID of the card.  If a new PCI network device comes out,
it'll more likely than not require an update to a network driver to make
it work.

The displays are not built for "this single board" but for a family of
boards: not only Versatile PB/AB, but also the Realview family of boards
too.

> But I cannot accept that as a general solution for all similar cases
> going forward, especially when moving to DRM world, that's just bad SW
> design.

I think that's a matter of personal opinion, perspective and situation.
What is good design today is not necessary good design yesterday or
tomorrow.  I thought we already ascertained that earlier in this
discussion. :)

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
