From: Jiri Kosina <jkosina@suse.cz>
Date: Tue, 27 Apr 2010 13:32:40 +0000
Subject: Re: [PATCH] hid: split picolcd's operation_mode sysfs attribute
Message-Id: <alpine.LNX.2.00.1004271532260.9849@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100324233707.7243b04d@neptune.home> <20100330223224.18fe4f3e@neptune.home> <20100330223350.32044891@neptune.home> <201004011858.45859.oliver@neukum.org> <20100425212916.2b9af33b@neptune.home>
In-Reply-To: <20100425212916.2b9af33b@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Oliver Neukum <oliver@neukum.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Sun, 25 Apr 2010, Bruno Pr=C3=A9mont wrote:

> Original operation_mode sysfs attribute accepts the operation mode
> as main value with an option delay as second value to change
> the start-up delay on mode change.
>=20
> As it is preferred to have exactly one value per sysfs attribute,
> extract this delay into a separate sysfs attribute called
> operation_mode_delay.

Yeah, thanks for fixing this. Applied.

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
