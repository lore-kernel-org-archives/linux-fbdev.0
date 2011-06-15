From: Wanlong Gao <wanlong.gao@gmail.com>
Date: Wed, 15 Jun 2011 01:09:24 +0000
Subject: re:Possible deadlock when suspending framebuffer
Message-Id: <1308100165.2113.4.camel@Tux>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-rTnFNydmgaih3M/h0Rn4"
List-Id: <linux-fbdev.vger.kernel.org>
References: <BANLkTimny9nzr23TufH1kMcsk57M3NXuaA@mail.gmail.com>
In-Reply-To: <BANLkTimny9nzr23TufH1kMcsk57M3NXuaA@mail.gmail.com>
To: Francis Moreau <francis.moro@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>


--=-rTnFNydmgaih3M/h0Rn4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<snip>
Hi Francis:
can you test this patch?
Thanks

From fe026c42af4cbdce053460a428a445e99071586a Mon Sep 17 00:00:00 2001
From: Wanlong Gao <wanlong.gao@gmail.com>
Date: Wed, 15 Jun 2011 09:03:41 +0800
Subject: [PATCH] test



Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
---
 drivers/video/fbmem.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 5aac00e..6e6cef3 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1642,11 +1642,8 @@ static int do_unregister_framebuffer(struct
fb_info *fb_info)
 	if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
 		return -EINVAL;
 
-	if (!lock_fb_info(fb_info))
-		return -ENODEV;
 	event.info = fb_info;
 	ret = fb_notifier_call_chain(FB_EVENT_FB_UNBIND, &event);
-	unlock_fb_info(fb_info);
 
 	if (ret)
 		return -EINVAL;
-- 
1.7.4.1



--=-rTnFNydmgaih3M/h0Rn4
Content-Disposition: attachment; filename="0001-test.patch"
Content-Type: text/x-patch; name="0001-test.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

From fe026c42af4cbdce053460a428a445e99071586a Mon Sep 17 00:00:00 2001
From: Wanlong Gao <wanlong.gao@gmail.com>
Date: Wed, 15 Jun 2011 09:03:41 +0800
Subject: [PATCH] test

test

Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
---
 drivers/video/fbmem.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 5aac00e..6e6cef3 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1642,11 +1642,8 @@ static int do_unregister_framebuffer(struct fb_info *fb_info)
 	if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
 		return -EINVAL;
 
-	if (!lock_fb_info(fb_info))
-		return -ENODEV;
 	event.info = fb_info;
 	ret = fb_notifier_call_chain(FB_EVENT_FB_UNBIND, &event);
-	unlock_fb_info(fb_info);
 
 	if (ret)
 		return -EINVAL;
-- 
1.7.4.1


--=-rTnFNydmgaih3M/h0Rn4--

