Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D58DC64E7B
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE3E20771
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1SQRZSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgK1Wnb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732694AbgK1Wn3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:43:29 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF8AC08E85F
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:42:05 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d8so12778173lfa.1
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i/jzMmTNfIIHRAzbdgJUlI30eY/5E6v51csqIZVPdm8=;
        b=H1SQRZSraI92a5O8JSNe2407lQpbO/+p9TDZYNkqAVUoapJk9fO+eGsW9hEC0PhPwQ
         MpND47D0UvArbcEQ6WCBHFbfL+Yj82bjKGsmbi1NL9P+Drah4BbSv2KWIwjIa7VtDKSC
         HLFX0TiM836LhxAnGD8VZIcFRVe37KjZkVD8bly5ogDokaCOe6rZkpYUE9zBOXZwIJeP
         jHP0XeZr/46sh5nl2Uo7tv5amK8nJqhQe+6A7RJqP8KEyG7ZABXvV1PIT0/j9J/XvlFW
         Pgvazywpu8LHLmRdFfaCSXUNq84LG/HMHt9XKr3njllPiDQ6VOrnopdZ3PVQFeD4IFqZ
         mzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=i/jzMmTNfIIHRAzbdgJUlI30eY/5E6v51csqIZVPdm8=;
        b=Ka7HvpHX3Qqp1I32Sd8x4W94q7pTEArpvY1S+lcW+PwpvBdrtkhF3ni14PIFfBZEW/
         x++avLNm9nSrFc1BpKu4luDGwlkxBUOoaGeiDVRe7qe6XakxRdNGUV1Kacmi/yYyp7N/
         lwT2ZzOnarhZ5QlksALfbbMwjm/8PPLwTVu36Kcttsz5tM0Coc4NHHDG25tthybAAYmv
         lELyy3uQTRF7e+Ksg2bV5tJUYsDY9LiXdAppjxnralHsP12nNDIXiPj/NlmXzRQyFMJY
         p4G3327SEssn1hvNxcxdgGVjcMJW3Ulq1e4GwkNSoLqyvzKYL+AOotQnKAYaFyZypwH0
         y6bg==
X-Gm-Message-State: AOAM531SANIsRxTvTK8ZWkKQfBAM9VdkiJlzDAx0TFG+fQCVyS+dn5Eh
        XbellldqMoOVdOg69QpGATzCUBrbWCUYCQ==
X-Google-Smtp-Source: ABdhPJxtO7VXEd89T+Ciyiy6CaN38D1Nxk/voiHrw2OR7xLLx2fqYvJc1vd+oWe7rP3sXbswetx3Nw==
X-Received: by 2002:a19:fc0d:: with SMTP id a13mr6540657lfi.276.1606603323803;
        Sat, 28 Nov 2020 14:42:03 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:42:03 -0800 (PST)
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
Subject: [PATCH v2 22/28] video: fbdev: omapfb: Fix set but not used warnings in dsi
Date:   Sat, 28 Nov 2020 23:41:08 +0100
Message-Id: <20201128224114.1033617-23-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix several W=1 warnings.
This removes unused code and avoids an assignment by moving
the use inside the conditional block.

The register read FLD_GET(r, 15, 8) could be dropped as it was done a
few lines before too.

v2:
  - Updated subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Lee Jones <lee.jones@linaro.org>
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

