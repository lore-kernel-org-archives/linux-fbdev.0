Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFA5C433FE
	for <linux-fbdev@archiver.kernel.org>; Thu, 13 Jan 2022 15:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiAMPlu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 13 Jan 2022 10:41:50 -0500
Received: from mout.gmx.net ([212.227.17.20]:44205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233305AbiAMPlt (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 13 Jan 2022 10:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642088500;
        bh=Pm16orVY4OVh2JPou8ROtUueZdZWdS9G0avKCkWVR9Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Nvz0PXh9F2zCDmcwRtZjMn0Lhv17Fzgyh51MDcaaoWHdcBKz1dmaMZqtRO09cJVo+
         Aifi1wZcIp7PdiDiu6RMkEmeBYnwVCLEWGhAkSvd6AgESOwWpqO1gJHF1d40m+5Iw1
         ENyINu3TH1XNEhxecGjc0iyedxsqI+UmRAsLOUME=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.168.79]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4zAy-1m9eAi2M2W-010vdH; Thu, 13
 Jan 2022 16:41:40 +0100
From:   Helge Deller <deller@gmx.de>
To:     linux-parisc@vger.kernel.org
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH] video/fbdev/stifb: Implement the stifb_fillrect() function
Date:   Thu, 13 Jan 2022 16:40:37 +0100
Message-Id: <20220113154037.49294-1-deller@gmx.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uZDYNAnQnkvzBm7uDLeBebVoRxHZ6kLdIYnWtrsZiOzphrkGnLQ
 wFf3H0qfga5luk0+vxYNzFcaiwPBbeF6ItyzFSrL8DQglULm8htNciz13ljPYGd8qRiQwwV
 cEa/sQ8l/JXtogbYYIqZ+rNf5FzfU0ZtVj1pUUmndUcasewHw+i+OWVcUEOiOfwZRTn0Z72
 FVCAduqRY/3yuT3h5hZ3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DxfzyF7tOlY=:hHHBqbZM+TnNcbvFa4SeyT
 At25mQ9xu134Tw5L5SyBl0IVo+JWikVSqssaGuTRrc8UGwCgV2JnA0FgUWimFOOETeL/YeHaw
 sgmuYJSKojf7rSveotujwmoLUdZzKcPWZgdZSt/nb2lVKij0YG0ZJ6iuD9UW9b7rji+MvemVn
 l5R/ElJa6ij6xmtye7kaa2PKb1VF0pRhi6+FrStlKx1JGavLg2LlnX90JRvXJijkiRGL8LGXr
 Daop6Ns36ch/GlQnlUePYNjlTGW163qSLXlVDc+PrkWc6nz+osSKFaC0XdMeUwnhw0MU3mxtY
 BhVqrt8Yt8+kjQy7JKFOAbyCW4EuHRmerJaWz8xoEAyytcZSYN6KR7tQKIjFUZMRj1IIv7bUW
 /pYSZvuvaOk804qywg5wnVuKFoDvm6IGWblnkgdPjtXLjWg3sTgnqcf0Zml0aXS76rteoapYI
 nJOjS7CqfA1oNN6Ia7KPyH5rTq6/qmJH6KvODck1l5URtFcjv4ZQuxc4hQ4jT1ZrcbIVbw1eu
 AjmJDaQJuHK/pNUeWQ1o/j6nLcFNT6r59U7YYp2pCpG3T+7d5hnGi9v0V8zJ8BXYfWGHjMgv7
 RQifA/ittWP12aopP5sLeAMnwl/pxZ3FIg46uCv9H7zSGqzQUHnnOdtdltTKNw2jp0Xc+Hawa
 h4ctqPtwnqXqEN6/bH1kBx+q8YtR7LbxoZhR+BNeVb01yPTkZ00W+sz79YoKqx6FwYXMoRGHg
 m/4eBP3YmR4tZ7jHn/MUiPV38zHhTkXLe7x9VdovC07TTdLUsB3evsFI2yeBBa7Tm2JZZqZfC
 Epu+auKMXw7E2UnxSmwiNQZtqZLK8FXkYRy4G810H3E8trsKUUykcUv+R8uXwO4HKFU4W4tIl
 OwsXznP6g5o89xePI/tKTIr55/TJYOx2GF7dLu1DicmKRjwgDQ9gaBOcSIDZvuBUGzezJ1E+k
 EsTHePeL50wWmemGFNjGfeS8M2yQifDEeHORai8040fuj3wu0HuOOoq3FmQGMHEHTW3KW8kfX
 b2aaz1k9Rds2ceIlKQ9Le6+Qh6uhVyETcY4CYKfdcuJ4kOECEP08Xo950PTeUMe21zXCy92V7
 ycYDIZb3ArtiPI=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The stifb driver (for Artist/HCRX graphics on PA-RISC) was missing
the fillrect function.
Tested on a 715/64 PA-RISC machine and in qemu.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
=2D--
 drivers/video/fbdev/stifb.c | 43 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index 265865610edc..aae6c9f6ff97 100644
=2D-- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1041,6 +1041,47 @@ stifb_copyarea(struct fb_info *info, const struct f=
b_copyarea *area)
 	SETUP_FB(fb);
 }

+#define ARTIST_VRAM_SIZE			0x000804
+#define ARTIST_VRAM_SRC				0x000808
+#define ARTIST_VRAM_SIZE_TRIGGER_WINFILL	0x000a04
+#define ARTIST_VRAM_DEST_TRIGGER_BLOCKMOVE	0x000b00
+#define ARTIST_SRC_BM_ACCESS			0x018008
+#define ARTIST_FGCOLOR				0x018010
+#define ARTIST_BGCOLOR				0x018014
+#define ARTIST_BITMAP_OP			0x01801c
+
+static void
+stifb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+{
+	struct stifb_info *fb =3D container_of(info, struct stifb_info, info);
+
+	if (rect->rop !=3D ROP_COPY)
+		return cfb_fillrect(info, rect);
+
+	SETUP_HW(fb);
+
+	if (fb->info.var.bits_per_pixel =3D=3D 32) {
+		WRITE_WORD(0xBBA0A000, fb, REG_10);
+
+		NGLE_REALLY_SET_IMAGE_PLANEMASK(fb, 0xffffffff);
+	} else {
+		WRITE_WORD(fb->id =3D=3D S9000_ID_HCRX ? 0x13a02000 : 0x13a01000, fb, R=
EG_10);
+
+		NGLE_REALLY_SET_IMAGE_PLANEMASK(fb, 0xff);
+	}
+
+	WRITE_WORD(0x03000300, fb, ARTIST_BITMAP_OP);
+	WRITE_WORD(0x2ea01000, fb, ARTIST_SRC_BM_ACCESS);
+	NGLE_QUICK_SET_DST_BM_ACCESS(fb, 0x2ea01000);
+	NGLE_REALLY_SET_IMAGE_FG_COLOR(fb, rect->color);
+	WRITE_WORD(0, fb, ARTIST_BGCOLOR);
+
+	NGLE_SET_DSTXY(fb, (rect->dx << 16) | (rect->dy));
+	SET_LENXY_START_RECFILL(fb, (rect->width << 16) | (rect->height));
+
+	SETUP_FB(fb);
+}
+
 static void __init
 stifb_init_display(struct stifb_info *fb)
 {
@@ -1105,7 +1146,7 @@ static const struct fb_ops stifb_ops =3D {
 	.owner		=3D THIS_MODULE,
 	.fb_setcolreg	=3D stifb_setcolreg,
 	.fb_blank	=3D stifb_blank,
-	.fb_fillrect	=3D cfb_fillrect,
+	.fb_fillrect	=3D stifb_fillrect,
 	.fb_copyarea	=3D stifb_copyarea,
 	.fb_imageblit	=3D cfb_imageblit,
 };
=2D-
2.31.1

