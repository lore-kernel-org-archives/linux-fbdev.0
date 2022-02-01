Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897C7C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Feb 2022 10:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236968AbiBAK4D (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Feb 2022 05:56:03 -0500
Received: from mx.ucr.edu ([138.23.62.71]:56807 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236943AbiBAK4B (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 1 Feb 2022 05:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643712962; x=1675248962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N87/Yfcs/eolC23BLtRDzeHlHtMpAA1EhSMYLZCuSgg=;
  b=JlNMx/SSCHAwpC0QlVnQyIuTMtiDpmfUYmYrsbGmc8ExpbA6/Z9vmOYK
   XF3nLxDYdGUS7odkLZNY/HSBXVeyhyiEoA0thl6TucVb7+hB7dhPbADYv
   ngN6V8swzKnjMEFuUZjS3VigjRJVHsFvQSNfL7PycG8qk3g7+BGXefljO
   vK1+XhcA/H9dAhmvrIkf0QCu2ogtG9N6PyjbWRQCc8SfXoYPjD1Dl/wMa
   IJE17B7tCrVYyrfpAI/lCHNNAczO58DEda9P7zKBp3eNDbwHWCZFd5wGa
   fB2+aLEZNGsXeG08S6+A18Xj/3oRqo9dShRWr56SqWB1qEWJxiPLI90Wd
   w==;
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="277699238"
Received: from mail-pf1-f199.google.com ([209.85.210.199])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2022 02:56:02 -0800
Received: by mail-pf1-f199.google.com with SMTP id 188-20020a6219c5000000b004ce24bef61fso3660371pfz.9
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Feb 2022 02:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQBU+rnQ5my6cghLd5mHteSqBsmjbcfDnGbLH9g2K+8=;
        b=Kp+L/NXLOT26so2b9sKhMnvfFfAOWX2LvoHcv+Y79qAJpkTqghLmqcuxSdhQq4LvKc
         sFDd6zoymWPC37y2O0KKu+BDk+7xTDK+4VvFJ9ELAUbXMwgNtOcas2ir9izjxhd9RklV
         Oinco7mkkofgTbTvtdOMWBxc04FCfIqk8RnmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQBU+rnQ5my6cghLd5mHteSqBsmjbcfDnGbLH9g2K+8=;
        b=SAbZmfRHh/7VnIsPxWIwWlXRGYAutFXGE/1I9KgQEKsPqKhgxo3y7lbAQFpGaUsJPM
         IUuPe5zQzMCkSXBLNZRv3MIUNXCoN+FV0ylW35v14trCRwD1Wd6MiT9IJbclFrW8qf7N
         kF5OqUAvvIOEfjFQYAbD0dLZxtCQ+BZbTXCatbyMc2XsMxouWx6l9BEI0PBPls0+x3bF
         uZ65PlEI4yP2MnkInnYKITk6phKuzMItHFoPl2O2/jEvAQOW/miigC3/KiA+BCkHmCgY
         WBrBJj7hlQww/mdxFhuAoVNvJdCDIL5TrljRUfdrgEmivMFzHvmoTeTfo2Yetf/mZ+Ih
         x1hA==
X-Gm-Message-State: AOAM531bI7JWQ5CDqne5SPSNksl2pYEQZUKoEL5Y8aT8n/1yco+Y1PPR
        rklZJ/Os5DDhVxzpwh9zvRMayFboj0Dl/xmZeaMlCQ7je7MxfUiBxP+NZYxxyvp8UQpJ0mD4VAZ
        r1tMNKZcwmCl6dNILQLlNnpci
X-Received: by 2002:a17:902:e5d1:: with SMTP id u17mr25442902plf.40.1643712960612;
        Tue, 01 Feb 2022 02:56:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+4Bx2r2dBQG35mt2wEHOqbwiXd+lGZCO+bfqdjhApNLkZyLU6LTpemTtlr9KBpq1jXc4xRQ==
X-Received: by 2002:a17:902:e5d1:: with SMTP id u17mr25442869plf.40.1643712960369;
        Tue, 01 Feb 2022 02:56:00 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id b6sm22349723pfl.126.2022.02.01.02.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 02:56:00 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] fbdev: fbmem: Fix the implicit type casting
Date:   Tue,  1 Feb 2022 02:56:08 -0800
Message-Id: <20220201105610.2975873-2-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201105610.2975873-1-yzhai003@ucr.edu>
References: <202202011802.cpmdbzHR-lkp@intel.com>
 <20220201105610.2975873-1-yzhai003@ucr.edu>
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
index 0fa7ede94fa6..991711bfd647 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1162,6 +1162,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOBLANK:
 		console_lock();
 		lock_fb_info(info);
+		if (arg > FB_BLANK_POWERDOWN)
+			arg = FB_BLANK_POWERDOWN;
 		ret = fb_blank(info, arg);
 		/* might again call into fb_blank */
 		fbcon_fb_blanked(info, arg);
-- 
2.25.1

