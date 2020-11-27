Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409D6C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF18422255
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCBYH4Mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgK1BVV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 20:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731162AbgK0UBR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 15:01:17 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF97DC08E860
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:33 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id z21so8531261lfe.12
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rJy8+vjkzYcV3XZ9Y+7Fhqd4Ih76XwRBzaJbmXxDMAw=;
        b=TCBYH4MoDC4EkijExZlsZmuW7pCHINO8ItDGIOhZpNfusWNsUwsPFSjpOj3DV1FYfq
         U7rEdu3HkuAAtAPqhoC9k9YNFAdbYPSWUHxs8zNG6Wkd4BfEwYRxYzZReMO8HsrT96UA
         TIXsjv6vxzOlkQK8X4r168/DpCnKzqBaLxYag3qdIwFpLzGNDSbDNTaLjNT/RS9MFNzK
         GuxEHrhefBzz4opGqJsXeV1LE28StIAkEBTZLqF1vfe4UXaI2cKfqOE8wPRCw2IqU+Jh
         9sVtCEx725p2FYiEAlCLIfbbYsklFvoCjAbnmD8RbDnN6lKr7NGHecqvHhfsCCr6+2ho
         p2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rJy8+vjkzYcV3XZ9Y+7Fhqd4Ih76XwRBzaJbmXxDMAw=;
        b=bZFP1jRQGtxtt7sTURw95haJbR9QzhHdai2a0OIN65C79HY5p/sYmkYXK4mMu+TMZN
         DeknhtPLUbFJABUrzS8stsxezwSqII85sE5+zI54WMForfSWqwvFSNqUb5cYRGAt1zR4
         sJlEOplWz5xUg6nBxL7bak/u2ix+grPUmY4KfxnvwVG5hv8rcrxxFQE6S8FMnGV3YFyh
         87SEXBNdgtynNsGt0eYYudesyxRb0ICG8l5bU+lVFwBXu5eUgMEVYEI6BkhH/BStzJZs
         R3f0eH39qU35eQd8R80xycX//Dujrpdso6owXbL3pWbCcyg776ZtZF25UlSqCA/Gs1xV
         6Vng==
X-Gm-Message-State: AOAM5316NbLVTHX/eRRGAy/W2CIWJWk8Id6gPSA3vLgKo+aEOCSmCfcr
        zQ+GwFxwv4V60mjexwSmCv5CwwCctJi0135i
X-Google-Smtp-Source: ABdhPJyOgA2kVm8O0iBLEqcMx9FEwMgL+93MG+gzwXYrmJwqzkMgjoJP3OWnlBdNp/YB6uBjS4Hc3g==
X-Received: by 2002:ac2:562a:: with SMTP id b10mr4250758lff.227.1606507172012;
        Fri, 27 Nov 2020 11:59:32 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:31 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-nvidia@lists.surfsouth.com,
        Michal Januszewski <spock@gentoo.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimemrmann <tzimmermann@suse.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v1 22/28] video: fbdev: omapfb: Fix W=1 warnings in dsi
Date:   Fri, 27 Nov 2020 20:58:19 +0100
Message-Id: <20201127195825.858960-23-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix several W=1 warnings.
This removes a little unused code and avoids an assignment by moving
the use inside the conditional block.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index 6f9c25fec994..72d45a02c3ac 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -1178,13 +1178,12 @@ static int dsi_regulator_init(struct platform_device *dsidev)
 
 static void _dsi_print_reset_status(struct platform_device *dsidev)
 {
-	u32 l;
 	int b0, b1, b2;
 
 	/* A dummy read using the SCP interface to any DSIPHY register is
 	 * required after DSIPHY reset to complete the reset of the DSI complex
 	 * I/O. */
-	l = dsi_read_reg(dsidev, DSI_DSIPHY_CFG5);
+	dsi_read_reg(dsidev, DSI_DSIPHY_CFG5);
 
 	if (dss_has_feature(FEAT_DSI_REVERSE_TXCLKESC)) {
 		b0 = 28;
@@ -3627,7 +3626,7 @@ static int dsi_proto_config(struct platform_device *dsidev)
 static void dsi_proto_timings(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	unsigned tlpx, tclk_zero, tclk_prepare, tclk_trail;
+	unsigned tlpx, tclk_zero, tclk_prepare;
 	unsigned tclk_pre, tclk_post;
 	unsigned ths_prepare, ths_prepare_ths_zero, ths_zero;
 	unsigned ths_trail, ths_exit;
@@ -3646,7 +3645,6 @@ static void dsi_proto_timings(struct platform_device *dsidev)
 
 	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG1);
 	tlpx = FLD_GET(r, 20, 16) * 2;
-	tclk_trail = FLD_GET(r, 15, 8);
 	tclk_zero = FLD_GET(r, 7, 0);
 
 	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG2);
@@ -4040,7 +4038,6 @@ static int dsi_update(struct omap_dss_device *dssdev, int channel,
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	u16 dw, dh;
 
 	dsi_perf_mark_setup(dsidev);
 
@@ -4049,11 +4046,8 @@ static int dsi_update(struct omap_dss_device *dssdev, int channel,
 	dsi->framedone_callback = callback;
 	dsi->framedone_data = data;
 
-	dw = dsi->timings.x_res;
-	dh = dsi->timings.y_res;
-
 #ifdef DSI_PERF_MEASURE
-	dsi->update_bytes = dw * dh *
+	dsi->update_bytes = dsi->timings.x_res * dsi->timings.y_res *
 		dsi_get_pixel_size(dsi->pix_fmt) / 8;
 #endif
 	dsi_update_screen_dispc(dsidev);
-- 
2.27.0

