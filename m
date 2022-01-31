Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7113AC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jan 2022 07:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357855AbiAaHES (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 02:04:18 -0500
Received: from mx.ucr.edu ([138.23.62.71]:11233 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357848AbiAaHEP (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 02:04:15 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Jan 2022 02:04:15 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643612657; x=1675148657;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eEsk92A0ZXPnX2Ki88PFE3IgBq8wg+0W/+nONtlHHnA=;
  b=LK5m2QKMqnIttyXR0rtWuuHV7TSefDDT7RkJbiW724Bi3XwqSi7GwYf2
   EQ4ZlVFVK0gWz5WyN3dSsd0DDn4o+58W6JC0EO5jFNE4/PJad5jueSf/A
   p/X4U7QziuWb8+hBKZ7B4aClBYU6PDNVzwcLXM5Z5XtOZYogY2o7zFZfO
   4o7dyZWh2smUOq2llPOFYW1N2QUpl0sg/HRR6Nn9mSNaX8jPix1sGD7Km
   83zShKLz7nygHA/15RTN2YR4RjCKQ4wvarNg0B6s3vHnsIo2pPcmBGf9S
   bnfPKwas3Any2xmulKao7tvD2ACaepN/Wz2SdH2gipqgraTQp4kqiwdOn
   g==;
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="277379301"
Received: from mail-pj1-f69.google.com ([209.85.216.69])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2022 22:57:01 -0800
Received: by mail-pj1-f69.google.com with SMTP id i8-20020a17090a718800b001b35ee7ac29so8609561pjk.3
        for <linux-fbdev@vger.kernel.org>; Sun, 30 Jan 2022 22:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9mTVzsHAHJ5mTM22d2IAe55DJRgo8Pr7F09OYCu4c4=;
        b=dEYxCn3BfV+JihG8ONV/WUGd8IamJ2JvzSSyxN0Yc69fn81moYaQ7zA8iO84UMQDkP
         uhUF08FkXagVOD5CW2tvG0POmWwZjo4ZdNbloTwew5BnwG9z64bC6i7JLYIlTLgUkphJ
         +ztQFc98NYZfDzfi41jfdivXxHpiLrzU8f/cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9mTVzsHAHJ5mTM22d2IAe55DJRgo8Pr7F09OYCu4c4=;
        b=gsN5KRFyxkd3gKMqg06kds0TY+ckq87tSIK2Xjt6bqrwwSa3u8p03eO48W5PS4aGIg
         e4CvDdbuIGHXauwo11eUHB6Nb+2ugF+CmBm3DH0JcW/+HU49GndN39nGquN2VAMRRqSd
         Lg+uDcBS/3zVdXKdrofMBCe10VwqQ0abHwJ3+d0/exMnfUHwtzbOt8YUK/DcJh1TJBL7
         fITz4QN+BlN06x128jqqEc4SqP/BzsYOiGpqOSaae1wF+CvEgw3sa/o860zNGG7fDoSb
         75yBkLbN+XLO6bXIjiW9kyZcQcvNr1zCqvfXDfQ7ZlvFY7mX+fySuJlNFEFyZLQ9gMYz
         pBaA==
X-Gm-Message-State: AOAM531sT2769vKZ4sVyh5f1zRS/ggNQMiqA00dCBP5MTGHTZKy5VO2p
        JyMvbvV+al9o0lHws1gZXDvWUJ6h5keqQH/tnp8WGhV5mp0oBGEhyCcBK7EDQcan525gaORViUa
        Q5laD7KQmJlAGQnIUdI96IQRs
X-Received: by 2002:a05:6a00:1394:: with SMTP id t20mr19171346pfg.70.1643612219930;
        Sun, 30 Jan 2022 22:56:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYqb47bfhGvFHVqHFtNpiuYQ+NsZNuHIRbT+5N2iRk9p02bVcswfTGcUNfips3vZNzbIN8WQ==
X-Received: by 2002:a05:6a00:1394:: with SMTP id t20mr19171333pfg.70.1643612219691;
        Sun, 30 Jan 2022 22:56:59 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id h3sm9641434pfo.66.2022.01.30.22.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 22:56:59 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: fbmem: Fix the implicit type casting
Date:   Sun, 30 Jan 2022 22:57:17 -0800
Message-Id: <20220131065719.1552958-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
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
the user input.

Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
---
 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0fa7ede94fa6..a5f71c191122 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1064,7 +1064,7 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 EXPORT_SYMBOL(fb_set_var);
 
 int
-fb_blank(struct fb_info *info, int blank)
+fb_blank(struct fb_info *info, unsigned long blank)
 {
 	struct fb_event event;
 	int ret = -EINVAL;
-- 
2.25.1

