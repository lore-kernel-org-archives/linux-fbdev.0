Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B661C433DB
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Feb 2021 15:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C6AD64E98
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Feb 2021 15:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBAP50 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhBAP5Y (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 1 Feb 2021 10:57:24 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBDFC061573;
        Mon,  1 Feb 2021 07:56:44 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id h11so17835786ioh.11;
        Mon, 01 Feb 2021 07:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kcdyPTY1skmYjF1uajFrBrZyBd8/9OXciUlqQZU21U8=;
        b=uzQLEFhC1+ARNN6hqVIa3FQ1xYmbDBd6n80aAnHAx4MdYkelzPRroBA9AJQ0g6qqs3
         jk7x6Htzbv9fooOxUmbTNvcYJ0ZtW2rRH9u3Ku57aBuItx9s4yCB1N73BTJjMBRoFI1g
         kyHhgKtKJ9sTrAANLdvBJ14fZeNwXfpShWQHuWrRRHM8IDqt0s4WxV/Ta+b8NuURv5m/
         EUGt+SEJl+Sb9wBhHMed/erkr8hNm78soejwZHzeJU0CsnjSPF5swBHQI2321G1NB+sZ
         QqUpowJcAKuaW9s9XU3ZIlmWQWMbntJQGS/2PQC3+MiNNztGa0LExQuKUK8rvUPD3x5F
         gTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kcdyPTY1skmYjF1uajFrBrZyBd8/9OXciUlqQZU21U8=;
        b=kgz69Ookl+tvJzyt1zdBcArooFx3b5CrPLzBVTIy5xMx3WAu6x6uVEFhpodGxWx1hv
         0pWOoedyq0JC3EUMck0TSV+b/C5gu/jNRIhuO+Ww1Cb4Ura3kq+7oKu+23+KtAa2PWnS
         XT2oaXCKheR1sDsV72dp2lyVd40+ekcyQws60jTa2U/xc5pHiCXn8wJZ/AarrnNaFMP6
         aN8biztRVcaEAaaPceMxfZe/y8IsXxVofQ5iCK14eN9bB/VNvNrAbu/oat7MajYVOJhm
         SX7KrR3Eo3OdVJXG9CZMp/vpcsMlLMuBAIzDeMVAXd3kL1LGCgum7Pij88mJKphXCiyd
         OiHA==
X-Gm-Message-State: AOAM533wJrXuCkkRIedSGeZY1STqQExxfVsV9VgHBK3xPMAQ5mEzoLXv
        6bYQooKy65zbUh68BjHxX7tkIIS1KB9vCu2+
X-Google-Smtp-Source: ABdhPJzR64pEhc1+heg0E33szWIpaM9xLSkpXN4WnftuLWxO8guiKR5uRsSuzM9125+j6Lk8IeaEgA==
X-Received: by 2002:a5d:8704:: with SMTP id u4mr12277294iom.3.1612195004270;
        Mon, 01 Feb 2021 07:56:44 -0800 (PST)
Received: from spring-Precision-5820-Tower.cs.umn.edu ([2607:ea00:101:3c74:b4b0:f34c:770:f33f])
        by smtp.gmail.com with ESMTPSA id t7sm9485796ilg.9.2021.02.01.07.56.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 07:56:43 -0800 (PST)
From:   Wenjia Zhao <driverfuzzing@gmail.com>
Cc:     driverfuzzing@gmail.com,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] video: fbdev: fix the out-of-bounds access cr_data->bak
Date:   Mon,  1 Feb 2021 09:56:34 -0600
Message-Id: <1612194994-50994-1-git-send-email-driverfuzzing@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The size of cr_data->bak is CURSOR_SIZE/4, however the access size in
the is
CURSOR_SIZE in the loop. It causes the out-of-bounds access.

Signed-off-by: Wenjia Zhao <driverfuzzing@gmail.com>
---
 drivers/video/fbdev/via/viafbdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 22deb34..ef217cc 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -839,7 +839,7 @@ static int viafb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	if (cursor->set & FB_CUR_SETSHAPE) {
 		struct {
 			u8 data[CURSOR_SIZE];
-			u32 bak[CURSOR_SIZE / 4];
+			u32 bak[CURSOR_SIZE];
 		} *cr_data = kzalloc(sizeof(*cr_data), GFP_ATOMIC);
 		int size = ((cursor->image.width + 7) >> 3) *
 			cursor->image.height;
-- 
2.7.4

