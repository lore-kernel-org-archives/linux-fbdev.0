From: Rob Herring <robh@kernel.org>
Date: Mon, 19 Oct 2015 22:58:40 +0000
Subject: Re: [GIT PULL] On-demand device probing
Message-Id: <CAL_JsqKa3MFJUWKV2KxPE_NmrP2g4dOD3zr+0Kyx4yBkDOg2HA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <561E1378.6000906@collabora.com> <1445268580.53393.183.camel@infradead.org>
 <CAL_JsqLwvc1H9kQnWs=mA8P4Mq4izmSSeFU6KRtkExBkzF9ABg@mail.gmail.com> <1603415.VWFZ8V0WMC@vostro.rjw.lan>
In-Reply-To: <1603415.VWFZ8V0WMC@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: David Woodhouse <dwmw2@infradead.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Liam Girdwood <lgirdwoo>

On Mon, Oct 19, 2015 at 4:40 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, October 19, 2015 10:58:25 AM Rob Herring wrote:
>> On Mon, Oct 19, 2015 at 10:29 AM, David Woodhouse <dwmw2@infradead.org> wrote:
>> > On Mon, 2015-10-19 at 15:50 +0100, Mark Brown wrote:
>> >> > But the point I'm making is that we are working towards *fixing* that,
>> >> > and *not* using DT-specific code in places where we should be using the
>> >> > generic APIs.
>> >>
>> >> What is the plan for fixing things here?  It's not obvious (at least to
>> >> me) that we don't want to have the subsystems having knowledge of how
>> >> they are bound to a specific firmware which is what you seem to imply
>> >> here.
>> >
>> > I don't know that there *is* a coherent plan here to address it all.
>> >
>> > Certainly, we *will* need subsystems to have firmware-specific
>> > knowledge in some cases. Take GPIO as an example; ACPI *has* a way to
>> > describe GPIO, and properties which reference GPIO pins are intended to
>> > work through that — while in DT, properties which reference GPIO pins
>> > will have different contents. They'll be compatible at the driver
>> > level, in the sense that there's a call to get a given GPIO given the
>> > property name, but the subsystems *will* be doing different things
>> > behind the scenes.
>> >
>> > My plan, such as it is, is to go through the leaf-node drivers which
>> > almost definitely *should* be firmware-agnostic, and convert those. And
>> > then take stock of what we have left, and work out what, if anything,
>> > still needs to be done.
>>
>> Many cases are already agnostic in the drivers in terms of the *_get()
>> functions. Some are DT specific, but probably because those subsystems
>> are new and DT only. In any case, I don't think these 1 line changes
>> do anything to make doing conversions here harder.
>>
>> >> It seems like we're going to have to refactor these bits of code when
>> >> they get generalised anyway so I'm not sure that the additional cost
>> >> here is that big.
>> >
>> > That's an acceptable answer — "we're adding legacy code here but we
>> > know it's going to be refactored anyway". If that's true, all it takes
>> > is a note in the commit comment to that effect. That's different from
>> > having not thought about it :)
>>
>> Considering at one point we did create a fwnode based API, we did
>> think about it. Plus there was little input from ACPI folks as to
>> whether the change was even useful for ACPI case.
>
> Well, sorry, but who was asking whom, specifically?

You and linux-acpi have been copied on v2 and later of the entire
series I think.

> The underlying problem is present in ACPI too and we don't really have a good
> solution for it.  We might benefit from a common one if it existed.

The problem for DT is we don't generically know what are the
dependencies at a core level. We could know some or most dependencies
if phandles (links to other nodes) were typed, but they are not. If
the core had this information, we could simply control the device
creation to order probing. Instead, this information is encoded into
the bindings and binding parsing resides in the subsystems. That
parsing happens during probe of the client side and is done by the
subsystems (for common bindings). Since we already do the parsing at
this point, it is a convenient place to trigger the probe of the
dependency. Is ACPI going to be similar in this regard?

Fundamentally, it is a question of probe devices when their
dependencies are present or drivers ensure their dependencies are
ready. IIRC, init systems went thru a similar debate for service
dependencies.

>> In any case, we're talking about adding 1 line.
>
> But also about making the driver core slighly OF-centric.

How so? The one line is in DT binding parsing code in subsystems, not
driver core. The driver core change is we add every device (that
happened to be created by DT) to the deferred probe list, so they
don't probe right away.


> Sure, we need OF-specific code and ACPI-specific code wherever different
> handling is required, but doing that at the driver core level seems to be
> a bit of a stretch to me.
>
> Please note that we don't really have ACPI-specific calls in the driver core,
> although we might have added them long ago even before the OF stuff appeared
> in the kernel for the first time.  We didn't do that, (among other things)
> because we didn't want that particular firmware interface to appear special
> in any way and I'm not really sure why it is now OK to make OF look special
> instead.

I don't think DT is special and we avoid DT specific core changes as
much as possible. I think the difference is DT uses platform_device
and ACPI does not. It used to be separate, but got merged together
primarily to support the plethora of existing drivers. Anyway, that is
all outside of anything in this series.

> If it is trivial to avoid that (and you seem to be arguing that it is), why
> do we have to do it?

Sorry, I don't follow what "that" or "it" is.

Rob
