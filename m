From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 31 Jul 2012 14:11:25 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120731141125.GR4468@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <1343390750-3642-2-git-send-email-acourbot@nvidia.com>
 <20120730113323.GA7303@avionic-0098.adnet.avionic-design.de>
 <5017AA87.2040503@nvidia.com>
In-Reply-To: <5017AA87.2040503@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot@nvidia.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Stephen Warren <swarren@nvidia.com>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Tue, Jul 31, 2012 at 06:51:03PM +0900, Alex Courbot wrote:

> 2) On cleanup, it cleans the resources that needs to be freed (i.e.
> those that are not devm-handled).

> 2) can certainly be removed either by enforcing use of devm, or by
> doing reference counting. 1) seems more difficult to avoid - we need

I'd just add devm_ for everything that's not got it.
