From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 24 Feb 2016 10:46:38 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <20160224104638.GL19428@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <56CC546A.9070705@ti.com>
In-Reply-To: <56CC546A.9070705@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 23, 2016 at 02:45:30PM +0200, Tomi Valkeinen wrote:
> My opinion is that the bootloader should be responsible for telling the
> kernel what hardware there is on the board. For busses like PCI we have
> proper probing mechanism with global unique identifiers for the devices,
> and nothing is needed from the bootloader.

Exactly, but that is _NOT_ the case here, because we're not talking
about an on-board display.

> In the Versatile case the panels are kind of probeable, but not in the
> same sense as PCI: all that can be probed on Versatile is a board
> specific ID, which in itself doesn't tell what kind of panel there is.
> In addition to the ID we need board specific tables listing the details
> of the panels.

That argument does not stack up.  Just because you've plugged in a
network device does not mean that the kernel can drive it: the kernel
needs a device specific driver, which is determined by looking at the
IDs.  There is no standard network driver PCI interface.

> I think one of the core questions here is: do we want to start adding
> board specific drivers to the kernel, instead of dealing with it in the
> bootloader when possible? My understanding is that we've been trying to
> reduce board specific code from the kernel.

That's not really the question, because that question assumes that it
isn't already present, which is not true.  The code is already present.
The question is how to deal with this from the DT perspective.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
