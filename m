From: Russ Dill <Russ.Dill@ti.com>
Date: Wed, 09 May 2012 22:50:07 +0000
Subject: Re: [PATCH] OMAPDSS: TFP410: use gpio_set_value_cansleep
Message-Id: <CA+Bv8Xa+1RJ5QTn=vO4GSw1VtUZc3xX0J5qBVshvV5Dj+9uZVA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336601288-27848-1-git-send-email-Russ.Dill@ti.com>
	<20120509221447.GY5088@atomide.com>
In-Reply-To: <20120509221447.GY5088@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wed, May 9, 2012 at 3:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Russ Dill <Russ.Dill@ti.com> [120509 15:12]:
>> The Beagleboard xM gpio used for TFP410 powerdown is connected through
>> an I2C attached chip which means setting the GPIO can sleep. Code that
>> calls tfp410_power_on/off holds a mutex, so sleeping should be fine.
>
> What's the error without this patch? Or just no display?
>
> Just wondering if it's safe to merge Tomi's clean up series to
> arm-soc tree..

The only platform that has a problem is Beagleboard xM, and that is
only after 'ARM: OMAP: Cleanup Beagleboard DVI reset gpio' is applied.
Since the context actually can sleep, the only consequence is a
WARN_ON statement.

So yes, it should be safe.

>> Signed-off-by: Russ Dill <Russ.Dill@ti.com>
>> ---
>>  drivers/video/omap2/displays/panel-tfp410.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
>> index 52637fa..1266520 100644
>> --- a/drivers/video/omap2/displays/panel-tfp410.c
>> +++ b/drivers/video/omap2/displays/panel-tfp410.c
>> @@ -68,7 +68,7 @@ static int tfp410_power_on(struct omap_dss_device *dssdev)
>>               goto err0;
>>
>>       if (gpio_is_valid(ddata->pd_gpio))
>> -             gpio_set_value(ddata->pd_gpio, 1);
>> +             gpio_set_value_cansleep(ddata->pd_gpio, 1);
>>
>>       return 0;
>>  err0:
>> @@ -83,7 +83,7 @@ static void tfp410_power_off(struct omap_dss_device *dssdev)
>>               return;
>>
>>       if (gpio_is_valid(ddata->pd_gpio))
>> -             gpio_set_value(ddata->pd_gpio, 0);
>> +             gpio_set_value_cansleep(ddata->pd_gpio, 0);
>>
>>       omapdss_dpi_display_disable(dssdev);
>>  }
>> --
>> 1.7.10
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
