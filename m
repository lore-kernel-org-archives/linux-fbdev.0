From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Fri, 26 Mar 2010 09:29:51 +0000
Subject: Re: [PATCH v3 1/6] hid: new driver for PicoLCD device
Message-Id: <20100326102951.3b9ecda1@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100324233707.7243b04d@neptune.home>
	<20100324234022.0361bd80@neptune.home>
	<20100326065656.GC26602@core.coreip.homeip.net>
In-Reply-To: <20100326065656.GC26602@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Thu, 25 March 2010 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Wed, Mar 24, 2010 at 11:40:22PM +0100, Bruno Pr=C3=A9mont wrote:
> > +	for (i =3D 0; i < PICOLCD_KEYS; i++) {
> > +		int key =3D ((int *)idev->keycode)[i];
>=20
> Keycodes are now short, not int. Also, just do:
>=20
> 		input_set_capability(idev, EV_KEY, data->keycode[i]);
>=20
> > +		if (key < KEY_MAX && key >=3D 0)
> > +			input_set_capability(idev, EV_KEY, key);

Oops, I was not careful enough when switching over...
Thanks for catching,
Bruno
