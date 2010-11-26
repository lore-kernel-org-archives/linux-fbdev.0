From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Date: Fri, 26 Nov 2010 12:55:39 +0000
Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
Message-Id: <20101126125539.GG8094@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <19F8576C6E063C45BE387C64729E739404BC762E9A@dbde02.ent.ti.com>
 <1290589057.13243.22.camel@tubuntu>
 <19F8576C6E063C45BE387C64729E739404BCCA3A55@dbde02.ent.ti.com>
 <20101124163100.GB5681@nokia.com>
 <19F8576C6E063C45BE387C64729E739404BCCA3CAE@dbde02.ent.ti.com>
 <yw1xeia81nts.fsf@unicorn.mansr.com>
 <19F8576C6E063C45BE387C64729E739404BCCA401F@dbde02.ent.ti.com>
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BCCA401F@dbde02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Fri, Nov 26, 2010 at 05:38:11PM +0530, ext Hiremath, Vaibhav wrote:
>=20
> > -----Original Message-----
> > From: Hiremath, Vaibhav
> > Sent: Friday, November 26, 2010 5:34 PM
> > To: 'M=E5ns Rullg=E5rd'; linux-omap@vger.kernel.org
> > Subject: RE: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> >=20
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of M=E5ns Rullg=E5rd
> > > Sent: Friday, November 26, 2010 2:09 PM
> > > To: linux-omap@vger.kernel.org
> > > Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> > >
> > > "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> > >
> > > >> -----Original Message-----
> > > >> From: Ville Syrj=E4l=E4 [mailto:ville.syrjala@nokia.com]
> > > >> Sent: Wednesday, November 24, 2010 10:01 PM
> > > >> To: Hiremath, Vaibhav
> > > >> Cc: Tomi Valkeinen; linux-omap@vger.kernel.org
> > > >> Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> > > >>
> > > >> On Wed, Nov 24, 2010 at 03:39:44PM +0530, ext Hiremath, Vaibhav
> > wrote:
> > > >> >
> > > >> > > -----Original Message-----
> > > >> > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > > >> > > Sent: Wednesday, November 24, 2010 2:28 PM
> > > >> > > To: Hiremath, Vaibhav
> > > >> > > Cc: linux-omap@vger.kernel.org
> > > >> > > Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> > > >> > >
> > > >> > > On Tue, 2010-11-23 at 23:46 +0530, ext Hiremath, Vaibhav wrote:
> > > >> > > > Hi,
> > > > <snip>
> > > >> >
> <snip..>
> >=20
> > > > As far as WAITFORGO is concerned, I think GO bit concept is
> > > > something OMAP notion/term and doesn't make sense to standardize
> > > > it. Atleast I am not aware of any other architecture having GO bit.
> > >
> > > Naming is minor detail.  Feel free to suggest a better one.
> > >
> > [Hiremath, Vaibhav] If I fail to convince on this, then I think the only
> > left option is to make WAITFORGO ioctl generic. And put a disclaimer on
> > WAITFORVSYNC, it must not be used in panning use-case.
> >=20
> >=20
> [Hiremath, Vaibhav] Also let me bring another point here,
>=20
> If I understand correctly most of the application libraries (DirectFB, X,=
 etc..) does use FBIO_WAITFORVSYNC to synchronize with HW, and manage ping =
pong mechanism.

DirectFB uses it also for waiting for vsync.

> With this finding, in case of OMAP3 we have to use OMAPFB_WAITFORGO (brea=
king standard applications).

Applications using the standard fbdev API won't work with manual update
displays anyway. You need omapfb specific code to handle it so having
another small difference is not a big deal.

In DirectFB the that's trivial since there's already a simple omap
gfxdriver where you could override the default flip functionality with
WAITFORGO based stuff.

Or, as I said, you could add another standard ioctl and fix up userspace
to use it where appropriate and if the kernel driver supports it.

--=20
Ville Syrj=E4l=E4
