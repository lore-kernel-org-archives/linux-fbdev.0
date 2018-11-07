From: =?UTF-8?q?La=C3=ADs=20Pessine=20do=20Carmo?= <laispc19@gmail.com>
Date: Wed, 07 Nov 2018 00:28:04 +0000
Subject: [PATCH] staging: sm750fb: Add spaces around '+'
Message-Id: <20181107002804.25345-1-laispc19@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org

Add spaces around '+' to correct the following checkpath.pl warnings:

WARNING: line over 80 characters
+                       write_dpPort(accel, *(unsigned int *)(pSrcbuf +
(j * 4)));

WARNING: line over 80 characters
+                       memcpy(ajRemain, pSrcbuf+ul4BytesPerScan,
ulBytesRemain);

Signed-off-by: La=C3=ADs Pessine do Carmo <laispc19@gmail.com>

---

Hi, I am new to Linux community and I am sending this patch to learn
about the kernel development.
Please, let me know if there is anything I can improve.
Thank you!
---
 drivers/staging/sm750fb/sm750_accel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750f=
b/sm750_accel.c
index 1035e91e7cd3..eed840b251da 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -383,7 +383,8 @@ int sm750_hw_imageblit(struct lynx_accel *accel,
 			write_dpPort(accel, *(unsigned int *)(pSrcbuf + (j * 4)));
=20
 		if (ulBytesRemain) {
-			memcpy(ajRemain, pSrcbuf+ul4BytesPerScan, ulBytesRemain);
+			memcpy(ajRemain, pSrcbuf + ul4BytesPerScan,
+			       ulBytesRemain);
 			write_dpPort(accel, *(unsigned int *)ajRemain);
 		}
=20
--=20
2.11.0
