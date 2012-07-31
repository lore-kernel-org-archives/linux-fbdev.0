From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 31 Jul 2012 16:50:44 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120731165044.GH11892@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5017B434.2010706@nvidia.com>
 <20120731105640.GD16155@avionic-0098.adnet.avionic-design.de>
 <20120731141328.GS4468@opensource.wolfsonmicro.com>
 <20120731142216.GA19591@avionic-0098.adnet.avionic-design.de>
 <20120731142607.GV4468@opensource.wolfsonmicro.com>
 <20120731143235.GA21126@avionic-0098.adnet.avionic-design.de>
 <20120731153941.GF4468@opensource.wolfsonmicro.com>
 <20120731161954.GB4941@kroah.com>
 <20120731162230.GE11892@opensource.wolfsonmicro.com>
 <20120731164245.GA5762@kroah.com>
In-Reply-To: <20120731164245.GA5762@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Alex Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Tue, Jul 31, 2012 at 09:42:45AM -0700, Greg Kroah-Hartman wrote:
> On Tue, Jul 31, 2012 at 05:22:30PM +0100, Mark Brown wrote:

> > Hrm?  I'm not sure I understand the direct relevance here - we're
> > talking about platform data.

> The platform data was marked __devdata, and you said it could be thrown
> away after init so you should keep it around somehow.

Ah, sorry - I was thinking __devinitdata.
