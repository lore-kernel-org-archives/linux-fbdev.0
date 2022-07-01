Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4A7CCA482
	for <linux-fbdev@archiver.kernel.org>; Fri,  1 Jul 2022 20:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiGAUWS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 1 Jul 2022 16:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiGAUWR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 1 Jul 2022 16:22:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CECA3EF34
        for <linux-fbdev@vger.kernel.org>; Fri,  1 Jul 2022 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656706927;
        bh=rQmS4yIj+Kq0oK+U8Ryv32tYGBvhOaSYofJZQWpZKAg=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=iWpE2jm7Ufk7mQ50Zm8w8zIY0Q+AxA+1DILK0QiyafiApwOBjuLngJqGaccX7I3Qn
         beQDUbzFzLO2afFs36vneCqxYr+5xajFpnCCd6bzOQoYlGx5IKKOcRVSyJYhwU2whx
         OrABWaWuIO+27WvTFOekaazhOFosvgnAhFdPfkbk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.182.192]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGiJ-1oFJDI2ypf-00RF90; Fri, 01
 Jul 2022 22:22:07 +0200
From:   Helge Deller <deller@gmx.de>
To:     daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org,
        geert@linux-m68k.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/4] fbcon: Disallow setting font bigger than screen size
Date:   Fri,  1 Jul 2022 22:22:03 +0200
Message-Id: <20220701202206.559518-2-deller@gmx.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220701202206.559518-1-deller@gmx.de>
References: <20220701202206.559518-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fzH1XW8PW0o+xI+pNd1m0oozUeUQdrEEe1OqFZbPAd7iLV4MbbW
 vpBM9C7r6IC/MKONWJGv1ouOBm6qifrprX+ZzZwO8B8xnLy6IxWnUXpmkmvQhe9Byl0hURi
 uULXJNuZacUcwswJYLALyFXgMEvpbs/Wo/KabteaPREOI1scjChnz5FvyKzv74Obuz+sZ30
 nus/+ajPRxbKXM/OAifjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aft038Hc5e4=:DFcBXqvipdLAoUMvLCG3KQ
 80zH03BI5YlCMDQqxC8XuPR1VZscY83GWZiQ4SQ77IK/PAqiAORQ8AChtT0BGD4+s7ggp1B3n
 FHCgfscT2YDHes4MI37fquJjOpp0SL4EGnS8VE0K8LIus74E3L6xL70VJfaV+R7+hl8DJgqKV
 0OBZp3DqPiWQcbFM5uEVys6l8bkadRY/fUmc9semeHwoYXhUZmq23TxoltxLCZQeoJsjbGQLN
 HDtFEha8Ad7WuENhZDGtrUvn+QGzoEymT+DK+XVXSrx0kClRufzflBQ1P0/oyts0S4GuQJdqd
 aGtqy3vtluBmNDgd56+TLYOQHZ4acchtwhT6Yqv5tIegbpy0AflL6HB2OwmDomQ0AOjd/fotG
 QEN2kvfdRAIF6GmF8giNDkwpwc/qSZ5G3REc8RX8rfKAfoFWxZ4cBXWby2KY4a8Rp1qmyNMY3
 HJH1jzIXGtasgYCIFNSe3II7QHMv6Q4DINpNlC6gJm9wNg//6tH4m5uT/Sx8jKQSKT9CgY5qQ
 GIbg3bhAPrRICKeIUSVep4ue0yyv59A8N6fhVIRltNg/3/S4VhuJtul8hoMNpgYeJW4Z9TsZY
 K/disEvo5AwZG2vwg+twmvXtEInVnBsvdzmG6aEC17OBpCXDhpSlzfoIPcCStsGtoF0EHk56g
 bPbq/F/C/aGs86kpPDtSBD0wkE5OQO7FncrUBHdEnKq5PiOyS1KL3zHUcbX56zIomNmiDotO1
 n39hlqlQe5H5L7Fyd21N1XUHjrURmyQDvAjjpcOLrB2mW44cD8X9+Iv/nzg4PVj+ubCnVJipl
 PxnyoXOvNuWqzxMHRA9UwdLmX2BpqTrSWYIvQ4ZrVIOJ0bYdqePiD0Xaq50I7zfa8NY7AHZLZ
 GHMv4q+DzHA95zJeysHdogTAR5WWbaDKIbaBcdMGhCVa/jTdfVv2KUlEBdGVO/491xjp4FMNo
 N+n7mPylb2cPJ0bykVq8XG9/xEcOj7ONsnsDqCCwQUWjSdJKIBFkmPpnhMXoYpbAlIkVz53Eo
 1eJbUl5fFROzwG6UYr3yNsuMm7+mGglK9RN8ZDG96cLnIzridUv/1ejYdf8v45Z2bpl73plMT
 ODPuT8DVfK0IekD2J8UShfgWuqpWmS6DQH1PdmtQVQgas7eQz9RYnrrng==
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
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: stable@vger.kernel.org # v4.14+
=2D--
 drivers/video/fbdev/core/fbcon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/f=
bcon.c
index c4e91715ef00..a33532564393 100644
=2D-- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2469,6 +2469,11 @@ static int fbcon_set_font(struct vc_data *vc, struc=
t console_font *font,
 	if (charcount !=3D 256 && charcount !=3D 512)
 		return -EINVAL;

+	/* font bigger than screen resolution ? */
+	if (w > FBCON_SWAP(info->var.rotate, info->var.xres, info->var.yres) ||
+	    h > FBCON_SWAP(info->var.rotate, info->var.yres, info->var.xres))
+		return -EINVAL;
+
 	/* Make sure drawing engine can handle the font */
 	if (!(info->pixmap.blit_x & (1 << (font->width - 1))) ||
 	    !(info->pixmap.blit_y & (1 << (font->height - 1))))
=2D-
2.35.3

