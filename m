From: Mark Brown <broonie@kernel.org>
Date: Sun, 18 Oct 2015 19:57:19 +0000
Subject: Re: [PATCH RFC 0/2] simplefb: Add regulator handling support
Message-Id: <20151018195719.GC14956@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="zkS4nBu7xsy2hAaK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444669458-5588-1-git-send-email-wens@csie.org>
 <561CAFE8.9080506@redhat.com>
 <20151014105556.GT14956@sirena.org.uk>
 <561E3D28.2090901@redhat.com>
In-Reply-To: <561E3D28.2090901@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--zkS4nBu7xsy2hAaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2015 at 01:31:52PM +0200, Hans de Goede wrote:

> I like your idea in your other mail where you suggest to actually
> use foo-supply and bar-supply names in the simplefb node, and then have
> some code simple iterate over all the properties and check for *-supply
> properties, so that the proper, schematic matching names can be used.

> But surely if we go this way having a helper for this so that others
> can re-use that likely not entirely trivial code is a good idea ?

Yeah.  It's trying to come up with a way to do this that is easy to
avoid abuse that's tricky.

> One user which comes to mind immediately here is the generic mmc-pwrseq
> driver.

> I agree that we need to be careful to not use a helper like this too
> much, but I do believe it will make sense to have it in some rare cases.
> We can put a big warning in both the header declaring it and above
> the implementation to use it scarcely.

I'd rather have something that was visible in the code, not everyone
reads the documentation especially not subsystem maintainers reviewing
drivers that use APIs they're not familiar with.

--zkS4nBu7xsy2hAaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWI/meAAoJECTWi3JdVIfQ/KQH/AplrD5DclG0K6rHq14zyl3s
6TPBcR95e/52urDktvCDt9V5+3rOo9E+I46dnj8UGNgOCgGrt8J7iwuFh2+MYgVy
NBoid3vgU+sXw4vlQBdIwOuqcMPjU8pBuzTEYIjixeGxyjjfh5+eO4Dm8NXMtTcL
I0i84zkG3RTDIlHg90CpDkQ631FRPtgw7A9DaUBOMoSjqqoPtq1Ud06NAqHa2iD0
3y2M1BPJIgTGG2VtJu7peBTyIkTjKSWx2BMXW423/Bv0s1fh+tP3xS3RrLEU24na
47Wc0QpkEgpkAEpZW6Ht2Og2UTG44G1Gm6rROtGEzn8toYrjtfwSVPtpYT08p5g=
=ETM+
-----END PGP SIGNATURE-----

--zkS4nBu7xsy2hAaK--
