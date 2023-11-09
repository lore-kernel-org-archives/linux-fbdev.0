Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FB4C4167B
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Nov 2023 22:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjKIWCM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Nov 2023 17:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjKIWCL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Nov 2023 17:02:11 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FA23C01
        for <linux-fbdev@vger.kernel.org>; Thu,  9 Nov 2023 14:02:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1D6D-0004Vf-Cq; Thu, 09 Nov 2023 23:02:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1D6C-007sDH-9I; Thu, 09 Nov 2023 23:02:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1D6B-00GL6M-W7; Thu, 09 Nov 2023 23:02:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Atul Raut <rauji.raut@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel@pengutronix.de
Subject: [PATCH 0/2] fb: amifb: Convert to platform remove callback returning void
Date:   Thu,  9 Nov 2023 23:01:52 +0100
Message-ID: <20231109220151.10654-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=795; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=FLvQaW8NDzDUC0VV2BZU0TZE/kUbDQHy+tt3/U2DflM=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTfsPOpDAaKBb+ucXfaFX7SeTy//n3xxrsp28XLGWQM+ Pd5fBbrZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiUV3s/2u1tDlnCYRznPMu CGaK4ehoCvbUbWMpuF62V2h5x/vI7A9iybt9OBu1ytjPaZUF+fQemcxhfnWnetGD5PwjtdYFibv 5W99EvvJ68Ift5Km1qS3rvrv/LNTIcOAt7eRQP5HoPOHR9N0zjm3NKZL/d//mPgb7JoslXxxkjz 6y2zf3d38P+7TWAwabNvrmHC2f/aN9JsfdJf2tpg/m6fgXHdb5zantP09cMvF45KmZtVEnP7gpe y3l/y2t+XyfdV2ivrHBHycbzxUfGbxiHunME3LLsEp18nnXkZsZ/62iwXB7zatZOxjaBb7GW08O V1bW1u9bG9kyiXVKQuOJ6FTHsir3K083xjVlhh+YcwgA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

in the series https://lore.kernel.org/20231107091740.3924258-1-u.kleine-koenig@pengutronix.de
I suggested to replace module_platform_driver_probe() in the amifb
driver. Geert Uytterhoeven objected because the amiga platform has very
little RAM. This series implements the alternative: Mark the driver
struct with __refdata to suppress the section warning. Patch #2 is just
a rebase from the above series.

Best regards
Uwe

Uwe Kleine-König (2):
  fb: amifb: Mark driver struct with __refdata to prevent section
    mismatch warning
  fb: amifb: Convert to platform remove callback returning void

 drivers/video/fbdev/amifb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)


base-commit: aba6ab57a910ad4b940c2024d15f2cdbf5b7f76b
-- 
2.42.0

