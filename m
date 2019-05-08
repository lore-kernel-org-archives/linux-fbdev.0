From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 08 May 2019 13:18:56 +0000
Subject: Re: [PATCH 03/16] lib,treewide: add new match_string() helper/macro
Message-Id: <20190508131856.GB10138@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190508112842.11654-1-alexandru.ardelean@analog.com>
 <20190508112842.11654-5-alexandru.ardelean@analog.com>
 <20190508131128.GL9224@smile.fi.intel.com>
In-Reply-To: <20190508131128.GL9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-fbdev@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, linux-clk@vger.kernel.org, devel@driverdev.osuosl.org, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, Alexandru Ardelean <alexandru.ardelean@analog.com>, linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-gpio@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, cgroups@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Wed, May 08, 2019 at 04:11:28PM +0300, Andy Shevchenko wrote:
> On Wed, May 08, 2019 at 02:28:29PM +0300, Alexandru Ardelean wrote:
> > This change re-introduces `match_string()` as a macro that uses
> > ARRAY_SIZE() to compute the size of the array.
> > The macro is added in all the places that do
> > `match_string(_a, ARRAY_SIZE(_a), s)`, since the change is pretty
> > straightforward.
> 
> Can you split include/linux/ change from the rest?

That would break the build, why do you want it split out?  This makes
sense all as a single patch to me.

thanks,

greg k-h
