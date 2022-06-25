Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97534C433EF
	for <linux-fbdev@archiver.kernel.org>; Sat, 25 Jun 2022 22:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiFYWGj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 25 Jun 2022 18:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiFYWGi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 25 Jun 2022 18:06:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955CB11158
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656194792;
        bh=PMakGc1Xx8pWLUuhWgvPzqMjvPuAkCCgL2mFABbdBRg=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=H2U2KRXoYHZBkyLwCHWjwDeggkPTFw5mvNehZEky3T4W3XEyUF3tHcRrUV2pQ9Q8L
         q+k3xd64eutVsmLyDHlOvVMoDZxA6UCam97eUVEXjzg4mzTCxxAMHyGMcjpUQIk3Ex
         iVEqMaKGvE0jy1AiryqZQeH5XFKoRke0nQHb64M4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.162.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GQy-1naPKC08Bc-014Gip; Sun, 26
 Jun 2022 00:06:32 +0200
From:   Helge Deller <deller@gmx.de>
To:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        linux-fbdev@vger.kernel.org
Subject: [PATCH v3 3/4] fbmem: Check screen resolution change against font size
Date:   Sun, 26 Jun 2022 00:06:29 +0200
Message-Id: <20220625220630.333705-4-deller@gmx.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220625220630.333705-1-deller@gmx.de>
References: <20220625220630.333705-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s5v/qQunOpq3us49AGxcriWC5b51eFrJN40JCWcMOWgfk2AGVLB
 wipZ9W1IDXoS3Xid3swg5H2oL/R2hVw7uepIEVTEhI71ZeqHa3NYKNr0Z5mFF5wmmswrhqx
 5XyFLU9J0pD/2eBnPl3/mUaJgHl7gaK9o83w5hCdJcrUDWNlttRXiYKFBonjwd8eYHU8w8/
 GXqitBKH0Fx7qAaZnTLwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oD735pIe7V8=:IFgtWmEWedqlDobqBPEwXW
 ynAbbJUxXKXIVuHII3u6SCWfZVUZV7tBRRvTmet2wok93TgHlncpfSY8YyPFxh1Qr6tghyK2i
 o8DoN2gikhrbcm5gakuRswpTyLjVUUgIklRZ7eYv+8VXp1/eaIBjt7yUqkKDfNtTuk2uxHQ13
 W4qaUNOtdSjkgAGHJrS6neDyKT1F0p1DDNGqWSuQvAYfATwHfZT/oiePz3e0UZyXftfW6Z7A2
 tHAbN/U5l/UHrQUUjPdoJ1KptcEuJCyBk9wIyemJHAMMSq5B/CEamGfh3KXGnXDwou0ztktoP
 0MB3adKFlGaV6tgBv+v8y6MVXglJ6M4TZ72GgwuvyhOriYWtvlXYCVPd6Pem8NGW3PmwfQQFD
 ETL+eQAgWD2cDgOJQzerYvLIJI6vILs8+RVdAC0mgkBFzXmrxfTctN577W3Vb3ow1RX5LALdv
 uGvJmtO0A0Nk+z9JTcuLaycVNx6l0RlbMgQAVZbTe/j/xgIVo6dUVS6mvxQ0HqFe2Nz5ftNX1
 5fxWQ9sMWP4GpNkCLeiqSbpBSZvk9wWQ97/qksJ5UQPFnSISXAvP1xXxXvkdWVqvZjf1pDlHu
 hg2S97dY7NTmh+UggGjJNACAbsDlPHuIjHzGnsuLHQ34jAnwR6kpRPwM0NhrNXvjrpMLcUpJP
 7PoHYKkp7U3jqZxFJrDIpRFSMk9Jy7bF26aO+UlngnH8YK/qvKBddHhIbrSh2oJtKfhpbHKn9
 cKtGIHZLli3tQBxf22zgFnU6P+w5wO6F86KqGpzoP2yMnzBpcREw0kwyfKL/zidZ4TFoukQy9
 4KdoBWd22+ntTXT8RUaBLORG5B983WMdrxBn/O1AKpWg8pHV6eJyLHWhjepSZA91MraKBbvSc
 8R2Ts0u+monu5cCqaQ2AosSrnZrMZCRSC20OhVHofeEXYzuKacu06xSy2Xbfor1ETIEwE0Tpk
 gdjbiY2FLjepN2GkJYZt0PDcBsp6gXjI7XQRCvS8E04jG/G/TSEA+jtDpyrvxPeQtwGGkfw8g
 UD/MlgMe+lwmU08NwPUIExnxNcPbmkWNueuWKRNK9GpgKvb5g0boyM/IIGO+pLqxQdk6bgXuV
 +lqXloA9ai0VfwXeW86FrFd5M0zfM0CQTInDUeNLzl+j0lOEa+wec8bLw==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Enhance the check in the FBIOPUT_VSCREENINFO ioctl handler to verify if th=
e
user-provided new screen size is bigger than the current font size.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.4+
=2D--
 drivers/video/fbdev/core/fbmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/f=
bmem.c
index afa2863670f3..160389365a36 100644
=2D-- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1106,7 +1106,9 @@ static long do_fb_ioctl(struct fb_info *info, unsign=
ed int cmd,
 			return -EFAULT;
 		console_lock();
 		lock_fb_info(info);
-		ret =3D fb_set_var(info, &var);
+		ret =3D fbcon_modechange_possible(info, &var);
+		if (!ret)
+			ret =3D fb_set_var(info, &var);
 		if (!ret)
 			fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
 		unlock_fb_info(info);
=2D-
2.35.3

