From: Mark Brown <broonie@kernel.org>
Date: Wed, 14 Oct 2015 10:55:56 +0000
Subject: Re: [PATCH RFC 0/2] simplefb: Add regulator handling support
Message-Id: <20151014105556.GT14956@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dXvu6+ixFx2ZffE8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444669458-5588-1-git-send-email-wens@csie.org>
 <561CAFE8.9080506@redhat.com>
In-Reply-To: <561CAFE8.9080506@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--dXvu6+ixFx2ZffE8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 13, 2015 at 09:16:56AM +0200, Hans de Goede wrote:
> On 12-10-15 19:04, Chen-Yu Tsai wrote:

> >Now the DT bindings don't support a list of regulators directly, so
> >I'm working around it by having a "num-supplies" property to specify
> >the number of supply properties to check, and name the actual supplies
> >as "vinN-supply".

> Hmm, I can see the need for a "supplies" property with a list of regulators
> in other use-cases (e.g. the generic mmc-pwrseq driver) too. Now as discussed
> we can simply do vin0-supply - vinN-supply properties and be done with it,
> but maybe we need to actually add support for a generic "supplies" property ?

I really don't like having unnamed supplies, or supplies with names that
don't correspond to the schematic names for the physical supplies.  It
makes it harder to go between the DT and the schematic and encourages
bad practice on specific chip bindings which should be done properly
since it's harder to tell if the binding is done correctly.

Adding something with the pattern of parallel arrays of phandles and
names properties that got introduced after the regulator bindings were
done also means we need to go and update every single binding using
regulators to document the new properties which is going to be tedious
and require constant policing for a while.  I'm also not a big fan of
the pattern from a legibility point of view but that's a separate thing.

> And if not then maybe we need a few generic helper devm helper function which
> takes a node, figures out how much vinN-supply properties there are and returns
> a dynamically allocated array containing references to all the regulators, or
> a PTR_ERR in case of err, at which point the caller is expected to fail the
> probe so that any successfully acquired regulators are released.

I can see it for this sort of simplefb thing but I'm not sure how we'd
discourage drivers for specific hardware from also using the same helper
which then makes it easy to get sloppy board DTs which I'd expect to
lead to hassle down the road as drivers try to use their supplies and
find that actual DTs have things that don't correspond to reality in
them.  The nice thing about having drivers name the supplies they're
expecting is that it makes describing the board as it really is much
more the path of least resistance.

--dXvu6+ixFx2ZffE8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWHjS7AAoJECTWi3JdVIfQYZMH/ji08KaKvK4/5lz9Tt+QmcTG
jJi0S4YlVMrSx3e94O4xdR6m2TE5ITclME0mRWoj8ZdYczJANC19t94Ktvw9Yqst
pTkUUGOBDM916Hl24pRpkHxew5UWXlgfnraRZSZa1EticIPn4+Hj7RZWnCMgYaEZ
qdUTS6Ud1jbszl2V9c++BrSzZbTswagRV6b3la7QV1Pq+ZlTAu0PI63TlDXQdRGS
ugBoJHF+KuLhgEXvk0htNw3UxfB64qoxujfvqXSdIwdNE0F7qZeaTGvc3zJM6SBi
5Nl45od28PXtIuAJ73dKpnPRLrDnnq9HMQEIF5xgAyxBSnxKRWs/JiCm98sSAY4=
=marz
-----END PGP SIGNATURE-----

--dXvu6+ixFx2ZffE8--
