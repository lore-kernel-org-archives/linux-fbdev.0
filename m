From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Thu, 04 Aug 2011 12:09:43 +0000
Subject: Re: [Bugme-new] [Bug 40492] New: FB_BACKLIGHT should be set by
Message-Id: <1312459783.29550.55.camel@thor.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110803175541.7ed2fb24.rdunlap@xenotime.net>
In-Reply-To: <20110803175541.7ed2fb24.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Don, 2011-08-04 at 14:04 +0200, David wrote:=20
> On Thursday 04 August 2011 07:55:16 you wrote:
> > On Mit, 2011-08-03 at 17:55 -0700, Randy Dunlap wrote:
> > > On Wed, 3 Aug 2011 18:55:41 GMT bugzilla-daemon@bugzilla.kernel.org w=
rote:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id@492
> > > >=20
> > > >            Summary: FB_BACKLIGHT should be set by
> > > >            BACKLIGHT_CLASS_DEVICE Product: Other
> > > >            Version: 2.5
> > > >    =20
> > > >     Kernel Version: 3.0.0
> > > >    =20
> > > >           Platform: All
> > > >        =20
> > > >         OS/Version: Linux
> > > >        =20
> > > >               Tree: Mainline
> > > >            =20
> > > >             Status: NEW
> > > >          =20
> > > >           Severity: normal
> > > >           Priority: P1
> > > >         =20
> > > >          Component: Configuration
> > > >        =20
> > > >         AssignedTo: other_configuration@kernel-bugs.osdl.org
> > > >         ReportedBy: StormByte@gmail.com
> > > >         Regression: No
> > > >=20
> > > > Created an attachment (idg432)
> > > >=20
> > > >  --> (https://bugzilla.kernel.org/attachment.cgi?idg432)
> > > >=20
> > > > Kernel's config
> > > >=20
> > > > I discovered a scenario in which menuconfig fails to set
> > > > FB_BACKLIGHT symbol when needed.
> > > >=20
> > > > In my case, I have propietary nvidia drivers once loaded Xorg, but
> > > > in the meanwhile, I have configured an uvesafb framebuffer (thus,
> > > > no other framebuffer active nor compiled).
> > > >=20
> > > > System works ok, but when trying to install nvidiabl[1] (to control
> > > > nvidia's backlight) I find that FB_BACKLIGHT is not set where it
> > > > should be because I have BACKLIGHT_CLASS_DEVICE set.
> > > >=20
> > > > The result is that nvidiabl does not compile.
> >=20
> > Sounds like an nvidiabl bug. I'm successfully using backlight control
> > with radeon KMS with
> >=20
> > # CONFIG_FB_BACKLIGHT is not set
> > CONFIG_BACKLIGHT_CLASS_DEVICE=3Dm
>=20
> It does not seem a bug in nvidiabl, it needs this symbol in order to get =
2=20
> defines (from include/linux/fb.h)
> 394 #ifdef CONFIG_FB_BACKLIGHT
> 395 /* Settings for the generic backlight code */
> 396 #define FB_BACKLIGHT_LEVELS     128
> 397 #define FB_BACKLIGHT_MAX        0xFF
> 398 #endif
>=20
> I think nvidiabl uses those instead of having them hardcoded in its sourc=
e,=20
> and thus not a bug really.

If those defines are relevant outside of CONFIG_FB_BACKLIGHT (radeon KMS
doesn't use them), they should probably be defined somewhere else.


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
