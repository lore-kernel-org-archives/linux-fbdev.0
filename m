Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63F9C43334
	for <linux-fbdev@archiver.kernel.org>; Fri,  1 Jul 2022 20:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiGAUYE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 1 Jul 2022 16:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiGAUYC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 1 Jul 2022 16:24:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062263AA6D
        for <linux-fbdev@vger.kernel.org>; Fri,  1 Jul 2022 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656707034;
        bh=dEefPiI9Wq3+N76bPKdFvUHz0EeUTEIRh3WCR7KXkgA=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=HEFt5iZDmNZf66zk+qkPjL3tW/l2Fg/mj39IwVLc9Udj7wk4mo3GOy8hvIzKNSMjZ
         1gIakjLvxkq8vz/kDjPdv/khMXrT2wdDiBLpUteax/9On9UcojFbz6WKfb3RJBtpFX
         zKPl6vMnyG8dRvOH6jql54+NqKx8HkZPl5XNYvoU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.182.192]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHnm-1nn6Ad44zK-00ticg; Fri, 01
 Jul 2022 22:23:54 +0200
From:   Helge Deller <deller@gmx.de>
To:     geert@linux-m68k.org, dri-devel@lists.freedesktop.org,
        daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 3/4] fbmem: Prevent invalid virtual screen sizes in fb_set_var()
Date:   Fri,  1 Jul 2022 22:23:51 +0200
Message-Id: <20220701202352.559808-4-deller@gmx.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220701202352.559808-1-deller@gmx.de>
References: <20220701202352.559808-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bf8VXfaa577fpq4acsmdWzYRjRzn9t3d4jS+k3688Br3xPNGmzP
 p53HnFCs0503W6wMD/41hpxfgpasIAVFfi+0BsK0Vaca5CnYMrAq92Vt4Tv+y1NmmzQs91o
 sVc5gGs3GeWTC2v0TTBIXaXv/f8fpwtPuDlMwKHBivevR9eRdM3KlUOT4Ma599iz18mKGA0
 zulyQJ8I7gZN6XhQyLMUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vw9SFYftwds=:rr4MBShpbjEyzFIUlufOTC
 c/MzOQWgDKdqqI6ErlQQSs7fvS6fRhtrRcuAtfnXFGwMl3llbzURBcbqajh2yuL4CnGqOY/im
 qxSAxrVThZlQNTnuErbRtOS5D1Ib4TobV9FaN8k2wSqNskvY/JdatfT9PwqyaCQbZ4JQ4y8u8
 KNiSxIpYQ0qvVGYzwUG2PtUGoHYc9PAa7tBFoScRv9AuLwykZ2SUwCALRysMGJHo8RAMbojOw
 HCL6o+uJQd+sHpSCC9SnXktaDTJPklX8cJE67vWppHC40YA84O4GDdrcJUEhmxyTeGsmGJhbk
 9OAd2RlR3kvKZSu7mPe+QPIoFj/v8MS2XaohZ+hQiR+GS7MhauN7cCcFRd+pM0baSQnnstYSC
 TRqfUD/QZ0xh8exiFubK/APbIr7nxJRxfPQxlI5NQctBPP/YJZlQuIeUN4Cozr2+0lnxs4Dsa
 oP1RdkF5V5RVEP1wpg56ZIpoJvA/LoiV5+HQ7Htn2r+0biNhPWEEyJ/hbhmhZTQcU3GhVPsJL
 jR+5Iujjv2NYaR17ipV61J7X+4yJPOUVvANCSvtbkcE+MRW/wqlUfYcWkxdBykhumrzqeqbQf
 YIt+mJS/8l5f6jZ+LzOuZ2gRoLQm2yfqyaFXQN0quCzF2l+OQErY7ZKU6HbfbIHey8vNqG1AX
 75EpJwWfycUEiHmRrP9mkETt/kPVECtqnJJjNn32GXg4TRN6fAAfMRAOxJavcluEUuyal7EJz
 CJbnLMsB1UiwBif7hdyZ4+ttwl+EWWS59Uq0JFduXObZ0VAMthoMccSdRlYiT/vL6bTZjSNHy
 TEW34N4LBqpeXkMDScqnsQarwjqDFV60vsxC1FNemFWYS4FYHziLU4er5jAt+eyu6/zzbMlNG
 w8/ukmPmX4bUizk4xvTy7j60pICkSFog6EK5AYmaS51zyWZCU8ccJT6v4txKvxkLhx2z3A2s+
 MYpXwZrMRyh+0uZWAbTHWv+wwT8dCmsclOjVRO6Y5aQlT7s14YkMvHsItJGuITDMtdKNvrF8o
 OMrCmoMZ6LK0Wh4HJUj6EB0qnDehIoyzoJJF4BNJEn64pDQP/A/73hTjkQmTRNcltxtbhPkIU
 1M0pF0YtNlgIBkko68snz3nUE5vQLlK1s6jcdZZCFGh99qG760rPGZy/Q==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Prevent that drivers configure a virtual screen resolution smaller than
the physical screen resolution.  This is important, because otherwise we
may access memory outside of the graphics memory area.

Give a kernel WARNing and show the driver name to help locating the buggy
driver.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.4+
=2D--
 drivers/video/fbdev/core/fbmem.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/f=
bmem.c
index 160389365a36..e8f06d26803c 100644
=2D-- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1016,6 +1016,18 @@ fb_set_var(struct fb_info *info, struct fb_var_scre=
eninfo *var)
 	if (ret)
 		return ret;

+	/* make sure virtual resolution >=3D physical resolution */
+	if (WARN_ON(var->xres_virtual < var->xres)) {
+		pr_warn("fbcon: Fix up invalid xres %d for %s\n",
+			var->xres_virtual, info->fix.id);
+		var->xres_virtual =3D var->xres;
+	}
+	if (WARN_ON(var->yres_virtual < var->yres)) {
+		pr_warn("fbcon: Fix up invalid yres %d for %s\n",
+			var->yres_virtual, info->fix.id);
+		var->yres_virtual =3D var->yres;
+	}
+
 	if ((var->activate & FB_ACTIVATE_MASK) !=3D FB_ACTIVATE_NOW)
 		return 0;

=2D-
2.35.3

