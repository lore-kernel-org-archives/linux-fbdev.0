From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 31 Jul 2012 14:26:07 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120731142607.GV4468@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <1343390750-3642-2-git-send-email-acourbot@nvidia.com>
 <50170EA0.1010408@wwwdotorg.org>
 <5017B434.2010706@nvidia.com>
 <20120731105640.GD16155@avionic-0098.adnet.avionic-design.de>
 <20120731141328.GS4468@opensource.wolfsonmicro.com>
 <20120731142216.GA19591@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20120731142216.GA19591@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Alex Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Tue, Jul 31, 2012 at 04:22:17PM +0200, Thierry Reding wrote:
> On Tue, Jul 31, 2012 at 03:13:29PM +0100, Mark Brown wrote:

> > __devinit can be discarded if you disable enough kernel features,
> > HOTPLUG is the main one IIRC, modules might also need to go - drivers
> > really ought to take a copy of platform data they plan to use at
> > runtime, though practically speaking you have to try to trigger any
> > problems.

> HOTPLUG is marked EXPERT and explicitly states that it should only be
> disabled if you're not using modules or dynamic device discovery. I
> think if you've ignored all of that you're no longer entitled to
> complain.

This is framework code - it doesn't have much option.  Disabling HOTPLUG
is totally reasonable on space constrained systems, there's no reason
for the code to break things for people.
