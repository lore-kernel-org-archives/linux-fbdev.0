Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52521C7EE2C
	for <linux-fbdev@archiver.kernel.org>; Sat, 27 May 2023 09:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjE0JaY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 27 May 2023 05:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjE0JaX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 27 May 2023 05:30:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD752D3
        for <linux-fbdev@vger.kernel.org>; Sat, 27 May 2023 02:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1685179817; i=deller@gmx.de;
        bh=Ub76/RFJwYAmxJ7Nq0hhmU3imJIdF21c1d+mNwim1x8=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=pMXEbaFZSqr/+zSIiEknbPnOFJWhZ1hAYazjY/n1bYkIIS89xgnW4wRMLXQNdrdVm
         G9otVmZTpix2AP4Ljq4LNz6baLqB3W9+bJG1JXPdMt8wQkTnDn9YoR3L2ZFgrplSSa
         P5O8GTHedxHMHNGKicp6foyNxEQP2+pcYIocAoYZn8wDEbitMvMlHMu1pB0nKodSBh
         G84nodCSIwLMzVgnfG/lunZ0nW+4fJs48WEpI5Lmff+2nzazrkyxzyOst9dFEqmLFT
         OjSeYdnFCVMXjA2O4H0l1bHYA4KoZnLymQpIbEG4IIMJefyxkC9FMD2qkFVvGxNMx4
         1HU7pIY/OBosQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ls3530.fritz.box ([94.134.159.182]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s0j-1q4DIU0ywB-0022tT; Sat, 27
 May 2023 11:30:17 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        stern@rowland.harvard.edu
Subject: [PATCH] fbdev: imsttfb: Release framebuffer and dealloc cmap on error path
Date:   Sat, 27 May 2023 11:30:16 +0200
Message-Id: <20230527093016.486521-1-deller@gmx.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:crPjy995UI032iOiIkfi5gEfMIlSMKKlohpDau3afmh4df3Fn9E
 oSt7ZD7qHAZEr/EhB1LD84WClrDiOVMg9JKDd3uN+pOhshpLALavswdCXrLPaVzkUyNaNt8
 YAUkD5a+38hYArXlS4OkntYP8QF6GPKQ8dHr4AnJyXdQCMffopKyI6PO0qiWqopb9bJj020
 IrI0TIy38WXUzp8NKkqvQ==
UI-OutboundReport: notjunk:1;M01:P0:LpNxU+h9oSw=;YhxuploVOUWI+mqDdmayKYTor/0
 ek4TyS1NF4n8gPB0cuIDnACs0HjXZqtU0Yq7c8Wszx/tQJ++8mRuhNV0AeAhbd43bUWRBN8LQ
 Nzv7E+qNU53LfcrEv5HN1ZjJZxAlqjxkLp0Qc62qiZLdkmI4+xkLz8bY6XVJrBul4U8pANUXx
 IKBHFjIG/o1KmpKR2/KZB3C6AULMc+DxmQNCpChX8pT3bJfvEP0ZDKzRRh7veKyH1BSFxzCga
 yOPiJ70n1MFlNKGGQqOlJgLR0BwsFKiqmSrO31JfmjQeUrGdcDwYkgCm2DWufWo+HKZVOMrC1
 lMeN1UKPyYsl1r4VwlzdvTeNGM99s3MLynbg+2EpPvf86LFXqxExfKqs46J6EKTKNUxNR1oiz
 CTuVo+WkYxXgUCducBPCcj3WD+2+I+rZEUb2ud6o9e8+d5TFJaB2G5XSTaiffh1pxaMmhgSY5
 K0fBq7N7Xios0bK002zrEkEV0jPtPJOgK7MhFyMx3PPHxRZxPFTvvln9gn+q31F1R9grOnowC
 f9WHXtA971pGQLlTZoTJ23idL3N8FOEHOtLGKHeo9kUfb6dzb81jztVuCYNQBC29TBf/P3r7S
 o9o8n9KMfY84Xjtb4GauR/nQ8Ri3fdb905Feql1N5Lv+9asZ7odHrwSycNwi8D513kUGT7V6d
 VRuumys1JdBYBiddRcdE4ij6FM1gB/PErZeSnJsYlW06Az/OgPDmPER78IXSDTgg7XkGoMxN9
 FKRyQDV+xCPPPD9/lG1pIVNz/8fOsXB2nh/Yfzmm6X+koC4uaEwl3Zpf2k6GzSI4ouziTGEWq
 yve2+Raca4spkiqikzAjJ8rXYYxR1al4rWsYIPnlRHZ7s3SPF+PJSi+fgzW4onSYRExmVs9l9
 yT7wGxNMAfKi0zMq5A7316jb5b9wOI2GiB5l3nRrxaG55xySsdaCkLMdYzbKg5ogZsT5vo+IG
 beQOAw==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add missing cleanups in error path.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 drivers/video/fbdev/imsttfb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 975dd682fae4..075f11991281 100644
=2D-- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1452,9 +1452,13 @@ static int init_imstt(struct fb_info *info)
 	              FBINFO_HWACCEL_FILLRECT |
 	              FBINFO_HWACCEL_YPAN;

-	fb_alloc_cmap(&info->cmap, 0, 0);
+	if (fb_alloc_cmap(&info->cmap, 0, 0)) {
+		framebuffer_release(info);
+		return -ENODEV;
+	}

 	if (register_framebuffer(info) < 0) {
+		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
 		return -ENODEV;
 	}
=2D-
2.40.1

