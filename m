Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DBDCCA479
	for <linux-fbdev@archiver.kernel.org>; Fri,  1 Jul 2022 20:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiGAUYG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 1 Jul 2022 16:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiGAUYD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 1 Jul 2022 16:24:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC54387B1
        for <linux-fbdev@vger.kernel.org>; Fri,  1 Jul 2022 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656707033;
        bh=rQmS4yIj+Kq0oK+U8Ryv32tYGBvhOaSYofJZQWpZKAg=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=fIOLdTnCwKdSF7QIxTmumraXGkfNUG0ClivcyASnedEIPIfK9MhHxNauXOXAW1Nw7
         foY+RQl5EEiaYzBZWm4MIZfRM78rQlMArLqWC6AA5ngCeanzECZW3ZPNkeaaOMZ4zK
         cPTGeD+lt9v4lQk1EpDvJCI4IOFqfoQUYpzaslRY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.182.192]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNh1-1nPltG2fT5-00hz1f; Fri, 01
 Jul 2022 22:23:53 +0200
From:   Helge Deller <deller@gmx.de>
To:     geert@linux-m68k.org, dri-devel@lists.freedesktop.org,
        daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 1/4] fbcon: Disallow setting font bigger than screen size
Date:   Fri,  1 Jul 2022 22:23:49 +0200
Message-Id: <20220701202352.559808-2-deller@gmx.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220701202352.559808-1-deller@gmx.de>
References: <20220701202352.559808-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LHLDoqxvdfUun4EcG3tmI0dlKtgbAn1uYwunDECGEcGaabXAxNN
 Bs/x/xwEaj5rGknXyHB4AlMOUqfFfOIFITBzIQmNGDGw4Ingi2HTebkfNfjkiAbwSmPdZ6D
 dqrPPbGT8vVuZI+0qfZJNI1F7KNfCQ4leIA5+vOQCaaEmpxouuvIl1nj0ZidKW0bvKMhLZ6
 eTYxUl2xqM+zWGSDsVuZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cB2/OJqA+lE=:QEDxZRbm+VSDc5BqF44nrB
 KL2bW+V+Q950YrP+hTgVPQNcuWwaiXcYaySC07CFbvOQGnAk1F0upBe7bGbBU7hlRRFZ5JZno
 Y/9bacluv/lopfOnozzFyrpUpa0nE6zXpujxSPePiwSUYShFMRx/DOpCUxm+y0CIrPb/Hk9Tx
 qAWmsgZGBeabUiuDjS9yRyITZ3dpFbkOSeihRglAN/bhGGUTsibTf8gfyke6Zg4I0ZizZJGSP
 LqBPge22derxF01P+pdFUPe3HbQMRAM5qJcW/AjO/rF1FEfEegR0pV4H7y+WyN0xUSPHTa0bF
 YOXnoKU2aE2r5gKiyvRUsqN5fcG8m+pvHTxy5D361CLwajww78O9qFcx1BUo7bycfELPb91OX
 eyBkgg9eM3FyFvZzVIJQ33JBsch/BTkriESHl2WoBSDVbIZ59BssIxJkFefMJc5zcKS53Hjhr
 p3iq9tsU5iEGpOXyvEC1LylTJmPT4TTNTIZKsaPfW6iw2rQavKJ57GqkFOuKVe8t02iIPCCR4
 SRjSRHg4iaPHCq86FPrDjPCiThjiCsrSnHjUlcMfIuUBOg4CX42qhqjn2ZfPoz6MsjILMsMPr
 7BWy14hJnP+/O21MrD3jWFzR3fMcJzAtwEjoA0pqNl4crxnflFT1LcBt8fp06/0ENTY4r45SZ
 LD3S2L7FtUehcTCsVXe5Lg1vWblkd+nvrvU/IjmXlyq/fudsxk0ydThGMmrfs5tZK3VDVjOqC
 nHBcUOSsgmUVlwQUPeDX6cae8ecmMOybbFXAnLuprUUXKgoPQfORBDvZ1JwF3QTHWqGCs5qQc
 yVoo4jCcvU+RUYCNUnJoxHl2g3I237j2xFqzcpAqu0pFybHpDSoEoZEeObeYp6IeThzxZylSS
 C/L25gU7BiwNpRNFlDUnb9WzKcnR5fC5wUNzUofvCDqfRaMbenRj+wGqtVY7Mjte49qEt8giD
 Tyt3JljEDxEobwiXDyPa3rAclHLBzl6eW2egbsHj4utPWVGhEEAk12dw53x872NfyS3ezmENs
 CYR/4yYBx6X7cE+RMpw9W3XH9r83yDGe+KBsHPVO/7+zqAOQ/g30ELAwRSkPFxlYI9YjMposA
 1gup/fG89zgRtUM7t8vRcdEmg9IUePiJwMv2++R2bkm60OyaLzmitpY5w==
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

