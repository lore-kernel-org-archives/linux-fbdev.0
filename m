From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Sat, 14 Feb 2015 15:36:17 +0000
Subject: Re: [PATCH 4/8] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <20150214153617.GB25269@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gj572EiMnwbLXET9"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-5-git-send-email-niederp@physik.uni-kl.de>
 <20150207111821.GN2079@lukather>
 <20150207163541.30047a33@maestro.intranet>
 <20150212151121.GJ2079@lukather>
 <20150214152212.1643da7d@maestro.intranet>
In-Reply-To: <20150214152212.1643da7d@maestro.intranet>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 14, 2015 at 03:22:12PM +0100, Thomas Niederpr=FCm wrote:
> Am Thu, 12 Feb 2015 16:11:21 +0100
> schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
>=20
> > On Sat, Feb 07, 2015 at 04:35:41PM +0100, Thomas Niederpr=FCm wrote:
> > > Am Sat, 7 Feb 2015 12:18:21 +0100
> > > schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
> > >=20
> > > > Hi,
> > > >=20
> > > > On Fri, Feb 06, 2015 at 11:28:10PM +0100, niederp@physik.uni-kl.de
> > > > wrote:
> > > > > From: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> > > > >=20
> > > > > It makes sense to use vmalloc to allocate the video buffer
> > > > > since it has to be page aligned memory for using it with mmap.
> > > >=20
> > > > Please wrap your commit log at 80 chars.
> > >=20
> > > I'll try to do so in future, sorry for that.
> > >=20
> > > >=20
> > > > It looks like there's numerous fbdev drivers using this
> > > > (especially since you copy pasted that code, without mentionning
> > > > it).
> > >=20
> > > Yes, I should have mentioned that in the commit message. As
> > > implicitly indicated in the cover letter the rvmalloc() and
> > > rvfree() are copy pasted from the vfb driver. Honestly, I didn't
> > > give this one too much thought. It seemed a viable solution to the
> > > mmap problem. For a bit more history on that, see my comment below.
> > >=20
> > > >=20
> > > > That should be turned into an allocator so that drivers all get
> > > > this right.
> > > >=20
> > > > > Also deffered io seems buggy in combination with kmalloc'ed
> > > > > memory (crash on unloading the module).
> > > >=20
> > > > And maybe that's the real issue to fix.
> > >=20
> > > The problem is solved by using vmalloc ;)
> >=20
> > Yep, but why do you need to mark the reserved pages?
> >=20
> > ...
>=20
> As far as I understood mmaped memory is marked as userspace memory in
> the page table and is therefore subject to swapping. The pages are
> marked reserved to make clear that this memory can not be swapped and
> thus lock the pages in memory. See discussions [0,1,2].=20
>=20
> [0]http://stackoverflow.com/questions/10760479/mmap-kernel-buffer-to-user=
-space
> [1]http://www.linuxquestions.org/questions/linux-kernel-70/why-why-setpag=
ereserved-is-needed-when-map-a-kernel-space-to-user-space-885176/
> [2]https://sites.google.com/site/skartikeyan/mmap.html

Hmmm, both https://lwn.net/Articles/28746/ and
http://linux-mm.org/DeviceDriverMmap tell otherwise :)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU32txAAoJEBx+YmzsjxAgQUoP/35iHm/36AAYCeMBbKQwbKy5
5w9S7H+7kXFH2XsUVMFZWdHLNaa4jSTKF6XoVbIWzRqOWRW9QBxFfmvT5zYYTuMQ
dRqWtKjVw9VqKvrys+Cf6ZSdBArS7aWROfi7z8Krd+St+HQlUpyYFHtG7tNqf4IY
UhyRsNq0vLg5JlPrhmWYo9JFepK5NOjw6CvYD0UvCEGm8DoaMUjvzwVEsuuJPUnb
VT029BK8hVE59p2kirpiP//qKiPRIw1/XGlEM+LzgI9AI/3jAXa+1Qb2InCAD551
9HxdgaLpwI6I8GYwho8WlPRjL8V95S1KZj02WkZypBe38jdQJTmrpMd4nx8CnH4P
q7ODBIYLYoVaePKFVU0JBQ0mybnOrRDJqiSFfaluPRrjKNA7sATK/U39WLjZ+X5e
AKPCmQOyVVVfuWyPftXoTzehrw8suLBr8MK5V+08z5fOEUchdHYxYM2r6BdsXoZv
9oAis7CQUcG47nQX5LBNrK6McfpsrYIQ2Ss1k9S/XiSIlQ3uQAxyzYx3+L677xER
8i14Wt7eP00MIvFPHzhIMDhkOpXrKjGf2yCsv9VVDfRJq1/Sfezc/hxpzNA1g/bT
gXQOpFwPHWiwFnJbpksvN+W9hv8FVEYGSxYi6LHuIYg3mtStZ259f3HsLeF6z+oE
05oSjWxnFmEfZaZHulgP
=X7A2
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
