From: Ben Hutchings <ben@decadent.org.uk>
Date: Sun, 29 Mar 2015 22:28:28 +0000
Subject: [PATCH] sisfb: Replace creative use of the ternary operator
Message-Id: <1427668108.32382.106.camel@decadent.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-gi4TJPLNJt3chGxrqgcY"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org


--=-gi4TJPLNJt3chGxrqgcY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

GETBITSTR() and related macros are defined in such a way that two of
the macro arguments must be pairs of integers joined with a ':',
selected between by prepending '1?' or '0?'.  This is rather clever
but not very readable.  Redefine the macros and change the users so
that each integer is a separate argument.

While we're at it, add a BUILD_BUG_ON_ZERO() to check that the
redundant first part of the 'to' argument is consistent with the
other arguments.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/sis/init.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/init.=
c
index dfe3eb7..d0c2e72 100644
--- a/drivers/video/fbdev/sis/init.c
+++ b/drivers/video/fbdev/sis/init.c
@@ -3320,11 +3320,9 @@ SiSSetMode(struct SiS_Private *SiS_Pr, unsigned shor=
t ModeNo)
    return true;
 }
=20
-#ifndef GETBITSTR
-#define GENBITSMASK(mask)   	GENMASK(1?mask,0?mask)
-#define GETBITS(var,mask)   	(((var) & GENBITSMASK(mask)) >> (0?mask))
-#define GETBITSTR(val,from,to)  ((GETBITS(val,from)) << (0?to))
-#endif
+#define GETBITSTR(val, fromhigh, fromlow, tohigh, tolow)		    \
+	(((((val) & GENMASK(fromhigh, fromlow)) >> (fromlow)) << (tolow)) + \
+	 BUILD_BUG_ON_ZERO((fromhigh) - (fromlow) !=3D (tohigh) - (tolow)))
=20
 void
 SiS_CalcCRRegisters(struct SiS_Private *SiS_Pr, int depth)
@@ -3363,23 +3361,23 @@ SiS_CalcCRRegisters(struct SiS_Private *SiS_Pr, int=
 depth)
    SiS_Pr->CCRT1CRTC[12] =3D (SiS_Pr->CVBlankEnd   - 1) & 0xFF;			/* CR16 =
*/
=20
    SiS_Pr->CCRT1CRTC[13] =3D							/* SRA */
-			GETBITSTR((SiS_Pr->CVTotal     -2), 10:10, 0:0) |
-			GETBITSTR((SiS_Pr->CVDisplay   -1), 10:10, 1:1) |
-			GETBITSTR((SiS_Pr->CVBlankStart-1), 10:10, 2:2) |
-			GETBITSTR((SiS_Pr->CVSyncStart -x), 10:10, 3:3) |
-			GETBITSTR((SiS_Pr->CVBlankEnd  -1),   8:8, 4:4) |
-			GETBITSTR((SiS_Pr->CVSyncEnd     ),   4:4, 5:5) ;
+			GETBITSTR((SiS_Pr->CVTotal     -2), 10, 10, 0, 0) |
+			GETBITSTR((SiS_Pr->CVDisplay   -1), 10, 10, 1, 1) |
+			GETBITSTR((SiS_Pr->CVBlankStart-1), 10, 10, 2, 2) |
+			GETBITSTR((SiS_Pr->CVSyncStart -x), 10, 10, 3, 3) |
+			GETBITSTR((SiS_Pr->CVBlankEnd  -1),  8,  8, 4, 4) |
+			GETBITSTR((SiS_Pr->CVSyncEnd     ),  4,  4, 5, 5) ;
=20
    SiS_Pr->CCRT1CRTC[14] =3D							/* SRB */
-			GETBITSTR((SiS_Pr->CHTotal      >> 3) - 5, 9:8, 1:0) |
-			GETBITSTR((SiS_Pr->CHDisplay    >> 3) - 1, 9:8, 3:2) |
-			GETBITSTR((SiS_Pr->CHBlankStart >> 3) - 1, 9:8, 5:4) |
-			GETBITSTR((SiS_Pr->CHSyncStart  >> 3) + 3, 9:8, 7:6) ;
+			GETBITSTR((SiS_Pr->CHTotal      >> 3) - 5, 9, 8, 1, 0) |
+			GETBITSTR((SiS_Pr->CHDisplay    >> 3) - 1, 9, 8, 3, 2) |
+			GETBITSTR((SiS_Pr->CHBlankStart >> 3) - 1, 9, 8, 5, 4) |
+			GETBITSTR((SiS_Pr->CHSyncStart  >> 3) + 3, 9, 8, 7, 6) ;
=20

    SiS_Pr->CCRT1CRTC[15] =3D							/* SRC */
-			GETBITSTR((SiS_Pr->CHBlankEnd >> 3) - 1, 7:6, 1:0) |
-			GETBITSTR((SiS_Pr->CHSyncEnd  >> 3) + 3, 5:5, 2:2) ;
+			GETBITSTR((SiS_Pr->CHBlankEnd >> 3) - 1, 7, 6, 1, 0) |
+			GETBITSTR((SiS_Pr->CHSyncEnd  >> 3) + 3, 5, 5, 2, 2) ;
 }
=20
 void

--=20
Ben Hutchings
Sturgeon's Law: Ninety percent of everything is crap.

--=-gi4TJPLNJt3chGxrqgcY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVRh8kee/yOyVhhEJAQodLw//XibFmSXGAiuHLqSKfVHxxCK6/AxW6wnI
Fik7xwFPwVwBS1Pho/w69qgeOg+bvqclPx8GNgITbCBSycVJeKst8FzxT+OEokVb
t4BMqq7MTMsNMlUC8tsmS7ORgDw5si9J0fO1Vil92zI6mdb5oIOEvtSHNje8N5Z4
qkLj7xoDqwCPQJimkztj0MP6S8ea5igBe4wjbh6ndBkoykLAWyKy2MFQU9cBiYBA
zDFCKqX7MiktEWiC8dkLCJKrsChIGnzCzusO13ceHtP5XjUoWtS847iyb27U+wPU
oRasCR4Asljyt5KvxS0Up7lw/qaxlIM6OYOGRmMBQVc8s23p6cvnRke3LdB1Qhmi
XIOxNPHpWSdeepHCDdxqCCp+8cpc3nN0n3nJFZobuRcjmB/SxnYH+0vpy8FVf1wq
6dEm+or4UH8Q2fWE2IBWagG+QW9iW+JRpla4ZLxUz1jejIc/AKTq1AiY7S0io/yn
FqPKW+nK0liKigw3kZDD0Q4Tw4dutS+WQ5PN21u+Y3TVmZstXkK5vPCzuPPnpDsG
oOWVpR65dHRpf8JXQr5PZI5PAlwTMJQA93kCHYmNdgSuSPA2ZoAovctDJiCwShEr
d5o6s90s6tBMubJqzAUc7xSihs1mzyiBjgjRSbmxZrccLi8iKSZTQqTiyPfKRYXw
80b5oGMsjd0=
=ID8t
-----END PGP SIGNATURE-----

--=-gi4TJPLNJt3chGxrqgcY--
