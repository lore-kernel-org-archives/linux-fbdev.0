From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 25 Aug 2014 14:16:29 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140825141600.GA14763@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
In-Reply-To: <53FB3E7F.4000503@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 03:47:43PM +0200, Hans de Goede wrote:
> On 08/25/2014 03:39 PM, Thierry Reding wrote:
> > On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
> >> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
> >>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
> >>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
> >>> [...]
> >>>>> If not, perhaps the clock driver should force the clock to be
> >>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
> >>>>
> >>>> I'm sorry, but I'm not going to take any code that will do that in o=
ur
> >>>> clock driver.
> >>>>
> >>>> I'm not going to have a huge list of ifdef depending on configuration
> >>>> options to know which clock to enable, especially when clk_get should
> >>>> have the consumer device as an argument.
> >>>
> >>> Are you saying is that you want to solve a platform-specific problem =
by
> >>> pushing code into simple, generic drivers so that your platform code =
can
> >>> stay "clean"?
> >>
> >> Are you saying that this driver would become "dirty" with such a patch?
> >=20
> > Yes. Others have said the same and even provided alternative solutions
> > on how to solve what's seemingly a platform-specific problem in a
> > platform-specific way.
>=20
> This is not platform specific, any platform with a complete clock driver
> will suffer from the same problem (the clock driver disabling unclaimed
> ahb gates, and thus killing the video output) if it wants to use simplefb
> for early console support.

It is platform specific in that your platform may require certain clocks
to remain on. The next platform may require power domains to remain on
during boot and yet another one may rely on regulators to stay on during
boot. By your argument simplefb will need to be taught to handle pretty
much every type of resource that the kernel has.

> As for the suggestion to simply never disable the plls / ahb gates by blo=
cking
> them from ever being disabled in the sunxi clock driver, that is not real=
ly
> a solution either, as we want to be able to turn these things off to safe
> power on screen blank once control has been turned over to the kms driver.

Then perhaps part of the hand-off procedure between simplefb and DRM/KMS
should involve marking PLLs or "gates" as properly managed.

> And while at it let me also tackle the don't use simplefb only use kms ar=
gument,
> that means that the clocks will be turned off until the kms module loads,=
 which
> will cause noticable screen flicker / video output resync, something whic=
h we've
> been trying to get rid of for years now.
>=20
> And no, build in the kms driver is not an answer either. That works nicel=
y for
> firmware, but not for generic Linux distributions supporting a wide range
> of boards.

Odd... I didn't offer any of those two as solutions to the problem.

Thierry

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT+0UgAAoJEN0jrNd/PrOh/DYQAMDsBzxzz7zwcWr88zai3VY1
PwarcfJfN8DWOXYtfwGNGg3PawML9nqbTLv7clpcl08IRX8R4MZdAdYwuDQvweF1
7ch6YWsRYqgfoI3n0+7re0zp5K9ckZfxD3V7HCildJNr5TCUJbg+6YYrCdNRDOfT
EwdMm9w3QfWXzqrqaoQSPSgDkdZX4IR97fZWar1WCyqvy0f0uX21jCX/9CxM3rfs
DQ8hCn0/oRuKBS1PeJOkKnF4v3WzkgCRJAnjPLuT7yokAtniIIDFmqi0PnDEqjsB
XbFIIC0rSoHq/E8TQdzY3HVk2J8UObmUyi0I6f+N+S3l9E4jtDQkepGGflbNnAzI
y4NwhUM3Z8tI6TDRzPsFIp/CxVDXeisFhZjVIdLKPypTqJvTrWyqnDX2pN0A51Yc
OPp8XMDXFYA2pWH432OO+qs84KNOphJ4Bc6x6QDf0qQjBdN2yVgrjQnOERwVCmYh
dg+/6v9btIEUSLtsWjYeJKnvLUIFCk24Hw9V2YYVhdy44hhRZ4vjWBRoEOqPN9CV
GZcwFVWqOuBM1vU3iF04OzK3y532ydQnC/ergDDnrAoSQ6NX2D6KRhXwO9MQ8d47
eIoIwrEHpjzYFJGChwE+IEsiMbo1ldqnVw40GS87VMVW0oiQl2YLUM9iXR0/L1iD
xPxt3A1+4IhhDCSeltBQ
=cTmx
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
