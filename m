From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 13 May 2020 22:18:15 +0000
Subject: Re: [PATCH v2 00/10] drivers, provide a way to add sysfs groups easily
Message-Id: <CACvgo52+Uqx4GJFwadJoFzzt5EMc69HcW-+K9uxv9t25TtSDBg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
 <20190731131045.GB147138@dtor-ws> <20190802104633.GA14823@kroah.com>
In-Reply-To: <20190802104633.GA14823@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: platform-driver-x86@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, Sudeep Holla <sudeep.holla@arm.com>, Tony Prisk <linux@prisktech.co.nz>, Andy Shevchenko <andy.shevchenko@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Borislav Petkov <bp@alien8.de>, linux-input@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, LAKML <linux-arm-kernel@lists.infradead.org>, Richard Gong <richard.gong@linux.intel.com>

Hi Greg,

On Fri, 2 Aug 2019 at 11:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

>
> I have now done this with patch 1/10.  Here's the pull info if any
> subsystem maintainer wants to suck this into their tree to provide the
> ability for drivers to add/remove attribute groups easily.
>
> This is part of my driver-core tree now, and will go to Linus for
> 5.4-rc1, along with a few platform drivers that have been acked by their
> various subsystem maintainers that convert them to use this new
> functionality.
>
> If anyone has any questions about this, please let me know.
>
> thanks,
>
> greg k-h
>
> -------------------
>
> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
>
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/dev_groups_all_drivers
>
> for you to fetch changes up to 23b6904442d08b7dbed7622ed33b236d41a3aa8b:
>
>   driver core: add dev_groups to all drivers (2019-08-02 12:37:53 +0200)
>
> ----------------------------------------------------------------
> dev_groups added to struct driver
>
> Persistent tag for others to pull this branch from
>
> This is the first patch in a longer series that adds the ability for the
> driver core to create and remove a list of attribute groups
> automatically when the device is bound/unbound from a specific driver.
>
> See:
>         https://lore.kernel.org/r/20190731124349.4474-2-gregkh@linuxfoundation.org
> for details on this patch, and examples of how to use it in other
> drivers.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ----------------------------------------------------------------
> Dmitry Torokhov (1):
>       driver core: add dev_groups to all drivers
>
>  drivers/base/dd.c      | 14 ++++++++++++++
>  include/linux/device.h |  3 +++
>  2 files changed, 17 insertions(+)
> _______________________________________________

Was planning to re-spin DRM a series which uses .dev_groups, although
I cannot see the core patch.
Did the it get reverted or simply fell though the cracks?

-Emil
