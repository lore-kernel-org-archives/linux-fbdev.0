From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Tue, 14 Jul 2015 12:47:04 +0000
Subject: Re: [alsa-devel] [PATCH v2 11/12] ASoC: tegra: register dependency parser for firmware nodes
Message-Id: <CAAObsKAHviKKTrEBhuge-KQ115p-kOf69miNnmpR+7knOeg+qg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
 <1435743667-11987-12-git-send-email-tomeu.vizoso@collabora.com>
 <20150701173802.GW11162@sirena.org.uk>
 <CAAObsKDsEuDS46rW9CMuviDEDV-OVXe5q-kiWmw0D_n2D3Tf5A@mail.gmail.com>
 <20150713154254.GH11162@sirena.org.uk>
 <CAAObsKAVY7-QpcRyT4juc2RyB+vqibvzKO7wFCT2VsL9R8bzPw@mail.gmail.com>
 <20150714110713.GT11162@sirena.org.uk>
In-Reply-To: <20150714110713.GT11162@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-acpi@vger.kernel.org, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>

On 14 July 2015 at 13:07, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 14, 2015 at 09:34:22AM +0200, Tomeu Vizoso wrote:
>> On 13 July 2015 at 17:42, Mark Brown <broonie@kernel.org> wrote:
>
>> > No, I'm looking at how we already have all the "did all my dependencies
>> > appear" logic in the core based on data provided by the drivers.
>
>> Sorry, but I still don't get what you mean.
>
> I'm not sure how I can be clearer here...  you're replacing something
> that is currently pure data with open coding in each device.  That seems
> like a step back in terms of ease of use.

I could understand that if snd_soc_dai_link had a field with the
property name, and the core called of_parse_phandle on it, but
currently what I'm duplicating is:

    tegra_max98090_dai.cpu_of_node = of_parse_phandle(np,
            "nvidia,i2s-controller", 0);

with:

    add_dependency(fwnode, "nvidia,i2s-controller", deps);

Admittedly, we could add a cpu_fw_property field to snd_soc_dai_link
and have the core call of_parse_phandle itself.

But even then, the core doesn't know about a device's snd_soc_dai_link
until probe() is called and then it's too late for the purposes of
this series.

That's why I mentioned devm_probe, as it would add a common way to
specify the data needed to acquire resources in each driver, which
could be made available before probe() is called.

From the proof of concept that Arnd sent in
https://lkml.kernel.org/g/4742258.TBitC3hVuO@wuerfel :

struct foo_priv {
        spinlock_t lock;
        void __iomem *regs;
        int irq;
        struct gpio_desc *gpio;
        struct dma_chan *rxdma;
        struct dma_chan *txdma;
        bool oldstyle_dma;
};

/*
 * this lists all properties we access from the driver. The list
 * is interpreted by devm_probe() and can be programmatically
 * verified to match the binding.
 */
static const struct devm_probe foo_probe_list[] = {
        DEVM_ALLOC(foo_priv),
        DEVM_IOMAP(foo_priv, regs, 0, 0),
        DEVM_PROP_BOOL(foo_priv, oldstyle_dma, "foo,oldstyle-dma"),
        DEVM_DMA_SLAVE(foo_priv, rxdma, "rx");
        DEVM_DMA_SLAVE(foo_priv, txdma, "tx");
        DEVM_GPIO(foo_priv, gpio, 0);
        DEVM_IRQ_NAMED(foo_priv, irq, foo_irq_handler, "fifo", IRQF_SHARED),
        {},
};

Thanks,

Tomeu

>> Information about dependencies is currently available only after
>> probe() starts executing, and used to decide whether we want to defer
>> the probe.
>
>> The goal of this series is to eliminate most or all of the deferred
>> probes by checking that all dependencies are available before probe()
>> is called.
>
> Right, but the way it does this is by moving code out of the core into
> the drivers - currently drivers just tell the core what resources to
> look up and the core then makes sure that they're all present.
>
>> I thought you were pointing out that the property names would be
>> duplicated, once in the probe() implementation and also in the
>> implementation of the get_dependencies callback.
>
> Yes, that is another part of issue with this approach - drivers now have
> to specify things twice, once for this new interface and once for
> actually looking things up.  That doesn't seem awesome and adding the
> code into the individual drivers and then having to pull it out again
> when the redundancy is removed is going to be an enormous amount of
> churn.
>
>> A way to consolidate the code and remove that duplication would be
>> having a declarative API for expressing dependencies, which could be
>> used for both fetching dependencies and for preventing deferred
>> probes. That's why I mentioned devm_probe.
>
> Part of what I'm saying here is that in ASoC we already have (at least
> as far as the individual drivers are concerned) a declarative way of
> specifying dependencies.  This new code should be able to make use of
> that, if it can't and especially if none of the code can be shared
> between drivers then that seems like the interface needs another spin.
>
> I've not seen this devm_probe() code but the name sounds worryingly like
> it might be fixing the wrong problem :/
