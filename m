Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8786C47082
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Jun 2021 01:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB1D610A0
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Jun 2021 01:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhFABa7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 May 2021 21:30:59 -0400
Received: from m12-12.163.com ([220.181.12.12]:60708 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231714AbhFABa7 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 May 2021 21:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TD8tt
        DRjkoIh5GipXEh5UOfa9zr6wYIAwrcv6LbbEQQ=; b=jDcI3ldYfFIWJE73onAQN
        dPdSXiakmfvG26Bkh6HlFpj8qEeI2tDucp220sdDHVz0dR8xEEtS9HBYWEwS4vnH
        APvsgT7WdKdViFeQ4HSQUjLSCmbZAuntBuLUxZm51Jn8Zl5xy5hbKri+rR7+kOtG
        q0IpTxepz1DjXYO6nId8mc=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp8 (Coremail) with SMTP id DMCowADHu_dhjbVgHw2AHQ--.8323S2;
        Tue, 01 Jun 2021 09:29:06 +0800 (CST)
From:   lijian_8010a29@163.com
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lijian <lijian@yulong.com>
Subject: [PATCH] video: fbdev: atyfb: mach64_cursor.c: deleted the repeated word
Date:   Tue,  1 Jun 2021 09:27:47 +0800
Message-Id: <20210601012747.38884-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowADHu_dhjbVgHw2AHQ--.8323S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryxtF4kAryfArW3CFykZrb_yoWDXrX_Cr
        srZ39Yqryvyw4vqrn3Jw4fWFyqq3WkXFWDX3s2qrWSk34UXr45Xr1Dur10gFyUWryUZFZ8
        Zwna9rWvv3yfujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5b_-JUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/xtbBLAOkUF++MAqd8QAAss
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: lijian <lijian@yulong.com>

deleted the repeated word 'be' in the comments.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/video/fbdev/aty/mach64_cursor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/mach64_cursor.c b/drivers/video/fbdev/aty/mach64_cursor.c
index b06fa6e42e6e..4ad0331a8c57 100644
--- a/drivers/video/fbdev/aty/mach64_cursor.c
+++ b/drivers/video/fbdev/aty/mach64_cursor.c
@@ -46,7 +46,7 @@
  * The Screen position of the top left corner of the displayed
  * cursor is specificed by CURS_HORZ_VERT_POSN. Care must be taken
  * when the cursor hot spot is not the top left corner and the
- * physical cursor position becomes negative. It will be be displayed
+ * physical cursor position becomes negative. It will be displayed
  * if either the horizontal or vertical cursor position is negative
  *
  * If x becomes negative the cursor manager must adjust the CURS_HORZ_OFFSET
-- 
2.25.1


