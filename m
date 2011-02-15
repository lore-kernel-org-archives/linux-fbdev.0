From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 15 Feb 2011 09:48:08 +0000
Subject: Re: [PATCH] ARM: PXA: Make PXA27x/PXA3xx overlay actually work
Message-Id: <20110215094808.GB4152@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1296679619-32666-1-git-send-email-anarsoul@gmail.com>
	<AANLkTi=AfxN73pSNZ5RiTiTWfxR7PhcyJUyXzzeaYNWw@mail.gmail.com>
In-Reply-To: <AANLkTi=AfxN73pSNZ5RiTiTWfxR7PhcyJUyXzzeaYNWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 15, 2011 at 03:35:44PM +0800, Eric Miao wrote:
> > @@ -720,12 +726,10 @@ static int overlayfb_open(struct fb_info *info, i=
nt user)
> > =A0 =A0 =A0 =A0if (user =3D 0)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> >
> > - =A0 =A0 =A0 /* allow only one user at a time */
> > - =A0 =A0 =A0 if (atomic_inc_and_test(&ofb->usage))
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> > + =A0 =A0 =A0 if (ofb->usage++ =3D 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* unblank the base framebuffer */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb_blank(&ofb->fbi->fb, FB_BLANK_UNBLANK);
>=20
> The change above allows multiple user at a time? Then I guess
> some other places need to be changed accordingly to avoid the
> racing conditions.

You can't prevent multiple users.  Think threaded applications which
share the same set of fds.

Any driver which tries to do so by restricting the number of open()s is
simply buggy.
