From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Date: Wed, 03 Jun 2015 19:57:24 +0000
Subject: Re: [PATCH 00/21] On-demand device registration
Message-Id: <556F5C24.1030101@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com> <CAL_Jsq+EWLEJhRudTGAwYsOg4tX2-pGhygeQGHae9RL8rBpMiA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+EWLEJhRudTGAwYsOg4tX2-pGhygeQGHae9RL8rBpMiA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, =?UTF-8?B?U3TDqXBoYW5lIE1hcmNoZXNpbg==?= <stephane.marchesin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>linux

Hi Tomeu,

On 05/28/2015 07:33 AM, Rob Herring wrote:
> On Mon, May 25, 2015 at 9:53 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com=
> wrote:
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
>=20
> I like the concept and novel approach.
>=20
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
>=20
> Yeah, this is the opposite of what we'd really like. Ideally, we would
> have a solution that works for modules too. However, we're no worse
> off. We pretty much build-in dependencies to avoid module ordering
> problems.
>=20
> Perhaps we need to make the probing on-demand rather than simply on
> device<->driver match occurring.
>=20
>> For machs that don't move of_platform_populate() to a later point, these
>> patches shouldn't cause any problems but it's not guaranteed that we'll =
avoid
>> all the deferred probes as some drivers may not be registered yet.
>=20
> Ideally, of_platform_populate is not explicitly called by each
> platform. So I think we need to make this work for the default case.
>=20
>> I have tested this on boards with Tegra, iMX.6 and Exynos SoCs, and these
>> patches were enough to eliminate all the deferred probes.
>>
>> With this series I get the kernel to output to the panel in 0.5s, instea=
d of 2.8s.
>=20
> That's certainly compelling.

I've found your idea about moving device registration later during System b=
oot
very interesting so I've decided to try it on dra7-evem (TI) :).
It's good to know time during Kernel boot when we can assume that all drive=
rs are
ready for probing, so there are more ways to control probing order.

Pls, Note here that TI OMAP2+ mach is not pure DT mach - it's combination of
DT and not DT devices/drivers.

Ok. So What was done...

LKML Linux 4.1-rc3 (a simple case)
1) use your patches 3/4 as reference (only these two patches :)
2) move of_platform_populate later at device_initcall_sync time
Boot time reduction ~0.4 sec


TI Android Kernel 3.14 (NOT a simple case)
1) use your patches 3/4 as reference (only these two patches :)
2) move of_platform_populate later at device_initcall_sync time
3) make it to boot (not sure I've fixed all issues, but those which
   break the System boot):
 - split non-DT and DT devices registration in platform code;
 - keep non-DT devices registration from .init_machine() [arch_initcall]
 - move DT-devices registration at device_initcall_sync time
 - fix drivers which use platform_driver_probe().
   Note. Now there are at about ~190 occurrences of this macro in Kernel.
 - re-order few devices in DT (4 devices)
 - fix one driver which uses of_find_device_by_node() wrongly
   Note. This API is used some times with assumption that
   requested dev has been probed already.
Boot time reduction ~0.3 sec. Probing of some devices are still deferred.

TI Android Kernel 3.14 + of_platform_device_ensure
1) backport of_platform_device_ensure() (also need patches=20
   "of: Introduce device tree node flag helpers" and=20
   "of: Keep track of populated platform devices")
2) back-port all your patches which uses of_platform_device_ensure()
3) make it to boot:
   - drop patch dma: of: Probe DMA controllers on demand
   - fix deadlock in regulator core:
   regulator_dev_lookup() called from regulator_register() in K3.14
4) get rid of deferred probes - add of_platform_device_ensure() calls in:
   - drivers/video/fbdev/omap2/dss/output.c
   - drivers/extcon/extcon-class.c

 Boot time reduction: NONE !?


So few comments from above:
- registering devices later during the System boot may improve boot time.
  But resolving of all deferred probes may NOT improve boot time ;)=20
  Have you seen smth like this?

- usage of of_platform_device_ensure() will require continuous fixing of Ke=
rnel :(

- late_initcall is not (as for me not safe) a good time to register devices=
. A lot
  of platforms/subsystems/frameworks perform their final initialization or =
clean-up
  steps, with assumption that System mostly ready to work. For example, CPU=
Idle/CPUFreq
  are allowed and other PM staff. CPUIdle and driver's probing are not frie=
nds.

What would be nice to have for now in my opinion:
- some useful place to move device population code.
  May be machine_desc->init_device_sync() callback.
- some optional feature in DTC which will allow to re-arrange DT nodes for =
levels 0(root)
  and 1(simple-bus) using standard or widely used bindings (gpio, regulator=
s, clocks, dma,
  pinctrl, irqs).

Additional note:
- Changing device's registration order will change devices's order in
 dpm_list (drivers/base/power/main.c) and devices_kset list
 (drivers/base/core.c). This might potentially affect on suspend [1] and sh=
utdown.=20
[1] https://lkml.org/lkml/2014/12/12/324


--=20
regards,
-grygorii
