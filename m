Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8716CCA482
	for <linux-fbdev@archiver.kernel.org>; Sat, 25 Jun 2022 12:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiFYMZO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 25 Jun 2022 08:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiFYMZK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 25 Jun 2022 08:25:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA0C1CFE1
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656159903;
        bh=Ay26CGk1aPsgjG95eVOHNR7bePSriIQn1aMGg2u+ms8=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=aC+l2dGY48+Vs++ByX+MJrYaK0KlOQx5peS7ugemKR4/Tk/k09Ltyo1K6QUavAazp
         xr6/QyGpXPc4IGPP/MF4IIJHnqFUMkQXZ08y0Q5t5tMW3wPiKycrhSTnk222Yx+GHe
         gK6KC9FztPX7E3jchEUdJmSyvqn31Pl2X4GJIkcw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.162.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNNo-1o8nxV1uyI-00VMvL; Sat, 25
 Jun 2022 14:25:03 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-fbdev@vger.kernel.org, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, deller@gmx.de
Subject: [PATCH v2 1/4] fbcon: Disallow setting font bigger than screen size
Date:   Sat, 25 Jun 2022 14:24:59 +0200
Message-Id: <20220625122502.68095-2-deller@gmx.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220625122502.68095-1-deller@gmx.de>
References: <20220625122502.68095-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cANQeMXRFyLktZ9xQPHna/UWNDvfGoNjlnXhyc8ecEbkkxb8SnQ
 XpVabKoaEcTFuY+N1kzM4Q0M3eS3EBdcI5/gc8/2MICE7raiS6WKO29HW8jli5LAf+1VyeL
 dbG922eLXJavzFN7TseR4p3TkvzKOCYqjUzcxK82D/BFMxB1P4AaGRil8DJzI22DxPEmSBW
 QVYuVIGLws79rQ3Walewg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jz2D2RW9e8U=:e/KdQo8BBYzJu7BZNVQcoK
 PWkYGjJDGBcDP0FjuwOMFjoxLVvhFVEmWl/kN46D154zQSJMl9Hloxddquu3qtb2DS7+bFEtO
 SrA0she5s56MSfes7YYYwHUDtOfrPOx7O0ZV25Mt7isGjjeVKy1kgH8d2txwVZtt30htXbstF
 Pn0TIxtR4u6tVE6OFQZ2mgwblbIK/loXbE07bjnJGzjXSkLTwowhSOWOYngOeQ1FIC4Bxsl24
 IxzNkqfwRWTVrMTbMQKOIaVAKqBSDxCivsqudlWJZLgwufEgr9bC0VQMjIY65kI1w1Hs7AigD
 PRGFSn6bllDdQj54qkj6E9g6aNTyZQWDZPG8r5tZ+g88LdqDrWdK177qGSy72EHuAdBYJilLP
 iZN0lCKo5sQDKZ5aFyZDGSvMmaeJJGb42BYPMcl/HlYzz5nMGx6pC++ix2R6YGx6RxF5PurGU
 tEN49wCtrF2wB2TCnIxTuE26tx/T53x+w/+avkeyGkBHKYWMbJjA6xoVG8HRGLrxUICghJdj0
 YAso5zVUAb2OJpz5cp0bAnJdlI/FkbHWE3dLGK4lnlg00/ddxtpJBSsOVrZzpDpWX9E7fRcsr
 sr9nXEEL2y4it4Dv0jWqcRNwxluxBZYqeAdkSZLsDg8s2RG8QCPvlHubGvFtMohmC5gufc4ji
 DOHytej6Cj1mOznnMjtcOw2pwtX6J3FoUdtS+sXVeuzrKE9XP0eB7CekzK3EsOQRL+AVg8CDX
 9vjLdDWFabQ/5S5B5i5HJPo7SRViGWAU6/L3ZsggktV6ahHJxGTXysA/kH79lR0gWMqDedOEh
 n4OklNtptmDNwQUeMirBM4ByKcJHYmVfmd6K2SD8getvLy/5BHFqXe6Tv3MpuaaqBh9Qvfu1A
 3e0qwQC8PsbxjP3TqkTRaKJB1d9DQZbi5Mbn8apNvcIliG6zT4DE5fBjCRabuO/EsEd7g/5fI
 t+Lu9KohZPvLCykNT5vxnVPLHcmDI4Fgqn73JVrwDsQnNK+bSFa0yqLjuI0MYwIPHe+xTwqRP
 Vi1ZkLFMyFSQ6XoK1kPL5VjAGwUGeUMNqx/SpReSQSljm9S/+rYWfZSZPteFTRBQfrPhPjxzC
 6/h4QAgArG3IAok9vsN2uSmrVZzuTLJjPDirP4X7A11c4dLPrIGTVshKQ==
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

