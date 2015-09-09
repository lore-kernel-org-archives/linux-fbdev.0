From: Rob Herring <robh@kernel.org>
Date: Wed, 09 Sep 2015 01:33:25 +0000
Subject: Re: [PATCH v4 0/22] On-demand device probing
Message-Id: <55EF8C65.4030706@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_Jsq+E31JaPcp5ELS_ztSqgSrK7U4OzB9xNcNz01Ayrrm+Yg@mail.gmail.com>
 <CAAObsKDUzk-9H2_VrVmbc=ZeRaknGcjTMY3Mauh3JVZxLz4CiA@mail.gmail.com>
In-Reply-To: <CAAObsKDUzk-9H2_VrVmbc=ZeRaknGcjTMY3Mauh3JVZxLz4CiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux PWM List <linux-pwm@vger.kernel.org>, =?UTF-8?Q?Terje_Bergstr=c3=b6m?= <tbergstrom@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jingo

On 09/08/2015 02:30 AM, Tomeu Vizoso wrote:
> On 7 September 2015 at 22:50, Rob Herring <robherring2@gmail.com> wrote:
>> On Mon, Sep 7, 2015 at 7:23 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com=
> wrote:
>>> Hello,
>>>
>>> I have a problem with the panel on my Tegra Chromebook taking longer
>>> than expected to be ready during boot (St=C3=A9phane Marchesin reported=
 what
>>> is basically the same issue in [0]), and have looked into ordered
>>> probing as a better way of solving this than moving nodes around in the
>>> DT or playing with initcall levels and linking order.
>>>
>>> While reading the thread [1] that Alexander Holler started with his
>>> series to make probing order deterministic, it occurred to me that it
>>> should be possible to achieve the same by probing devices as they are
>>> referenced by other devices.
>>>
>>> This basically reuses the information that is already implicit in the
>>> probe() implementations, saving us from refactoring existing drivers or
>>> adding information to DTBs.
>>>
>>> During review of v1 of this series Linus Walleij suggested that it
>>> should be the device driver core to make sure that dependencies are
>>> ready before probing a device. I gave this idea a try [2] but Mark Brown
>>> pointed out to the logic duplication between the resource acquisition
>>> and dependency discovery code paths (though I think it's fairly minor).
>>>
>>> To address that code duplication I experimented with Arnd's devm_probe
>>> [3] concept of having drivers declare their dependencies instead of
>>> acquiring them during probe, and while it worked [4], I don't think we
>>> end up winning anything when compared to just probing devices on-demand
>>> from resource getters.
>>>
>>> One remaining objection is to the "sprinkling" of calls to
>>> of_device_probe() in the resource getters of each subsystem, but I think
>>> it's the right thing to do given that the storage of resources is
>>> currently subsystem-specific.
>>>
>>> We could avoid the above by moving resource storage into the core, but I
>>> don't think there's a compelling case for that.
>>>
>>> I have tested this on boards with Tegra, iMX.6, Exynos, Rockchip and
>>> OMAP SoCs, and these patches were enough to eliminate all the deferred
>>> probes (except one in PandaBoard because omap_dma_system doesn't have a
>>> firmware node as of yet).
>>>
>>> Have submitted a branch [5] with only these patches on top of thursday's
>>> linux-next to kernelci.org and I don't see any issues that could be
>>> caused by them. For some reason it currently has more passes than the
>>> version of -next it's based on!
>>>
>>> With this series I get the kernel to output to the panel in 0.5s,
>>> instead of 2.8s.
>>>
>>> Regards,
>>>
>>> Tomeu
>>>
>>> [0] http://lists.freedesktop.org/archives/dri-devel/2014-August/066527.=
html
>>>
>>> [1] https://lkml.org/lkml/2014/5/12/452
>>>
>>> [2] https://lkml.org/lkml/2015/6/17/305
>>>
>>> [3] http://article.gmane.org/gmane.linux.ports.arm.kernel/277689
>>>
>>> [4] https://lkml.org/lkml/2015/7/21/441a
>>>
>>> [5] https://git.collabora.com/cgit/user/tomeu/linux.git/log/?h=3Don-dem=
and-probes-v6
>>>
>>> [6] http://kernelci.org/boot/all/job/collabora/kernel/v4.2-11902-g25d80=
c927f8b/
>>>
>>> [7] http://kernelci.org/boot/all/job/next/kernel/next-20150903/
>>>
>>> Changes in v4:
>>> - Added bus.pre_probe callback so the probes of Primecell devices can be
>>>   deferred if their device IDs cannot be yet read because of the clock
>>>   driver not having probed when they are registered. Maybe this goes
>>>   overboard and the matching information should be in the DT if there is
>>>   one.
>>
>> Seems overboard to me or at least a separate problem.
>=20
> It's a separate problem but this was preventing the series from
> working on a few boards.

What is the failure? Not booting? Fixing not working would certainly not
be overboard.

>=20
>> Most clocks have
>> to be setup before the driver model simply because timers depend on
>> clocks usually.
>=20
> Yes, but in this case the apb clocks for the primecell devices are
> implemented in a normal platform driver (vexpress_osc_driver), instead
> of using CLK_OF_DECLARE.

Okay.

Rob

