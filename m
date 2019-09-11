From: Dan Murphy <dmurphy@ti.com>
Date: Wed, 11 Sep 2019 18:48:36 +0000
Subject: Re: [PATCH v2 2/2] backlight: lm3630a: add an enable gpio for the HWEN pin
Message-Id: <a3f10318-11f4-3b78-47e5-d9add8a46791@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190910212909.18095-1-andreas@kemnade.info>
 <20190910212909.18095-3-andreas@kemnade.info>
 <20190911102533.not4ta3xwgm6bhjo@holly.lan>
In-Reply-To: <20190911102533.not4ta3xwgm6bhjo@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>, Andreas Kemnade <andreas@kemnade.info>
Cc: lee.jones@linaro.org, jingoohan1@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>


On 9/11/19 5:25 AM, Daniel Thompson wrote:
> On Tue, Sep 10, 2019 at 11:29:09PM +0200, Andreas Kemnade wrote:
>> For now just enable it in the probe function to allow i2c
>> access. Disabling also means resetting the register values
>> to default and according to the datasheet does not give
>> power savings
>>
>> Tested on Kobo Clara HD.
>>
>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>> ---
>> changes in v2:
>> - simplification
>> - correct gpio direction initialisation
>>
>>   drivers/video/backlight/lm3630a_bl.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
>> index 8f84f3684f04..9d0639d4202d 100644
>> --- a/drivers/video/backlight/lm3630a_bl.c
>> +++ b/drivers/video/backlight/lm3630a_bl.c
>> @@ -12,6 +12,8 @@
>>   #include <linux/uaccess.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/regmap.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/gpio.h>
> Nitpicking... but I don't think linux/gpio.h is used anymore.
>
>
>>   #include <linux/pwm.h>
>>   #include <linux/platform_data/lm3630a_bl.h>
>>   
>> @@ -48,6 +50,7 @@ struct lm3630a_chip {
>>   	struct lm3630a_platform_data *pdata;
>>   	struct backlight_device *bleda;
>>   	struct backlight_device *bledb;
>> +	struct gpio_desc *enable_gpio;
>>   	struct regmap *regmap;
>>   	struct pwm_device *pwmd;
>>   };
>> @@ -535,6 +538,13 @@ static int lm3630a_probe(struct i2c_client *client,
>>   	}
>>   	pchip->pdata = pdata;
>>   
>> +	pchip->enable_gpio = devm_gpiod_get_optional(&client->dev, "enable",
>> +						GPIOD_OUT_HIGH);
>> +	if (IS_ERR(pchip->enable_gpio)) {
>> +		rval = PTR_ERR(pchip->enable_gpio);
>> +		return rval;

the enable gpio is optional so if it fails you log the error and move on

Also on driver removal did you want to set the GPIO to low to disable 
the device to save power?

Dan


>> +	}
>> +
>>   	/* chip initialize */
>>   	rval = lm3630a_chip_init(pchip);
>>   	if (rval < 0) {
>> -- 
>> 2.20.1
>>
