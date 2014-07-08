From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 08 Jul 2014 07:30:16 +0000
Subject: Re: [PATCH 01/12] ARM: OMAP2+: Remove non working OMAP HDMI audio initialization
Message-Id: <53BB9E08.7090802@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1403807781.git.jsarha@ti.com> <b0764a3af8181db55db046d6139119def363e8eb.1403807781.git.jsarha@ti.com> <20140707114625.GT28884@atomide.com>
In-Reply-To: <20140707114625.GT28884@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tony Lindgren <tony@atomide.com>, Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi

Hi Tony,

On 07/07/2014 02:46 PM, Tony Lindgren wrote:
> * Jyri Sarha <jsarha@ti.com> [140626 12:26]:
>> This code is not working currently and it can be removed. There is a
>> conflict in sharing resources with the actual HDMI driver and with
>> the ASoC HDMI audio DAI driver.
>=20
> Is this OK to queue for v3.17 or do we need this for v3.16-rc series?

Jyri is away currently, but I think it would be great if this patch goes in
for 3.16. The patch does not introduce regression since the OMAP4/5 HDMI is=
 in
non working state in the kernel so removing the platform device right now w=
ill
ease up the merger of the new and working code.

Regards,
P=E9ter

>=20
> Regards,
>=20
> Tony
> =20
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>>  arch/arm/mach-omap2/devices.c |   28 ----------------------------
>>  1 file changed, 28 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices=
.c
>> index 592ba0a..b6f8f34 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -297,33 +297,6 @@ static void omap_init_audio(void)
>>  static inline void omap_init_audio(void) {}
>>  #endif
>> =20
>> -#if defined(CONFIG_SND_OMAP_SOC_OMAP_HDMI) || \
>> -		defined(CONFIG_SND_OMAP_SOC_OMAP_HDMI_MODULE)
>> -
>> -static struct platform_device omap_hdmi_audio =3D {
>> -	.name	=3D "omap-hdmi-audio",
>> -	.id	=3D -1,
>> -};
>> -
>> -static void __init omap_init_hdmi_audio(void)
>> -{
>> -	struct omap_hwmod *oh;
>> -	struct platform_device *pdev;
>> -
>> -	oh =3D omap_hwmod_lookup("dss_hdmi");
>> -	if (!oh)
>> -		return;
>> -
>> -	pdev =3D omap_device_build("omap-hdmi-audio-dai", -1, oh, NULL, 0);
>> -	WARN(IS_ERR(pdev),
>> -	     "Can't build omap_device for omap-hdmi-audio-dai.\n");
>> -
>> -	platform_device_register(&omap_hdmi_audio);
>> -}
>> -#else
>> -static inline void omap_init_hdmi_audio(void) {}
>> -#endif
>> -
>>  #if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
>> =20
>>  #include <linux/platform_data/spi-omap2-mcspi.h>
>> @@ -459,7 +432,6 @@ static int __init omap2_init_devices(void)
>>  	 */
>>  	omap_init_audio();
>>  	omap_init_camera();
>> -	omap_init_hdmi_audio();
>>  	omap_init_mbox();
>>  	/* If dtb is there, the devices will be created dynamically */
>>  	if (!of_have_populated_dt()) {
>> --=20
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>


