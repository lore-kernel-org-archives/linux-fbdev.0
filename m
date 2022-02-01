Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7DAC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Feb 2022 10:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiBAKzs (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Feb 2022 05:55:48 -0500
Received: from mx2.ucr.edu ([138.23.62.3]:17063 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233111AbiBAKzs (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 1 Feb 2022 05:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643712948; x=1675248948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N87/Yfcs/eolC23BLtRDzeHlHtMpAA1EhSMYLZCuSgg=;
  b=OOuxIn/LseLRPuxUZNIhzFkLS16PlPndBpmf6dHWdRIODpJuFxkAF7Vq
   9HBGPlQBRaNCCEUFol56BIo/Htr2oosUKihNByrO1mFNEZ8LH/YCuX9yM
   KDE5aV4CPOMFFQy8jLmS2MSVuVb/H8BIqVapCr4SDqTLbupMRHYPwBa3F
   qjB1MumCejnLcsdsGEKzu+9RX5IdG8Y/anyaGT2FbZQSLVK5L0SfDyIEE
   WqZMHdsyhBev/iOjGkdrd87JbqfMGgT5YdlGxv775VNv5ca0zOVxcMcGa
   GGMHJLi4yef1ZopXvjwYSS+NlRe/BxPeffHraJ1R/0i4KxbXL7OG9gK7G
   A==;
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="216745304"
Received: from mail-pf1-f197.google.com ([209.85.210.197])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2022 02:55:47 -0800
Received: by mail-pf1-f197.google.com with SMTP id a12-20020a056a001d0c00b004cc283b2e30so8885639pfx.2
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Feb 2022 02:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQBU+rnQ5my6cghLd5mHteSqBsmjbcfDnGbLH9g2K+8=;
        b=BwhVCD5gApUnEMgR2x6gnBOuitDGWagg6hwNd5yCWlvrOYE0V3sK17saP7f+Yc16+1
         G3pRKrhlsqIilqa46HHPg5D6XG36N0Z3ALHPq+0c0RxMv7mmY4MZlPZ7W22rw1/XBYOD
         Eu5zRLrWCD44RW63WrPWEyk1zTrRCt+dI8dzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQBU+rnQ5my6cghLd5mHteSqBsmjbcfDnGbLH9g2K+8=;
        b=7PqKwxwdsEDBJDn4p4hJlZO/nugxFuWraJF+6UDuvHpCYi4YHnVA/sa6U2lY55h75n
         ike7zqMhXiONZO9ZWb6KC4tZHwD0YcUMztKsaAwhr9n331eJI7JnQXxgS+fQfINUeM9p
         wIN1eKrD+LG6dLLhDYL3S6qf5ptVf8P7C5Wi0Rxqw5jnAImorJxn6UlbnqRqmY7euhpN
         u3WZisWavTV8Ah4PLjDQfL8dtVM9N5U8rgm6KHh4rNqxb4ZtORd2R6khB0xVVftkBZgF
         j2djawYoFQPWOEZDqA6+gaNnrA5LuaA3a+5nvxamyuim+wxUy/BWde3Z46yc4py/VqQL
         WPZQ==
X-Gm-Message-State: AOAM530ya+vInMBsGSZDcdsLLNQZdR+PygjZsQZjfKC4dV8XJ8vL53sc
        dYoNwZhVVpUQ+wU1mSBLTEBV/Ft+fzut03bmnqDzbZPtqDQXRcedsKEVcZO8MzT0qhIeva01Za0
        STf55BuYIvnYpZL4pQAMILp3b
X-Received: by 2002:a17:90a:e7d0:: with SMTP id kb16mr1639592pjb.128.1643712946647;
        Tue, 01 Feb 2022 02:55:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwR+51ZW666OWygVPyo83ZYuqOoW9d83uUD1rNUB7qxA4cSjb97vUb10lngV7jgl6wSo1FrUg==
X-Received: by 2002:a17:90a:e7d0:: with SMTP id kb16mr1639572pjb.128.1643712946369;
        Tue, 01 Feb 2022 02:55:46 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id b6sm22349723pfl.126.2022.02.01.02.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 02:55:46 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] fbdev: fbmem: Fix the implicit type casting
Date:   Tue,  1 Feb 2022 02:56:07 -0800
Message-Id: <20220201105610.2975873-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202202011802.cpmdbzHR-lkp@intel.com>
References: <202202011802.cpmdbzHR-lkp@intel.com>
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

