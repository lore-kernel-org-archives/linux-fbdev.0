From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 10 Jan 2012 14:19:18 +0000
Subject: Re: [PATCH] atmel_lcdfb: support 16bit BGR:565 mode, remove unsupported 15bit modes
Message-Id: <87pqerd4ih.fsf@macbook.be.48ers.dk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1318517570-28459-1-git-send-email-jacmet@sunsite.dk>
 <4F0AC2B1.8010601@atmel.com> <87ty45dt89.fsf@macbook.be.48ers.dk>
 <20120110140218.GB7180@jl-vm1.vm.bytemark.co.uk>
In-Reply-To: <20120110140218.GB7180@jl-vm1.vm.bytemark.co.uk> (Jamie Lokier's
 message of "Tue, 10 Jan 2012 14:02:18 +0000")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>>>>> "Jamie" = Jamie Lokier <jamie@shareable.org> writes:

 >> Similar you can connect a 12bit 4:4:4 panel by just connecting it to the
 >> MSB LCD pins.

 Jamie> If you're connecting an RGB555 or RGB444 panel, don't you want
 Jamie> the software using the framebuffer to know this so it will
 Jamie> dither appropriately?

Potentially. This is similar to the issues with cheap 18bit laptop
LCDs. We somewhat do this (E.G. default to 565 mode if a 16bit panel is
used), but as the hardware doesn't support anything bwteen 8bit paletted
and RGB565 modes, there's not much else we can do (fbdev doesn't provide
any info about the panel specs).

-- 
Bye, Peter Korsgaard
