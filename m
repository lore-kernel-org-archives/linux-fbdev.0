From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Mon, 09 Jan 2012 13:34:56 +0000
Subject: Re: [PATCHv2] atmel_lcdfb: support new-style palette format
Message-Id: <4F0AED00.8060505@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1318517152-27578-1-git-send-email-jacmet@sunsite.dk>
 <4EBDBAF9.3090805@gmx.de>
In-Reply-To: <4EBDBAF9.3090805@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 11/12/2011 01:16 AM, Florian Tobias Schandinat :
> On 10/13/2011 02:45 PM, Peter Korsgaard wrote:
>> The newer Atmel SoCs use normal 16bit 565 BGR/RGB for the palette data,
>> rather than the special intensity + 555 format.
>>
>> Fill out palette data correctly on these devices, and at the same time
>> respect the RGB/BGR wiring mode.
> 
> Applied this patch.
> 
> 
> Thanks,
> 
> Florian Tobias Schandinat

Florian, here is my:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Can you please send it upstream through your tree?

>> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
>> ---
>> Changes since v1:
>>  - ATMEL_LCDC_WIRING_RGB/BGR was swapped
>>
>>  drivers/video/atmel_lcdfb.c |   32 ++++++++++++++++++++++++--------
>>  1 files changed, 24 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
>> index 63409c1..7ca3eaf 100644
>> --- a/drivers/video/atmel_lcdfb.c
>> +++ b/drivers/video/atmel_lcdfb.c
>> @@ -682,14 +682,30 @@ static int atmel_lcdfb_setcolreg(unsigned int regno, unsigned int red,
>>  
>>  	case FB_VISUAL_PSEUDOCOLOR:
>>  		if (regno < 256) {
>> -			val  = ((red   >> 11) & 0x001f);
>> -			val |= ((green >>  6) & 0x03e0);
>> -			val |= ((blue  >>  1) & 0x7c00);
>> -
>> -			/*
>> -			 * TODO: intensity bit. Maybe something like
>> -			 *   ~(red[10] ^ green[10] ^ blue[10]) & 1
>> -			 */
>> +			if (cpu_is_at91sam9261() || cpu_is_at91sam9263()
>> +			    || cpu_is_at91sam9rl()) {
>> +				/* old style I+BGR:555 */
>> +				val  = ((red   >> 11) & 0x001f);
>> +				val |= ((green >>  6) & 0x03e0);
>> +				val |= ((blue  >>  1) & 0x7c00);
>> +
>> +				/*
>> +				 * TODO: intensity bit. Maybe something like
>> +				 *   ~(red[10] ^ green[10] ^ blue[10]) & 1
>> +				 */
>> +			} else {
>> +				/* new style BGR:565 / RGB:565 */
>> +				if (sinfo->lcd_wiring_mode =
>> +				    ATMEL_LCDC_WIRING_RGB) {
>> +					val  = ((blue >> 11) & 0x001f);
>> +					val |= ((red  >>  0) & 0xf800);
>> +				} else {
>> +					val  = ((red  >> 11) & 0x001f);
>> +					val |= ((blue >>  0) & 0xf800);
>> +				}
>> +
>> +				val |= ((green >>  5) & 0x07e0);
>> +			}
>>  
>>  			lcdc_writel(sinfo, ATMEL_LCDC_LUT(regno), val);
>>  			ret = 0;
> 
> 


-- 
Nicolas Ferre
