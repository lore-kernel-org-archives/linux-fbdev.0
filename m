From: "andriy.shevchenko@linux.intel.com"  <andriy.shevchenko@linux.intel.com>
Date: Fri, 10 May 2019 14:34:07 +0000
Subject: Re: [PATCH 03/16] lib,treewide: add new match_string() helper/macro
Message-Id: <20190510143407.GA9224@smile.fi.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190508112842.11654-1-alexandru.ardelean@analog.com>
 <20190508112842.11654-5-alexandru.ardelean@analog.com>
 <20190508131128.GL9224@smile.fi.intel.com>
 <20190508131856.GB10138@kroah.com>
 <b2440bc9485456a7a90a488c528997587b22088b.camel@analog.com>
 <4df165bc4247e60aa4952fd55cb0c77e60712767.camel@analog.com>
In-Reply-To: <4df165bc4247e60aa4952fd55cb0c77e60712767.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Fri, May 10, 2019 at 09:15:27AM +0000, Ardelean, Alexandru wrote:
> On Wed, 2019-05-08 at 16:22 +0300, Alexandru Ardelean wrote:
> > On Wed, 2019-05-08 at 15:18 +0200, Greg KH wrote:
> > > On Wed, May 08, 2019 at 04:11:28PM +0300, Andy Shevchenko wrote:
> > > > On Wed, May 08, 2019 at 02:28:29PM +0300, Alexandru Ardelean wrote:

> > > > Can you split include/linux/ change from the rest?
> > > 
> > > That would break the build, why do you want it split out?  This makes
> > > sense all as a single patch to me.
> > > 
> > 
> > Not really.
> > It would be just be the new match_string() helper/macro in a new commit.
> > And the conversions of the simple users of match_string() (the ones using
> > ARRAY_SIZE()) in another commit.
> > 
> 
> I should have asked in my previous reply.
> Leave this as-is or re-formulate in 2 patches ?

Depends on on what you would like to spend your time: collecting Acks for all
pieces in treewide patch or send new API first followed up by per driver /
module update in next cycle.

I also have no strong preference.
And I think it's good to add Heikki Krogerus to Cc list for both patch series,
since he is the author of sysfs variant and may have something to comment on
the rest.

-- 
With Best Regards,
Andy Shevchenko
