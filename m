From: Pawel Moll <pawel.moll@arm.com>
Date: Fri, 21 Sep 2012 10:44:06 +0000
Subject: Re: [RFC PATCH 1/3] amba-clcd: Add Device Tree support to amba-clcd driver
Message-Id: <1348224246.11116.178.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348070666-9153-1-git-send-email-ryan.harkin@linaro.org>
 <1348070666-9153-2-git-send-email-ryan.harkin@linaro.org>
 <20120920102453.GG32603@e102652-lin.cambridge.arm.com>
 <CAD0U-h+Z1zQYTiEm+aKwNJa48SdHfs6-qUu4vNRwFr=mqxyXCg@mail.gmail.com>
In-Reply-To: <CAD0U-h+Z1zQYTiEm+aKwNJa48SdHfs6-qUu4vNRwFr=mqxyXCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, 2012-09-21 at 11:35 +0100, Ryan Harkin wrote:
> Good point.  Sorry for my ignorance, but is there a place I should put
> such documentation?

Documentation/devicetree/bindings/fb/amba-clcd.txt :-)

> When the A9 CoreTile uses the on-tile CLCD controller, it can use DMA
> to handle the framebuffer.  DMA is not available to the motherboard
> CLCD controller.

Uh, you probably mean that the motherboard CLCD must use the specialised
video memory, while the one in the test chip would normally use a buffer
allocated via the DMA API...

> I was trying to keep the properties simple, but they are more complex
> than just the two settings: use_dma and framebuffer.  If use_dma is
> specified, the framebuffer property is not used; in this case, the
> framebuffer is allocated by the DMA framework and the framebuffer
> property is ignored.  If use_dma is not present or is set to <0>, the
> code uses the framebuffer property to specify the address.

I'm not sure if the "framebuffer" property is really needed, at least in
the form you have it there now. I think I know you where you get it from
- HDLCD driver, right? It was sort-of-needed there, because we had to
reserve memory for the framebuffer, because you couldn't allocate big
enough (8MB if I remember correctly) area using the DMA alloc function.
But now, with the CMA in place it should be possible, so I believe it's
not even necessary in that case. Simply speaking - if the driver is not
told what address to use, it should get the memory on its own.

Now, as to the motherboard CLCD... That's where you actually could use
this property in the way you have there, to enforce the address of the
video RAM as the framebuffer. But maybe it would be better to have a
phandle to the video RAM node?

Cheers!

Pawe=C5=82


