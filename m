From: Marcelo =?utf-8?Q?Guzm=C3=A1n?= Lamperti  <marcelo.guzman.lamperti@gmail.com>
Date: Mon, 08 Jan 2018 01:03:32 +0000
Subject: [PATCH] staging: sm750fb: Remove multiple blank lines
Message-Id: <20180108010332.GA7646@nerv>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Remove multiple blank lines. Issue found by checkpatch.

Signed-off-by: Marcelo Guzm=C3=A1n Lamperti <marcelo.guzman.lamperti@gmail.=
com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 8 --------
 drivers/staging/sm750fb/ddk750_sii164.h | 2 --
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm75=
0fb/ddk750_sii164.c
index c787a74c4f9c..4b34a083f5cf 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -62,8 +62,6 @@ unsigned short sii164GetDeviceID(void)
 	return deviceID;
 }
=20
-
-
 /* DVI.C will handle all SiI164 chip stuffs and try it best to make code m=
inimal and useful */
=20
 /*
@@ -239,10 +237,6 @@ long sii164InitChip(unsigned char edgeSelect,
 	return -1;
 }
=20
-
-
-
-
 /* below sii164 function is not necessary */
=20
 #ifdef SII164_FULL_FUNCTIONS
@@ -402,5 +396,3 @@ void sii164ClearInterrupt(void)
 #endif
=20
 #endif
-
-
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm75=
0fb/ddk750_sii164.h
index 2e9a88cd6af3..862e7bf27353 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -12,7 +12,6 @@ enum sii164_hot_plug_mode {
 	SII164_HOTPLUG_USE_HTPLG            /* Use Hot Plug detect bit. */
 };
=20
-
 /* Silicon Image SiI164 chip prototype */
 long sii164InitChip(unsigned char edgeSelect,
 		    unsigned char busSelect,
@@ -28,7 +27,6 @@ long sii164InitChip(unsigned char edgeSelect,
 unsigned short sii164GetVendorID(void);
 unsigned short sii164GetDeviceID(void);
=20
-
 #ifdef SII164_FULL_FUNCTIONS
 void sii164ResetChip(void);
 char *sii164GetChipString(void);
--=20
2.13.6

