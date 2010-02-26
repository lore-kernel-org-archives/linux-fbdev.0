From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 26 Feb 2010 08:15:15 +0000
Subject: Re: [PATCH 1/3] picolcd: driver for PicoLCD HID device
Message-Id: <20100226081514.GB17444@core.coreip.homeip.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100221002001.0a7e05a7@neptune.home>
 <20100224170049.0d04af3c@neptune.home>
 <alpine.LNX.2.00.1002251201430.30967@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1002251201430.30967-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rick L. Vinyard Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>, Nicu Pavel <npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org>

On Thu, Feb 25, 2010 at 12:07:38PM +0100, Jiri Kosina wrote:
> On Wed, 24 Feb 2010, Bruno Pr=E9mont wrote:
>=20
> > +/* Update fb_vbitmap from the screen_base and send changed tiles to de=
vice */
> > +static void picolcd_fb_update(struct picolcd_data *data)
> > +{
> > +	int chip, tile;
> > +
> > +	spin_lock(&data->lock);
> > +	if (!(data->status & PICOLCD_READY_FB)) {
> > +		spin_unlock(&data->lock);
> > +		picolcd_fb_reset(data->hdev, 0);
> > +	} else
> > +		spin_unlock(&data->lock);
>=20
> Please put the brackets to the else branch as well.
>=20
Well, it looks like it can be rewritten as:

	spin_lock(&data->lock);
	need_reset =3D !(data->status & PICOLCD_READY_FB);
	spin_unlock(&data->lock);

	if (need_reset)
		picolcd_fb_reset(data->hdev, 0);

Which plainly shows that the locking here is bogus.

--=20
Dmitry
