From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 19 Sep 2012 03:01:16 +0000
Subject: Re: [PATCH v6 0/4] Runtime Interpreted Power Sequences
Message-Id: <20120919030116.GN8832@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com>
 <4473898.CeAQBgUhKL@percival>
 <20120913071928.GA20959@opensource.wolfsonmicro.com>
 <1378218.yLeQheNFT0@percival>
 <20120913072943.GB20959@opensource.wolfsonmicro.com>
 <5051FAC5.40501@wwwdotorg.org>
In-Reply-To: <5051FAC5.40501@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Alex Courbot <acourbot@nvidia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Leela Krishna Amudala <l.krishna@samsung.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Anton Vorontsov <cbou@mail.ru>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Thu, Sep 13, 2012 at 09:24:53AM -0600, Stephen Warren wrote:
> On 09/13/2012 01:29 AM, Mark Brown wrote:

> > The driver knows the power sequence.  Having to type the same sequence
> > into the DT or platform data for each board using the device wouuld be
> > retarded so we need the drivers to be able to give the sequence to the
> > library if they're going to be able to reuse it (which is a lot of what
> > Tomi is talking about).

> I believe that's trivial to implement. The relevant function is:

Right, that's what I'm saying - the code is mostly there now.

> It's up to the driver whether pseq comes from platform data or is
> hard-coded into the driver (or not provided at all, for the DT case).
> So, the only change needed to convert a "hard-coded" driver to this API
> is to convert the current custom data structure (or code) that describes
> the sequence into a struct platform_power_seq_set.

The framework could still help by providing ways to avoid having to copy
the structure and fill in the blanks for GPIO numbers (and anything else
that is numbered rather than named) by hand.
