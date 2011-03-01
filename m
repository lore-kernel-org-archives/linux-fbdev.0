From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Tue, 01 Mar 2011 17:18:49 +0000
Subject: Re: [PATCH 1/6] FBDEV: JZ4740: Refactor GPIO pin operations
Message-Id: <4D6D2A79.50109@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7f854ef86a16dd03f415965b3535c607c401941e.1298980528.git.mcuelenaere@gmail.com>
In-Reply-To: <7f854ef86a16dd03f415965b3535c607c401941e.1298980528.git.mcuelenaere@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Op 01-03-11 14:56, Lars-Peter Clausen schreef:
> On 03/01/2011 01:05 PM, Maurus Cuelenaere wrote:
>> Encapsulate all GPIO pins related operations into 1 function which'll make it
>> easier to add on SLCD support.
>>
>> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
>> ---
>>  drivers/video/jz4740_fb.c |   82 +++++++++++++++++++++-----------------------
>>  1 files changed, 39 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
>> index 7e61e68..65741d0 100644
>> --- a/drivers/video/jz4740_fb.c
>> +++ b/drivers/video/jz4740_fb.c
>> @@ -178,59 +178,60 @@ static const struct jz_gpio_bulk_request jz_lcd_data_pins[] = {
>>  	JZ_GPIO_BULK_PIN(LCD_DATA17),
>>  };
>>  
>> -static unsigned int jzfb_num_ctrl_pins(struct jzfb *jzfb)
>> +enum jzfb_pin_operation {
>> +	REQUEST_PINS,
>> +	FREE_PINS,
>> +	RESUME_PINS,
>> +	SUSPEND_PINS,
>> +};
> Please add a JZFB_ prefix.

Ok.

-- 
Maurus Cuelenaere

