From: Jamie Lokier <jamie@shareable.org>
Date: Tue, 10 Jan 2012 14:02:18 +0000
Subject: Re: [PATCH] atmel_lcdfb: support 16bit BGR:565 mode, remove
Message-Id: <20120110140218.GB7180@jl-vm1.vm.bytemark.co.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1318517570-28459-1-git-send-email-jacmet@sunsite.dk>
 <4F0AC2B1.8010601@atmel.com> <87ty45dt89.fsf@macbook.be.48ers.dk>
In-Reply-To: <87ty45dt89.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Peter Korsgaard wrote:
> Because it is arguable wrong as far as I understand the HW.
> There's two parts here:
> 
> - 1: Format of framebuffer memory
> - 2: Wiring of LCD (RGB/BGR order and number of bits)
> 
> >From the datasheet, the following framebuffer formats are supported:
> 
> 1, 2, 4, 8 bits per pixel (palletized), 16, 24 bits per pixel
> (non-palletized) for TFT.
> 
> So it doesn't really support RGB555 mode. The controller reads up to
> 32bit of framebuffer data and outputs 24bit on the LCD pins. You CAN
> wire up a RGB555 panel by just skipping the LSB green of a RGB565
> wiring, but that is independent of the framebufffer format. The
> controller/driver doesn't do any RGB/BGR swapping, so the RBG/BGR wiring
> settings are just used as a software hint (in FBIOGET_VSCREENINFO) about
> the meaning of the individual bits of a pixel in the framebuffer.
> 
> Similar you can connect a 12bit 4:4:4 panel by just connecting it to the
> MSB LCD pins.

If you're connecting an RGB555 or RGB444 panel, don't you want the
software using the framebuffer to know this so it will dither appropriately?

E.g. gradients look "bandy" if drawn in RGB565 then green's LSB is dropped.

-- Jamie
