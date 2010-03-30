From: Jiri Kosina <jkosina@suse.cz>
Date: Tue, 30 Mar 2010 08:12:05 +0000
Subject: Re: [PATCH v4 1/6] hid: new driver for PicoLCD device
Message-Id: <alpine.LNX.2.00.1003301010410.24576@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100324233707.7243b04d@neptune.home> <20100324234022.0361bd80@neptune.home> <20100326065656.GC26602@core.coreip.homeip.net> <20100326102951.3b9ecda1@neptune.home> <alpine.LNX.2.00.1003262156280.24576@pobox.suse.cz> <20100327012245.0ace6a09@neptune.home>
 <alpine.LNX.2.00.1003291144350.24576@pobox.suse.cz> <20100329121611.0c22dcaf@pluto.restena.lu>
In-Reply-To: <20100329121611.0c22dcaf@pluto.restena.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Mon, 29 Mar 2010, Bruno Pr=C3=A9mont wrote:

> > > +static struct hid_driver picolcd_driver =3D {
> > > +	.name =3D          "hid-picolcd",
> > > +	.id_table =3D      picolcd_devices,
> > > +	.probe =3D         picolcd_probe,
> > > +	.remove =3D        picolcd_remove,
> > > +	.raw_event =3D     picolcd_raw_event,
> > > +#ifdef CONFIG_PM
> > > +	.suspend =3D       picolcd_suspend,
> > > +	.resume =3D        picolcd_resume,
> > > +	.reset_resume =3D  picolcd_reset_resume,
> > > +#endif
> > > +};
> >=20
> > struct hid_driver doesn't provide power-management related callbacks.
> > So I guess that you have either not tested this feature at all, or
> > you have some extra patch somewhere which adds such callbacks to HID
> > core, but you haven't sent it out for review?
> >=20
> > In any cases, this will very likely cause compilation failure with=20
> > CONFIG_PM turned on.
>=20
> That's the patch I referred to (under series introduction mail) when
> saying:
> > The series depends on my previous patch adding HID suspend support
> > (I've not yet looked at improving it).
>=20
> Link to the patch:
>   http://lkml.org/lkml/2010/2/24/233
>=20
> Especially the reset-resume part is important as the device has to be
> reprogrammed with framebuffer content, brightness/contrast in that case.
>=20
> As stated, Oliver didn't like the implementation of the addition of
> those hooks too much and I have yet to look at improving it.

Ah, OK, I have missed that one, thanks for pointing it out.

The driver itself now looks fine to me and I am willing to merge it,=20
modulo the power-management code -- so please either remove the parts that =

depend on power management for now, or I'll wait on your respin of the=20
generic HID-PM patch.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
