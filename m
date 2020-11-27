Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049F4C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0EA822245
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doK4lBFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgK1BhG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 20:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731057AbgK0T71 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:59:27 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23646C061A51
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:02 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d20so8514756lfe.11
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tAy2L6+yHjKuwgbD1GtBSbwZUtZR3+FgaFh+jK71xjw=;
        b=doK4lBFvnmTZcgYL/PjjUuQB8ZoUk+PEo0qU+uLpJMsr2En+IwyOb047noqpqiE4E7
         ns0ENbBkflLflMCTngF9seeipp8CMx1/WoAsTEf3iihARCetdENCniJzzfGCZplRbTtO
         UhusRpw2RGQLTMQ6zQuwpyeGjMzQz8ujlGRIKZJUiPT4+fRc8pQOWenhI6DaMxh3fTbM
         LPN+7GLLpoK+QEDfotRTyJ926oA0If7zdHpHKjTZXY3GKaDo3G8cfFpeRQQQmTQAZaZo
         OJUHeRPgDRH4JFWSYvBdCxT3x5oX5bfIRaMQJCUGx1Goh9AVJhbvcsTWq7YpDC6CW3iv
         b8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tAy2L6+yHjKuwgbD1GtBSbwZUtZR3+FgaFh+jK71xjw=;
        b=JS2zxaR7K7Cnk6RfOSiRznqahf7JQRlErRQ5yPq71XIylT0DwP7Co1wKXAxuNq7tKl
         9lxCY3jP2Vb0qJqTUBhvEXhD1XKZ0xTrcFZ3xGnQRFQBNLxb80XSv2jO6LlFbj31lRa/
         RGkAsR8AnkStbKhmhD6x3F8B1rlQc1TbOkTgrQtfi/Nlf9C3izCf5rRHN691IBGKKOQ+
         ayPoi/OkR/rSC6y/QiPjql60rN3DgwyTgK1KMoNmmt3aMxsBaHOIvsJoIS6LRiNPl/kT
         pdhCB8fTraBGlVqmIW8jkCuhQwOcNsH5cUH75WjernD24CkXaGY4lZKERjxxl3leHb+p
         Kemg==
X-Gm-Message-State: AOAM53359jSbDTX0mZUn/FfCK23BcfmKm7b3jqjfccz2zvFTdFb6WzQW
        8OETCOLmw2DweeaeZN+KT1JBIBej3vN23Zuq
X-Google-Smtp-Source: ABdhPJzA9tlt5/v8JE6nDmhPGEGXRsyRJmv4B2nwWuL72K6hMPQ+4HMvJ4sQQ3zrl6l0SjVCnZ1fkg==
X-Received: by 2002:a19:ec07:: with SMTP id b7mr4326715lfa.114.1606507140403;
        Fri, 27 Nov 2020 11:59:00 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:58:59 -0800 (PST)
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
Subject: [PATCH v1 10/28] video: fbdev: sis: Fix W=1 warnings in sis_main
Date:   Fri, 27 Nov 2020 20:58:07 +0100
Message-Id: <20201127195825.858960-11-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warning by dropping unused variable

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
---
 drivers/video/fbdev/sis/sis_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 03c736f6f3d0..266a5582f94d 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -5029,7 +5029,6 @@ static void sisfb_post_xgi_ddr2(struct sis_video_info *ivideo, u8 regb)
 	static const u8 cs168[8] = {
 		0x48, 0x78, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00
 	};
-	u8 reg;
 	u8 v1;
 	u8 v2;
 	u8 v3;
@@ -5037,9 +5036,9 @@ static void sisfb_post_xgi_ddr2(struct sis_video_info *ivideo, u8 regb)
 	SiS_SetReg(SISCR, 0xb0, 0x80); /* DDR2 dual frequency mode */
 	SiS_SetReg(SISCR, 0x82, 0x77);
 	SiS_SetReg(SISCR, 0x86, 0x00);
-	reg = SiS_GetReg(SISCR, 0x86);
+	SiS_GetReg(SISCR, 0x86);
 	SiS_SetReg(SISCR, 0x86, 0x88);
-	reg = SiS_GetReg(SISCR, 0x86);
+	SiS_GetReg(SISCR, 0x86);
 	v1 = cs168[regb]; v2 = cs160[regb]; v3 = cs158[regb];
 	if (ivideo->haveXGIROM) {
 		v1 = bios[regb + 0x168];
@@ -5049,9 +5048,9 @@ static void sisfb_post_xgi_ddr2(struct sis_video_info *ivideo, u8 regb)
 	SiS_SetReg(SISCR, 0x86, v1);
 	SiS_SetReg(SISCR, 0x82, 0x77);
 	SiS_SetReg(SISCR, 0x85, 0x00);
-	reg = SiS_GetReg(SISCR, 0x85);
+	SiS_GetReg(SISCR, 0x85);
 	SiS_SetReg(SISCR, 0x85, 0x88);
-	reg = SiS_GetReg(SISCR, 0x85);
+	SiS_GetReg(SISCR, 0x85);
 	SiS_SetReg(SISCR, 0x85, v2);
 	SiS_SetReg(SISCR, 0x82, v3);
 	SiS_SetReg(SISCR, 0x98, 0x01);
-- 
2.27.0

