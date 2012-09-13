From: Alex Courbot <acourbot@nvidia.com>
Date: Thu, 13 Sep 2012 06:08:23 +0000
Subject: Re: [PATCH v6 1/4] Runtime Interpreted Power Sequences
Message-Id: <1464760.6eqxJ2IzZ2@percival>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com> <1347443867-18868-2-git-send-email-acourbot@nvidia.com> <1347515139.7471.7.camel@lappyti>
In-Reply-To: <1347515139.7471.7.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>, Thierry Reding <thierry.reding@avionic-design.de>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Leela Krishna Amudala <l.krishna@samsung.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Thursday 13 September 2012 13:45:39 Tomi Valkeinen wrote:
> * PGP Signed by an unknown key
> 
> On Wed, 2012-09-12 at 18:57 +0900, Alexandre Courbot wrote:
> 
> > Some device drivers (panel backlights especially) need to follow precise
> > sequences for powering on and off, involving gpios, regulators, PWMs
> > with a precise powering order and delays to respect between each steps.
> > These sequences are board-specific, and do not belong to a particular
> > driver - therefore they have been performed by board-specific hook
> > functions to far.
> 
> 
> The sequences are not board-specific, they are device (backlight, etc.)
> specific. The sequences have been handled in board-specific hook
> functions so far because there hasn't been proper drivers for the
> devices.
> 
> If I were to take the same panel (and backlight) you have and install it
> on my board, I would need the same power sequence.

You could also have power sequences that control a set of GPIOs for an 
external interface (and would then be more board-specific), but you are right 
that for most of the case power seqs apply to devices and this statement is 
misleading. I will fix that in the commit message and wherever this might 
appear.

Alex.

