From: Jiri Kosina <jkosina@suse.cz>
Date: Mon, 29 Mar 2010 09:47:27 +0000
Subject: Re: [PATCH v4 1/6] hid: new driver for PicoLCD device
Message-Id: <alpine.LNX.2.00.1003291144350.24576@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100324233707.7243b04d@neptune.home> <20100324234022.0361bd80@neptune.home> <20100326065656.GC26602@core.coreip.homeip.net> <20100326102951.3b9ecda1@neptune.home> <alpine.LNX.2.00.1003262156280.24576@pobox.suse.cz>
 <20100327012245.0ace6a09@neptune.home>
In-Reply-To: <20100327012245.0ace6a09@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Sat, 27 Mar 2010, Bruno Pr=C3=A9mont wrote:

> +#ifdef CONFIG_PM
> +static int picolcd_suspend(struct hid_device *hdev)
> +{
> +	dbg_hid(PICOLCD_NAME " device ready for suspend\n");
> +	return 0;
> +}
> +
> +static int picolcd_resume(struct hid_device *hdev)
> +{
> +	return 0;
> +}
> +
> +static int picolcd_reset_resume(struct hid_device *hdev)
> +{
> +	int ret;
> +	ret =3D picolcd_reset(hdev);
> +	if (ret)
> +		dbg_hid(PICOLCD_NAME " resetting our device failed: %d\n", ret);
> +	return 0;
> +}
> +#endif
[ ... ]
> +static struct hid_driver picolcd_driver =3D {
> +	.name =3D          "hid-picolcd",
> +	.id_table =3D      picolcd_devices,
> +	.probe =3D         picolcd_probe,
> +	.remove =3D        picolcd_remove,
> +	.raw_event =3D     picolcd_raw_event,
> +#ifdef CONFIG_PM
> +	.suspend =3D       picolcd_suspend,
> +	.resume =3D        picolcd_resume,
> +	.reset_resume =3D  picolcd_reset_resume,
> +#endif
> +};

struct hid_driver doesn't provide power-management related callbacks. So I =

guess that you have either not tested this feature at all, or you have=20
some extra patch somewhere which adds such callbacks to HID core, but you=20
haven't sent it out for review?

In any cases, this will very likely cause compilation failure with=20
CONFIG_PM turned on.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
