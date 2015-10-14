From: Mark Brown <broonie@kernel.org>
Date: Wed, 14 Oct 2015 10:36:48 +0000
Subject: Re: [PATCH RFC 1/2] dt-bindings: simplefb: Support a list of regulator supply properties
Message-Id: <20151014103648.GS14956@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OowMmFE4aK71mEhh"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444669458-5588-1-git-send-email-wens@csie.org>
 <1444669458-5588-2-git-send-email-wens@csie.org>
 <20151012171018.GB3659@leverpostej>
 <CAGb2v651=uaHEQK4wpEQywgr311NSbqEvYkpsC5zSHPSFq-HHg@mail.gmail.com>
 <561CADFE.2010609@redhat.com>
In-Reply-To: <561CADFE.2010609@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--OowMmFE4aK71mEhh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 13, 2015 at 09:08:46AM +0200, Hans de Goede wrote:
> On 13-10-15 04:22, Chen-Yu Tsai wrote:
> >On Tue, Oct 13, 2015 at 1:10 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> >>On Tue, Oct 13, 2015 at 01:04:17AM +0800, Chen-Yu Tsai wrote:

> >>>+- num-supplies : The number of regulators used by the framebuffer.
> >>>+- vinN-supply : The N-th (from 0) regulator used by the framebuffer.

> >>I don't see why you need num-supplies. Why not just try probing
> >>vin${N}-supply until such a property isn't present in the DT?

> +1 for this.

Even better would be to just enumerate all the properties on the node
and request anything with a FOO-supply name.  That way we can keep
using standard regulator bindings that name the supplies after their
actual names on the device.

> > That's doable. Though I'd add a hard limit on it. Does 16 seem
> > reasonable?

> I would not add a hard limit to the binding, you can use a fixed array in
> the code to make the code simpler. I would say 8 should be sufficient, since
> the limit will only be in the code we can always bump it when we need
> to.

Or just dynamically allocate the array and resize as needed if it starts
to get to be a problem.

--OowMmFE4aK71mEhh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWHjBAAAoJECTWi3JdVIfQK/AH/1yPlf11H6nCC5On09TjJ5Ar
vHQQf90Avaj6fFtPeB23iarIAYHa5xb3J5kn/HPEakh3G1s8lchURSKihGs3aIdK
B11neQeJ0eJCRwFK3UJH/iUhx6J9EYK3OU/I3G1fwGNuMxjAfrCC4EzEVPiyTBzR
QabqtJo1MU+Wg8S7BMETD30sx8LUjYWuuRdzuo72r3DZ9s9iVc0OQivKPg1CxYsb
5+Bsh1U0oz+gDBdk7D8y7jVX7qqK0oZjj9ULLGUsMMwS70nl1m/ZCqSk06yU1sTl
DsnPDU3ARCrhlSFOqjzo4ksJTeSFxfQdAviu+56Im/O+rA8u0VY5gHzgApkOPDM=
=TZzQ
-----END PGP SIGNATURE-----

--OowMmFE4aK71mEhh--
