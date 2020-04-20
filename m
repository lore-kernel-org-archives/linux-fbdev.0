From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Mon, 20 Apr 2020 08:02:33 +0000
Subject: Re: [PATCH 7/8] fbdev: rework backlight dependencies
Message-Id: <871roi37qe.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
 <20200417155553.675905-8-arnd@arndb.de> <20200417170444.GB30483@ravnborg.org>
In-Reply-To: <20200417170444.GB30483@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>
Cc: marex@denx.de, Jason Gunthorpe <jgg@ziepe.ca>, linux-fbdev@vger.kernel.org, dsd@laptop.org, Nicolas Pitre <nico@fluxnic.net>, airlied@linux.ie, masahiroy@kernel.org, jfrederich@gmail.com, Saeed Mahameed <saeedm@mellanox.com>, thellstrom@vmware.com, dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>, kieran.bingham+renesas@ideasonboard.com, geert@linux-m68k.org, haojian.zhuang@gmail.com, linux-graphics-maintainer@vmware.com, robert.jarzmik@free.fr, daniel@zonque.org, Laurent.pinchart@ideasonboard.com

On Fri, 17 Apr 2020, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Arnd.
>
> On Fri, Apr 17, 2020 at 05:55:52PM +0200, Arnd Bergmann wrote:
>> Rather than having CONFIG_FB_BACKLIGHT select CONFIG_BACKLIGHT_CLASS_DEVICE,
>> make any driver that needs it have a dependency on the class device
>> being available, to prevent circular dependencies.
>> 
>> This is the same way that the backlight is already treated for the DRM
>> subsystem.
>
> I am not happy with the direction of this patch.
> It is not easy to understand that one has to enable backlight to
> be allowed to select a display or an fbdev driver.

Arguably that is a problem in Kconfig, and that applies to *all*
dependencies everywhere. It isn't something new to this patch.

For example, in the context of this patch you have:

  config HT16K33
	 tristate "Holtek Ht16K33 LED controller with keyscan"
	 depends on FB && OF && I2C && INPUT
 +	depends on BACKLIGHT_CLASS_DEVICE

The same thing could be said about FB and OF and IC2 and INPUT for
HT16K33, right? Why would *backlight* be the tipping point that makes
this difficult to understand?

Yeah, I agree it's not straightforward, but I think depends is the right
choice, not select.

The effort for making this easier to understand should be directed at
the various menuconfig tools to better highlight the dependencies that
should be enabled to let you enable other options.

> How about somthing like this:

I think this is a hack in Kconfig files that should really be fixed in
the Kconfig tooling instead. IMHO Kconfig should be as simple a
description of the dependencies as possible, not so much a UI language.

FWIW the patch is

Acked-by: Jani Nikula <jani.nikula@intel.com>

BR,
Jani.



-- 
Jani Nikula, Intel Open Source Graphics Center
