From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 13 Sep 2012 06:25:53 +0000
Subject: Re: [PATCH v6 0/4] Runtime Interpreted Power Sequences
Message-Id: <20120913062552.GB17869@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com>
 <1347515447.7471.12.camel@lappyti>
 <1749811.4qrG1GZfBf@percival>
In-Reply-To: <1749811.4qrG1GZfBf@percival>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot@nvidia.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Stephen Warren <swarren@nvidia.com>, Thierry Reding <thierry.reding@avionic-design.de>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Leela Krishna Amudala <l.krishna@samsung.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Thu, Sep 13, 2012 at 03:23:06PM +0900, Alex Courbot wrote:

> I understand the logic behind handling powering sequences in the device 
> driver, but as we discussed for some classes of devices this might just not 
> scale. I don't know how many different panels (each with different powering 

It would be sensible to make sure that the framework is done in such a
way that drivers can use it - there will be drivers (perhaps not display
ones) that have a known power sequence and which could benefit from the
ability to use library code to implement it based on the user simply
supplying named resources.
