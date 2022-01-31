Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95961C43219
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jan 2022 21:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379571AbiAaVGv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379607AbiAaVGt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 16:06:49 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6FCC061756
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 13:06:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n12-20020a05600c3b8c00b0034eb13edb8eso497818wms.0
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 13:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwGrwfETCM+M9+P3a4Nrp7y6QdxVSyzi92rKf4e0uVo=;
        b=J6qMgc5fOJUK3XPhn1qGhcwH2ALMYUIfKhMWansn7faeg7GJBdjaxgar/VwywGvql4
         93rIl4vZzDgIr6h21wtvZK2gzoTF2HpHw5kK2rnmsRT15RHohQ2exKndfEkXHIEFSvJi
         RDIJiadd0mNQP9LnViwYbhh+P80BASVMK1SKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwGrwfETCM+M9+P3a4Nrp7y6QdxVSyzi92rKf4e0uVo=;
        b=vp9YNyTsUNkNJvUpOtrOOnZCiKbwhFB6qgwgA+KQ77zDDd7S0Yu9fFZEo+ZWEjBF6h
         I+Om4DLAvllqM+Uc6924yMujINMqUWeeyceBehwqbO6rAvC0kVwZCpezZaxwvB8p4jLU
         gMwUbdxLaGUT/+C6YYw8EBb8OE0l9l7UiKARsGwdBDziiYURQmW1/WVZhFplKD6xmVyN
         ofB1jIrgAHsWR8O76507hSufKrRjHdxYmLouE9Wq6qjgpQkp1HRaY/yxlMepNrYA637c
         Ut8l4DLamnIpWgONqVrEv8LjCeEUWELradz2eRD/aBiVJ6DWZd6IWvez8pxtdogq3/lI
         4Fgw==
X-Gm-Message-State: AOAM532LURZJQ3D8mJsKigI74jyU+lMWLLKVU5l8ojOi4WnBOxd2R1f4
        1dzQqHV53a7m/UkICOqXjYCsbA==
X-Google-Smtp-Source: ABdhPJxlmDJLYtqZduMCaW0cxX2UeObaGw0dY/yqKl+E3ubVsocJ1ZEGqF+GaPai8YvkFp0Tm9EM5w==
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr28407018wml.181.1643663200650;
        Mon, 31 Jan 2022 13:06:40 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b11sm314961wmq.46.2022.01.31.13.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:06:40 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Du Cheng <ducheng2@gmail.com>
Subject: [PATCH 06/21] fbcon: delete delayed loading code
Date:   Mon, 31 Jan 2022 22:05:37 +0100
Message-Id: <20220131210552.482606-7-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Before

commit 6104c37094e729f3d4ce65797002112735d49cd1
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue Aug 1 17:32:07 2017 +0200

    fbcon: Make fbcon a built-time depency for fbdev

it was possible to load fbcon and fbdev drivers in any order, which
means that fbcon init had to handle the case where fbdev drivers where
already registered.

This is no longer possible, hence delete that code.

Note that the exit case is a bit more complex and will be done in a
separate patch.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Du Cheng <ducheng2@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 8f971de35885..814b648e8f09 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -942,7 +942,7 @@ static const char *fbcon_startup(void)
 		return display_desc;
 	/*
 	 * Instead of blindly using registered_fb[0], we use info_idx, set by
-	 * fb_console_init();
+	 * fbcon_fb_registered();
 	 */
 	info = registered_fb[info_idx];
 	if (!info)
@@ -3316,17 +3316,6 @@ static void fbcon_start(void)
 		return;
 	}
 #endif
-
-	if (num_registered_fb) {
-		int i;
-
-		for_each_registered_fb(i) {
-			info_idx = i;
-			break;
-		}
-
-		do_fbcon_takeover(0);
-	}
 }
 
 static void fbcon_exit(void)
-- 
2.33.0

