From: Anton Vorontsov <cbouatmailru@gmail.com>
Date: Mon, 30 Jul 2012 02:40:52 +0000
Subject: Gethering power management/policy hw drivers under drivers/power/? (Re: [RFC][PATCH v3 1/3] runtime
Message-Id: <20120730024049.GA10442@lizard>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <1343390750-3642-2-git-send-email-acourbot@nvidia.com>
 <20120727181923.GB23564@kroah.com>
 <5015E8AE.8060404@nvidia.com>
In-Reply-To: <5015E8AE.8060404@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot@nvidia.com>, Jean Pihet <j-pihet@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Stephen Warren <swarren@nvidia.com>, Thierry Reding <thierry.reding@avionic-design.de>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Arnd Bergmann <arnd@arndb.de>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Liam Girdwood <lrg@ti.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On Mon, Jul 30, 2012 at 10:51:42AM +0900, Alex Courbot wrote:
[...]
> On the other hand I have just noticed that the apparently unrelated
> Adaptive Voltage Scaling driver just appeared in drivers/power/avs.
> So if Anton and David are ok with this, maybe I could put the power
> sequences code in its own subdirectory within drivers/power.

Well, currently drivers/power/ is indeed just for power supply class
subsystem and drivers. But if the trend is to gather power management
("policy") stuff under one directory, i.e.

drivers/
  power/
    supplies/    <- former "power supply class and drivers"
    regulators/
    idle/
    cpuidle/
    cpufreq/
    devfreq/
    avs/
    ...

That would probably make sense, we could easily see the big picture.
But if we're not going to do this long-term, I would suggest to stick
to just a new directory under drivers (and move drivers/power/avs/ to
drivers/avs).

Cc'ing some more people...

Thanks,

p.s. Jean, why am I the last person who discovers drivers/power/avs/?
Would be nice to Cc me on such patches; by moving AVS under
drivers/power/ you effectively nominated me as its maintainer. :-)

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
