Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5F5C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Feb 2022 23:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348051AbiBBXR0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Feb 2022 18:17:26 -0500
Received: from mx-lax3-1.ucr.edu ([169.235.156.35]:5130 "EHLO
        mx-lax3-1.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348050AbiBBXRZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 2 Feb 2022 18:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643843845; x=1675379845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XA4HzDe0AEvwI/VRCaorqRe1KBJyowOMBeCxGfa6hn4=;
  b=RYGSZ8zv3ITIOjgDjJ8slDBjBbOHHtZ5odt60X8gi+e1dtGoJ5RIZh0X
   cgmLQ999y6X2IFhJTdYtfpwqgxvvlnL0Cv0ys+R7Bfot0DIbyGbjevw81
   0bvk9056Rj3HZNeCqF4VEOrcunbJ8EpvDuhcFwJyhO91brrNYi2gizOdE
   +KMWR9u21R4W4syKY3PwrEmewj9kpmrl0aJLwpY5o6XTzzrO3kttMPXjD
   c7FpydZLEyzCbTsk8oR3cdcxkJV7zIQfYQ6Lx63zNPqSovKNAKFhGzp9o
   mFmyx22mze0Nse9XJQIQ1sx8evyr1r7SNZm3q8PxoiRI7v3zYoXFBz6va
   g==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="102019924"
Received: from mail-pl1-f199.google.com ([209.85.214.199])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2022 15:17:25 -0800
Received: by mail-pl1-f199.google.com with SMTP id e3-20020a170902ed8300b0014b46561c92so139834plj.15
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Feb 2022 15:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x0gpjDLXaul+KimMP/te05qJYZBYJvmQ+lbw67iuhZI=;
        b=FLTFy7FMQp58INHLttCuIHz294nTMtd3aPRvSF4FjqWZkgzHuAVT593n57gr6D3wr9
         4So2/UsjM0gDmRsmqeuunUSEgE4Kov61tpxCHiUoF4ry6ArVAmuwNLKe8BL9PEdP3Ru3
         MjqLnU4S6ttaaqm14Expc2Ep0ssiU9Ny3LUTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x0gpjDLXaul+KimMP/te05qJYZBYJvmQ+lbw67iuhZI=;
        b=stswY8Jod1D3KLSs4WMvrPw243iB7hDnA4eZYYFYbFyHfAYVNBP8/ooiT38/iLOC32
         iqQ7D8bKbHwrKAN49TatLs23bAVEpGmfD46+xp3bEBPP35LsoeX13mkRHMVhBD4vxlJ3
         ap8bZbsI1XK65iKeq0/oAN7ZKppt9epby0Vvob//2j4jVFjbCtBcMe8vs8o91R0rEPQl
         qH6CdFOP+waqt9YVteHWW6O8F7Gxxq1KEakvTVpXAdR7VEy2L6pb4AQ5vP8JzezvsYMr
         KzAism7GTdkatHRK3rLDYi+mgV53VE9i1QLOd5b0n6jTfTPaCl09x7aiACCCF7H3FGSj
         AoBA==
X-Gm-Message-State: AOAM53332U2rDJuWKyxYZk/7N+rNui2q76biO7+BH/RFJbAlP7hQITsX
        1fsd9o8HaRPLGPkcQN9fACd1Waxd12QiHFKBmlI750+RUN+fn7cgxqtQE2SzHbUBNaS48gPlbHo
        QmkfG+Tjnk3UKV7yxfwwfBlOS
X-Received: by 2002:a17:903:2307:: with SMTP id d7mr34166963plh.52.1643843844240;
        Wed, 02 Feb 2022 15:17:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxysLdmzckR8L/Q+cSNZ4JMxUGdQpQyEn+58bq1m8yYLz88d/OhDa7N65YARWKJRnqVgxOtgA==
X-Received: by 2002:a17:903:2307:: with SMTP id d7mr34166950plh.52.1643843844033;
        Wed, 02 Feb 2022 15:17:24 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id j14sm27383525pfj.218.2022.02.02.15.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:17:23 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] fbdev: fbmem: Fix the implicit type casting
Date:   Wed,  2 Feb 2022 15:16:34 -0800
Message-Id: <20220202231636.1433050-2-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202231636.1433050-1-yzhai003@ucr.edu>
References: <882bfe4e-a5b6-2b2c-167b-eda8c08419e3@gmx.de>
 <20220202231636.1433050-1-yzhai003@ucr.edu>
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

