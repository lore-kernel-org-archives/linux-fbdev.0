From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 17 Feb 2016 21:32:50 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <20160217213250.GK19428@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <56C438DA.5040109@ti.com>
 <CACRpkdZ+G17hmVP8AejL7NTqg7k0SBC5kgF55ASjD+kfuGFJhQ@mail.gmail.com>
In-Reply-To: <CACRpkdZ+G17hmVP8AejL7NTqg7k0SBC5kgF55ASjD+kfuGFJhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Feb 17, 2016 at 05:17:33PM +0100, Linus Walleij wrote:
> As Russell points out: it's a register that contains a number saying what
> panel is connected.
> 
> So it is plug-n-play and I want to preserve this in the patch.
> 
> The alternative is to make one DTS per display type connected, but that is
> loosing all the nice plug'n'play :(

That's totally insane: we're talking about what's plugged in through
an external connector.  It's not an "internal" device connector.
These displays are external separate boxes to the board.

We don't have separate DT files just because we plugged in a USB device
to a board., or a SDIO card, or an external HDD.

> But if an overlay can do the same, I'm game for it.

That's rather eww, because that means you need to either build the
overlay into the kernel (which IIRC then ties the base DT file to
that exact kernel) or it needs to sit in userland, which means no
LCD display until userland is up and running.  It doesn't sound very
satisfactory, IMHO.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
