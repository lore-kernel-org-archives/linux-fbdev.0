From: Andrzej Hajda <a.hajda@samsung.com>
Date: Wed, 10 Jun 2015 12:23:25 +0000
Subject: Re: [PATCH 00/21] On-demand device registration
Message-Id: <55782C3D.5000606@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <CACRpkdasLwMfEHGMRd1X3K_DU7NMPreE8TMwqqDTg8k9wj=wJQ@mail.gmail.com>
 <CAAObsKCP-C+TY8Wkk6bQzxZeGYL9X01trtjxfaYp--ZnH07C+w@mail.gmail.com>
 <CACRpkdZuSj+S2x1yz6n5PgcRK=3ZCcq_To124b2Y+Oj54aydpg@mail.gmail.com>
 <CAAObsKD97nEARO5eZYA2g8+z_MrazBy-m8PV_kSyj19ya72mAw@mail.gmail.com>
In-Reply-To: <CAAObsKD97nEARO5eZYA2g8+z_MrazBy-m8PV_kSyj19ya72mAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, dmaengine@vger.kernel.org, Alexander Holler <holler@ahsoftware.de>, Dan Williams <dan.j.williams@intel.com>, linux-usb@vger.kernel.org, linux-clk@vger.kernel.org, Grant Likely <grant.likely@linaro.org>

On 06/10/2015 12:19 PM, Tomeu Vizoso wrote:
> On 10 June 2015 at 09:30, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Jun 2, 2015 at 12:14 PM, Tomeu Vizoso
>> <tomeu.vizoso@collabora.com> wrote:
>>> On 2 June 2015 at 10:48, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>>>> This is what systemd is doing in userspace for starting services:
>>>> ask for your dependencies and wait for them if they are not
>>>> there. So drivers ask for resources and wait for them. It also
>>>> needs to be abstract, so for example we need to be able to
>>>> hang on regulator_get() until the driver is up and providing that
>>>> regulator, and as long as everything is in slowpath it should
>>>> be OK. (And vice versa mutatis mutandis for clk, gpio, pin
>>>> control, interrupts (!) and DMA channels for example.)
>>>
>>> I understood above that you propose probing devices in order, but now
>>> you mention that resource getters would block until the dependency is
>>> fulfilled which confuses me because if we are probing in order then
>>> all dependencies would be fulfilled before the device in question gets
>>> probed.
>>
>> Sorry, the problem space is a bit convoluted so the answers
>> get a bit convoluted. Maybe I'm thinking aloud and altering the course
>> of my thoughts as I type...
>>
>> I guess there can be explicit dependencies for resources like this
>> patch does, but another way would be for all resource fetch functions
>> to be instrumented, so that you do not block until you try to take
>> a resource that is not yet there, e.g.:
>>
>> regulator_get(...) -> not available, so:
>> - identify target regulator provider - this will need instrumentation
>> - probe it
>>
>> It then turns out the regulator driver is on the i2c bus, so we
>> need to probe the i2c driver:
>> - identify target i2c host for the regulator driver - this will need
>>   instrumentation
>> - probe the i2c host driver
>>
>> i2c host comes out, probes the regulator driver, regulator driver
>> probes and then the regulator_get() call returns.
> 
> Hmm, if I understand correctly what you say, this is exactly what this
> particular series does:
> 
> regulator_get -> of_platform_device_ensure -> probe() on the platform
> device that encloses the requested device node (i2c host) -> i2c slave
> gets probed and the regulator registered -> regulator_get returns the
> requested resource

The downside of this solution is that it will not work without device
tree or even without device dependencies not explicitly specified in
device tree.

> 
> The downside I'm currently looking at is that an explicit dependency
> graph would be useful to have for other purposes. For example to print
> a neat warning when a dependency cannot be fulfilled. Or to refuse to
> unbind a device which other devices depend on,

As I understand Greg you cannot prevent unbinding by design, see [1].

[1]: http://thread.gmane.org/gmane.linux.kernel/1154308/focus54648

> or to automatically
> unbind the devices that depend on it,

What about devices that have weak dependency? They should not be unbound
but they should be somehow noticed about unbinding.

In general many kernel frameworks are broken in handling hot-unbinding
of drivers, consumers are not noticed about unbinding of their resource
providers and usually they stay with broken handles or handles to dummy
resources.

I suspect the only proper solution for handling resources that can
dynamically appear/disappear is to provide notification to their
consumers about appearance change of the resource.

I have proposed some times ago solution for above problems based on the
statement above, cover letter explains it in more detail [2].
In short it solves following issues:
- consumer receives resource as soon as it becomes available,
- consumer is notified just before resource removal,
- it can properly handle provider unbind/re-bind,
- it avoids late init due to deferred probing,
- it allows to track optional resources.

[2]: http://thread.gmane.org/gmane.linux.kernel.gpio/5201

Regards
Andrzej

> or to print a warning if a
> device is hotplugged off and other devices depend on it.
> 
>> This requires instrumentation on anything providing a resource
>> to another driver like those I mentioned and a lot of overhead
>> infrastructure, but I think it's the right approach. However I don't
>> know if I would ever be able to pull that off myself, I know talk
>> is cheap and I should show the code instead.
> 
> Yeah, if you can give it a second look and say if it matches what you
> wrote above, it would be very much appreciated.
> 
>> Deepest respect for your efforts!
> 
> Thanks!
> 
> Tomeu
> 
>> Yours,
>> Linus Walleij
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> http://lists.freedesktop.org/mailman/listinfo/dri-devel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

