Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46763C6FD1F
	for <linux-fbdev@archiver.kernel.org>; Wed, 22 Mar 2023 20:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjCVUOg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 22 Mar 2023 16:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjCVUOI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 22 Mar 2023 16:14:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E3972B08;
        Wed, 22 Mar 2023 13:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1788622C7;
        Wed, 22 Mar 2023 20:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84910C433EF;
        Wed, 22 Mar 2023 20:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679515443;
        bh=EduoB6WhQCnBZmdi72+Bo085S6SfVuPZTIQfw1E868U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6weGyExbwchFbTtUPjoI1dUU0xq3lTnDj3umKuWU6RIiOEX7MQ7OmEWjQus7Hxsl
         BsCuOUvl2Ru5eyExWV8OUNbyQ52ZbtXog0TEMAkuFF2rvjDBje322MoC/2RQmf2+XV
         rdkI9qDzpSz72YKH0xB3b1BfIpaTY50ZGisiGMy0BfiEMZ2Sy6xMHf2K90UxwbySRg
         lCrek98OkPMEqjK9JWZEogx/94x0JlBZmpYdeztaMnzCILn7yrxMaJeZPe7gjDOQIh
         e3rhJYL2hjgyZRwwhJzLSavAwt/AE5bXbrR4dwRNEdCaFDGdvoE4Z9F4bfkkfsvPP/
         VFgI1nPegf0pw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Chen <harperchen1110@gmail.com>, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 9/9] fbdev: au1200fb: Fix potential divide by zero
Date:   Wed, 22 Mar 2023 16:03:36 -0400
Message-Id: <20230322200337.1997810-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322200337.1997810-1-sashal@kernel.org>
References: <20230322200337.1997810-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Wei Chen <harperchen1110@gmail.com>

[ Upstream commit 44a3b36b42acfc433aaaf526191dd12fbb919fdb ]

var->pixclock can be assigned to zero by user. Without
proper check, divide by zero would occur when invoking
macro PICOS2KHZ in au1200fb_fb_check_var.

Error out if var->pixclock is zero.

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/au1200fb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 6c542d0ca076e..e17a083f849ad 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1039,6 +1039,9 @@ static int au1200fb_fb_check_var(struct fb_var_screeninfo *var,
 	u32 pixclock;
 	int screen_size, plane;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	plane = fbdev->plane;
 
 	/* Make sure that the mode respect all LCD controller and
-- 
2.39.2

