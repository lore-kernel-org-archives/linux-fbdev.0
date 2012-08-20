From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 20 Aug 2012 10:46:22 +0000
Subject: Re: [PATCH V4 3/6] OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
Message-Id: <1345459582.2684.9.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-bDEtVfhFTiIa77Of8X68"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344859176-4512-1-git-send-email-cmahapatra@ti.com>
	 <1345115913-6773-1-git-send-email-cmahapatra@ti.com>
	 <1345211692.3158.160.camel@deskari> <1345452124.2684.7.camel@deskari>
	 <CAF0AtAtePhxTsoCyatfXWR+e4sc3WHmg=Wq_ZXkowoGpOg63FA@mail.gmail.com>
In-Reply-To: <CAF0AtAtePhxTsoCyatfXWR+e4sc3WHmg=Wq_ZXkowoGpOg63FA@mail.gmail.com>
To: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-bDEtVfhFTiIa77Of8X68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-08-20 at 16:06 +0530, Mahapatra, Chandrabhanu wrote:

> By releasing resources did you mean the dss.feat memory? I think
> dss_init_features call is wrongly placed and should be placed at the
> very beginning of the probe function.

I meant e.g. pm_runtime_disable() etc. But if the call is moved t the
beginning, there's nothing to release.

 Tomi



--=-bDEtVfhFTiIa77Of8X68
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQMhV+AAoJEPo9qoy8lh71ljkP/0R9L1ziunE67/SOmmyLE/KN
J0eKRSjOr48znKXaAgw758mkvtc+MscoF8vJjHGAQiTMnMXyP3obWQFk0inIsmTI
KYXGJGkRWMkNCq4/y0Dr9SZ7YC0BVY0+ORlbczf6Tbrj+jlY/CMCeaLwaD8DWo8/
FEg4d4Upgbyv2nq3YWeNsnQMml+TPCBW9nIbvTuAlwliTCR/fxfLnJCY+kfx8mEJ
M2iwVecU8iJZxJmsu33/SAFNj4NiKeeWlrw5yfYiFIteITghGlpcnNH0vPLGkeWA
uSveE5xL2KIG70/FGfJ1e69hYRrV+W/YEDCfoOcqlOqRyNaM7JEV6gtWqkQqMvSX
kNrozxCnuPpHGT1ILsmX1pbybifOXTBPR0mUPKRsyKjomf+j1cTs2EZifpyuwViz
lsstPcvn0UfBgO1qIi7lZtWzoMRAceeKbC67me91WYFXgMpRQmrozFaCljFA5TRB
K5n2a3+uXmGLP/y23PZg491KeX1mrknEaWhDOqfJ4Uejh5ZBFs+St3IuCyszc6gV
oOg9YUHDo0CKI/lNpqsrFPaKGPHZXTAesoQcTT4L7LnJrwLx2MgTcT2yuw7genef
Q+D6yC2lvT27ZEEo5tthDMWBKMlXmOzwOTBetal5e0o1jYsEMzbnROrUWh92NJAV
LA3wQp5BHygf7KIxaX9O
=6U+6
-----END PGP SIGNATURE-----

--=-bDEtVfhFTiIa77Of8X68--

