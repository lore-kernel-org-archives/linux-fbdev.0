From: Alex Courbot <acourbot@nvidia.com>
Date: Tue, 21 Aug 2012 08:53:27 +0000
Subject: Re: [PATCH v4 1/3] Runtime Interpreted Power Sequences
Message-Id: <1860040.h1S5hbLDAH@percival>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345097337-24170-1-git-send-email-acourbot@nvidia.com> <1562509.b0FYTUZ1D8@percival> <20120821083329.GA28992@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20120821083329.GA28992@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Stephen Warren <swarren@nvidia.com>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Leela Krishna Amudala <leelakrishna.a@gmail.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Tuesday 21 August 2012 16:33:30 Thierry Reding wrote:
> I suppose power sequences aren't needed if you have a specific driver
> for every panel out there. However that also means that you'd have to
> write drivers for literally every panel that requires support. In the
> end this will just result in discussion down the road how the common
> functionality can be refactored and we may end up with power sequences
> again.
> 
> Also as you mentioned, power sequences are useful for a number of other
> use-cases. Without power sequences you'll have to potentially create
> extra frameworks tha reimplement parts of the power sequence code for
> their specific hardware needs.

Yes, I can imagine what a mess it would become it we had one driver for every 
panel out there which sole purpose would be to define power sequences over more 
generic drivers. That reassures me about the usefulness of this work.

Another (small) benefit of power sequences over specific drivers is that being 
defined in the DT, they would allow an old kernel to operate a newer device if 
the base driver is the same.

Alex.

