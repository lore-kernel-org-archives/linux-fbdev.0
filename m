From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 07 Sep 2012 08:15:03 +0000
Subject: Re: [PATCH v5 1/4] Runtime Interpreted Power Sequences
Message-Id: <20120907081501.GA17749@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346412846-17102-1-git-send-email-acourbot@nvidia.com>
 <1346412846-17102-2-git-send-email-acourbot@nvidia.com>
 <201209061614.54022.heiko@sntech.de>
 <1887927.1deN8M9siP@percival>
In-Reply-To: <1887927.1deN8M9siP@percival>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot@nvidia.com>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Stephen Warren <swarren@nvidia.com>, Thierry Reding <thierry.reding@avionic-design.de>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Leela Krishna Amudala <leelakrishna.a@gmail.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Fri, Sep 07, 2012 at 05:04:24PM +0900, Alex Courbot wrote:

> If e.g. the power on sequence fails at step N (of M steps for that sequence), 
> one could try playing the corresponding power off sequence (either completely 
> of from step M - N), but then again we cannot rely on sequences to be 
> perfectly symetrical. Maybe this is more something for the calling driver to 
> check for and control?

That had been my thought too - depending on what the sequence is for it
may be that the corrective action is something very different to
reversing the sequence, for example a device reset may be required.
