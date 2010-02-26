From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Fri, 26 Feb 2010 02:30:32 +0000
Subject: Re: [PATCH] Add sysfs support for fbdefio delay
Message-Id: <45a44e481002251830j710e87bah52486a489eef04cb@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201002252215.o1PMFnoP011425@mustang.cs.nmsu.edu>
In-Reply-To: <201002252215.o1PMFnoP011425@mustang.cs.nmsu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>
Cc: linux-kernel@vger.kernel.org, npavel@ituner.com, tomi.valkeinen@nokia.com, tony@atomide.com, FlorianSchandinat@gmx.de, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, jkosina@suse.cz, bonbons@linux-vserver.org

Hi Rick,

On Fri, Feb 26, 2010 at 6:15 AM, Rick L. Vinyard Jr.
<rvinyard@cs.nmsu.edu> wrote:
> This patch adds support for examining and modifying the fbdefio delay
> parameter through sysfs. It also adds two driver definable minimum
> and maximum bounds.

Thanks for posting this. I've now read through this patch and your
past patches, but I couldn't get a good understanding of how this
userspace exposed defio delay would interact with most existing
systems.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 Set the deferred I/O delay of the framebuff=
er in ms.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 This value can be used to throttle deferred=
 I/O updates.

Please help us understand how userspace should use the ability to set
this delay. Who in userspace is intended to use it? Would this be the
X server, cairo, or papyrus? A separate daemon? Human interaction?
When should said userspace entity throttle updates? How would this
entity know when throttling is needed? Could this throttling possibly
or should this possibly be done automatically by the driver itself?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 Most framebuffer devices do not have or nee=
d support for
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 deferred I/O. Accessing a framebuffer witho=
ut deferred I/O
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 support will return -ENODEV. Can be read bu=
t not modified if
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /sys/class/graphics/<fb>/defio_delay_max is=
 0. When modifying,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 the value must be greater than or equal to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /sys/class/graphics/<fb>/defio_delay_min an=
d less than or equal
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 to /sys/class/graphics/<fb>/defio_delay_max.

Please help the reader of above understand the sequence of userspace
changing the defio delay, and how and when that would affect the
associated drivers. Will the delay behaviour be standard for all defio
client drivers? What happens in all the various timing scenarios, eg:
if a defio delay is changed in the middle of a display update or a
defio page clean or before? The sysfs parameter description mentioning
min/max above could use some elaboration as reading it doesn't make
clear if userspace can also affect min/max or if it is completely
owned by the driver.

Thanks,
jaya

ps: I only found your patches by accident when reading through the
fbdev mailing list. I'm very interested in defio (I happen to be the
author of it) and also drivers that use defio so I would appreciate
being CCed on such changes. Thanks a bunch.
