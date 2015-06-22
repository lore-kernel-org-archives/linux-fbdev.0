From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Mon, 22 Jun 2015 15:23:53 +0000
Subject: Re: [PATCH 00/21] On-demand device registration
Message-Id: <CAAObsKCdv_X+YPFacO7NjbRMnvuDisAmiQOWE-Xb3xFFrn6Qog@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_Jsq+EWLEJhRudTGAwYsOg4tX2-pGhygeQGHae9RL8rBpMiA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+EWLEJhRudTGAwYsOg4tX2-pGhygeQGHae9RL8rBpMiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rob Herring <robherring2@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Alexander Holler <holler@ahsoftware.de>, linux-clk@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry>

On 28 May 2015 at 06:33, Rob Herring <robherring2@gmail.com> wrote:
> On Mon, May 25, 2015 at 9:53 AM, Tomeu Vizoso
> <tomeu.vizoso@collabora.com> wrote:
>> Hello,
>>
>> I have a problem with the panel on my Tegra Chromebook taking longer than
>> expected to be ready during boot (St=C3=A9phane Marchesin reported what =
is
>> basically the same issue in [0]), and have looked into ordered probing a=
s a
>> better way of solving this than moving nodes around in the DT or playing=
 with
>> initcall levels.
>>
>> While reading the thread [1] that Alexander Holler started with his seri=
es to
>> make probing order deterministic, it occurred to me that it should be po=
ssible
>> to achieve the same by registering devices as they are referenced by oth=
er
>> devices.
>
> I like the concept and novel approach.
>
>> This basically reuses the information that is already implicit in the pr=
obe()
>> implementations, saving us from refactoring existing drivers or adding
>> information to DTBs.
>>
>> Something I'm not completely happy with is that I have had to move the c=
all to
>> of_platform_populate after all platform drivers have been registered.
>> Otherwise I don't see how I could register drivers on demand as we don't=
 have
>> yet each driver's compatible strings.
>
> Yeah, this is the opposite of what we'd really like.

Can you elaborate on the reasons why we would like to have devices
registered before built-in drivers finish registering, even if we
don't probe them yet?

> Ideally, we would
> have a solution that works for modules too. However, we're no worse
> off. We pretty much build-in dependencies to avoid module ordering
> problems.

Nod, I haven't looked yet at requesting modules on-demand, but I guess
it should be doable. Modules that have dependencies described in the
firmware should get them probed automatically already though.

> Perhaps we need to make the probing on-demand rather than simply on
> device<->driver match occurring.

I'm afraid that too much old code depends on that. For example, Rafael
pointed out to the PNP subsystem, which registers a driver that will
probe devices with the EISA ID PNP0c02 to reserve memory regions for
devices that will be probed later.

http://lxr.free-electrons.com/source/drivers/pnp/system.c

My understanding is that probing of PNP0c02 devices must happen before
the actual devices that depend on those regions are probed, so if we
decoupled the probing from the driver/device registration, we would be
breaking that assumption.

>> For machs that don't move of_platform_populate() to a later point, these
>> patches shouldn't cause any problems but it's not guaranteed that we'll =
avoid
>> all the deferred probes as some drivers may not be registered yet.
>
> Ideally, of_platform_populate is not explicitly called by each
> platform. So I think we need to make this work for the default case.

The problem is that some platforms will need fixing because some
initcalls assume that some devices will have been registered already,
or even probed. I think removing those assumptions shouldn't be
problematic because I haven't had much trouble with this on the four
platforms I have tested with, but I cannot test every board that is
supported upstream.

I can ask though the KernelCI folks to boot my branch in all their
boards and make sure that those work when of_platform_populate is
called in late_initcall.

http://kernelci.org/boot/all/job/next/kernel/next-20150619/

>> I have tested this on boards with Tegra, iMX.6 and Exynos SoCs, and these
>> patches were enough to eliminate all the deferred probes.
>>
>> With this series I get the kernel to output to the panel in 0.5s, instea=
d of 2.8s.
>
> That's certainly compelling.

Have to say that those numbers are with the serial console enabled
(without, it's 0.5s vs 1.5s), but on machines that take longer to boot
we should see bigger gains because we won't be sending devices to the
end of the queue when their probe is deferred.

Regards,

Tomeu

> Rob
>
>>
>> Regards,
>>
>> Tomeu
>>
>> [0] http://lists.freedesktop.org/archives/dri-devel/2014-August/066527.h=
tml
>>
>> [1] https://lkml.org/lkml/2014/5/12/452
>>
>> Tomeu Vizoso (21):
>>   regulator: core: Reduce critical area in _regulator_get
>>   ARM: tegra: Add gpio-ranges property
>>   ARM: tegra: Register drivers before devices
>>   ARM: EXYNOS: Register drivers before devices
>>   ARM i.MX6q: Register drivers before devices
>>   of/platform: Add of_platform_device_ensure()
>>   of/platform: Ensure device registration on lookup
>>   gpio: Probe GPIO drivers on demand
>>   gpio: Probe pinctrl devices on demand
>>   regulator: core: Probe regulators on demand
>>   drm: Probe panels on demand
>>   drm/tegra: Probe dpaux devices on demand
>>   i2c: core: Probe i2c master devices on demand
>>   pwm: Probe PWM chip devices on demand
>>   backlight: Probe backlight devices on demand
>>   usb: phy: Probe phy devices on demand
>>   clk: Probe clk providers on demand
>>   pinctrl: Probe pinctrl devices on demand
>>   phy: core: Probe phy providers on demand
>>   dma: of: Probe DMA controllers on demand
>>   power-supply: Probe power supplies on demand
>>
>>  arch/arm/boot/dts/tegra124.dtsi     |  1 +
>>  arch/arm/mach-exynos/exynos.c       |  4 +--
>>  arch/arm/mach-imx/mach-imx6q.c      | 12 ++++-----
>>  arch/arm/mach-tegra/tegra.c         | 21 ++++++---------
>>  drivers/clk/clk.c                   |  3 +++
>>  drivers/dma/of-dma.c                |  3 +++
>>  drivers/gpio/gpiolib-of.c           |  5 ++++
>>  drivers/gpu/drm/drm_panel.c         |  3 +++
>>  drivers/gpu/drm/tegra/dpaux.c       |  3 +++
>>  drivers/i2c/i2c-core.c              |  3 +++
>>  drivers/of/platform.c               | 53 ++++++++++++++++++++++++++++++=
+++++++
>>  drivers/phy/phy-core.c              |  3 +++
>>  drivers/pinctrl/devicetree.c        |  2 ++
>>  drivers/power/power_supply_core.c   |  3 +++
>>  drivers/pwm/core.c                  |  3 +++
>>  drivers/regulator/core.c            | 45 +++++++++++++++----------------
>>  drivers/usb/phy/phy.c               |  3 +++
>>  drivers/video/backlight/backlight.c |  3 +++
>>  include/linux/of_platform.h         |  2 ++
>>  19 files changed, 130 insertions(+), 45 deletions(-)
>>
>> --
>> 2.4.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
