From: Mark Brown <broonie@kernel.org>
Date: Tue, 17 Dec 2013 18:26:12 +0000
Subject: Re: [PATCH] video: amba-clcd: Make CLCD driver available on more platforms
Message-Id: <20131217182612.GA28455@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386868390-12231-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1386868390-12231-1-git-send-email-broonie@kernel.org>
To: linux-fbdev@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 04:27:34PM +0000, Catalin Marinas wrote:
> On 12 December 2013 17:13, Mark Brown <broonie@kernel.org> wrote:

> > The CLCD driver is used on ARM reference models for ARMv8 so add ARM64
> > to the list of dependencies. The driver also has no build time dependen=
cies
> > on ARM (stubs are provided for ARM-specific DMA functions in the code) =
so
> > make it available with COMPILE_TEST in order to maximise build coverage.

> I haven't followed other CLCD patches but for arm64 it requires
> support for DT. I have been carrying some patches (done by Linaro) for
> a long time and Pawel @ ARM has another set of patches. Do you know
> what the status for those is before enabling CLCD on arm64? That's
> unless you are only looking at compile-testing.

Pawel's patches are going nowhere slowly as far as I can tell due to a
slow feedback loop and extensive discussion of the DT bindings. =20

I think this patch is an orthogonal thing, though - as you say it's
useful for compile testing on its own and it means the driver will load
as soon as the DT bindings are supported.  It's one less patch to carry
out of tree and one less iteration when debugging why the framebuffer
isn't supported when testing.

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsJdBAAoJELSic+t+oim9aWgP/0zzBdNkEg0X+rynPtO3s11J
bWojvTVolCzPkWnrrjxgnHEP0imAC/5iVX4qbhjevs2nQRqlScpz07fCOsdi9Rwn
8QUfjkUQRUC60WT1lg8fo0H3sr6LIXMPb9ZQy/Z/IJFf78Q/gazXtmAnmbp/QSWO
zjVJ0S3bVIejLFwa2gk24WxROQSNSk9wsxx9yvoWw3zVchx8NmxVA2XhupLutzu+
aju2UWd8VXyWvBD6reL0sP6sABn3KPGSXaHR0k5Z0tu1h8hpDm+4sRvauqWp98Tp
xWIqKoqjECVgaG+Ms4zq0ylcSsgkn/n0cERPzinrV6du8PO+5bMBUmwlrS3FlnJ3
KuHqJZEly1bAdVj+9d4I9JMAiLv8nsdIMI+FaD1EqHMCPdhLIggkX5Q2aEcxELNQ
VaalQk2czhW/JloMdilM9Gf+Fh7uDnbuJJUmFcjCNlH1oN2/eya1/EbaY39IvCxF
CzwTvkGw3dvirhy4DssDZ9u8IDfwexKHkYKXmmjRD1PpeptqDw3VI2OtqvWiF3Fm
rj0DY1N03U6RA+RRIXnJoNNr15imzsnhlyzFp0093SYHEZIQQXwVN0vSzB3guPl4
f53G/4Xmd9zEH5CLCwJoBzBgukZ9AomkaVt+JMr6+Cy23yRMwwp9XEYyjtcT4xYp
6IiKvBA86znFj/KfkBqj
=S6Ax
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
