From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Tue, 14 Jul 2015 07:34:22 +0000
Subject: Re: [alsa-devel] [PATCH v2 11/12] ASoC: tegra: register dependency parser for firmware nodes
Message-Id: <CAAObsKAVY7-QpcRyT4juc2RyB+vqibvzKO7wFCT2VsL9R8bzPw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
 <1435743667-11987-12-git-send-email-tomeu.vizoso@collabora.com>
 <20150701173802.GW11162@sirena.org.uk>
 <CAAObsKDsEuDS46rW9CMuviDEDV-OVXe5q-kiWmw0D_n2D3Tf5A@mail.gmail.com>
 <20150713154254.GH11162@sirena.org.uk>
In-Reply-To: <20150713154254.GH11162@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-acpi@vger.kernel.org, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>

On 13 July 2015 at 17:42, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 13, 2015 at 02:10:45PM +0200, Tomeu Vizoso wrote:
>> On 1 July 2015 at 19:38, Mark Brown <broonie@kernel.org> wrote:
>> > On Wed, Jul 01, 2015 at 11:41:06AM +0200, Tomeu Vizoso wrote:
>
>> >> +static void tegra_max98090_get_dependencies(struct fwnode_handle *fwnode,
>> >> +                                         struct list_head *deps)
>> >> +{
>> >> +     add_dependency(fwnode, "nvidia,i2s-controller", deps);
>> >> +     add_dependency(fwnode, "nvidia,audio-codec", deps);
>> >> +}
>
>> > Why is this all being open coded in an individual driver (we already
>> > know about and manage all these dependencies in the core...)?  If we're
>> > going to do this I'd expect the interface for specifying DT nodes to the
>> > core to be changed to support this.
>
>> Are you thinking of changing drivers to acquire their resources
>> through Arnd's devm_probe (only that the resource table would have to
>> be in struct device_driver)?
>
>> https://lkml.kernel.org/g/4742258.TBitC3hVuO@wuerfel
>
> No, I'm looking at how we already have all the "did all my dependencies
> appear" logic in the core based on data provided by the drivers.

Sorry, but I still don't get what you mean.

Information about dependencies is currently available only after
probe() starts executing, and used to decide whether we want to defer
the probe.

The goal of this series is to eliminate most or all of the deferred
probes by checking that all dependencies are available before probe()
is called.

Because currently we only have dependency information after probe()
starts executing, we have to make it available earlier. In this
particular version, in callbacks that are registered from the
initcalls that register subsystems, classes, drivers, etc. Whatever
knows how these dependencies are expressed in the firmware data.

I thought you were pointing out that the property names would be
duplicated, once in the probe() implementation and also in the
implementation of the get_dependencies callback.

A way to consolidate the code and remove that duplication would be
having a declarative API for expressing dependencies, which could be
used for both fetching dependencies and for preventing deferred
probes. That's why I mentioned devm_probe.

Thanks,

Tomeu
