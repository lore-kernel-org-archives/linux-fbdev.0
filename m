Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879F2C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Feb 2022 23:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241401AbiBBXRj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Feb 2022 18:17:39 -0500
Received: from mx6.ucr.edu ([138.23.62.71]:6602 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239155AbiBBXRi (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 2 Feb 2022 18:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643843859; x=1675379859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XA4HzDe0AEvwI/VRCaorqRe1KBJyowOMBeCxGfa6hn4=;
  b=f4MeDW74oZ6Q8N7EvkPDbrSy5san7ca2jSeiGmwiDhY0s+4fAqEyxXKo
   ceA6Q6EJKCWGbRALZlmvDuQA6gCCqFRdIuIQ7+hGmZKSwfoCXTK+caXcV
   MjDuKhH01Iskg82Lt9v3JdjKfQWMriQtQOsQ4cUoP2FvvS2qRKSzYvvuK
   3SPCt5sIMAmkMZJ1jN4MiflXl//plyVP5FjZlz7B3xisB8vAkJJuFWLLx
   NWnrGstiCw+EhU5EMpLfRnmjYp547KGNTuJ4AfbM6dfq3FMG8bDSXotB/
   Y7WGbaWra9fLOlbC06PRGe7APRcxRCNtaZR6yICdA/yxDXpAEElqghsgk
   w==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="278234505"
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2022 15:17:27 -0800
Received: by mail-pj1-f71.google.com with SMTP id js6-20020a17090b148600b001b835ae2017so1560758pjb.5
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Feb 2022 15:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x0gpjDLXaul+KimMP/te05qJYZBYJvmQ+lbw67iuhZI=;
        b=iG0hqIojQ+Btn3YyfJz0zIh+ids2UdHlcdajOgKekWODbOVBE25xUjQthNVNVCYJZL
         ziLiUrKHuhoXAKfwZ6C7H0nGSqSQhiN5jcNjOymYda/yMkGSCQpR8Jg0jBCRvZRWu7Ly
         FY1UCAwviBYMivvY4GLNBbBng5j7VlxTHZzhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x0gpjDLXaul+KimMP/te05qJYZBYJvmQ+lbw67iuhZI=;
        b=SAdZObgqH0yzh+t/HyZZ1hfN79ufU+GzyW1Ki7X3IF7RppyZ5jRgni43eSyuqAjHH5
         368fb2icua5DA2q93lAqCFnVM8Ie+1jn/CSrKBa9v2QN8lLBeV6rlE3mJs6QTdm0yqOZ
         wiD+LjKkvBkYbfwuhAKVtLuGM+I3RzBJf0xN6iQ71a4elbq2BFdXGWTaNhkw3Zq2+tb8
         +Yaitx2dxOLPL9Gnmg3DYxEsUv4NeLEdE2uKrvo3ibFuDXDZvmFbFl5AxiPQK6VHSGAW
         417rW3CB6eP+DWVl/jJR0TORPI8Fx1WmXE3rrzidf7lgW5oG/kPS7MCbfC/llvjy5kk+
         bZew==
X-Gm-Message-State: AOAM531qxvBq2kO0pgSF4sy2h47cnTvswXojAa2gJFA4Q/x/dKkl0sEf
        KD4NNSzD/kI9v967LqJ4P4CrPFhsz/oas660tPKPxiO/BDenvHOrhFwJZRxw+9VM4fI2IkULhRk
        8GSOxXHILYl4bSMdztjm7rLZR
X-Received: by 2002:a05:6a00:114e:: with SMTP id b14mr32122976pfm.31.1643843838878;
        Wed, 02 Feb 2022 15:17:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOOE+HHe74jnu6gkVO3QanT2cNSA16ZEnCIFi4F5dLBKqCPSoK9K2Dq+OswSZYFwgxrT9+zw==
X-Received: by 2002:a05:6a00:114e:: with SMTP id b14mr32122959pfm.31.1643843838640;
        Wed, 02 Feb 2022 15:17:18 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id j14sm27383525pfj.218.2022.02.02.15.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:17:18 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] fbdev: fbmem: Fix the implicit type casting
Date:   Wed,  2 Feb 2022 15:16:33 -0800
Message-Id: <20220202231636.1433050-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <882bfe4e-a5b6-2b2c-167b-eda8c08419e3@gmx.de>
References: <882bfe4e-a5b6-2b2c-167b-eda8c08419e3@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

In function do_fb_ioctl(), the "arg" is the type of unsigned long,
and in "case FBIOBLANK:" this argument is casted into an int before
passig to fb_blank(). In fb_blank(), the comparision
if (blank > FB_BLANK_POWERDOWN) would be bypass if the original
"arg" is a large number, which is possible because it comes from
the user input. Fix this by adding the check before the function
call.

Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
---
 drivers/video/fbdev/core/fbmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0fa7ede94fa6..b3352e23caaa 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1162,6 +1162,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOBLANK:
 		console_lock();
 		lock_fb_info(info);
+		if (arg > FB_BLANK_POWERDOWN)
+			return -EINVAL;
 		ret = fb_blank(info, arg);
 		/* might again call into fb_blank */
 		fbcon_fb_blanked(info, arg);
-- 
2.25.1

