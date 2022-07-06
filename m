Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FC4CCA473
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Jul 2022 15:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiGFPDE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 6 Jul 2022 11:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiGFPDD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 6 Jul 2022 11:03:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BE02611B
        for <linux-fbdev@vger.kernel.org>; Wed,  6 Jul 2022 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657119774;
        bh=UG0Ldu9nBni/JzXBdcDjRSy1yD/YbCgEK7jXGm18EC8=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=AM8nP5u2hW2kku4Zc7jLEMmt1TzSb/kZHfog0M0hRKXU9OSE6u2mXYaV1DthfoP01
         yCD6gVipm7/IaqC8QWiV8Xs9SMid6ncK3MP5cpTPSdK4IFq/M1mgZ5vu7XW6AsLLXW
         FlPCfP/VF+QB8Wi+j5hjCNnOrZyw5jD9MJPfUGLc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.134.81]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHGCu-1oMHq22XmS-00DEu4; Wed, 06
 Jul 2022 17:02:54 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-fbdev@vger.kernel.org, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, geert@linux-m68k.org
Subject: [PATCH v3 0/4] fbcon: Fixes for screen resolution changes
Date:   Wed,  6 Jul 2022 17:02:49 +0200
Message-Id: <20220706150253.2186-1-deller@gmx.de>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+1W7MsO3It53f8MJY7NxHXXbg0T4czPd2xPfiaG5vZaHGzXsMSS
 aVEGWiI/tNPanzgfhJsPly+BL0lCUiT3BmbMMk95fl6OatZUfgMZ/1KWpO9fQJ6SStJCfFf
 4+xuPz08rFLq+lSCk6GWf2zitssNye62A+dHMkq6dku9guzG6JLrwDmbsrTUnlu0s1ZFEwm
 b/utLQRlCv0Zg/hEiHJSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GVCyoL8A/p8=:Pwxb9ygAcIfYdO4D85FLd8
 6RMoWJtMabCyakN4m0YNiVgbBmQXiiy+7INmq6XjENUgwRDjCjn28WJZBrf0yRFTUnMqoGdZS
 A57crIQBNzwNuTQItLRPLXtB9+FD5xV9cdcsYYUGXuiCMl358Z4Hu1ZkSdKXmKI1kMyw+vxJk
 xKRtDNZ975xABkASNkeEfd5aw6mosD4YJTdJcTQY2jykv15yBTd6GumqWJCi/UHIdE70Pq3Ss
 bT2osBzwgM45rH8dpmkNe1fIMUaIurLhyz7LhwcZUkIjPDsttCvywGrzvcaC3UmSDj4H1s3j/
 eAO5eGxbdMKOMGFALCXFxuhK/arMD3Q9fTU+hGPl6AwYY2yvUjsPTU0zzLMVFdN8tPh2NKZan
 FApFLHT5BLOmBXpK8Oy7pA3dcIFH/znNnN6M85ofRrmtT0T5DwRQQ1n6S1uPeNuGSkOrCX0VD
 WrUGrvcZbYdtGHgcKJUTjTcHajfyWHIuzL+g8hpU9ErCmYUAOmPm/os3ALmbKV8pIk1dJPCiW
 uyDhc2QDpuGeNbfUS1VdOmQVTXACCqT8eM/i6cS47gQk1KMzULAVQDaD8xgcpmK2I/My+ivbm
 80v1qjDwVHAipZNwHVPBHHDeJ7KH9NnQkIdlx7twzwHEPxQ0Dm/7Bmpd50jifIGbw9EntVgbE
 v/p8X5cYL8fY6Ss0UDoS/XRHX8WNS/DG4rJAm0ZUDUfyApTDPVpMkk2iswLmUJwcEhIeGKWeF
 7ZVSoGMe4R+N1cG7dmtw8oUJ/cTzRpGCS4uq3Gz7iYwL8exsrWHvER1FrRCBUTJskLG3YkPVE
 pXR4IJpZyajowghubeQ+EeH28bekeGkZZvGAiRb9vKVsOBbstiFaQTggrwCRf1g4DcBVykQeP
 l7nY5EZBQ+COmr94WKmikrazD/BCvdaBtBjTC+hHOc7aiQutybOyZG4j3OBmHJHcKazhoyUgz
 wOZymU3gmESPVLmbJEpHdqh+AWb86Are8sZaEwLLprfr+K5/Or7fLIgHLrvERBSKKS/dLpRqr
 RKDKJcz338Lo9f0V3Xd88z43LlVdqanoZIv0g3zBXwEW/DOvt/D+6oXMyFixJXhO9VlO+i+vW
 NP3ggsUgOKFGNBejhxwiV63Tl8Wbh00lvtd
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This series fixes possible out-of-bound memory accesses when users trigger
screen resolutions changes with invalid input parameters, e.g. reconfigure=
s
screen which is smaller than the current font size, or if the virtual scre=
en
size is smaller than the physical screen size.

Changes in v3 (all feedback from Geert):
- Drop WARNING, instead just use pr_warn() to report if driver failed
  to adjust xres_virtual or yres_virtual
- Use EXPORT_SYMBOL_GPL()
- fbcon_modechange_possible() allows changes for non-text screens

Changes in v2:
- don't fixup wrong xy_vres values, but instead print warning.
- add Reviewed-by tags, minor variable name fixes

Helge Deller (4):
  fbcon: Disallow setting font bigger than screen size
  fbcon: Prevent that screen size is smaller than font size
  fbmem: Check virtual screen sizes in fb_set_var()
  fbcon: Use fbcon_info_from_console() in fbcon_modechange_possible()

 drivers/video/fbdev/core/fbcon.c | 33 ++++++++++++++++++++++++++++++++
 drivers/video/fbdev/core/fbmem.c | 15 ++++++++++++++-
 include/linux/fbcon.h            |  4 ++++
 3 files changed, 51 insertions(+), 1 deletion(-)

=2D-
2.35.3

