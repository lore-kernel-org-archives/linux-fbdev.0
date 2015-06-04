From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Thu, 04 Jun 2015 08:39:30 +0000
Subject: Re: [PATCH 00/21] On-demand device registration
Message-Id: <CAAObsKAFQrm-maqzadCELi2JVt5jd+yoqCbDpu5OP7gkSk8gcA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_Jsq+EWLEJhRudTGAwYsOg4tX2-pGhygeQGHae9RL8rBpMiA@mail.gmail.com>
 <556F5C24.1030101@linaro.org>
In-Reply-To: <556F5C24.1030101@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Alexander Holler <holler@ahsoftware.de>, linux-clk@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>Linux USB List <linux->

On 3 June 2015 at 21:57, Grygorii.Strashko@linaro.org
<grygorii.strashko@linaro.org> wrote:
> Hi Tomeu,
>
> On 05/28/2015 07:33 AM, Rob Herring wrote:
>> On Mon, May 25, 2015 at 9:53 AM, Tomeu Vizoso <tomeu.vizoso@collabora.co=
m> wrote:
>>> I have a problem with the panel on my Tegra Chromebook taking longer th=
an
>>> expected to be ready during boot (St=C3=A9phane Marchesin reported what=
 is
>>> basically the same issue in [0]), and have looked into ordered probing =
as a
>>> better way of solving this than moving nodes around in the DT or playin=
g with
>>> initcall levels.
>>>
>>> While reading the thread [1] that Alexander Holler started with his ser=
ies to
>>> make probing order deterministic, it occurred to me that it should be p=
ossible
>>> to achieve the same by registering devices as they are referenced by ot=
her
>>> devices.
>>
>> I like the concept and novel approach.
>>
>>> This basically reuses the information that is already implicit in the p=
robe()
>>> implementations, saving us from refactoring existing drivers or adding
>>> information to DTBs.
>>>
>>> Something I'm not completely happy with is that I have had to move the =
call to
>>> of_platform_populate after all platform drivers have been registered.
>>> Otherwise I don't see how I could register drivers on demand as we don'=
t have
>>> yet each driver's compatible strings.
>>
>> Yeah, this is the opposite of what we'd really like. Ideally, we would
>> have a solution that works for modules too. However, we're no worse
>> off. We pretty much build-in dependencies to avoid module ordering
>> problems.
>>
>> Perhaps we need to make the probing on-demand rather than simply on
>> device<->driver match occurring.
>>
>>> For machs that don't move of_platform_populate() to a later point, these
>>> patches shouldn't cause any problems but it's not guaranteed that we'll=
 avoid
>>> all the deferred probes as some drivers may not be registered yet.
>>
>> Ideally, of_platform_populate is not explicitly called by each
>> platform. So I think we need to make this work for the default case.
>>
>>> I have tested this on boards with Tegra, iMX.6 and Exynos SoCs, and the=
se
>>> patches were enough to eliminate all the deferred probes.
>>>
>>> With this series I get the kernel to output to the panel in 0.5s, inste=
ad of 2.8s.
>>
>> That's certainly compelling.
>
> I've found your idea about moving device registration later during System=
 boot
> very interesting so I've decided to try it on dra7-evem (TI) :).
> It's good to know time during Kernel boot when we can assume that all dri=
vers are
> ready for probing, so there are more ways to control probing order.

Thanks, though right now I'm following Rob's suggestion and only delay
probing, not registration. The patch is really simple (applies on
linux-next, with async probing):

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 8da8e07..7e6b1e1 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -407,6 +407,11 @@ int driver_probe_device(struct device_driver
*drv, struct device *dev)
        if (!device_is_registered(dev))
                return -ENODEV;

+       if (!driver_deferred_probe_enable) {
+               driver_deferred_probe_add(dev);
+               return 0;
+       }
+
        pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
                 drv->bus->name, __func__, dev_name(dev), drv->name);

@@ -585,7 +590,7 @@ EXPORT_SYMBOL_GPL(device_attach);

 void device_initial_probe(struct device *dev)
 {
-       __device_attach(dev, true);
+       __device_attach(dev, driver_deferred_probe_enable);
 }

 static int __driver_attach(struct device *dev, void *data)

> Pls, Note here that TI OMAP2+ mach is not pure DT mach - it's combination=
 of
> DT and not DT devices/drivers.
>
> Ok. So What was done...
>
> LKML Linux 4.1-rc3 (a simple case)
> 1) use your patches 3/4 as reference (only these two patches :)
> 2) move of_platform_populate later at device_initcall_sync time
> Boot time reduction ~0.4 sec

I'm a bit surprised at such a big improvement. May I ask how you are
measuring it?

> TI Android Kernel 3.14 (NOT a simple case)
> 1) use your patches 3/4 as reference (only these two patches :)
> 2) move of_platform_populate later at device_initcall_sync time
> 3) make it to boot (not sure I've fixed all issues, but those which
>    break the System boot):
>  - split non-DT and DT devices registration in platform code;
>  - keep non-DT devices registration from .init_machine() [arch_initcall]
>  - move DT-devices registration at device_initcall_sync time
>  - fix drivers which use platform_driver_probe().
>    Note. Now there are at about ~190 occurrences of this macro in Kernel.
>  - re-order few devices in DT (4 devices)
>  - fix one driver which uses of_find_device_by_node() wrongly
>    Note. This API is used some times with assumption that
>    requested dev has been probed already.
> Boot time reduction ~0.3 sec. Probing of some devices are still deferred.

I got no deferred probes on a pandaboard with just these changes:

https://git.collabora.com/cgit/user/tomeu/linux.git/commit/?id=1586c6f50b3d=
3c65dc219a3cdc3327d798cabca6

> TI Android Kernel 3.14 + of_platform_device_ensure
> 1) backport of_platform_device_ensure() (also need patches
>    "of: Introduce device tree node flag helpers" and
>    "of: Keep track of populated platform devices")
> 2) back-port all your patches which uses of_platform_device_ensure()
> 3) make it to boot:
>    - drop patch dma: of: Probe DMA controllers on demand
>    - fix deadlock in regulator core:
>    regulator_dev_lookup() called from regulator_register() in K3.14
> 4) get rid of deferred probes - add of_platform_device_ensure() calls in:
>    - drivers/video/fbdev/omap2/dss/output.c
>    - drivers/extcon/extcon-class.c
>
>  Boot time reduction: NONE !?
>
> So few comments from above:
> - registering devices later during the System boot may improve boot time.
>   But resolving of all deferred probes may NOT improve boot time ;)
>   Have you seen smth like this?

Yeah, I don't really expect for on-demand probing to improve boot time
much in the general case, as drivers tend to first acquire resources
(and defer probe if needed) and only then access hardware and wait for
stuff to happen.

The main advantage of ordered/ondemand probing is that it is much
easier to see the order in which devices will be bound. In my case
this is useful because one could get one device (eg. the drm panel) to
probe very early by just moving that node to the beginning of the DT.
With deferred probe, one would have to figure out all the dependencies
and shuffle them around in the DT.

Another advantage (but not the one why I'm doing this work) is that in
general a driver's probe will be called only once per device, and if
it fails then we can be almost certain that something is wrong. This
should aid in debugging as right now one has to take into account the
several reasons why a device might defer its probe.

Depending on what work your drivers do in your platform, enabling
async probing for all of them may have a noticeable impact though.

> - usage of of_platform_device_ensure() will require continuous fixing of =
Kernel :(

You mean adding those calls to more subsystems?

> - late_initcall is not (as for me not safe) a good time to register devic=
es. A lot
>   of platforms/subsystems/frameworks perform their final initialization o=
r clean-up
>   steps, with assumption that System mostly ready to work. For example, C=
PUIdle/CPUFreq
>   are allowed and other PM staff. CPUIdle and driver's probing are not fr=
iends.

Yeah, I was expecting to find more problems due to this, but the
platforms I tested on didn't show any. Do you have pointers to
concrete issues?

> What would be nice to have for now in my opinion:
> - some useful place to move device population code.
>   May be machine_desc->init_device_sync() callback.

I'm looking at leave device registration where it currently is and
just add devices to the deferred list until we get to late_initcall,
where we would start to actually probe them. Seems promising for now.

> - some optional feature in DTC which will allow to re-arrange DT nodes fo=
r levels 0(root)
>   and 1(simple-bus) using standard or widely used bindings (gpio, regulat=
ors, clocks, dma,
>   pinctrl, irqs).

Could you extend on this, please?

> Additional note:
> - Changing device's registration order will change devices's order in
>  dpm_list (drivers/base/power/main.c) and devices_kset list
>  (drivers/base/core.c). This might potentially affect on suspend [1] and =
shutdown.

Yeah, I don't plan to change registration order, but probing certainly will.

> [1] https://lkml.org/lkml/2014/12/12/324

Thanks,

Tomeu

>
> --
> regards,
> -grygorii
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
