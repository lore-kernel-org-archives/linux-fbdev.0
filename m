Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A88C4708C
	for <linux-fbdev@archiver.kernel.org>; Mon,  5 Dec 2022 22:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiLEWL7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 5 Dec 2022 17:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiLEWLz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 5 Dec 2022 17:11:55 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E761A216
        for <linux-fbdev@vger.kernel.org>; Mon,  5 Dec 2022 14:11:52 -0800 (PST)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2B5MBo19027801;
        Tue, 6 Dec 2022 07:11:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Tue, 06 Dec 2022 07:11:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2B5MAZtx027513
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Dec 2022 07:10:35 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d37c0147-3605-a876-9b85-16bcbc05eaa6@I-love.SAKURA.ne.jp>
Date:   Tue, 6 Dec 2022 07:10:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: [PATCH] fbdev: fbcon: release buffer when fbcon_do_set_font() failed
Content-Language: en-US
To:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Shigeru Yoshida <syoshida@redhat.com>
References: <000000000000e2efc305ef0d341f@google.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000e2efc305ef0d341f@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

syzbot is reporting memory leak at fbcon_do_set_font() [1], for
commit a5a923038d70 ("fbdev: fbcon: Properly revert changes when
vc_resize() failed") missed that the buffer might be newly allocated
by fbcon_set_font().

Link: https://syzkaller.appspot.com/bug?extid=25bdb7b1703639abd498 [1]
Reported-by: syzbot <syzbot+25bdb7b1703639abd498@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+25bdb7b1703639abd498@syzkaller.appspotmail.com>
Fixes: a5a923038d70 ("fbdev: fbcon: Properly revert changes when vc_resize() failed")
---
 drivers/video/fbdev/core/fbcon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 098b62f7b701..8363f3b2b452 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2450,7 +2450,8 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 
 	if (userfont) {
 		p->userfont = old_userfont;
-		REFCOUNT(data)--;
+		if (--REFCOUNT(data) == 0)
+			kfree(data - FONT_EXTRA_WORDS * sizeof(int));
 	}
 
 	vc->vc_font.width = old_width;
-- 
2.34.1

