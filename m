From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Date: Tue, 06 Jul 2010 11:42:56 +0000
Subject: Re: [PATCH] OMAP: DSS2: OMAPFB: add support for FBIO_WAITFORVSYNC
Message-Id: <20100706114256.GC8925@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1278104096-27809-1-git-send-email-notasas@gmail.com>
 <19F8576C6E063C45BE387C64729E7394044EAADA06@dbde02.ent.ti.com>
 <20100706100533.GB8925@nokia.com>
 <19F8576C6E063C45BE387C64729E7394044EAADB6B@dbde02.ent.ti.com>
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044EAADB6B@dbde02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen Tomi (Nokia-MS/Helsinki)" <Tomi.Valkeinen@nokia.com>

On Tue, Jul 06, 2010 at 01:26:28PM +0200, ext Hiremath, Vaibhav wrote:
>=20
> > -----Original Message-----
> > From: Ville Syrj=E4l=E4 [mailto:ville.syrjala@nokia.com]
> > Sent: Tuesday, July 06, 2010 3:36 PM
> > To: Hiremath, Vaibhav
> > Cc: Grazvydas Ignotas; linux-fbdev@vger.kernel.org; linux-
> > omap@vger.kernel.org; Valkeinen Tomi (Nokia-MS/Helsinki)
> > Subject: Re: [PATCH] OMAP: DSS2: OMAPFB: add support for FBIO_WAITFORVS=
YNC
> >=20
> > On Tue, Jul 06, 2010 at 08:08:14AM +0200, ext Hiremath, Vaibhav wrote:
> > > > @@ -648,6 +649,17 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned=
 int
> > cmd,
> > > > unsigned long arg)
> > > >  			r =3D -EFAULT;
> > > >  		break;
> > > >
> > > > +	case FBIO_WAITFORVSYNC:
> > > > +		if (get_user(p.crt, (__u32 __user *)arg)) {
> > > > +			r =3D -EFAULT;
> > > > +			break;
> > > > +		}
> > > > +		if (p.crt !=3D 0) {
> > > > +			r =3D -ENODEV;
> > > > +			break;
> > > > +		}
> > > > +		/* FALLTHROUGH */
> > > > +
> > > >  	case OMAPFB_WAITFORVSYNC:
> > > [Hiremath, Vaibhav] I don't see any reason why we should still keep o=
ld
> > custom IOCTL support here.
> >=20
> > It can already be used so it should not be removed.
> >=20
> [Hiremath, Vaibhav] I am not in favor of this, if we have standard interf=
ace then we should encourage people to use it. Don't you think we will have=
 different interface for OMAP and different for non-omap device.

What anyone thinks that apps should do doesn't matter. Removing the
ioctl will break the ABI and that is not an acceptable thing to do in
kernel development usually.

--=20
Ville Syrj=E4l=E4
