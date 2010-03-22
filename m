From: Jiri Kosina <jkosina@suse.cz>
Date: Mon, 22 Mar 2010 08:54:12 +0000
Subject: Re: [PATCH v2 1/6] hid: new driver for PicoLCD device
Message-Id: <alpine.LNX.2.00.1003220951440.18642@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100320170014.440959a8@neptune.home> <20100320170241.55258b0d@neptune.home> <20100321034600.GE29360@core.coreip.homeip.net> <20100321173737.5fcf3580@neptune.home>
In-Reply-To: <20100321173737.5fcf3580@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Sun, 21 Mar 2010, Bruno Pr=E9mont wrote:

> > > +	}
> > > +	data->status |=3D PICOLCD_BUSY;
> > > +	data->pending =3D work;
> > > +	for (i =3D k =3D 0; i < report->maxfield; i++)
> > > +		for (j =3D 0; j < report->field[i]->report_count; j++) {
> > > +			hid_set_field(report->field[i], j, k < size ? raw_data[k] : 0);
> > > +			k++;
> > > +		}
> > > +	usbhid_submit_report(data->hdev, report, USB_DIR_OUT);
> > > +	complete_all(&data->ready);
> > > +	INIT_COMPLETION(data->ready);
> >=20
> > Umm, what does this do, exactly?
> >
> It wakes up anyone waiting on the completion and then resets the completi=
on
> as otherwise any future attempt to wait on it would succeed immediately.
>=20
> The complete_all() instead of just complete() comes from the reset() func=
tion.
> I can probably reduce it here.
>=20
> Will check this combined with your mutex suggestion above.

I am afraid this code is racy as is. You can't be sure that whoever has=20
been waiting on the completion has been notified already between=20
complete_all() and INIT_COMPLETION(), can you?

Thanks for the driver!

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
