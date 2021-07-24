Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6A4C4338F
	for <linux-fbdev@archiver.kernel.org>; Sat, 24 Jul 2021 17:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329F560E8F
	for <linux-fbdev@archiver.kernel.org>; Sat, 24 Jul 2021 17:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhGXRE0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 24 Jul 2021 13:04:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:59081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGXREY (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 24 Jul 2021 13:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627148677;
        bh=NnnKncfAnaFeKpuZRfNKoEnQZQQS40lYryGaD8rwMk4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NFNUK8e1lGKlLsZ78wPfP5vHKXND1wmC2AI4RH71M5Ie9Y8wYdWHqJVuRDtIJ3wW3
         VXs2CX4KUZKOYnpaq3xLdSs4YyW7qx6gNhO3e4eHKLo/QnqC/AzUNWViHh7ztLdfXa
         a3TfKXl//kPVXrValL65VXLVmtUKycHLbFO8vyjI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Ml6mE-1lMEif0gvs-00lTqs; Sat, 24 Jul 2021 19:44:37 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] staging/fbtft: Fix braces coding style
Date:   Sat, 24 Jul 2021 17:14:11 +0200
Message-Id: <20210724151411.9531-4-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724151411.9531-1-len.baker@gmx.com>
References: <20210724151411.9531-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lxq6kiLtjzFc7OrUMkOeAtgYvYuYKRc/giZKldt3BoFUT8h46VN
 Kg9FIPsCHHoEzU1Mpx9okxfyNGfBWPsPHYWimuPRdKM7YMgx2f/hyOp2LoOaeTQQ39tB119
 r00lutgbYittzltAdnF6QCZZMkyT5+zF0brw7VKPt3rZbRv5z9hwxA/m471V2iAF4Ivk4re
 fJ9snb6LaTghFsDzNuZKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+WwuL9lnI14=:Lg8CcfCZ7rwXHqQl323hZy
 fGlFde99fZWlaom5py+XLvoegd+qdqmZEnaZcZfjaZXvCeQfq1VcgF/kPHuf3DX7+Dnc+fEYM
 GF5J3HJvxIuQB/LKFn2AYmrVe+k7eP8fdhESjiwle6j2jlpdvGJkY53L22oeIQ9pjNVzIssJR
 lTeRxVTZoFtv7PJXi4frv7WYleVjSsoS+aMSpp7psFbCVzS0eR36Fl61cRvfhokOfM3YVs71d
 TSUNWgcaTPd2gGx/iffDIqzBPfpZfSPZ57NqUjGggEfbgwrNQyh7zBArIEtgH6Qdl/hRT32PJ
 JXoI9p0V8gNiUjVGp1f1s9Uz/+ibpDt7QxC6XeQ+0bo1/uw6tqnO3lVGaVIHVWKq7VzeNY4+d
 2OpnbFIPjtMG4G37mboGXULo2eh2u2o6A0XFu2pYtyK0J8GAyB5aIjgh7s9SVTV94dYXhLCBv
 0miwN3QGGRxpnD5Kxw+0pfJfAJubKiXXXruRCsawp5sJ1aqNmI/GellC7vWzdjvW3M7JFhBxV
 D+LTiSfdu6TIqkaju1DEGsoHLejU9iO+jg2GOwpf4tsTVfz1rkaaYRT/YilFHbaxeuENaDVUZ
 KlfGAn9Q7eBgvNoXqYPJUM5Pt6dN/Eo6NbpkJs5P7okfSgpPdP2YqDk9OMZRSdn0kNciNMdl+
 MXvkoUTAtJe1fy93gvr7MVIvwmN5QCaxcMZI9NMCETYMV7S45tDl+wEZvFEdBP9aSuXC0ughK
 9odmeqPINVGQWl1Vd5BMuvN1jf1ucvBSmD+b+XDCaA8oPJGqNg94oTA5jI2lbELcTe+UEUC4k
 2VZZkSasNSfjuaS0Qw9UY62tOGme/eW2xzVXIUdkAfKzSdOYg5SspQsEp7tl/gKC640W26ivK
 +3GDojDJUFZNf5dAvtRwplJIKRuG3mo4RXhFXDekbKGom+ybJq+s19ZFJRtYW30q99dg66Oqn
 NVZ/95qRcpoIbhYb87SLwP2G1O9gMhadg3TgGQpfaJZstM6uK6dGjVuaN6h/ixb7IWFI5k/Nl
 7wG2olAL5nGf7iJQ2NFtfHQ9f0MCh6jDVlSoiwy4qZmjA2XnlK5rUjsDTiI6vIPDskEW+/YdI
 DBKweJCMhiMW2bjwr0ar/okB4t5uJ6NbzgQ
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add braces to the "for" loop and remove braces from the "if" statement.
This way the kernel coding style is followed.

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/staging/fbtft/fbtft-core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fb=
tft-core.c
index cc2bee22f7ad..d87792649efe 100644
=2D-- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -1003,9 +1003,11 @@ int fbtft_init_display(struct fbtft_par *par)
 	}

 	/* make sure stop marker exists */
-	for (i =3D 0; i < FBTFT_MAX_INIT_SEQUENCE; i++)
+	for (i =3D 0; i < FBTFT_MAX_INIT_SEQUENCE; i++) {
 		if (par->init_sequence[i] =3D=3D -3)
 			break;
+	}
+
 	if (i =3D=3D FBTFT_MAX_INIT_SEQUENCE) {
 		dev_err(par->info->device,
 			"missing stop marker at end of init sequence\n");
@@ -1016,10 +1018,9 @@ int fbtft_init_display(struct fbtft_par *par)

 	i =3D 0;
 	while (i < FBTFT_MAX_INIT_SEQUENCE) {
-		if (par->init_sequence[i] =3D=3D -3) {
-			/* done */
-			return 0;
-		}
+		if (par->init_sequence[i] =3D=3D -3)
+			return 0; /* done */
+
 		if (par->init_sequence[i] >=3D 0) {
 			dev_err(par->info->device,
 				"missing delimiter at position %d\n", i);
=2D-
2.25.1

