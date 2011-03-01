From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Tue, 01 Mar 2011 17:26:14 +0000
Subject: Re: [PATCH 5/6] FBDEV: JZ4740: Get rid of enumeration value not handled
Message-Id: <4D6D2C36.9060002@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1202f26b58f8dea782600827a158f08b1775953b.1298980528.git.mcuelenaere@gmail.com>
In-Reply-To: <1202f26b58f8dea782600827a158f08b1775953b.1298980528.git.mcuelenaere@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

> On 03/01/2011 01:06 PM, Maurus Cuelenaere wrote:
>> Convert enum jz4740_fb_lcd_type to #define's in order to get rid of these
>> warnings.
>>
> Nack. If it is not handled the code is wrong.
> If this is because you only handle SLCD types in some SLCD specific functions add a
> default:
> 	BUG();

Ok, that's also a way to handle it.

>> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
>> ---
>>  arch/mips/include/asm/mach-jz4740/jz4740_fb.h |   40 ++++++++++++-------------
>>  1 files changed, 19 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_fb.h b/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
>> index eaaac43..d6c11f2 100644
>> --- a/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
>> +++ b/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
>> @@ -17,27 +17,25 @@
>>  
>>  #include <linux/fb.h>
>>  
>> -enum jz4740_fb_lcd_type {
>> -	JZ_LCD_TYPE_GENERIC_16_BIT = 0,
>> -	JZ_LCD_TYPE_GENERIC_18_BIT = 0 | (1 << 4),
>> -	JZ_LCD_TYPE_SPECIAL_TFT_1 = 1,
>> -	JZ_LCD_TYPE_SPECIAL_TFT_2 = 2,
>> -	JZ_LCD_TYPE_SPECIAL_TFT_3 = 3,
>> -	JZ_LCD_TYPE_NON_INTERLACED_CCIR656 = 5,
>> -	JZ_LCD_TYPE_INTERLACED_CCIR656 = 7,
>> -	JZ_LCD_TYPE_SINGLE_COLOR_STN = 8,
>> -	JZ_LCD_TYPE_SINGLE_MONOCHROME_STN = 9,
>> -	JZ_LCD_TYPE_DUAL_COLOR_STN = 10,
>> -	JZ_LCD_TYPE_DUAL_MONOCHROME_STN = 11,
>> -	JZ_LCD_TYPE_8BIT_SERIAL = 12,
>> +#define JZ_LCD_TYPE_GENERIC_16_BIT		(0)
>> +#define JZ_LCD_TYPE_GENERIC_18_BIT		(0 | (1 << 4))
>> +#define JZ_LCD_TYPE_SPECIAL_TFT_1		(1)
>> +#define JZ_LCD_TYPE_SPECIAL_TFT_2		(2)
>> +#define JZ_LCD_TYPE_SPECIAL_TFT_3		(3)
>> +#define JZ_LCD_TYPE_NON_INTERLACED_CCIR656	(5)
>> +#define JZ_LCD_TYPE_INTERLACED_CCIR656		(7)
>> +#define JZ_LCD_TYPE_SINGLE_COLOR_STN		(8)
>> +#define JZ_LCD_TYPE_SINGLE_MONOCHROME_STN	(9)
>> +#define JZ_LCD_TYPE_DUAL_COLOR_STN		(10)
>> +#define JZ_LCD_TYPE_DUAL_MONOCHROME_STN		(11)
>> +#define JZ_LCD_TYPE_8BIT_SERIAL			(12)
>>  
>> -	JZ_SLCD_TYPE_PARALLEL_8_BIT = 1 | (1 << 5),
>> -	JZ_SLCD_TYPE_PARALLEL_16_BIT = 0 | (1 << 5),
>> -	JZ_SLCD_TYPE_PARALLEL_18_BIT = 2 | (1 << 5),
>> -	JZ_SLCD_TYPE_SERIAL_8_BIT = 1 | (3 << 5),
>> -	JZ_SLCD_TYPE_SERIAL_16_BIT = 0 | (3 << 5),
>> -	JZ_SLCD_TYPE_SERIAL_18_BIT = 2 | (3 << 5),
>> -};
>> +#define JZ_SLCD_TYPE_PARALLEL_8_BIT		(1 | (1 << 5))
>> +#define JZ_SLCD_TYPE_PARALLEL_16_BIT		(0 | (1 << 5))
>> +#define JZ_SLCD_TYPE_PARALLEL_18_BIT		(2 | (1 << 5))
>> +#define JZ_SLCD_TYPE_SERIAL_8_BIT		(1 | (3 << 5))
>> +#define JZ_SLCD_TYPE_SERIAL_16_BIT		(0 | (3 << 5))
>> +#define JZ_SLCD_TYPE_SERIAL_18_BIT		(2 | (3 << 5))
>>  
>>  #define JZ4740_FB_SPECIAL_TFT_CONFIG(start, stop) (((start) << 16) | (stop))
>>  
>> @@ -58,7 +56,7 @@ struct jz4740_fb_platform_data {
>>  	struct fb_videomode *modes;
>>  
>>  	unsigned int bpp;
>> -	enum jz4740_fb_lcd_type lcd_type;
>> +	unsigned int lcd_type;
>>  
>>  	struct {
>>  		uint32_t spl;
>
> Nack

Ok.

Thanks for the review!

-- 
Maurus Cuelenaere

