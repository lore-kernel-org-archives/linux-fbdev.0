Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C0CC433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2A161222
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349164AbhDGGqd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349194AbhDGGq0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:46:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06064C0613D9;
        Tue,  6 Apr 2021 23:46:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id i4so317978pjk.1;
        Tue, 06 Apr 2021 23:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aNs0AO776EogKhlzulOQJvra1//Jd3QrXTsT/Rf44n8=;
        b=TBa55wJSKfXc31phpjDZmPxaPtI1b8z5bBwBHwO+0yj4x5TkFIxvunTcNiA6hYkcqQ
         JUAaONr16oyjxRFQ3D9ksDLDrbWKC8d+d9YxugrgnRGLhLftQFIqU+XTQc70HU1a8+jm
         H0vHIL2+LMdhSX0D9py+KinOQMp6Hqw42sA5uozZExhhk8DqaKZRiYj/BUsLXMpn0Qrf
         PXh4nVbHRDEpBUlT/sQisCn/FjzIA+BiTNk1B6C5ka5LAMx6czIl4oi+ESKlWrkLVXjp
         ALdsvgfzXqZF5pZxAmjr3TSSDiWerSSgMiOHRTj3iZrinTp8Nu8QalifcCqZNFJNt+a6
         j9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aNs0AO776EogKhlzulOQJvra1//Jd3QrXTsT/Rf44n8=;
        b=Kr/yjUpunWVoXhpSysQ3HLkzVH1yH6aEb0pauhfRWP1WhWH2Xkvrrg2ITH1Gri6qyU
         l8x2nFafPp4wJ9UJ6twD4NZadjzDmwvSH1NEvHTSNFqb4fjNIE3KKRoMrHBlEQSB2vzE
         v6nOBKuRJH41AvCKDiwx6FfDHHCpHaH3PX+VIGhIwTmjNiQPp+ATFwUjqLS6rwQKMl5s
         O8XrAYGGhy543vS22VTrPQ/wz54LPJMG9fTUwFgioNfEQGJDq40MqltQh5YSqt4EWujS
         6j4U1hOUkN53AuFI136HLsxa2Ae1JbRRimVprJSBqeq9k3/MJDhuK+Y/enDpdlAHq5L3
         sVVA==
X-Gm-Message-State: AOAM532LNTFbJ9Ph7KX5LDQ3fiBBau/Wm2WMgxszNAsIDXhzIyp/vPr5
        +zXW2SC5Qd1xusunm0UQfdl53W/47qf+hA==
X-Google-Smtp-Source: ABdhPJxjo7d1CMoBW6P1IsapB0U61Q0/p/IAFor+//t3W48jP0o0jKvZJzh9bR4yn5nq7+JJyZTqAg==
X-Received: by 2002:a17:902:c192:b029:e9:4afd:1f37 with SMTP id d18-20020a170902c192b02900e94afd1f37mr1789594pld.37.1617777977596;
        Tue, 06 Apr 2021 23:46:17 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id o9sm3999643pjr.43.2021.04.06.23.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:46:17 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:46:15 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 48/49] staging: sm750fb: Rename fixId to fix_id
Message-ID: <65640b7983efc71cd60dbec7a2dd1d6d8c6f4344.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the local variable
fixId in lynxfb_set_fbinfo function.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 0c6bfbedde50..946143de11fc 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -694,7 +694,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		"kernel HELPERS prepared vesa_modes",
 	};
 
-	static const char *fixId[2] = {
+	static const char *fix_id[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
 
@@ -814,7 +814,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	fix->ywrapstep = crtc->ywrapstep;
 	fix->accel = FB_ACCEL_SMI;
 
-	strscpy(fix->id, fixId[index], sizeof(fix->id));
+	strscpy(fix->id, fix_id[index], sizeof(fix->id));
 
 	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
 	pr_info("fix->smem_start = %lx\n", fix->smem_start);
-- 
2.30.2

