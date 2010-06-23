From: Jiri Kosina <jkosina@suse.cz>
Date: Wed, 23 Jun 2010 10:30:01 +0000
Subject: Re: [PATCH] hid Logitech G13 Driver 0.0.5
Message-Id: <alpine.LNX.2.00.1006231229230.13809@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LNX.2.00.1006211442350.13809@pobox.suse.cz> <d1cda632f4cdb650a68119903473fbb4.squirrel@intranet.cs.nmsu.edu> <20100623122344.372e5f75@neptune.home>
In-Reply-To: <20100623122344.372e5f75@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>, Marek Vasut <marek.vasut@gmail.com>, Pavel Machek <pavel@ucw.cz>, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, linux-usb@vger.kernel.org, oliver@neukum.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, npavel@ituner.com, tomi.valkeinen@nokia.com, tony@atomide.com, florianschandinat@gmx.de, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org

On Wed, 23 Jun 2010, Bruno Pr=E9mont wrote:

> Please check how your driver behaves if the framebuffer is still in use
> (open and/or mmapped) by some userspace process when you unplug the
> keyboard.
>=20
> Probably you will get hit be the same complaints from kernel I was seeing
> with PicoLCD driver (see my patch http://lkml.org/lkml/2010/5/30/15 that
> is expected to fix it on PicoLCD side, the refcounting part of the patch)

BTW I'd like to have this fixed, but I haven't seen any Acks from=20
framebuffer people, which I'd really like to have before taking it through =

my tree.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
