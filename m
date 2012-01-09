From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 09 Jan 2012 11:13:10 +0000
Subject: Re: [PATCH] atmel_lcdfb: support 16bit BGR:565 mode, remove unsupported 15bit modes
Message-Id: <87ty45dt89.fsf@macbook.be.48ers.dk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1318517570-28459-1-git-send-email-jacmet@sunsite.dk>
 <4F0AC2B1.8010601@atmel.com>
In-Reply-To: <4F0AC2B1.8010601@atmel.com> (Nicolas Ferre's message of "Mon, 09
 Jan 2012 11:34:25 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>>>>> "Nicolas" = Nicolas Ferre <nicolas.ferre@atmel.com> writes:

 Nicolas> On 10/13/2011 04:52 PM, Peter Korsgaard :
 >> Allow framebuffer to be configured in 16bit mode when panel is wired in
 >> (the default) BGR configuration, and don't claim to support 15bit input
 >> modes, which the LCD controller cannot handle.
 >> 
 >> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

 Nicolas> Hi Peter,

 Nicolas> Sorry for not having more responsive concerning the two
 Nicolas> patches that you posted about atmel_lcdfb driver.

No problem.

 Nicolas> I have a question though about this one...

 >> -		} else if (sinfo->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB555) {
 >> -			var->red.offset = 10;
 >> -			var->blue.offset = 0;
 >> -			var->green.length = 5;

 Nicolas> Maybe I have missed something but I do not know why you are removing
 Nicolas> this part of the configuration? A board at least is using this wiring
 Nicolas> mode...

Because it is arguable wrong as far as I understand the HW.
There's two parts here:

- 1: Format of framebuffer memory
- 2: Wiring of LCD (RGB/BGR order and number of bits)

From the datasheet, the following framebuffer formats are supported:

1, 2, 4, 8 bits per pixel (palletized), 16, 24 bits per pixel
(non-palletized) for TFT.

So it doesn't really support RGB555 mode. The controller reads up to
32bit of framebuffer data and outputs 24bit on the LCD pins. You CAN
wire up a RGB555 panel by just skipping the LSB green of a RGB565
wiring, but that is independent of the framebufffer format. The
controller/driver doesn't do any RGB/BGR swapping, so the RBG/BGR wiring
settings are just used as a software hint (in FBIOGET_VSCREENINFO) about
the meaning of the individual bits of a pixel in the framebuffer.

Similar you can connect a 12bit 4:4:4 panel by just connecting it to the
MSB LCD pins.

So in conclusion, I think we should just have:

- ATMEL_LCDC_WIRING_RGB
- ATMEL_LCDC_WIRING_BGR
- ATMEL_LCDC_WIRING_RGB565
- ATMEL_LCDC_WIRING_BGR565

These simply define framebuffer bit order (RGB/BGR) and preferred
default bit depth (16/24).

I hope this makes it more clear.

-- 
Bye, Peter Korsgaard
