Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B23CCA480
	for <linux-fbdev@archiver.kernel.org>; Wed, 29 Jun 2022 20:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiF2UAg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiF2UAe (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 29 Jun 2022 16:00:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561996584
        for <linux-fbdev@vger.kernel.org>; Wed, 29 Jun 2022 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656532825;
        bh=tRqvkgP3s46IORRaOk1LZP5YQEeJ21rrrTXuUbKXSvE=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=Ento3nZdW0q9/UO4RDKRZiVb6pw6ey9KxVMhLEqP+/L3xK3ng/MbZY/wYgTqWBD8L
         yJDSqwo2XEb2z0tMF/g23dVI9XVmLM+bLBvd/V7iCIjnVoSRM1NW1y2RywAa1Axm5a
         +puNJj09fdbmq8+sjyE5UujKloay+fksmkqhfJ2c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.135.51]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJlW-1nNMxZ1hbA-00jJ2Y; Wed, 29
 Jun 2022 22:00:25 +0200
From:   Helge Deller <deller@gmx.de>
To:     daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, geert@linux-m68k.org
Subject: [PATCH 1/5] fbcon: Disallow setting font bigger than screen size
Date:   Wed, 29 Jun 2022 22:00:20 +0200
Message-Id: <20220629200024.187187-2-deller@gmx.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220629200024.187187-1-deller@gmx.de>
References: <20220629200024.187187-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RLQtPxRX4o/1fkCuxSLZsoyQCtuI9fQ9wby/9dJx0ssJ+Za7mXQ
 S3Y3icrcrK2wOwaBeJzjLYV1FxNqBFp/iHungp4Noa87uoMr59FJfl5U092DlNInhh/b5M7
 2SqENKjjuxO3K7tW9HwRex1hoP83mJYklhCqQCBvIlUQveYj2W5+ktjvQz/1/BpYkwGjlzy
 dDjg8KogjvPn7yrb2cLVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z6Ma4WkdjRg=:MOOSdCJ505CPKSqvODfGAj
 k2GJzF+eW+UnJEm5AaqrDSEhzBV43ArNrMthzXyZAT956cWT386yqIEdBA2AgWlMKIxxw7dsE
 MqOnsCuQAjlz4Mk7VgTIpzjhB0Exj6ObNnL5B4Mx6f1D+1YNgnzAWjGCfyGcQagMLFVsoePpS
 a+bflIqP4aHg30DPvD2JqdvGOn5ARul1KoQaLUO5A8gfFgZhSq7U4NcwR9z3EznJUZQOxk5g+
 57lMRIdOnGiHKCkhVyuoyobIEi2XF4XECRCSaVXognd6il6jeY4OdswHndKYhnidqpvoRCIxu
 OdhM3JpVuj54lMbKN8w28KoPsFLF4hjCxdRjbIzPhp0F1+1U16nGY5ffg5zk4N89APJKxfrup
 tF/rYy5F01saiMiv4qH53Qh/T4SyEYKsYpN34SIsLZBsRNeEYpl1hkyfHPSKA6BRbsvSwb7Ge
 wrql9gX8Yla7XPsrdpDQ3kyX+4YFGo0q9pOqiFrzrPr4rGeiaJGRaVX6zJaJb2NSZXdAMMwKf
 BA03Xf3UA7Clc2zf+0n5Y/qbcIuopCP6Y3AhQwf6KIc3IajdNijjfD000UbJS2/nNkpNpnXbs
 InPFrp4XEb+fsgsHIdrxjwz22OtFe+kPT0DlRyelHrJJtePczvHQsbAovDyyBzvvhJro4dIGJ
 JVrQsQcMaN9BOlVxbRoPC8bb1Z4OfbM+gamyToNxyhtDv+Hoh8XDJEC22SD/xV+bu0PcVci1o
 X3Kcv1StOa5WHbWtCToMtPexzjB8KN4PRqYWfP1z5pNq1vswcLNQVP9+ph4R0Q/1MNX7PXknh
 rVmRr+UxfX1EprXjS+xKmxktNX2rLKjA9fyck4v30T3vLT0xWwFbiO++eHDp7ZPCPtmF3Wg9K
 QFSBQH6nw3Oebp9Atn2eC0RkImInfaqtVBbZRW1g1L64LLaiVitbKlmgyXhFtf72VWEwyyhM8
 6J89SZNOPgNz1yXuMQmu5X5iFqBty9e4elx2ooFnCUKCHmOaHuavSIwj6ljKJff+BQTTEGF0L
 UaHqaEzBSItIw6GwSHAuX+ggxhlspAeiNLBAWPjs22X4i/1vKMVX8rYqrw9kIhnsQdrE8lXIP
 ZrSlV6W3lXfePg8ulX7jDnd/8KUIZ0vU9f1+kqjJFCY6+2Xeaf9lJHGzg==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Prevent that users set a font size which is bigger than the physical scree=
n.
It's unlikely this may happen (because screens are usually much larger tha=
n the
fonts and each font char is limited to 32x32 pixels), but it may happen on
smaller screens/LCD displays.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: stable@vger.kernel.org # v4.14+
=2D--
 drivers/video/fbdev/core/fbcon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/f=
bcon.c
index c4e91715ef00..e162d5e753e5 100644
=2D-- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2469,6 +2469,11 @@ static int fbcon_set_font(struct vc_data *vc, struc=
t console_font *font,
 	if (charcount !=3D 256 && charcount !=3D 512)
 		return -EINVAL;

+	/* font bigger than screen resolution ? */
+	if (font->width  > FBCON_SWAP(info->var.rotate, info->var.xres, info->va=
r.yres) ||
+	    font->height > FBCON_SWAP(info->var.rotate, info->var.yres, info->va=
r.xres))
+		return -EINVAL;
+
 	/* Make sure drawing engine can handle the font */
 	if (!(info->pixmap.blit_x & (1 << (font->width - 1))) ||
 	    !(info->pixmap.blit_y & (1 << (font->height - 1))))
=2D-
2.35.3

