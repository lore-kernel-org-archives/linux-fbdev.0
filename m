From: Inki Dae <inki.dae@samsung.com>
Date: Wed, 01 Dec 2010 02:29:17 +0000
Subject: RE: [PATCH 3/4] S5PC110: add MIPI-DSI support for platform and machine.
Message-Id: <005101cb90ff$8d6185b0$a8249110$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1290496593-4927-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1290496593-4927-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Sylwester.

Thank you for your comments.

> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Sylwester Nawrocki
> Sent: Wednesday, December 01, 2010 7:57 AM
> To: Inki Dae
> Cc: linux-fbdev@vger.kernel.org; kgene.kim@samsung.com;
> kyungmin.park@samsung.com; lethal@linux-sh.org; akpm@linux-foundation.org;
> linux-arm-kernel@lists.infradead.org; 'Sylwester Nawrocki'
> Subject: Re: [PATCH 3/4] S5PC110: add MIPI-DSI support for platform and
> machine.
>=20
> Hi Inki,
>=20
> On 11/30/2010 02:30 AM, Inki Dae wrote:
> > Hello, Sylwester.
> > Long time no see. :)
> >
> > Thank you for your comments.
> >
> >> -----Original Message-----
> >> From: Sylwester Nawrocki [mailto:spnlinux@gmail.com]
> >> Sent: Sunday, November 28, 2010 2:07 AM
> >> To: Inki Dae
> >> Cc: linux-fbdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> >> kyungmin.park@samsung.com; kgene.kim@samsung.com; akpm@linux-
> >> foundation.org; lethal@linux-sh.org
> >> Subject: Re: [PATCH 3/4] S5PC110: add MIPI-DSI support for platform and
> >> machine.
> >>
> >> Hello,
> >>
> >> On 11/23/2010 08:16 AM, Inki Dae wrote:
> >>> clock.c
> >>> - added dsim clock gate.
> >>>
> >>> dev-dsim.c
> >>> - platform and machine specific definitions.
> >>> Now just supports only MACHINE GONI so for other machines,
> >>> mipi_1_1v_name and mipi_1_8v_name values should be changed to
> >>> proper regulator name at each machine file.
> >>>
> >>> setup-dsim.c
> >>> - platform specific definitions.
> >>>
> >>> Signed-off-by: Inki Dae<inki.dae@samsung.com>
> >>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
> >>> ---
> >>>    arch/arm/mach-s5pv210/Kconfig                   |   11 ++
> >>>    arch/arm/mach-s5pv210/Makefile                  |    2 +
> >>>    arch/arm/mach-s5pv210/clock.c                   |    6 +
> >>>    arch/arm/mach-s5pv210/dev-dsim.c                |  149
> >> +++++++++++++++++++++++
> >>>    arch/arm/mach-s5pv210/include/mach/map.h        |    4 +
> >>>    arch/arm/mach-s5pv210/include/mach/regs-clock.h |    3 +-
> >>>    arch/arm/mach-s5pv210/mach-goni.c               |   12 ++
> >>>    arch/arm/mach-s5pv210/setup-dsim.c              |  144
> >> ++++++++++++++++++++++
> >>>    arch/arm/plat-s5p/Kconfig                       |    5 +
> >>>    9 files changed, 335 insertions(+), 1 deletions(-)
> >>>    create mode 100644 arch/arm/mach-s5pv210/dev-dsim.c
> >>>    create mode 100644 arch/arm/mach-s5pv210/setup-dsim.c
> >>>
> [snip]
> >>> diff --git a/arch/arm/mach-s5pv210/dev-dsim.c b/arch/arm/mach-
> >> s5pv210/dev-dsim.c
> [snip]
> >>> +
> >>> +static struct s5p_platform_dsim dsim_platform_data =3D {
> >>> +	.clk_name		=3D "dsim",
> >>> +	.mipi_1_1v_name		=3D "vmipi_1.1v",
> >>> +	.mipi_1_8v_name		=3D "vmipi_1.8v",
> >>
> >> You could avoid passing regulator's names in here. All you need to do
> is
> >> defining regulator supplies properly (see further comments below).
> >> Creating well known (e.g. as defined in the datasheet) regulator supply
> >> names in the actual driver file (s5p-dsim.c) should be enough.
> >> The regulator API can be used to match a regulator and its consumer.
> >>
> > Regulator's name could be changed according to machine so I think should
>  > be set to Machine specific file.
>=20
> First of all it is just my suggestion, please feel free to ignore it.
>=20
> Regulator names are mostly different across machines but it is
> the *"regulator consumer supply"* names that are used for lookup in
> calls like regulator_get(). In the setup code of each machine that
> wants to use mipi-dsi you could insert an entry dedicated to your
> device into the consumers array of specific regulator.
>=20
> On the other hand, if the number of regulators needed varies across
> machines then using platform data structure for the names might be
> a solution. But that doesn't look like your case.
>=20
If it removes regulator consumer name from platform data then s5p_dsim_mipi=
_power() below should be added to machine code. In this case, every when mi=
pi-dsi driver is ported to other machines regulator consumer name in s5p_ds=
im_mipi_power() should be modified properly in other words, s5p_dsim_mipi_p=
ower() couldn't be used commonly. if platform data includes regulator consu=
mer name then it is done just only changing consumer name to machine specif=
ic and also s5p_dsim_mipi_power() could be used commonly. If I missed thing=
s then please feel free to give me your opinion.

> >>> +	.dsim_info		=3D&dsim_info,
> >>> +	.dsim_lcd_info		=3D&dsim_lcd_info,
> >>> +
> >>> +	.mipi_power		=3D s5p_dsim_mipi_power,
> >>> +	.part_reset		=3D s5p_dsim_part_reset,
> >>> +	.init_d_phy		=3D s5p_dsim_init_d_phy,
> >>> +	.get_fb_frame_done	=3D NULL,
> >>> +	.trigger		=3D NULL,
> >>> +
> >>> +	.platform_rev		=3D 1,
> >>> +
> >>> +	/*
> >>> +	 * the stable time of needing to write data on SFR
> >>> +	 * when the mipi mode becomes LP mode.
> >>> +	 */
> >>> +	.delay_for_stabilization =3D 600,
> >>> +};
> >>> +
> >>> +struct platform_device s5p_device_dsim =3D {
> >>> +	.name			=3D "s5p-dsim",
> >>> +	.id			=3D 0,
> >>> +	.num_resources		=3D ARRAY_SIZE(s5p_dsim_resource),
> >>> +	.resource		=3D s5p_dsim_resource,
> >>> +	.dev			=3D {
> >>> +		.platform_data =3D (void *)&dsim_platform_data,
> >>> +	},
> >>> +};
> >>> diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-
> >> s5pv210/include/mach/map.h
> >>> index 861d7fe..1ad2dad 100644
> >>> --- a/arch/arm/mach-s5pv210/include/mach/map.h
> >>> +++ b/arch/arm/mach-s5pv210/include/mach/map.h
> >>> @@ -69,6 +69,10 @@
> >>>
> >>>    #define S5PV210_PA_FB		(0xF8000000)
> >>>
> >>> +/* MIPI-DSI */
> >>> +#define S5PV210_PA_DSI		(0xFA500000)
> >>> +#define S5PV210_SZ_DSI		SZ_1M
> >>
> >> How about removing S5PV210_SZ_DSI and directly using SZ_1M in dev-
> dsim.c
> >> ? Also, 1MB is probably excessive.
> >>
> >>> +
> >>>    #define S5PV210_PA_FIMC0	(0xFB200000)
> >>>    #define S5PV210_PA_FIMC1	(0xFB300000)
> >>>    #define S5PV210_PA_FIMC2	(0xFB400000)
> >>> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> >> b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> >>> index ebaabe0..c8b9366 100644
> >>> --- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> >>> +++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> >>> @@ -196,7 +196,8 @@
> >>>    #define S5P_OTHERS_USB_SIG_MASK		(1<<   16)
> >>>
> >>>    /* MIPI */
> >>> -#define S5P_MIPI_DPHY_EN		(3)
> >>> +#define S5P_MIPI_DPHY_EN		(3<<   0)
> >>> +#define S5P_MIPI_M_RESETN		(1<<   1)
> >>>
> >>>    /* S5P_DAC_CONTROL */
> >>>    #define S5P_DAC_ENABLE			(1)
> >>> diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-
> >> s5pv210/mach-goni.c
> >>> index b1dcf96..500cc1b 100644
> >>> --- a/arch/arm/mach-s5pv210/mach-goni.c
> >>> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> >>> @@ -269,10 +269,18 @@ static void __init goni_tsp_init(void)
> >>>    /* MAX8998 regulators */
> >>>    #if defined(CONFIG_REGULATOR_MAX8998) ||
> >> defined(CONFIG_REGULATOR_MAX8998_MODULE)
> >>>
> >>> +static struct regulator_consumer_supply goni_ldo3_consumers[] =3D {
> >>> +	REGULATOR_SUPPLY("vmipi_1.1v", ""),
> >>> +};
> >>
> >> You could just do:
> >> 	REGULATOR_SUPPLY("vmipi_1.1v", "s5p-dsim.0"),
> >>
> >> The second argument is used to match your consumer device with the
> >> relevant regulator supply.
> >>
> > Ok, it would be corrected.
> >
> >> Similar could be done in other machine's board setup files and there is
> >> no need to pass anything in the platform data.
> >>
> >> Then in your driver probe you might just do:
> >>
> >> ... =3D regulator_get(&pdev->dev, "vmipi_1.1v");
> >>
> > I mentioned before.
> >>> +
> >>>    static struct regulator_consumer_supply goni_ldo5_consumers[] =3D {
> >>>    	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.0"),
> >>>    };
> >>>
> >>> +static struct regulator_consumer_supply goni_ldo7_consumers[] =3D {
> >>> +	REGULATOR_SUPPLY("vmipi_1.8v", ""),
> >>> +};
> >>
> >> Ditto.
> >>
> >>> +
> >>>    static struct regulator_init_data goni_ldo2_data =3D {
> >>>    	.constraints	=3D {
> >>>    		.name		=3D "VALIVE_1.1V",
> >>> @@ -294,6 +302,8 @@ static struct regulator_init_data goni_ldo3_data =
> {
> >>>    		.apply_uV	=3D 1,
> >>>    		.always_on	=3D 1,
> >>>    	},
> >>> +	.num_consumer_supplies =3D ARRAY_SIZE(goni_ldo3_consumers),
> >>> +	.consumer_supplies =3D goni_ldo3_consumers,
> >>>    };
> >>>
> >>>    static struct regulator_init_data goni_ldo4_data =3D {
> >>> @@ -333,6 +343,8 @@ static struct regulator_init_data goni_ldo7_data =
> {
> >>>    		.apply_uV	=3D 1,
> >>>    		.always_on	=3D 1,
> >>>    	},
> >>> +	.num_consumer_supplies =3D ARRAY_SIZE(goni_ldo7_consumers),
> >>> +	.consumer_supplies =3D goni_ldo7_consumers,
> >>>    };
> >>>
> >>>    static struct regulator_init_data goni_ldo8_data =3D {
> >>> diff --git a/arch/arm/mach-s5pv210/setup-dsim.c b/arch/arm/mach-
> >> s5pv210/setup-dsim.c
> >>> new file mode 100644
> >>> index 0000000..874efa0
> >>> --- /dev/null
> >>> +++ b/arch/arm/mach-s5pv210/setup-dsim.c
> >>> @@ -0,0 +1,144 @@
> [snip]
> >>> +
> >>> +int s5p_dsim_mipi_power(struct dsim_global *dsim, struct regulator
> >> *p_mipi_1_1v,
> >>> +	struct regulator *p_mipi_1_8v, unsigned int enable)
> >>> +{
> >>> +	int ret =3D -1;
> >>> +
> >>> +	WARN_ON(dsim =3D NULL);
> >>> +
> >>> +	if (IS_ERR(p_mipi_1_1v) || IS_ERR(p_mipi_1_8v)) {
> >>> +		dev_err(dsim->dev, "p_mipi_1_1v or p_mipi_1_8v is NULL.\n");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	if (enable) {
> >>> +		if (p_mipi_1_1v)
> >>> +			ret =3D regulator_enable(p_mipi_1_1v);
> >>> +
> >>> +		if (ret<   0) {
> >>> +			dev_err(dsim->dev,
> >>> +				"failed to enable regulator mipi_1_1v.\n");
> >>> +			return ret;
> >>> +		}
> >>> +
> >>> +		if (p_mipi_1_8v)
> >>> +			ret =3D regulator_enable(p_mipi_1_8v);
> >>> +
> >>> +		if (ret<   0) {
> >>> +			dev_err(dsim->dev,
> >>> +				"failed to enable regulator mipi_1_8v.\n");
> >>> +			return ret;
> >>> +		}
> >>> +	} else {
> >>> +		if (p_mipi_1_1v)
> >>> +			ret =3D regulator_force_disable(p_mipi_1_1v);
> >>> +		if (ret<   0) {
> >>> +			dev_err(dsim->dev,
> >>> +				"failed to disable regulator mipi_1_1v.\n");
> >>> +			return ret;
> >>> +		}
> >>> +
> >>> +		if (p_mipi_1_8v)
> >>> +			ret =3D regulator_force_disable(p_mipi_1_8v);
> >>> +		if (ret<   0) {
> >>> +			dev_err(dsim->dev,
> >>> +				"failed to disable regulator mipi_1_8v.\n");
> >>> +			return ret;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	return ret;
> >>> +}
> >>
> >> This function seem to be called only in the driver and it uses driver's
> >> (private?) data, so can you explain what is the purpose of having it in
> >> arch?
> >> I suspect all the above regulator handling code could well be moved to
> >> the driver. Am I missing something?
> >>
> > As I said above, regulator's name is specific to machine so it would be
>  > got by driver's probe and then controlled by driver.
>=20
> Unless you plan to use mipi_power callback outside of the driver I
> don't see a good reason for having it here.
>=20
> Also you are not behaving nice by using regulator_force_disable().
> IIRC it should be used only as a last resort, in critical situations.
> If the mipi-dsi subsystem shares regulator with other device you will
> be cutting off other device's power anytime you are disabling supply
> of mipi-csi. Just imagine that this "other device" is the cpu core..
>=20
> > Note that some machine doesn=E2=80=99t use regulator(gpio instead of re=
gulator)
>=20
> For those you could define the fixed voltage regulator if appropriate
> and you would also get at the same time the reference counting.
>=20
Your pointing out is good. Definitely it's my mistake. Using regulator_forc=
e_disable() is critical. I will correct it. And also as you said, gpio coul=
d be used by regulator framework with fixed voltage regulator.
>=20
> --
> Regards,
> Sylwester
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

