From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 25 Aug 2014 14:58:54 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140825145854.GA15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NP+fiIeNjDlB/E6h"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
In-Reply-To: <20140825141600.GA14763@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org


--NP+fiIeNjDlB/E6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 04:16:29PM +0200, Thierry Reding wrote:
> On Mon, Aug 25, 2014 at 03:47:43PM +0200, Hans de Goede wrote:
> > On 08/25/2014 03:39 PM, Thierry Reding wrote:
> > > On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
> > >> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
> > >>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
> > >>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
> > >>> [...]
> > >>>>> If not, perhaps the clock driver should force the clock to be
> > >>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
> > >>>>
> > >>>> I'm sorry, but I'm not going to take any code that will do that in=
 our
> > >>>> clock driver.
> > >>>>
> > >>>> I'm not going to have a huge list of ifdef depending on configurat=
ion
> > >>>> options to know which clock to enable, especially when clk_get sho=
uld
> > >>>> have the consumer device as an argument.
> > >>>
> > >>> Are you saying is that you want to solve a platform-specific proble=
m by
> > >>> pushing code into simple, generic drivers so that your platform cod=
e can
> > >>> stay "clean"?
> > >>
> > >> Are you saying that this driver would become "dirty" with such a pat=
ch?
> > >=20
> > > Yes. Others have said the same and even provided alternative solutions
> > > on how to solve what's seemingly a platform-specific problem in a
> > > platform-specific way.
> >=20
> > This is not platform specific, any platform with a complete clock driver
> > will suffer from the same problem (the clock driver disabling unclaimed
> > ahb gates, and thus killing the video output) if it wants to use simple=
fb
> > for early console support.
>=20
> It is platform specific in that your platform may require certain clocks
> to remain on.

The platform doesn't. simplefb does. simplefb is the obvious consumer
for these clocks, and given the current API and abstraction we have,
it should be the one claiming the clocks too.

> The next platform may require power domains to remain on during boot
> and yet another one may rely on regulators to stay on during
> boot. By your argument simplefb will need to be taught to handle
> pretty much every type of resource that the kernel has.

And I wouldn't find anything wrong with that. We're already doing so
for any generic driver in the kernel (AHCI, EHCI comes to my mind
first, there's probably a lot of others). Why wouldn't we do as such
for this one?

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--NP+fiIeNjDlB/E6h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT+08uAAoJEBx+YmzsjxAgsEoQAJhvyKM7uvMzUF23/8h/IZ/q
wK7lC2/g9yP8biRnYdz4Y0wf8uoBUg0QXhE12xBy82ctM5qnLooNLP8vOsMtE0bI
LbFDjuZ3AMxJ5Vra1T26kxYGobCaNCHa6oMdHvn6uRtABB0c+HaIj5AgOoiFRzQa
pXFmzLg6x7c60hFXofSPUyxkChXgkc8fGC8tsmZs9VdeDiHjTL1cPR5Kbjimnirp
ZrkTZZmRgyo5KyGuY+7+2xwNNIUNRft6MkoWT5V5Tya3lLf/Dts6sfVp+XATXT5C
mjGF9U2BelNUFxZgeB3qKXURHicXI6dqkHWBGEHinuSAZsuXEaJbMWfBSWLO6fCR
0O5Szrns4+/YyemMerK9YvUYhHBBZ9N5bYuaw7bB52wJX8vVd0ftFeKvMZ251GNQ
WEo8y871BdPUL2z/R8VFSZeke7fk+Bnn2h8cAzlfX7npYgVLyq89cOfmBHScYYmh
5oW4QtAFN4ZGYrKGiGdpmx9c7iFUt7SLGqiAF+r1I5xpjaY78Rw3cN/8wgavYqog
iHWC62zbMKlMZVuBYgoTLiRtyppNbrQpwMqlrdTCbrNoUgxY0tFRhJrWn+8PdwsM
RPSIaXU+2XNqHOFjisrnPGJeYfvq2UdQWeQIYTOE66H7KUSL8EedGTSR+cndy8DO
uVwn5XErA4wAg6/+ukFJ
=C+4x
-----END PGP SIGNATURE-----

--NP+fiIeNjDlB/E6h--
