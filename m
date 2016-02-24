From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 24 Feb 2016 10:53:04 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <20160224105304.GM19428@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com>
In-Reply-To: <56CC60C4.6040908@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 23, 2016 at 03:38:12PM +0200, Tomi Valkeinen wrote:
> Ok. I feel everyone is trying to push the ugly part out of their domain.
> I want the board specific hacks out of fbdev. Bootloader people don't
> want it there. arch/arm/ people don't want it there. =)

I think that is really really unfair.  No one is trying to push ugly
bits out of their domain - this is being driven by Linus, who is
trying to convert Versatile to DT.  There is no other agenda here.

Remember, I was the one who wrote the CLCD driver, and it was written
to support the boards at the time using the best methods at the time.
Things change, people's ideas of what's acceptable change.  What was
acceptable when classes of boards were separate is no longer acceptable
with single zImage.

The board specific parts of CLCD were in arch/arm for a very long time,
but that gets in the way of single zImage, and the solution adopted by
the newly interested parties has been to move them to drivers/video
to keep things working.

That's how we're here: there isn't a conspiracy as you seem to be
thinking.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
