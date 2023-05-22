Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB5EC77B73
	for <linux-fbdev@archiver.kernel.org>; Mon, 22 May 2023 14:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjEVOER (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 22 May 2023 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbjEVOD5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 22 May 2023 10:03:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB904E47
        for <linux-fbdev@vger.kernel.org>; Mon, 22 May 2023 07:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684764216; i=deller@gmx.de;
        bh=+zC3D8AvSEx830CUZFTlFVLy1JxPYYFXGv+HoGh9Av0=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=a9iDEbzShA8bBr7LMGvEO8WLAaOEvqjBYoz2BvSqvoZQPRF5xBDbGkHcpn6w9FC/9
         oREalkbpeQcWFxpbiapFfGjv7rmm/lYMxzCTLy61KAqmBomOkn57zC3kvFB/vDA/oh
         5l2zSSuzZCC92WoJJchoA5rYZn6cRp4Le/wGdb+c0H4myDw5BVIkJxYPUl7/to3Uav
         oAebxDQbvOXYB61T3TDCe/Na7e1th1Q5Rgn0vkKYMVQQjiEWpxUOsEqfeqmObWhMtC
         1jMnaPwwFLjKQBQuJtMZMUntfYY2LlijB1iJOsxZqJ+SyzdKo18gjLQay0qnJDVF7W
         dPqTpXGiOCT0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ls3530.fritz.box ([94.134.144.112]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VHM-1qBZZq2PyU-016swh; Mon, 22
 May 2023 15:58:16 +0200
From:   Helge Deller <deller@gmx.de>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 1/2] sticon/parisc: Allow 64-bit STI calls in PDC firmware abstration
Date:   Mon, 22 May 2023 15:58:14 +0200
Message-Id: <20230522135815.38949-2-deller@gmx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522135815.38949-1-deller@gmx.de>
References: <20230522135815.38949-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f1rA2fw3o3HqeljaA7TXJFVJnsDxEKN8ALDvRtFYdQqvhGK7TJR
 WAMAW80wBSfg/ugKwoty8NCbhaskr5iKroDTPv+pV6pwsX9bDFOFfobVQ3qr4sTwc1TiPbt
 eQb68ZSn1Ot31ZjE1CeSPoE39yVioHugIU/3hH9MvUgZ4s3wITlkDOmwyl9wXijRVEZJLEL
 LedjFFisSK1m57lxVmulw==
UI-OutboundReport: notjunk:1;M01:P0:kb2X3MvJQZg=;13NWqEfR732j7d4vX6xf7euVhVp
 2oAaAQ8TJ+Tzcv2vewIV4wRLM1FFHOLxvEwMU+blPWWOjsJL9hIO4ALyYf0V3O71ZTRBiqY5j
 WbCEjxkBVABsmIqd1QV9XIq3tzRKVzgWjtPO1XQzRpa8RZg/uYdRb7He8HHbOmEZIGfDlXAxC
 7ofCxkt17r67urxQZYOQRtzCl/OMP/uHlIBkRc3+VnX4FcnHrpSLA1bGG7k85M0feOAJGoi01
 2Nh284VaJGsejEorDS2gPcwX9yPKDrUV+QMGg+Qo7RrMXjb++WX8StvjT9VWHBnuM+eKlGywR
 NmxiJE1+SkGTr7F3lGy3+Iz55PKdMejYPpQ2h8P56I2CYgYIZ7sjqm4+bwwAQtjQz2/DuqB0f
 3RFVE9X4rdB+h8zhW6zaJhF2QXruuupPVmxZgC/YOUOgL35R9a9BlGUWHg4zUkvInm3q5DALz
 i/CNCqwZm4hu9nL6DfFJdJktpJGfg3dXXkGT5zNauDdyzAGMcRJ4fX0kKbPMQ9HcSCF6ycegu
 it3O2AWuebMv7R+sPJiznrs1HlTlQpmYtaW/SU84QbK8UlKRNFrEluG1aJPIHpfUg8DKKpgbY
 FXdCl7+PFq62pD3e5y5XnV6gvJWy5NlqRZoD9OLn0zd3pu5ASj8ZXBFrH5uAOV8eeSP+D12Y9
 L46l+7YkHFN9k/YyUQUlkfIa3GbTNytNN6vGdWHmdWpagBspN5hPB50x5Wu9RcTnTfcdRRnTQ
 vP6W+C5P5irNfb3C+jBTXHWm0KKt7hPU74erjXnFJhoILtz2vL/tpD9I+ENEJaKHi7pcde1y+
 /MDuueCuoDT1PT9XYjTZ9e06YJnwKZ2gm/Ccs9xkLAdoOvGIn2K06Rrz8/KSqxB5s5+AQ/6PX
 hr3ZfbcngAUY9/5RZF+hnKvUlZNnQs7pPZGuiYpjuL5z4+G10g/8pjn9u2ZRHrJNG67ePJ9xI
 mTbmZw==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Some 64-bit machines require us to call the STI ROM in 64-bit mode, e.g.
with the VisFXe graphic card.
This patch allows drivers to use such 64-bit calling conventions.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 arch/parisc/include/asm/pdc.h |  4 ++--
 arch/parisc/kernel/firmware.c | 21 ++++++++++++++-------
 drivers/video/sticore.c       |  2 +-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/parisc/include/asm/pdc.h b/arch/parisc/include/asm/pdc.h
index 2b4fad8328e8..269b9a159f01 100644
=2D-- a/arch/parisc/include/asm/pdc.h
+++ b/arch/parisc/include/asm/pdc.h
@@ -88,8 +88,8 @@ int pdc_iodc_print(const unsigned char *str, unsigned co=
unt);

 void pdc_emergency_unlock(void);
 int pdc_sti_call(unsigned long func, unsigned long flags,
-                 unsigned long inptr, unsigned long outputr,
-                 unsigned long glob_cfg);
+		unsigned long inptr, unsigned long outputr,
+		unsigned long glob_cfg, int do_call64);

 int __pdc_cpu_rendezvous(void);
 void pdc_cpu_rendezvous_lock(void);
diff --git a/arch/parisc/kernel/firmware.c b/arch/parisc/kernel/firmware.c
index cc124d9f1f7f..71ef1640db5a 100644
=2D-- a/arch/parisc/kernel/firmware.c
+++ b/arch/parisc/kernel/firmware.c
@@ -1389,17 +1389,24 @@ int pdc_iodc_getc(void)
 }

 int pdc_sti_call(unsigned long func, unsigned long flags,
-                 unsigned long inptr, unsigned long outputr,
-                 unsigned long glob_cfg)
+		unsigned long inptr, unsigned long outputr,
+		unsigned long glob_cfg, int do_call64)
 {
-        int retval;
+	int retval =3D 0;
 	unsigned long irqflags;

-        spin_lock_irqsave(&pdc_lock, irqflags);
-        retval =3D real32_call(func, flags, inptr, outputr, glob_cfg);
-        spin_unlock_irqrestore(&pdc_lock, irqflags);
+	spin_lock_irqsave(&pdc_lock, irqflags);
+	if (IS_ENABLED(CONFIG_64BIT) && do_call64) {
+#ifdef CONFIG_64BIT
+		retval =3D real64_call(func, flags, inptr, outputr, glob_cfg);
+#else
+		WARN_ON(1);
+#endif
+	} else
+		retval =3D real32_call(func, flags, inptr, outputr, glob_cfg);
+	spin_unlock_irqrestore(&pdc_lock, irqflags);

-        return retval;
+	return retval;
 }
 EXPORT_SYMBOL(pdc_sti_call);

diff --git a/drivers/video/sticore.c b/drivers/video/sticore.c
index 7eb925f2ba9c..60ba3ab5b6cc 100644
=2D-- a/drivers/video/sticore.c
+++ b/drivers/video/sticore.c
@@ -1142,7 +1142,7 @@ int sti_call(const struct sti_struct *sti, unsigned =
long func,
 		return -1;
 #endif

-	ret =3D pdc_sti_call(func, _flags, _inptr, _outptr, _glob_cfg);
+	ret =3D pdc_sti_call(func, _flags, _inptr, _outptr, _glob_cfg, 0);

 	return ret;
 }
=2D-
2.40.1

