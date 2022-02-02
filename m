Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259C5C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Feb 2022 23:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348197AbiBBX6H (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Feb 2022 18:58:07 -0500
Received: from mx-lax3-3.ucr.edu ([169.235.156.38]:60875 "EHLO
        mx-lax3-3.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242970AbiBBX6G (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 2 Feb 2022 18:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643846287; x=1675382287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xYvx8fe8wRHtOQTQUEuPl7xZb+NEUT35cy+DHSkqPn4=;
  b=XTwqyDMPUvipi5OAfjVMLANO54AgAW+qEkH9m72P3WAdpTZmh3A+fmlS
   9m6CI0TrrOTM5rXNQf3jYF9auhWswWdZqGRawnL7sgIUGPrEAC85U78KI
   gqdJR8Wxt6GNncLsMPZkEcAA3ZkC+x58yWyNOxxkvCwVsS5Xt5dbyYhgv
   YhcUE0Oa1eC/aM/HKj3mb12K319mixco++9B4BzmKVmk4O1u8OM7r9E3V
   DeCuzp7s7qeJxGoPI/dDU30ADRT8U6vAJ5ixzbFMrb3oFjpaC9ImLHj+X
   IDY4j8ZmMq9KRRowb4CTv16mOiqPVQ4r3L/NhbEwaIYUGE95zG1ZZZqQL
   g==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="105399197"
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2022 15:58:07 -0800
Received: by mail-pj1-f71.google.com with SMTP id p14-20020a17090a2c4e00b001b54165bffeso719814pjm.0
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Feb 2022 15:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUOM8bvwC+la2NKqFvk2uI9Asw+K/wrTaRpdb2Kdz7U=;
        b=HrYsDT4AbEktOiXWlPEMn/m7e6zv2dsefdTeMC5C2hJLezPbv+I1/ftDBXrJt6Un0z
         GqSD3kzgEw3q1pfOdDoOgKDJvmgHKg8NIkh4s4COvIsupoE4p/b9lbZQZ4gbhXZtj7sK
         4vUh0ntfzQGjCKF3AZQ0GIBqkvnKIMkIts8xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUOM8bvwC+la2NKqFvk2uI9Asw+K/wrTaRpdb2Kdz7U=;
        b=kI4OjBBldB2RAL/4GxZAey9XmFVMK+vtuTw0Y10CiTEusVeHBAJhKmcv5dEeDn/U6H
         5p+PQikCJtOSGvBKXb0GCq0fmeUUNbuFk0Yl98P449DKgO1Oyl2pxZiv+bedd6oedmj2
         xFmgz7RyQUZEItjN148POisVfAw0k07XSO33zYUblQaQ8X/35yMQB+nOZ/y2M/qyKvPP
         EzzB7qnA4e1CkhXc/iHYqqHMW9qaUNjTX21/DonpQAVLD7c7kcbojfv8nNJ52Uus67iu
         8MaSZXbZ67mCVRWDEBB9kGXh6gg+biHXWvvmmsDEdZFI6DuCHAIUWEzzUDDTRi8HUmvw
         D8WQ==
X-Gm-Message-State: AOAM530+UQjvsz0DiIR/qGN6to7MRxHHeU5vjGQHONidOIqVITgmA74w
        78k19C6jqqwRvGtwOiHhss9xzlpDxzXZ77lhrUUlLUN9f/U3c/Kx47b2fqarXDjULbZdP1nOx0N
        LNs14Ar34W6+AKgyimdqD0lCF
X-Received: by 2002:a17:903:2310:: with SMTP id d16mr33430917plh.20.1643846285918;
        Wed, 02 Feb 2022 15:58:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZKL++WYDLmSn9xU1SSYz871Lo6pf/fCV7Hf709Wi2UHiygHMvfWHZxapRrgqd4vPTs3zu2w==
X-Received: by 2002:a17:903:2310:: with SMTP id d16mr33430902plh.20.1643846285669;
        Wed, 02 Feb 2022 15:58:05 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id b22sm27854781pfl.121.2022.02.02.15.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:58:05 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6] fbdev: fbmem: Fix the implicit type casting
Date:   Wed,  2 Feb 2022 15:58:08 -0800
Message-Id: <20220202235811.1621017-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f3b28143-5f59-ad77-f2b8-6274a6edbfdc@roeck-us.net>
References: <f3b28143-5f59-ad77-f2b8-6274a6edbfdc@roeck-us.net>
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

