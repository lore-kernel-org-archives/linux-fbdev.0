Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B408C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Feb 2022 02:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiBACfi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 21:35:38 -0500
Received: from mx.ucr.edu ([138.23.62.3]:23895 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232321AbiBACfh (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 21:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643682939; x=1675218939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q7G0r3sT1MHBeLXqshEFeURJWbJGybewYjiLKBDF12A=;
  b=KrTltakCQywsRqz9iifuGIJm1UazwZjSNzVcAtydDWBIhbPpodHqPlgY
   wQfbdRnExvDEbshQFJImDQGHH9cX2XXkaoJChrnME3HKeBUehz4dhCQ2c
   9ssTVKDVwCSmf4qBTNDkcONwIhw2FvHO3OCw+W7/t1jISphvzrEsKkRp/
   FDVuYT3FoA4SCYPZG2WGHXcRzQPg3kGuROJzAAQMZ8g7/Dd7z16Tke/Tb
   Hck14dFXBaWmgsDr9f+sDvEh9jeFDgc2tkDbSctXvUPdQQaH6uNyWnyHW
   z1MTQEizGq67w1nOQjmoODVlfLy4F28yGjwQVqluQ/BJF2onJOYaxJ20X
   g==;
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="216704567"
Received: from mail-pf1-f200.google.com ([209.85.210.200])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jan 2022 18:35:38 -0800
Received: by mail-pf1-f200.google.com with SMTP id u80-20020a627953000000b004c82105f20dso8380868pfc.11
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 18:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aSa2J7js34wpdjauwfhqRxuvRU1TQ5o8RuxTIvDH3Cs=;
        b=d+GKQPnu9sR+as+Dvt+t9kLxoUDj0AOCQ88bxnUZ1ZmN/OJIeRDt5oGyCLVrP9H1yK
         +9Z50pGEpQ1XuWd6YK8UDEwQw7l0MfzsatDiBLn1TD/TdZZ/Y2hKgEGiQXBirm1lBYcV
         uSTbZx7J6eJOcScJQWhFq3UwERSqjHNHM+fys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSa2J7js34wpdjauwfhqRxuvRU1TQ5o8RuxTIvDH3Cs=;
        b=gfbtIfMdwffPMGjUCD+csDo9KAHo1f8KlrBf3FI4J3x37enr9XIQfGkWYZjFmQI0oM
         77kAZ58Kk+MD7PhNirecrK9wEoBSGyBeaJaEWNEebKCPMc4ph4fBjjX4EXGs3vlgq3D6
         1Y8MZ8GA0BVYo2wkE4Q+5muByRKqkBthv8ifeGW+QBVhnnumNSweyDMrWJcKSXlSg9z4
         dpsFHNMQq5FAMycVKwirSaNTp4zRPel3d69D9wT5F77FAHx3AMa52iBK3NQt4YR/ru49
         3po2pHfQj2y2QuQXeHqEc9pZW/PZBZUfyQo62ewUqogI0mM+XSUFUc9wVsXGamaLVn5s
         I21w==
X-Gm-Message-State: AOAM533bA8XqShKewRYea6lXH91Kl9xJ62xY4qldClm6hsgRJyiNgcQI
        XSNd336H3/Lxsq2NxoLoyv/XtWKJMYhDLpws+F9fRdGoZAuq9wq8yZEQXjZuqNpDwNlkjeWhDjL
        NAywAZ5XNEN4uh4rHanTbsDdF
X-Received: by 2002:a05:6a00:98d:: with SMTP id u13mr22561452pfg.83.1643682936943;
        Mon, 31 Jan 2022 18:35:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQjGWejUV92C73WZlbo37LitJ/aFNM3AcfTSBcRBOYPWcQdX8WwT1o2NE9voSONanMEb9GWQ==
X-Received: by 2002:a05:6a00:98d:: with SMTP id u13mr22561430pfg.83.1643682936703;
        Mon, 31 Jan 2022 18:35:36 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id d1sm20083105pfj.179.2022.01.31.18.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 18:35:36 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fbdev: fbmem: Fix the implicit type casting
Date:   Mon, 31 Jan 2022 18:35:57 -0800
Message-Id: <20220201023559.2622144-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202201311943.VXU6K1gH-lkp@intel.com>
References: <202201311943.VXU6K1gH-lkp@intel.com>
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
index 0fa7ede94fa6..f08326efff54 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1162,6 +1162,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOBLANK:
 		console_lock();
 		lock_fb_info(info);
+		if (blank > FB_BLANK_POWERDOWN)
+			blank = FB_BLANK_POWERDOWN;
 		ret = fb_blank(info, arg);
 		/* might again call into fb_blank */
 		fbcon_fb_blanked(info, arg);
-- 
2.25.1

