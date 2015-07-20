From: Mark Brown <broonie@kernel.org>
Date: Mon, 20 Jul 2015 20:08:19 +0000
Subject: Re: [PATCH v2 00/10] pwm: add support for atomic update
Message-Id: <20150720200819.GN11162@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tOEJyvZxeaoVWcY4"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150720171950.GE11162@sirena.org.uk>
 <20150720214913.73c47fa6@bbrezillon>
In-Reply-To: <20150720214913.73c47fa6@bbrezillon>
To: linux-arm-kernel@lists.infradead.org


--tOEJyvZxeaoVWcY4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 20, 2015 at 09:49:13PM +0200, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Jul 20, 2015 at 05:31:57PM +0200, Boris Brezillon wrote:

> > > - dropped pwm-regulator patches (should be submitted separately)

> > I think the second patch needs to go in with this series doesn't it?  It
> > was just the enable one that was good to go immediately IIRC.

> I was planning on submitting those two patches after the PWM changes
> have been merged, but you're right, maybe we should think about a proper
> way to smoothly get all of them in the same release.

I see.  We should at least try to get the enable one in this time, I'd
like to just apply it and then either do a cross tree merge for the one
making use of the new functionality or (if the rest of the series gets
held up for some reason) just letting it get merged via Linus' tree.

> I have rebased my work on top your regulator/topic/pwm branch containing
> Lee's work [1].

> Note that patch 1 has changed a bit to take Lee's additions into
> account.

> Thierry, could you create a branch based on Mark's regulator/topic/pwm
> branch ?
> If everybody agrees on the solution I'll send a v3 rebasing my work on
> top of this topic branch.

I think that's fine for me, I can tag the PWM branch in my tree and
Thierry can pull that.

--tOEJyvZxeaoVWcY4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVrVUyAAoJECTWi3JdVIfQs+wH/iqSyJYwzHG6KAcehMfPKiEC
1OVQZS/wlHBsKPBTUPPt1yIgD3leQG/lQI4kDOtYRUSiz0u5qrRe+T2NHsDAWpVD
e1ArnTPxzERvGw95n3ZNT3rHtBWOIDhNwF7STVnlxYaMytgbdQghQOS4TwupwvwR
mTQ4C6VMJvkOscth9QQ5EbC4+M0LghXtFdttIthi7EMZiSP2lcbDpZ+cxp96Uonp
TPPS8fxDfY5v/DwToB7L4uYzxDbHK74xjtEuFssJNcykyul6QyS4NuYgi3mPnhxg
gFUHHbYbUJMzTDxg9yRNjdqJfDX455ee7DdCXuuWT09gbL2tAPqcO6OhldeZgJk=
=dllH
-----END PGP SIGNATURE-----

--tOEJyvZxeaoVWcY4--
