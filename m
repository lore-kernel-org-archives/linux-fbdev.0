Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715F1C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Feb 2022 23:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348207AbiBBX6N (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Feb 2022 18:58:13 -0500
Received: from mx.ucr.edu ([138.23.62.3]:5064 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348206AbiBBX6L (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 2 Feb 2022 18:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643846292; x=1675382292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xYvx8fe8wRHtOQTQUEuPl7xZb+NEUT35cy+DHSkqPn4=;
  b=h1wT+Q22xVIBdeTDaV9zETxtCvj7mlzMMxMgNQ32DnMpq5rtlzmuaneg
   DVbvF0qGSJG3Rggws5GZ71Eg7HmU3gvdbpzyBgxonP8poWRPgkUqwnP7q
   h88L/O+SUUoaM2auawhkd73pRo2mKB+iWfKCIsGOyUNX74VfdJ5VNLWhy
   6UmwbNdPAYXmVMb3E/m2Ftm81GsXOqjg873I8JdDMyPNsXbQop+5FBeJJ
   Zy06TkdY5YsWBrQ4HBr57MAy5kEADbMhUZEou7CaQAVdIUn7rT6FHNwmf
   CcGbjjCDoclrdsHRnn/aUpZ6ycbs8+eezL2WWmVvU/D+UHIbOEQAEvMLX
   A==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="217257636"
Received: from mail-pj1-f70.google.com ([209.85.216.70])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2022 15:58:12 -0800
Received: by mail-pj1-f70.google.com with SMTP id p14-20020a17090a2c4e00b001b54165bffeso719959pjm.0
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Feb 2022 15:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUOM8bvwC+la2NKqFvk2uI9Asw+K/wrTaRpdb2Kdz7U=;
        b=TOKLi1xV2VoAfEWpE5V83okRjedJuomWMncW4lik6VyhjCpHVot4ZXMBqgkJnTxt/b
         oXGo5UlO9ifjfReoAtoPe2/Nvn8No/cP8rGA+LA1D7RxUjku7PBWdN1Jjc6qECBlrFcO
         rjctdWIycnceaqeE20k2mgo8clQ4zuEqIjG90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUOM8bvwC+la2NKqFvk2uI9Asw+K/wrTaRpdb2Kdz7U=;
        b=8LT/NyexA7+NZWSSrj8fn+Ela22So0udGDa7923oc+BtFEaxouqOPdWL4ETRqHY1I1
         y4yrpAewHREOrtLUa4/GaLmkRsCTlLqDLjrDN3yjO5U/M04e2vV5eM31z1uNDsfz5+MQ
         bkOto9V60Q+lTgMbcAF2C+epnD4O3ZSWyN55IwEBmMVS9QhaLAScGj1I7MgPNzlqi+Rm
         ccCSxBaIaddub0PqSUWphdikp3mpDA2UrWZ8xmIWfIBWD3EbtblQR/dBO+BAYZQp4HjC
         pNMAtl3/DkIY5WoYp7PLnp/TyVb8smja6xg1zoXww+2t//2m9mFWuL3wA/MEMFjeDq2v
         ROvA==
X-Gm-Message-State: AOAM531JsJ8UaJIFktLab8TDXUIWBz56dHiHxzi7xCZnQTPNWnCkfTH3
        J5kWCYIXpLgA88CI+x6NXF5CV7lYzZotAo9NtODhmumXobluwVUpzMqA0nAJSyr1iJ0+CUp12bT
        f8t+1zwBLQ2Wd3AbELLC/knLs
X-Received: by 2002:a05:6a00:1256:: with SMTP id u22mr32510706pfi.82.1643846290846;
        Wed, 02 Feb 2022 15:58:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/rk+2PWsZGJZmsMuI52ixNCJbvxxZXhGBloxQkqqxkDky7OrWs3+DwSaQCwm+soYe+VmaFw==
X-Received: by 2002:a05:6a00:1256:: with SMTP id u22mr32510685pfi.82.1643846290619;
        Wed, 02 Feb 2022 15:58:10 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id b22sm27854781pfl.121.2022.02.02.15.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:58:10 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Guenter Roeck <linux@roeck-us.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6] fbdev: fbmem: Fix the implicit type casting
Date:   Wed,  2 Feb 2022 15:58:09 -0800
Message-Id: <20220202235811.1621017-2-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202235811.1621017-1-yzhai003@ucr.edu>
References: <f3b28143-5f59-ad77-f2b8-6274a6edbfdc@roeck-us.net>
 <20220202235811.1621017-1-yzhai003@ucr.edu>
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
index 0fa7ede94fa6..13083ad8d751 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1160,6 +1160,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		ret = fbcon_set_con2fb_map_ioctl(argp);
 		break;
 	case FBIOBLANK:
+		if (arg > FB_BLANK_POWERDOWN)
+			return -EINVAL;
 		console_lock();
 		lock_fb_info(info);
 		ret = fb_blank(info, arg);
-- 
2.25.1

