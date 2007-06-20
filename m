From: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
Subject: Re: [PATCH] atmel_lcdfb: Fix STN LCD support
Date: Wed, 20 Jun 2007 14:10:45 +0200
Message-ID: <46791945.6090203@rfo.atmel.com>
References: <467252C4.50203@rfo.atmel.com> <20070619094752.1b7ba108@dhcp-255-175.norway.atmel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760052AbXFTMLH@vger.kernel.org>
In-Reply-To: <20070619094752.1b7ba108@dhcp-255-175.norway.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, Jan Altenberg <jan.altenberg@linutronix.de>, Andrew Victor <andrew@sanpeople.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, Patrice Vilchez <patrice.vilchez@rfo.atmel.com>

Haavard Skinnemoen :
> On Fri, 15 Jun 2007 10:50:12 +0200
> Nicolas Ferre <nicolas.ferre@rfo.atmel.com> wrote:
> 
>> From: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
>>
>> Fixes STN LCD support for the atmel_lcdfb framebuffer driver.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
> 
> Looks correct to me. Although...
> 
>> Index: b/drivers/video/Kconfig
>> ===================================================================
>> --- a/drivers/video/Kconfig	2007-05-14 11:02:16.000000000 +0200
>> +++ b/drivers/video/Kconfig	2007-06-13 11:04:10.000000000 +0200
>> @@ -701,6 +701,16 @@
>>  	  Say Y if you want to map Frame Buffer in internal SRAM. Say N if you want
>>  	  to let frame buffer in external SDRAM.
>>  
>> +config FB_ATMEL_STN
>> +	bool "Use a STN display with AT91/AT32 LCD Controller"
>> +	depends on FB_ATMEL && ARCH_AT91SAM9261
>> +	default n
>> +	help
>> +	  Say Y if you want to connect a STN LCD display to the AT91/AT32 LCD
>> +	  Controller. Say N if you want to connect a TFT.
>> +
>> +	  If unsure, say N.
>> +
> 
> I don't think it's appropriate to include chip-specific options here.
> This option will not affect the driver at all, it will only affect the
> board-specific setup code, so IMO it should be under Platform-specific
> options or something like that.

True in a "code centric" point of view. I do not think it is very usable 
to move this switch in the board setup : The user will have to check if 
an option is appearing in the board menu while he select the Atmel LCD 
driver. He is supposed to have already selected the chip'n'board he is 
using.
Moreover, this option will not show its nose until the board that 
implements it is not included in depends.
(It is basically the same case with the option just above, with the very 
same arguments).

> Also, the text says AT91/AT32 but it depends on one particular AT91
> chip.

Ok, will move it to a board switch (MACH_AT91SAM9261EK for instance). 
This will grow as STN configuration will be implemented for boards.

Regards,
-- 
Nicolas Ferre
