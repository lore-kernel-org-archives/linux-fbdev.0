From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 02 Aug 2019 10:46:33 +0000
Subject: Re: [PATCH v2 00/10] drivers, provide a way to add sysfs groups easily
Message-Id: <20190802104633.GA14823@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
 <20190731131045.GB147138@dtor-ws>
In-Reply-To: <20190731131045.GB147138@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: x86@kernel.org, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>, Andy Shevchenko <andy.shevchenko@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Richard Gong <richard.gong@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org

On Wed, Jul 31, 2019 at 06:10:45AM -0700, Dmitry Torokhov wrote:
> On Wed, Jul 31, 2019 at 02:43:39PM +0200, Greg Kroah-Hartman wrote:
> > This patch originally started out just as a way for platform drivers to
> > easily add a sysfs group in a race-free way, but thanks to Dmitry's
> > patch, this series now is for all drivers in the kernel (hey, a unified
> > driver model works!!!)
> > 
> > I've only converted a few platform drivers here in this series to show
> > how it works, but other busses can be converted after the first patch
> > goes into the tree.
> > 
> > Here's the original 00 message, for people to get an idea of what is
> > going on here:
> > 
> > If a platform driver wants to add a sysfs group, it has to do so in a
> > racy way, adding it after the driver is bound.  To resolve this issue,
> > have the platform driver core do this for the driver, making the
> > individual drivers logic smaller and simpler, and solving the race at
> > the same time.
> > 
> > All of these patches depend on the first patch.  I'll take the first one
> > through my driver-core tree, and any subsystem maintainer can either ack
> > their individul patch and I will be glad to also merge it, or they can
> > wait until after 5.4-rc1 when the core patch hits Linus's tree and then
> > take it, it's up to them.
> 
> Maybe make an immutable branch off 5.2 with just patch 1/10 so that
> subsystems (and the driver core tree itself) could pull it in at their
> leisure into their "*-next" branches and did not have to wait till 5.4
> or risk merge clashes?

I have now done this with patch 1/10.  Here's the pull info if any
subsystem maintainer wants to suck this into their tree to provide the
ability for drivers to add/remove attribute groups easily.

This is part of my driver-core tree now, and will go to Linus for
5.4-rc1, along with a few platform drivers that have been acked by their
various subsystem maintainers that convert them to use this new
functionality.

If anyone has any questions about this, please let me know.

thanks,

greg k-h

-------------------

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/dev_groups_all_drivers

for you to fetch changes up to 23b6904442d08b7dbed7622ed33b236d41a3aa8b:

  driver core: add dev_groups to all drivers (2019-08-02 12:37:53 +0200)

----------------------------------------------------------------
dev_groups added to struct driver

Persistent tag for others to pull this branch from

This is the first patch in a longer series that adds the ability for the
driver core to create and remove a list of attribute groups
automatically when the device is bound/unbound from a specific driver.

See:
	https://lore.kernel.org/r/20190731124349.4474-2-gregkh@linuxfoundation.org
for details on this patch, and examples of how to use it in other
drivers.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dmitry Torokhov (1):
      driver core: add dev_groups to all drivers

 drivers/base/dd.c      | 14 ++++++++++++++
 include/linux/device.h |  3 +++
 2 files changed, 17 insertions(+)
