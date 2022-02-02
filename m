Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9B7C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Feb 2022 23:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344512AbiBBXeB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Feb 2022 18:34:01 -0500
Received: from mx-lax3-2.ucr.edu ([169.235.156.37]:60219 "EHLO
        mx-lax3-2.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348099AbiBBXeA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 2 Feb 2022 18:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643844840; x=1675380840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uavpFDxmGoKjrnyH0fVmnFMq2r7aGr052ubiJDv8DR8=;
  b=dCWRywTQq0xKthzSJakoV4dzKPy9VPUC+xAWTzqyfDN7THLTayjBWw6A
   xdXXHAiGxKh3heuoGZZUrUlMsU8AcaGP5inAY8exTio1gm48nWrvrsbAa
   +pOeAgSnUYfHT/kc01kBfNISvKw8KWKKMC/hPnjCxQigl8uZXIcm8+SdW
   AndyqnxnKHdej8e/iIQxA6d561yAwV9q3QudwF+i96I7k1VWG2WtWTYbT
   1k+ULxwKmUObOkkNQSknNZnr3au9DnGZHnKzr649Oh/W8NlVNJvZDlWbg
   fWrRmuEPGG2gIKzAxslIM0uPYpWPXOxxJbpp9Su14fZQg+bHn63KDHN6p
   g==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="102067173"
Received: from mail-pl1-f197.google.com ([209.85.214.197])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2022 15:33:59 -0800
Received: by mail-pl1-f197.google.com with SMTP id h11-20020a170902eecb00b0014cc91d4bc4so158736plb.16
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Feb 2022 15:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LoPhiSf2j9AFlf81eKG6xH4TR1F1QmboBbxydv3xQ7Y=;
        b=Vi+u9jBD+QVIbMUO77wQyOqhnpPIQvWmztX0ACI8XT+Izg3ej/xW05bi3EpXKQmC5b
         n2YPYxIV9U/xOb7ZmjQpv3qNoS/YYE8CzEdnpG+tSda1iqZ+zUfQ64mA8a+I0O/SBnbh
         Q5tT4F4wSPQgCi1arxRFL3Dhz5HXvtylb9o7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LoPhiSf2j9AFlf81eKG6xH4TR1F1QmboBbxydv3xQ7Y=;
        b=WewnpK9CZYHwmdwLBln9DRsePbPj/yX+LaQPA9aflY+ffRhwcgPJNnsbf9eQ6P3etg
         L6N/ZP4C74hIvJZ718ZGAqdhMvmABe5AUOildccPmG6oDOS8rGDZ+ehh/lzacMZmq+yS
         zNiZIov0SGIls1KAZ9lt6LuDrENq9FBVPFuS4Z02fOLsq2ejpCGZVnUMmZB2+ARxuG5A
         n7PQPGKxEMP56pZB+Ll1bbHcoy8hLhNW49f/XjD36FExW68ekLRMQTJgbTqH2nNhlixd
         Ef3PdSXYV3umg2iwpI3ZdbCrfkxtcd39ciyb1lKdq9FHVgCEOHguD1rXr/Q08w8KxShQ
         pmlg==
X-Gm-Message-State: AOAM530OTks/y2WH1jXEmYo2De9Djpt0WwzJ5WyicwCiYRV5J33UpjSv
        j5iuURB/qT5QOsaPmslJWorXNYn/Xek6+S9V8dQYX2ldwaCq3TSGPEVrPWlcn/ORTsfjSZp4w8z
        SUQTeiy2wcPofhPyJHTkZ7SUT
X-Received: by 2002:a17:903:2283:: with SMTP id b3mr31859672plh.0.1643844839718;
        Wed, 02 Feb 2022 15:33:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwz4/x8nWtBV0nXYgv98co1MlqgYrtI6GhpsU/PIcCVgrAG4WdSIF+YKtELNEJg4IP2qcHSQQ==
X-Received: by 2002:a17:903:2283:: with SMTP id b3mr31859649plh.0.1643844839488;
        Wed, 02 Feb 2022 15:33:59 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id s2sm26380387pgq.38.2022.02.02.15.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:33:59 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        William Kucharski <william.kucharski@oracle.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] fbdev: fbmem: Fix the implicit type casting
Date:   Wed,  2 Feb 2022 15:33:59 -0800
Message-Id: <20220202233402.1477864-2-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202233402.1477864-1-yzhai003@ucr.edu>
References: <83e46d8d-ec7a-6cbd-010e-7f50f88dcf96@I-love.SAKURA.ne.jp>
 <20220202233402.1477864-1-yzhai003@ucr.edu>
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
 drivers/video/fbdev/core/fbmem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0fa7ede94fa6..d5dec24c4d16 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1162,6 +1162,11 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOBLANK:
 		console_lock();
 		lock_fb_info(info);
+		if (arg > FB_BLANK_POWERDOWN) {
+			unlock_fb_info(info);
+			console_unlock();
+			return -EINVAL;
+		}
 		ret = fb_blank(info, arg);
 		/* might again call into fb_blank */
 		fbcon_fb_blanked(info, arg);
-- 
2.25.1

