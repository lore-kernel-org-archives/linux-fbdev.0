Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D55CCA482
	for <linux-fbdev@archiver.kernel.org>; Wed, 29 Jun 2022 20:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiF2UAg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiF2UAe (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 29 Jun 2022 16:00:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E506582
        for <linux-fbdev@vger.kernel.org>; Wed, 29 Jun 2022 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656532826;
        bh=X9zbpRPOh+ldE1nkJcYIH0k5ZFae+4Rxt79Zmb1FBKw=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=gzCJCr+O0d3IlfHCTZCcpw9St22P4VvmLORGZjEkaCaVYJx7KN6c0vsHC2U6NhWYN
         XmVWASz30uvH/4/kLnOIE7pC4riAIzUXa93CDtuHN+JQWMZjQUXn4PSEcJX5rueYPx
         Zij1yl2qH3Q2kM1mwp/rAQ4lbahuLmtmmlAtQucU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.135.51]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mFi-1ncpPR3KJQ-0132qo; Wed, 29
 Jun 2022 22:00:25 +0200
From:   Helge Deller <deller@gmx.de>
To:     daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, geert@linux-m68k.org
Subject: [PATCH 4/5] fbmem: Prevent invalid virtual screen sizes in fb_set_var()
Date:   Wed, 29 Jun 2022 22:00:23 +0200
Message-Id: <20220629200024.187187-5-deller@gmx.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220629200024.187187-1-deller@gmx.de>
References: <20220629200024.187187-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xKmtO/00TE159LdMjEf8AoxwSphDIXVRMyd7+AbgNBGf/mNYsg7
 BJK3LQnJudJo9b17lqFUIfsuxBjn87oIF7BsMcF38xCJfSNNIDmZJpW1JJTYcai485HnKso
 6GZQ7v/xsITxgNjfX8fOQl7MBjpOIShDfJqGvfqANw1H4/QxPQtqGdpJhmBATwQkJIuRn1e
 QhO2DHiOV43psWk2N9dog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6M8ukoIwx44=:+xv3kOYUuYBStueuar11to
 NNzzqBZa1bBHnUd1f5Lwchha/9YEyzKkFfcFFxEvfouQ4jB+5z3Myt41hBa3dugnhtUhA4p8c
 ruRPZRyYxUgZsC+oJsKgw7D+Nr4xDajUEzMjYXeoAjH2odNU544E49TgQTDt8ImjEZ33LXkFa
 RLp0Ppfn4LAHxksRENc+NFbfk0NuDmj1HBUKaGJC4PdrAXgibIwpysSRUF0HCBlLdxIVUfW22
 RxFueQqi0PC0U3vFBzJPSSEx07n//hb91geZoGjcAQnUhpxcsOC7frEKIc1etjQImV+jDK6Ov
 cJWh/4DXbEX0oY7g1V2GRSrEsk6SDcVeybHglGuBEb837TD6x/rPziEw0jrM2uCQ4nxD7K0nY
 m4wVdTUipEVwVtPj82HprreFQ9pIMZ1TumDD61IGq3a6E0X+Lh7Y6HiQHxSpnMdTl14MqudbR
 +7dE6BtMRcb9d9yc/H9YmYEelkljwEWidv/vo+usNSQ+/FoYxgMyrX5Pr3G5GA5THJjYpa3Hm
 hhSK53aHaaNkJxN+YsamEq6BZlLejEkI4JTIUQwBOxQMtqAcZtJkFZeP04OG9ti5KDD7ls0Ys
 YlpW0Pxy0eSS3GdX+Bc/o2Yg1atZg2Hckp/7IChI2p66io4LvYrKlXUvf1wAlWp+hxyfwkeED
 9d51JSDtOzde+64XTG6DfTznsjMseJJkr/KZjlwU13bJPzX7HxRRmUMPHSzembOZzykt42LKj
 LbQyv02oeaYoPHw+P4mGw17ujpqSYQdlm8sBKy6QuVKy7WpP2O+s/8WurrTd64tChNMqFQB3y
 ha8PZIxnBeXvOJr7TEr72r6kTAfTSJR/qEewjB8VjZ3DJToduYAeO4Beym7c99yxQOyU5H0TY
 +PIZysDyD76ftt9qzSdPFMxGKvkqYn4kg0MrKt8sLaWRbRty3Y7JD5wEDM4XhiCjyI3Mqi+ZC
 Wyai0p17eMVZWY26o/35gLaYCS5dPlGGYrbFBLirlnNXg+f29VqCuPEidIiWBV0diEUegSCjp
 0x+RJPZ7GOb7d/EggB4DLzr/cotU5VDxs+v7hP5s2ZAylzvkJSNj2RYMyk+oJVykneGR2CLrm
 VbCHNnJGHt6U8YDOLJ4jE302rYuPLILCoZ4jxjXpfctsZrMeD8kBhKSVw==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Prevent that drivers configure a virtual screen resolution smaller than
the physical screen resolution.  This is important, because otherwise we
may access memory outside of the graphics memory area.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.4+
=2D--
 drivers/video/fbdev/core/fbmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/f=
bmem.c
index 324f726739c4..222d94e2e0a2 100644
=2D-- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1006,6 +1006,12 @@ fb_set_var(struct fb_info *info, struct fb_var_scre=
eninfo *var)
 	if (var->xres < 8 || var->yres < 8)
 		return -EINVAL;

+	/* make sure virtual resolution >=3D physical resolution */
+	if (WARN_ON(var->xres_virtual < var->xres))
+		var->xres_virtual =3D var->xres;
+	if (WARN_ON(var->yres_virtual < var->yres))
+		var->yres_virtual =3D var->yres;
+
 	/* Too huge resolution causes multiplication overflow. */
 	if (check_mul_overflow(var->xres, var->yres, &unused) ||
 	    check_mul_overflow(var->xres_virtual, var->yres_virtual, &unused))
=2D-
2.35.3

