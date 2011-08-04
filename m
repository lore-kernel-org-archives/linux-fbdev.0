From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Thu, 04 Aug 2011 05:55:16 +0000
Subject: Re: [Bugme-new] [Bug 40492] New: FB_BACKLIGHT should be set by
Message-Id: <1312437316.29550.23.camel@thor.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110803175541.7ed2fb24.rdunlap@xenotime.net>
In-Reply-To: <20110803175541.7ed2fb24.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Mit, 2011-08-03 at 17:55 -0700, Randy Dunlap wrote:=20
> On Wed, 3 Aug 2011 18:55:41 GMT bugzilla-daemon@bugzilla.kernel.org wrote:
>=20
> > https://bugzilla.kernel.org/show_bug.cgi?id@492
> >=20
> >            Summary: FB_BACKLIGHT should be set by BACKLIGHT_CLASS_DEVICE
> >            Product: Other
> >            Version: 2.5
> >     Kernel Version: 3.0.0
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Configuration
> >         AssignedTo: other_configuration@kernel-bugs.osdl.org
> >         ReportedBy: StormByte@gmail.com
> >         Regression: No
> >=20
> >=20
> > Created an attachment (idg432)
> >  --> (https://bugzilla.kernel.org/attachment.cgi?idg432)
> > Kernel's config
> >=20
> > I discovered a scenario in which menuconfig fails to set FB_BACKLIGHT s=
ymbol
> > when needed.
> >=20
> > In my case, I have propietary nvidia drivers once loaded Xorg, but in t=
he
> > meanwhile, I have configured an uvesafb framebuffer (thus, no other fra=
mebuffer
> > active nor compiled).
> >=20
> > System works ok, but when trying to install nvidiabl[1] (to control nvi=
dia's
> > backlight) I find that FB_BACKLIGHT is not set where it should be becau=
se I
> > have BACKLIGHT_CLASS_DEVICE set.
> >=20
> > The result is that nvidiabl does not compile.

Sounds like an nvidiabl bug. I'm successfully using backlight control
with radeon KMS with

# CONFIG_FB_BACKLIGHT is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dm


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
