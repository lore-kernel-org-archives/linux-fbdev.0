Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E9AC433FE
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Sep 2021 10:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F267160F01
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Sep 2021 10:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhIHK3H (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:29:07 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63397 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245727AbhIHK3H (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Sep 2021 06:29:07 -0400
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 188ARqIt069556;
        Wed, 8 Sep 2021 19:27:52 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Wed, 08 Sep 2021 19:27:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 188ARpZV069553
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 8 Sep 2021 19:27:52 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH v2 (repost)] fbmem: don't allow too huge resolutions
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
References: <000000000000815b9605c70e74f8@google.com>
 <131b24e5-ee31-6f7b-42b4-c34583711913@infradead.org>
 <2fccb5d3-191c-924e-159f-1c9d423e282f@i-love.sakura.ne.jp>
 <339bfb21-8e80-c7d9-46dd-c416f87c50c0@infradead.org>
 <535e404d-03bf-8e7a-b296-132a2a98c599@i-love.sakura.ne.jp>
 <CAMuHMdWX7s63X_zR9329canbQkPGBVxZNG4O+_=jUut60aGR9g@mail.gmail.com>
 <5c6d2b95-31d7-0d59-5e62-2593d9a0e1fe@i-love.sakura.ne.jp>
 <CAMuHMdWbSUGRGAVi-17C3hyDBZnGLAsmbAs+wXPHiCNWWLbMpA@mail.gmail.com>
 <CAKMK7uF1cnen2UVWeOL164z1CCqOuRMC5SmM+5GvRvi7C-UOTw@mail.gmail.com>
 <CAMuHMdWNYaZxZB0Td4PFb76rrtQMumKu6cJgLi2aNnW-9NmG8A@mail.gmail.com>
 <CAKMK7uHuOQWUnsiH00QFbHKgTdjjryK0ra9We2stojXMiAVgJA@mail.gmail.com>
 <750ed1ae-de80-b232-4aea-79d60c212fab@i-love.sakura.ne.jp>
Message-ID: <185175d6-227a-7b55-433d-b070929b262c@i-love.sakura.ne.jp>
Date:   Wed, 8 Sep 2021 19:27:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <750ed1ae-de80-b232-4aea-79d60c212fab@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

syzbot is reporting page fault at vga16fb_fillrect() [1], for
vga16fb_check_var() is failing to detect multiplication overflow.

  if (vxres * vyres > maxmem) {
    vyres = maxmem / vxres;
    if (vyres < yres)
      return -ENOMEM;
  }

Since no module would accept too huge resolutions where multiplication
overflow happens, let's reject in the common path.

Link: https://syzkaller.appspot.com/bug?extid=04168c8063cfdde1db5e [1]
Reported-by: syzbot <syzbot+04168c8063cfdde1db5e@syzkaller.appspotmail.com>
Debugged-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Changes in v2:
  Use check_mul_overflow(), suggested by Geert Uytterhoeven <geert@linux-m68k.org>.

 drivers/video/fbdev/core/fbmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 71fb710f1ce3..7420d2c16e47 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -962,6 +962,7 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 	struct fb_var_screeninfo old_var;
 	struct fb_videomode mode;
 	struct fb_event event;
+	u32 unused;
 
 	if (var->activate & FB_ACTIVATE_INV_MODE) {
 		struct fb_videomode mode1, mode2;
@@ -1008,6 +1009,11 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 	if (var->xres < 8 || var->yres < 8)
 		return -EINVAL;
 
+	/* Too huge resolution causes multiplication overflow. */
+	if (check_mul_overflow(var->xres, var->yres, &unused) ||
+	    check_mul_overflow(var->xres_virtual, var->yres_virtual, &unused))
+		return -EINVAL;
+
 	ret = info->fbops->fb_check_var(var, info);
 
 	if (ret)
-- 
2.18.4


