From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 31 Jul 2012 16:19:54 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120731161954.GB4941@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <1343390750-3642-2-git-send-email-acourbot@nvidia.com>
 <50170EA0.1010408@wwwdotorg.org>
 <5017B434.2010706@nvidia.com>
 <20120731105640.GD16155@avionic-0098.adnet.avionic-design.de>
 <20120731141328.GS4468@opensource.wolfsonmicro.com>
 <20120731142216.GA19591@avionic-0098.adnet.avionic-design.de>
 <20120731142607.GV4468@opensource.wolfsonmicro.com>
 <20120731143235.GA21126@avionic-0098.adnet.avionic-design.de>
 <20120731153941.GF4468@opensource.wolfsonmicro.com>
In-Reply-To: <20120731153941.GF4468@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Alex Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Tue, Jul 31, 2012 at 04:39:41PM +0100, Mark Brown wrote:
> On Tue, Jul 31, 2012 at 04:32:35PM +0200, Thierry Reding wrote:
> > On Tue, Jul 31, 2012 at 03:26:07PM +0100, Mark Brown wrote:
> 
> > > This is framework code - it doesn't have much option.  Disabling HOTPLUG
> > > is totally reasonable on space constrained systems, there's no reason
> > > for the code to break things for people.
> 
> > Still if you use this code and disable HOTPLUG, then you shouldn't be
> > using modules either. I mean there is no way you can write a driver that
> 
> Of course.
> 
> > can gracefully handle its platform data being discarded.
> 
> Sure there is - take a copy of the platform data in probe().

Ick ick ick, devdata needs to die as it's pretty much pointless these
days.

It's on my TODO list actually...

greg k-h
