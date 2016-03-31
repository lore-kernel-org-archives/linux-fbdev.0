From: Mark Brown <broonie@kernel.org>
Date: Thu, 31 Mar 2016 17:39:42 +0000
Subject: Re: [PATCH] omapfb: Fix regulator API abuse in dss.c and hdmi4.c
Message-Id: <20160331173941.GN2350@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JIgDBBEDRU2Tt5Ar"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459355376-28507-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1459355376-28507-1-git-send-email-broonie@kernel.org>
To: linux-fbdev@vger.kernel.org


--JIgDBBEDRU2Tt5Ar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 31, 2016 at 08:11:08PM +0300, Tomi Valkeinen wrote:
> On 31/03/16 19:49, Mark Brown wrote:
> > On Thu, Mar 31, 2016 at 09:30:11AM +0300, Tomi Valkeinen wrote:

> >> This code did fix an issue, see 02b7a32083b9930543663720758de249b4f6a2a3.

> > That change isn't sensible, especially the _can_change_voltage() like I
> > said in the commit log.

> I may remember wrong, but I think regulator_set_voltage() failed if
> regulator_can_change_voltage() returned false. So I ended up having the
> 'if' there. But I may remember wrong, or maybe it's been changed since.

That's not been the case since 2012 but your change was written in
2014...

> I wonder why we have the same code in hdmi4. Again with a quick look,
> omap4 boards seem to use vdac for hdmi, and vdac doesn't have any
> constraints in twl6030.dtsi, so I presume it's a fixed-voltage.

Yes, if no range is specified the regulator API won't touch the set
voltage.

> Anyway, I'm happy to apply this patch (and we need similar for hdmi5,
> and also for omapdrm), we just need to do any necessary fixes to the
> .dts first.

> Although strictly speaking, I guess that's breaking backward
> compatibility...

Will anyone notice?

--JIgDBBEDRU2Tt5Ar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/WDcAAoJECTWi3JdVIfQnQUH/RUxpeh/517BXa3KXU0A2BVO
MDu0N3jneroHFeOywcilfbCSfbAQHrUjuk6xaJYJ8uewqlW7SfaSQOCo9YCPNkKO
O9asf4+4z0bXAXYCkZJWli7sYIkOtoX8QC3ytuOCdgoLYMqxGjd+G5W1Bj4Ge/Vf
tVHQKgdlHQkkYPpXE2UKF41rUdHVbZNrNGw0WxtFbi+ho8t1HrVq5OLLvqcUoIcg
/UH5chvyKXjWacy3YRiSa39jrgkN7j5zOc/C6szfMns5jk8gpAT3KYBO09CrNAfQ
bmQcw5sJMP/CDkFs+SclixsO4Q+pcof0fPxWqsNsxsrXoGx4M0OOcH/6lsq4WAU=
=Qdy1
-----END PGP SIGNATURE-----

--JIgDBBEDRU2Tt5Ar--
