Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BAACCA47E
	for <linux-fbdev@archiver.kernel.org>; Sat, 25 Jun 2022 23:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiFYX1M (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 25 Jun 2022 19:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiFYX1K (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 25 Jun 2022 19:27:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515521262F
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 16:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656199624;
        bh=tRqvkgP3s46IORRaOk1LZP5YQEeJ21rrrTXuUbKXSvE=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=ekyLueu3q4yEKiZDvMkn+rLTB9o/oGUxKPmhZqM6vvBVlIaRBjInTvrGfT243U19e
         Sfq3Ic1xWr26A5K00TNFl2/YryPaexB0y5vaIgoUhlFDRT3JSkh57mW0+gmDGLPt6q
         HSar6354k5GxRXcRqR2SVflqcEQmJtU4TQahCAeY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.162.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6v3-1nK5rv1qWp-00pb5f; Sun, 26
 Jun 2022 01:27:04 +0200
From:   Helge Deller <deller@gmx.de>
To:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        linux-fbdev@vger.kernel.org
Subject: [PATCH v4 1/3] fbcon: Disallow setting font bigger than screen size
Date:   Sun, 26 Jun 2022 01:27:01 +0200
Message-Id: <20220625232703.401821-2-deller@gmx.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220625232703.401821-1-deller@gmx.de>
References: <20220625232703.401821-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kPgt/ZBrXeMKs7bGhKl4XwlKHLKK75ciK7MEj01fO2LR5SVO5M1
 k2oCKgWk+XQTUSU/0PQAzXJWtZUVy8Yj4iG54SUXaQ6q2wu43DbcaSVFvvdx692b4T0SxEO
 jbF/iGrtAS22ja+FAtweeifaWJRIT+EryrHEKpVBLrNiAAV8fAYvHl7fxb96KY3OO4abrKS
 nkFqR1ToqxUdOI4LkRxMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OHawpzh/pyk=:5h8Q7LLBjRQrXxPueJBVtA
 t47X7LA84ma/ZC7qjwFI93R3g4HZuvVZmtuA0JXDcrgZ5/0FLDbUOMvH9ZynuYFysx1rrBduM
 nSF5p4iI/f7qaB3ySTO7wtlEEDpn1i1nb3vm5tqamh++dzqswZiL5+m6g4sc8hQkfZ+Wu0rgu
 EgrqK+gxYdFrVgb/ArtzaKzWMg+8Ol0OdbiykSseY84PQeRkLGopK7mCTXbRPk8823/eTvMAl
 w1sT21xa3xaeM5XnuDK67KPgc8EDIYpZdMJqwNtYt6ouiw83PHqJ5giRWXbgnIDlFg5lPnh/r
 gnBRtTkUTJhjnIMi8d73XunVveKlVgCvp17fNYOtyIPT6oIbx7Hnw2OeFAtDTLY7wxHjCWkjT
 T1mbh4osqLB8H3wWkeLOGDpodYeW+FDE5W8ogQUBNKJWHbyFk1dgmMcuNp00iRMUUhv1as0TO
 CYIlim9Gp+pQtqgO4eQ1yKwFbmwnNeLBdrSSqhsfX3JhF0NveX7HHwCEc+rVxW0nx3ukA7wlF
 NDGtj23XI9p6Pr7uzfB/ctlW90G1yV95CvWAibLoSJX+lHeIuxa9WkG8F33fGmEkoO61848ON
 rjrUdjQTeAqZ/C7FnAirMc+0hMfHgKEH+eiQFKHCg61SS81FmAF7fD39Rj7ASMpW91SsED2TO
 Y3a+6TK/xxKXR2esnssX7WMLpJd03AOw0znAYnsbaIVJoNW8ywpo0afn/WQ2KyEqPSLVK7KFd
 PPdFOjuzZEQA7arBvgf89yThWZrO1myqiyWpdwduiPiyxOdw63RPqoGUM2jTp6V1olfBIaoJK
 r49ydJHfmmH8LEp99svTRAe24y6O/aZBRT3VOBQ4V6bmMK3coIu+Va2Y07qPa1yVMiRdsTq9W
 Pg8Kskwnd6+kMnlM0JlddM2euC24x/C8j+HddGvFvxwyKxNOz+BMCamPYMB17/nA+BNeLm68e
 JJ5rnbDtLZ5XJsJQ7L2Z0r/bL/O999qjJp5huUOLBxhd7L4szFBEpiLxhRZaapEe0narWP9qa
 8fXWY9o403FEBZ+yAQGpLN7kewcIB2l7KPYl71cPdbkgZ0+pa80aSOwAHFd7o2VXrtwwS1tBY
 bSx3Y/CbNiiVKM4t6sGRUkP5B7L/ZtWIWWSM20Bru9wYGYYZUfdH1zuWg==
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

