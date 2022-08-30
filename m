Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A133AECAAD8
	for <linux-fbdev@archiver.kernel.org>; Tue, 30 Aug 2022 17:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiH3RX3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 30 Aug 2022 13:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiH3RWr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 30 Aug 2022 13:22:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BE8F72F7;
        Tue, 30 Aug 2022 10:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED2CA61775;
        Tue, 30 Aug 2022 17:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FACFC433D7;
        Tue, 30 Aug 2022 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661880059;
        bh=zneAbTP5pou8p5X4jgg4eabYrBfqHrjpDXDezHwggak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcA7kVhbZoxJslRWTloppfylEyunXU8ezZNM1tDwpeoX1TwyCclnzJIadF5pTC75Y
         aGWGszK+3EM0/h2UJVx4+KH8+/s7dsWk3D43bq5EWrnRVZi13/l/X7Eqhb/H4zR90r
         O/vIKjm+oCKPi85zo1GJT6vJcW52WDQg/rhsMPMvz6P3cSDXUM9C3Gmv+uKZmvH4HC
         HD3cxThS6oeG+idu1vTmu+SccspOUp9I3W7h8k4x7WUZ8miG7BrByx5MJTfKHgvZmX
         hg4ZyJqSKxR8s+StUKoS8py3pKU7pB6ZuQJ83FETzsrI/GhwTrKd5RaeyVwOAcgEeX
         afR2mTnKu+gJQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shigeru Yoshida <syoshida@redhat.com>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        daniel@ffwll.ch, sam@ravnborg.org, tzimmermann@suse.de,
        javierm@redhat.com, wangqing@vivo.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.19 29/33] fbdev: fbcon: Destroy mutex on freeing struct fb_info
Date:   Tue, 30 Aug 2022 13:18:20 -0400
Message-Id: <20220830171825.580603-29-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830171825.580603-1-sashal@kernel.org>
References: <20220830171825.580603-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit 58559dfc1ebba2ae0c7627dc8f8991ae1984c6e3 ]

It's needed to destroy bl_curve_mutex on freeing struct fb_info since
the mutex is embedded in the structure and initialized when it's
allocated.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbsysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index c2a60b187467e..4d7f63892dcc4 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -84,6 +84,10 @@ void framebuffer_release(struct fb_info *info)
 	if (WARN_ON(refcount_read(&info->count)))
 		return;
 
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
+	mutex_destroy(&info->bl_curve_mutex);
+#endif
+
 	kfree(info->apertures);
 	kfree(info);
 }
-- 
2.35.1

