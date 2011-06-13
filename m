From: "Ghongdemath, Girish" <girishsg@ti.com>
Date: Mon, 13 Jun 2011 16:37:01 +0000
Subject: Re: [PATCHv2 01/28] OMAP: change get_context_loss_count ret value to int
Message-Id: <BANLkTimi0RZ8Fe7VpY9J7dMPH6tpVzf=dw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
	<1307627810-3768-2-git-send-email-tomi.valkeinen@ti.com>
	<1307958710.1847.56.camel@deskari>
In-Reply-To: <1307958710.1847.56.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: paul@pwsan.com, linux-fbdev@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>

Tomi,
Couple of queries,

On Mon, Jun 13, 2011 at 4:51 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wro=
te:
> Paul, can you take this patch and queue it for an rc?
>
> =A0Tomi
>
> On Thu, 2011-06-09 at 16:56 +0300, Tomi Valkeinen wrote:
>> get_context_loss_count functions return context loss count as u32, and
>> zero means an error. However, zero is also returned when context has
>> never been lost and could also be returned when the context loss count
>> has wrapped and goes to zero.
>>
>> Change the functions to return an int, with negative value meaning an
>> error.
>>

>> + =A0 =A0 =A0 =A0 =A0 =A0 if (off_mode_enabled) {

- why have a check for off_mode_enabled? As this only detects valid
next state for MPU/CORE. Other pwrdm can still
hit OFF.


>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Context loss count has to=
 be a non-negative value.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Clear the sign bit to get=
 a value range from 0 to
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* INT_MAX.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count &=3D INT_MAX;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dummy_context_loss_counter =3D=
 count;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }

- Why not use u32 instead?


Regards,
Girish

>>
>> =A0 =A0 =A0 pr_debug("OMAP PM: context loss count for dev %s =3D %d\n",
>> @@ -337,7 +347,7 @@ u32 omap_pm_get_dev_context_loss_count(struct device=
 *dev)
>>
>> =A0#else
>>
>> -u32 omap_pm_get_dev_context_loss_count(struct device *dev)
>> +int omap_pm_get_dev_context_loss_count(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 return dummy_context_loss_counter;
>> =A0}
>> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_=
device.c
>> index 9bbda9a..9753f71 100644
>> --- a/arch/arm/plat-omap/omap_device.c
>> +++ b/arch/arm/plat-omap/omap_device.c
>> @@ -310,7 +310,7 @@ static void _add_optional_clock_clkdev(struct omap_d=
evice *od,
>> =A0 * return the context loss counter for that hwmod, otherwise return
>> =A0 * zero.
>> =A0 */
>> -u32 omap_device_get_context_loss_count(struct platform_device *pdev)
>> +int omap_device_get_context_loss_count(struct platform_device *pdev)
>> =A0{
>> =A0 =A0 =A0 struct omap_device *od;
>> =A0 =A0 =A0 u32 ret =3D 0;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
