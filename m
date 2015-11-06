From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 06 Nov 2015 12:45:54 +0000
Subject: Re: Mobility Radeon HD 4530/4570/545v: flicker in 1920x1080
Message-Id: <20151106124554.GA3630@amd>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20151031212259.GA6253@amd>
 <CADnq5_MoThbrDADBHBRXiEGWC8jukwOLyfjfX9-7d0fB0kbpMA@mail.gmail.com>
 <20151103220919.GA4824@amd>
 <CADnq5_P8TOQ14NiWKgV-YUy0_8P+K842pZ4h7WuU6XBu4o9fyQ@mail.gmail.com>
 <20151103230329.GA4167@amd> <5639B580.1050409@vodafone.de>
 <20151104221000.GA3608@amd>
 <CADnq5_OwDpgTKuS66dBSeFEMqkxi=1mie_xONZsnYj8su4Z_xw@mail.gmail.com>
 <20151105202301.GA3624@amd> <563C0F85.8070204@daenzer.net>
In-Reply-To: <563C0F85.8070204@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>

On Fri 2015-11-06 11:25:09, Michel D=E4nzer wrote:
> On 06.11.2015 05:23, Pavel Machek wrote:
> > Hi!
> >=20
> >>>> The flickering would vanish completely if that's the reason for the =
issue
> >>>> you are seeing.
> >>>
> >>>> Try setting ref_div_min and ref_div_max to 2 in
> >>>>  radeon_compute_pll_avivo().
> >>>
> >>> Ok, I did this, but no luck, still flickers. But the flicker only
> >>> happens when something changes on screen, like dragging a big
> >>> window. Is that consistent with wrong PLL timings?
> >>
> >> Does it go away with radeon.dpm=3D0?  Sounds more like either memory
> >> reclocking happening outside of vblank, or underflow to the display
> >> controllers.
> >=20
> > No, it does not:
> >=20
> > pavel@half:~$ cat /proc/cmdline
> > BOOT_IMAGE=3D(hd0,2)/l/linux/arch/x86/boot/bzImage root=3D/dev/sda4
> > resume=3D/dev/sda1 radeon.dpm=3D0
> >=20
> > ..and same issue. And yes, it looks like an underflow to me. How can I
> > debug reclocking / underflows?
>=20
> Does radeon.disp_priority=3D2 help?

Tried this, and no change, still flickers.

pavel@half:~$ cat /proc/cmdline
BOOT_IMAGE=3D(hd0,2)/l/linux/arch/x86/boot/bzImage root=3D/dev/sda4
resume=3D/dev/sda1 radeon.dpm=3D0 radeon.disp_priority=3D2
pavel@half:~$

I searched for some more config options, and tried:

pavel@half:~$ cat /proc/cmdline
BOOT_IMAGE=3D(hd0,2)/l/linux/arch/x86/boot/bzImage root=3D/dev/sda4
resume=3D/dev/sda1 radeon.dpm=3D0 radeon.disp_priority=3D2
radeon.amdgpu_runtime_pm=3D0 radeon.bapm=3D0 radeon.sched_hw_submission=3D0
radeon.enable_semaphores=3D0
pavel@half:~$

..still flickers.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
