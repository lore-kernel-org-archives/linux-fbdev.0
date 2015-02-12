From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 12 Feb 2015 15:11:21 +0000
Subject: Re: [PATCH 4/8] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <20150212151121.GJ2079@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="R8CP7fzfAHpwDIZp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-5-git-send-email-niederp@physik.uni-kl.de>
 <20150207111821.GN2079@lukather>
 <20150207163541.30047a33@maestro.intranet>
In-Reply-To: <20150207163541.30047a33@maestro.intranet>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


--R8CP7fzfAHpwDIZp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2015 at 04:35:41PM +0100, Thomas Niederpr=FCm wrote:
> Am Sat, 7 Feb 2015 12:18:21 +0100
> schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
>=20
> > Hi,
> >=20
> > On Fri, Feb 06, 2015 at 11:28:10PM +0100, niederp@physik.uni-kl.de
> > wrote:
> > > From: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> > >=20
> > > It makes sense to use vmalloc to allocate the video buffer since it
> > > has to be page aligned memory for using it with mmap.
> >=20
> > Please wrap your commit log at 80 chars.
>=20
> I'll try to do so in future, sorry for that.
>=20
> >=20
> > It looks like there's numerous fbdev drivers using this (especially
> > since you copy pasted that code, without mentionning it).
>=20
> Yes, I should have mentioned that in the commit message. As
> implicitly indicated in the cover letter the rvmalloc() and rvfree() are
> copy pasted from the vfb driver. Honestly, I didn't give this one too
> much thought. It seemed a viable solution to the mmap problem. For a
> bit more history on that, see my comment below.
>=20
> >=20
> > That should be turned into an allocator so that drivers all get this
> > right.
> >=20
> > > Also deffered io seems buggy in combination with kmalloc'ed memory
> > > (crash on unloading the module).
> >=20
> > And maybe that's the real issue to fix.
>=20
> The problem is solved by using vmalloc ;)

Yep, but why do you need to mark the reserved pages?

=2E..

> > > @@ -570,7 +608,7 @@ static int ssd1307fb_probe(struct i2c_client
> > > *client, info->var.blue.offset =3D 0;
> > > =20
> > >  	info->screen_base =3D (u8 __force __iomem *)vmem;
> > > -	info->fix.smem_start =3D (unsigned long)vmem;
> > > +	info->fix.smem_start =3D __pa(vmem);
> >=20
> > Why are you changing from virtual to physical address here?
>=20
> Oh, good catch! This is still a residual of my attempts to get this
> working with kmalloc'ed memory. In the current state the driver is
> presenting a completely wrong memory address upon mmap. As reported in
> [0] info->fix.smem_start has to hold the physical address of the video
> memory if it was allocated using kmalloc. Correcting this let me run
> into the problem that the kmalloc'ed memory was not page aligned but,
> the memory address handed to userspace mmap was aligned to the next
> full page, resulting in an inaccessable display region. At that point I
> just copied the vmalloc approach from the vfb driver.
>=20
> [0] http://stackoverflow.com/questions/22285151/kernel-panic-using-deferr=
ed-io-on-kmalloced-buffer

And the documentation of fb_fix_screeninfo indeed state that this
should be the physical address:
http://lxr.free-electrons.com/source/include/uapi/linux/fb.h#L158

Could you make that a separate patch?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--R8CP7fzfAHpwDIZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU3MKZAAoJEBx+YmzsjxAgef0QAL3+15vESEQgLh9mSRXOwbPM
hBJ07/zElgNO6GEgnjV0KYNkSMVN/9BtuBHPJ9nItrJ6EvmBi7JDGPw2KsjweyCE
VpECZtmWk6iHXF4mZdtycmkcl3IxMmYL9/EdNdnmrNshMEQpDejwQ0zUARTKCh6p
6/bRqkFlfE1/OtVGMGeZ1+qT9j5kCYHIUQ0CHoH/b1t4aJgUq6MP26/u6kktnmKQ
AFXclJ50YzhcIcYXj6YD7S15gZB7yhVRD67wgp73vLnGEAqq1Jns2WLthouv5dfn
sYWeG+hH0zPRevlr31xAWk7WLcRCxdHXwKXrmQd4ixLK+X/1cyG6ban05HqVR9Qd
6fXzEWjRv+EoST4WVZf6eU1rHQfRtP1rNv4tyvyQoRmAkCuoclLb/sk8f1OcD7xg
6fQZjk99E+8kogWrp1cHU3iqIlLqrgNCQD2OLFIeFGwyuN9tLwDeWjYWp3wLgXI3
2f/RUVUBbYlTyPz8vtvKcHLLkmHeXqLwj4krJoz6IJPBk8Orw0avfoTAKG4Qk6g9
hrr4fZqX/DpDHtBuP2uStNCyLuXTFwRxSzcAakC2lTzlQiueLEPO7p3wenNzBeS8
CiP36OnBZ0vbAD55+XKhGgZGJWa6V7pM7wWDszhjsNQBhfkNPM706RihmgWZdUNS
q7jsIoNLDgs+IaGY2PvA
=NQFB
-----END PGP SIGNATURE-----

--R8CP7fzfAHpwDIZp--
