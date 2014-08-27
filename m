From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 27 Aug 2014 13:05:55 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827130554.GG23186@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gm5TwAJMO0F2iVRz"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
 <53FDB46C.5010609@redhat.com>
 <CAKON4Owj=b7r_iuOOrr_5R++oSbxqF0G0i4puFz7aTaUF+weuw@mail.gmail.com>
 <53FDD40A.3040106@redhat.com>
In-Reply-To: <53FDD40A.3040106@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--gm5TwAJMO0F2iVRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 02:50:18PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 08/27/2014 02:44 PM, jonsmirl@gmail.com wrote:
>=20
> <snip>
>=20
> >> 1) Serving as *the* fb until a kms driver is present
> >=20
> > Why can't we whip together a real device specific fbdev driver and
> > quit trying to run without a device specific driver in place? History
> > has shown that to be bad idea except during early boot when there
> > isn't a choice.
>=20
> Writing a kms driver and getting it upstream is not a simple task, and
> starting with a too limited implementation is dangerous as we need to get
> the devicetree binding first from the get go.
>=20
> IOW this is not really a realistic answer to problem 1.
>=20
> <snip>
>=20
> >> 2) Allowing for output of early kernel boot messages.
> >=20
> > For this to work the kernel needs to know two things - address of the
> > framebuffer and the x/y layout. Then just nuke this display when the
> > kernel finishes the boot process.
>=20
> Please read my earlier mails on how completely flawed it is to write
> "when the kernel finishes the boot process". The problem is that there
> is no way to really determine when this happens.

That doesn't mean we can't create new ways to signal this. One option
would be for userspace to signal this, another would be to have critical
subsystems broadcast such events so that things like the clock framework
can listen for those and react accordingly. The fact remains that
disabling all unused clocks unconditinally at late_initcall time is not
(always) the right thing to do.

What this really is is a policy decision and traditionally we don't like
to dictate policy in the kernel, so having something like an optional
feature that would allow userspace to notify the kernel that it's
initialized doesn't sound like a bad idea. This doesn't necessarily have
to mean that all possible devices have been probed (users could choose
to blacklist modules, etc.) but just an indication that the system is
done with essential tasks (for desktop distributions I would assume that
means the graphical login manager has started).

Thierry

--gm5TwAJMO0F2iVRz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/deyAAoJEN0jrNd/PrOh5F8P/j/RlYNcaO11zaqB46jzyadV
5UYf+DSRUkgbk3QFa5LxOjX0kcFxniaq4OPPCSL+YENNhAK1/Car4t/MboTNW1AN
Hog7E0YGldwMvKOtZAxykQDW7OglMkhSSwuyM7JDZD+5CnCGLo45YFhlGSHrFGm0
pSQK5MM8kfssUSZeIIAqELLphZavYU2sVc6SjUSMSG4IQLkp5AierNIdWzHUx1Kg
JY74d3fqSXuKmD53SzNkY5k+3PNO3GLS8JAJhjoQq0K19ythblqvRdPdcE2m8TI8
cwpfSIb0dlP4C9V1na0/8Yce1opQxjHctIPhhhiicoa5Ddyeykg7Qhm6TY5X3wGN
HpNfFipvAZviduUqIn+eQGlhqCFw0d3Bdbglsn/MjO8vxGaxsyatdN/h6+4JerXH
71VVona/KYcM5CtSh2iVDwTg1E5eu/6/naAjfwPPpEKk+SGZzUnLNX7cODtw/Xap
IVT55H6M9ook1lrhjnO1ecySzHuwOzbkoYb6dyt+LZPnr6TC3Fkt8GcNeHqcXqxM
JBSnZUxJUlDAFJqij9Y7154DshpSYNiX4i+L0CVDqItYVHTAjtEkQ3e6JlfLoXdS
CehaLBXXGofgkHGK1AbMoeMgM3y9tdDWQBEFFodGEeppKaHzSBoe49k8soBhxK6j
J+Otf+kxgxrRXrxEZUU4
=2MjC
-----END PGP SIGNATURE-----

--gm5TwAJMO0F2iVRz--
