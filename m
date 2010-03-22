From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 22 Mar 2010 04:35:09 +0000
Subject: Re: [PATCH v2 1/6] hid: new driver for PicoLCD device
Message-Id: <20100322043508.GC31621@core.coreip.homeip.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100320170014.440959a8@neptune.home>
 <20100320170241.55258b0d@neptune.home>
 <20100321034600.GE29360@core.coreip.homeip.net>
 <20100321173737.5fcf3580@neptune.home>
In-Reply-To: <20100321173737.5fcf3580@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Sun, Mar 21, 2010 at 05:37:37PM +0100, Bruno Pr=E9mont wrote:
> On Sat, 20 March 2010 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > +	usbhid_submit_report(data->hdev, report, USB_DIR_OUT);
> > > +	complete_all(&data->ready);
> > > +	INIT_COMPLETION(data->ready);
> >=20
> > Umm, what does this do, exactly?
>=20
> It wakes up anyone waiting on the completion and then resets the completi=
on
> as otherwise any future attempt to wait on it would succeed immediately.
>=20

You realize that if you re-initialize the completion right after
signalling it there is a big chance the waiters will miss it (they do
check completion->done flags that you reset right away.

In general completions are suited for something that happens once (a
single request - allocated - processed - signalled) but not for
repeating use.

Thanks.

--=20
Dmitry
