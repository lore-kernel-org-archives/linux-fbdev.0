From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Date: Thu, 25 Nov 2010 06:53:47 +0000
Subject: RE: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
Message-Id: <19F8576C6E063C45BE387C64729E739404BCCA3CAE@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <19F8576C6E063C45BE387C64729E739404BC762E9A@dbde02.ent.ti.com>
 <1290589057.13243.22.camel@tubuntu>
 <19F8576C6E063C45BE387C64729E739404BCCA3A55@dbde02.ent.ti.com>
 <20101124163100.GB5681@nokia.com>
In-Reply-To: <20101124163100.GB5681@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

> -----Original Message-----
> From: Ville Syrj=E4l=E4 [mailto:ville.syrjala@nokia.com]
> Sent: Wednesday, November 24, 2010 10:01 PM
> To: Hiremath, Vaibhav
> Cc: Tomi Valkeinen; linux-omap@vger.kernel.org
> Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
>=20
> On Wed, Nov 24, 2010 at 03:39:44PM +0530, ext Hiremath, Vaibhav wrote:
> >
> > > -----Original Message-----
> > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > > Sent: Wednesday, November 24, 2010 2:28 PM
> > > To: Hiremath, Vaibhav
> > > Cc: linux-omap@vger.kernel.org
> > > Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> > >
> > > On Tue, 2010-11-23 at 23:46 +0530, ext Hiremath, Vaibhav wrote:
> > > > Hi,
<snip>
> >
> > > Changing it to WAITFORGO would alter the behaviour. Sometimes it would
> > > not wait at all, sometimes it could wait for multiple vsyncs.
> > [Hiremath, Vaibhav] I am quite not sure, whether it makes sense from
> application point of view to wait for vsync if config is not changed. What
> could be the use-case for such requirement, where application won't change
> anything but still would like to wait on vsync?
> >
> > And as far as wait on multiple vsync is concerned, it does make sense to
> coat "WAITFORVSYNC ioctl makes sure that your change got applied to HW".
> >
> > I am not aware of other architectures, but I believe this is something
> OMAP specific stuff. And for other platforms, WAITFORVSYNC means changes
> applied to HW (why does apps care about whether it is vsync or anything
> else?).
>=20
> WAITFORVSYNC waits for the next vsync (or actually vblank in many
> cases).=20
[Hiremath, Vaibhav] Please note that this doesn't include VFP (vertical fro=
nt porch), since you are going to get VSYNC only after VFP.

> That's it. I don't see any point in trying to shoehorn
> other functionality into it.
>=20
> If you want to standardise WAITFORGO type of stuff then just add
> another standard ioctl for it.
>=20
[Hiremath, Vaibhav] I still believe we should not only look at the name of =
IOCTL (WAITFORVSYNC) and define what it should do, it may change based on y=
our platform/HW to get the desired functionality out of it.

I am putting fbdev mailing list in CC to get comments from other folks on w=
hat is expected from WAITFORVSYNC, especially architectures like
	- s3c-fb.c
	- ps3fb.c
	- atyfb_base.c
	- matroxfb_crtc2.c
	- sh_mobile_lcdcfb.c

Please refer the wiki page which explains the OMAP DSS issue - http://proce=
ssors.wiki.ti.com/index.php/OMAP35x_Linux_-_DSS_FAQ


I would still argue on,=20
In OMAP there is chance of miss-match between user application and Display =
HW if user uses FBIO_WAITFORVSYNC ioctl in multi-buffer use-case.

while (1) {
	Update/Create the next buffer
	FBIO_PAN
	FBIO_WAITFORVSYNC //assuming HW-SW stay in sync (which is not)
}

There is definitely an issue with above use-case which has been un-doubtful=
ly conformed now.

At least in case of OMAP, WAITFORVSYNC is useless in multiple buffering use=
-case, application has to use WAITFORGO.

As far as WAITFORGO is concerned, I think GO bit concept is something OMAP =
notion/term and doesn't make sense to standardize it. Atleast I am not awar=
e of any other architecture having GO bit.

Thanks,
Vaibhav

> --
> Ville Syrj=E4l=E4
