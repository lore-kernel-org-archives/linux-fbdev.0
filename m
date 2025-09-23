Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAB0182B4;
	Tue, 23 Sep 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625629; cv=none; b=ZXSDsYyDFyOWDpBLRkLWp4ZVW1oUNL60fgQW/MRra52SEeX1qDZUt1iXbkAn5wrJzdTe/szbibdyorvPZr8YzUhdS4HP2UgDXsbk0HZ9a/wRWLG3Y3rM6i75KsImbbhZZMrV0bM541BrdroKQLEGq7+OclSyZ8Bzf7n0R4c+aKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625629; c=relaxed/simple;
	bh=iqyLva5ENeFJt1XjKaPRFvMGlYqucYojIW/YfbuQ9gM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XXIwNrGa5YxrH7Sgvk0d1bDH8bujGtH9fyBAJwExqUfv/uhcPVOeBC2w28g+RyxykPTVnhl6mq9Z+vkGkAFsdswlLPK6qJzr7qrhQ8VMhAY93+Y3TtUckLSVYcHz+aHtYaIAzdnr+M6VnW0RoXCleLolguPc59fXHrulXOS7TXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cWHB75Np6z2CgP5;
	Tue, 23 Sep 2025 19:02:23 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id DAA421A016C;
	Tue, 23 Sep 2025 19:07:01 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Sep
 2025 19:07:01 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <simona@ffwll.ch>
CC: <deller@gmx.de>, <linux-kernel@vger.kernel.org>,
	<linux-fbdev@vger.kernel.org>, <=dri-devel@lists.freedesktop.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>,
	<sunnanyong@huawei.com>
Subject: [PATCH] fbcon: Set fb_display[i]->mode to NULL when the mode is released
Date: Tue, 23 Sep 2025 19:06:08 +0800
Message-ID: <20250923110608.3385083-1-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Recently, we discovered the following issue through syzkaller:

BUG: KASAN: slab-use-after-free in fb_mode_is_equal+0x285/0x2f0
Read of size 4 at addr ff11000001b3c69c by task syz.xxx
...
Call Trace:
 <TASK>
 dump_stack_lvl+0xab/0xe0
 print_address_description.constprop.0+0x2c/0x390
 print_report+0xb9/0x280
 kasan_report+0xb8/0xf0
 fb_mode_is_equal+0x285/0x2f0
 fbcon_mode_deleted+0x129/0x180
 fb_set_var+0xe7f/0x11d0
 do_fb_ioctl+0x6a0/0x750
 fb_ioctl+0xe0/0x140
 __x64_sys_ioctl+0x193/0x210
 do_syscall_64+0x5f/0x9c0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The issue occurs in the function fb_mode_is_equal(p->mode, mode), I also
noticed that when freeing the memory related to fb_info->modelist, there's
no attempt to set the corresponding fb_display[i]->mode to NULL after
freeing. Based on analysis, the root cause of this bug appears to be that
a certain p->mode has become a wild pointer.

I've identified two code paths for freeing modelist->mode:
1. fb_delete_videomode - removes videomode entry from modelist.
2. fb_destroy_modelist - destroys the entire modelist.

Analysis shows that fb_delete_videomode path should have been fixed in
a previous patch[1]. Therefore, the current bug is likely triggered
through the fb_destroy_modelist path. I've found a reproducible test case:
1. With /dev/fb0 already registered in the system, load a kernel module
   to register a new device /dev/fb1;
2. Set fb1's mode to the global fb_display[] array (via FBIOPUT_CON2FBMAP);
3. Switch console from fb to VGA (to allow normal rmmod of the ko);
4. Unload the kernel module - at this point fb1's modelist is freed, leaving
   a wild pointer in fb_display[];
5. Trigger the bug via system calls through fb0 attempting to delete a mode
   from fb0.

To prevent similar issues from recurring, consider traversing fb_display[]
whenever releasing a mode from fb_info. If the corresponding mode exists
in fb_display[], set its pointer to NULL.

[1] https://lore.kernel.org/all/20210712085544.2828-1-thunder.leizhen@huawei.com/

Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
This is my first time working on fb issues. If there are any misunderstandings
in my analysis, I would appreciate corrections from the community.

 drivers/video/fbdev/core/fbcon.c  | 11 +++++++++++
 drivers/video/fbdev/core/modedb.c |  7 +++++++
 include/linux/fbcon.h             |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index b062b05f4128..bfbf79d6cd05 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2803,6 +2803,17 @@ int fbcon_mode_deleted(struct fb_info *info,
 	return found;
 }
 
+void fb_display_clean_videomode(struct fb_videomode *m)
+{
+	struct fbcon_display *p;
+
+	for (int i = first_fb_vc; i <= last_fb_vc; i++) {
+		p = &fb_display[i];
+		if (p->mode == m)
+			p->mode = NULL;
+	}
+}
+
 #ifdef CONFIG_VT_HW_CONSOLE_BINDING
 static void fbcon_unbind(void)
 {
diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 53a610948c4a..5a0ee96ebefa 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/fb.h>
 #include <linux/kernel.h>
+#include <linux/fbcon.h>
 
 #undef DEBUG
 
@@ -1100,6 +1101,7 @@ void fb_delete_videomode(const struct fb_videomode *mode,
 		modelist = list_entry(pos, struct fb_modelist, list);
 		m = &modelist->mode;
 		if (fb_mode_is_equal(m, mode)) {
+			fb_display_clean_videomode(m);
 			list_del(pos);
 			kfree(pos);
 		}
@@ -1113,8 +1115,13 @@ void fb_delete_videomode(const struct fb_videomode *mode,
 void fb_destroy_modelist(struct list_head *head)
 {
 	struct list_head *pos, *n;
+	struct fb_modelist *modelist;
+	struct fb_videomode *m;
 
 	list_for_each_safe(pos, n, head) {
+		modelist = list_entry(pos, struct fb_modelist, list);
+		m = &modelist->mode;
+		fb_display_clean_videomode(m);
 		list_del(pos);
 		kfree(pos);
 	}
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 81f0e698acbf..2b5e93aeaaff 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -18,6 +18,7 @@ void fbcon_suspended(struct fb_info *info);
 void fbcon_resumed(struct fb_info *info);
 int fbcon_mode_deleted(struct fb_info *info,
 		       struct fb_videomode *mode);
+void fb_display_clean_videomode(struct fb_videomode *m);
 void fbcon_new_modelist(struct fb_info *info);
 void fbcon_get_requirement(struct fb_info *info,
 			   struct fb_blit_caps *caps);
@@ -38,6 +39,7 @@ static inline void fbcon_suspended(struct fb_info *info) {}
 static inline void fbcon_resumed(struct fb_info *info) {}
 static inline int fbcon_mode_deleted(struct fb_info *info,
 				     struct fb_videomode *mode) { return 0; }
+static inline void fb_display_clean_videomode(struct fb_videomode *m) {}
 static inline void fbcon_new_modelist(struct fb_info *info) {}
 static inline void fbcon_get_requirement(struct fb_info *info,
 					 struct fb_blit_caps *caps) {}
-- 
2.43.0

