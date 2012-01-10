From: Christian Glindkamp <christian.glindkamp@taskit.de>
Date: Tue, 10 Jan 2012 13:01:46 +0000
Subject: Re: [PATCH] atmel_lcdfb: support 16bit BGR:565 mode, remove
Message-Id: <20120110130146.GC2057@taskit.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1318517570-28459-1-git-send-email-jacmet@sunsite.dk>
 <4F0AC2B1.8010601@atmel.com> <87ty45dt89.fsf@macbook.be.48ers.dk>
In-Reply-To: <87ty45dt89.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 2012-01-09 12:13, Peter Korsgaard wrote:
> >>>>> "Nicolas" = Nicolas Ferre <nicolas.ferre@atmel.com> writes:
> 
>  Nicolas> On 10/13/2011 04:52 PM, Peter Korsgaard :
>  >> Allow framebuffer to be configured in 16bit mode when panel is wired in
>  >> (the default) BGR configuration, and don't claim to support 15bit input
>  >> modes, which the LCD controller cannot handle.
>  >> 
>  >> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> 
>  Nicolas> Hi Peter,
> 
>  Nicolas> Sorry for not having more responsive concerning the two
>  Nicolas> patches that you posted about atmel_lcdfb driver.
> 
> No problem.
> 
>  Nicolas> I have a question though about this one...
> 
>  >> -		} else if (sinfo->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB555) {
>  >> -			var->red.offset = 10;
>  >> -			var->blue.offset = 0;
>  >> -			var->green.length = 5;
> 
>  Nicolas> Maybe I have missed something but I do not know why you are removing
>  Nicolas> this part of the configuration? A board at least is using this wiring
>  Nicolas> mode...
> 
> Because it is arguable wrong as far as I understand the HW.
> There's two parts here:
> 
> - 1: Format of framebuffer memory
> - 2: Wiring of LCD (RGB/BGR order and number of bits)
> 
> From the datasheet, the following framebuffer formats are supported:
> 
> 1, 2, 4, 8 bits per pixel (palletized), 16, 24 bits per pixel
> (non-palletized) for TFT.
> 
> So it doesn't really support RGB555 mode. The controller reads up to
> 32bit of framebuffer data and outputs 24bit on the LCD pins. You CAN
> wire up a RGB555 panel by just skipping the LSB green of a RGB565
> wiring, but that is independent of the framebufffer format.

But the AT91SAM9261/AT91SAM9263 do not have a native RGB565 format if it
is configured for 16bit (so it does not read 32bit and output 24bit but
just 16bit) but uses BGR555 with an additional intensity bit in the MSB
like the palette where you also kept the BGR555 format. How can you get
correct colors on these processors if this code above is removed?

