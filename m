From: Jiri Kosina <jkosina@suse.cz>
Date: Fri, 26 Mar 2010 20:59:19 +0000
Subject: Re: [PATCH v3 1/6] hid: new driver for PicoLCD device
Message-Id: <alpine.LNX.2.00.1003262156280.24576@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100324233707.7243b04d@neptune.home> <20100324234022.0361bd80@neptune.home> <20100326065656.GC26602@core.coreip.homeip.net> <20100326102951.3b9ecda1@neptune.home>
In-Reply-To: <20100326102951.3b9ecda1@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Fri, 26 Mar 2010, Bruno Pr=E9mont wrote:

> > > +	for (i =3D 0; i < PICOLCD_KEYS; i++) {
> > > +		int key =3D ((int *)idev->keycode)[i];
> >=20
> > Keycodes are now short, not int. Also, just do:
> >=20
> > 		input_set_capability(idev, EV_KEY, data->keycode[i]);
> >=20
> > > +		if (key < KEY_MAX && key >=3D 0)
> > > +			input_set_capability(idev, EV_KEY, key);
>=20
> Oops, I was not careful enough when switching over...

Dmitry, thanks a lot for rapid review the driver.

Bruno, could you please fix this and submit a followup 1/6 patch, so that=20
I could queue the driver in my tree?

I have almost finished going over the driver and haven't encountered any=20
other issues that would require immediate fixing.

Still, it would be nice to have the framebuffer/LCD/backlight bits=20
reviewed by respective subsystem maintainers. But I'll probably queue the=20
driver nevertheless and add potential ACKs later.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
