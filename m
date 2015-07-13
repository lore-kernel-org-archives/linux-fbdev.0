From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Mon, 13 Jul 2015 12:10:45 +0000
Subject: Re: [alsa-devel] [PATCH v2 11/12] ASoC: tegra: register dependency parser for firmware nodes
Message-Id: <CAAObsKDsEuDS46rW9CMuviDEDV-OVXe5q-kiWmw0D_n2D3Tf5A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
 <1435743667-11987-12-git-send-email-tomeu.vizoso@collabora.com>
 <20150701173802.GW11162@sirena.org.uk>
In-Reply-To: <20150701173802.GW11162@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>

On 1 July 2015 at 19:38, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jul 01, 2015 at 11:41:06AM +0200, Tomeu Vizoso wrote:
>
>> +static void tegra_max98090_get_dependencies(struct fwnode_handle *fwnode,
>> +                                         struct list_head *deps)
>> +{
>> +     add_dependency(fwnode, "nvidia,i2s-controller", deps);
>> +     add_dependency(fwnode, "nvidia,audio-codec", deps);
>> +}
>
> Why is this all being open coded in an individual driver (we already
> know about and manage all these dependencies in the core...)?  If we're
> going to do this I'd expect the interface for specifying DT nodes to the
> core to be changed to support this.

Are you thinking of changing drivers to acquire their resources
through Arnd's devm_probe (only that the resource table would have to
be in struct device_driver)?

https://lkml.kernel.org/g/4742258.TBitC3hVuO@wuerfel

Sounds like lots of fun, but that means that any given machine will
get ordered probe only after all the drivers it uses have been moved
to the new declarative API.

TBH, that seems really far away.

Regards,

Tomeu
