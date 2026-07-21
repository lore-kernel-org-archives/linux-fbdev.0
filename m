Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C58395AE9;
	Tue, 21 Jul 2026 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618150; cv=none; b=ZOAV9MGNb13uKAf7u4V1XFruim0i7P/RnVf/QydD7R4My7uk5izfeVNI5dJUI0YeBRDJrdGmNuCAskWW8K3FiuONUkio77AGH/Ki8HElrT6rrvvw9etTFjEaKLyfkJZnaFL5Ntf0X6gXle9j/caRGi4IxzuiXisrqBRdtJrMw2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618150; c=relaxed/simple;
	bh=AePeGOFZigeaH1EnbYCaQzQtvOgA8hmbgeEZru83gaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TyUhW40N3okzH5MS8nP4oKh92D7Mofsjc1thNKcuhmrBGj4TwxWPkTP6dJqUFdnJ6tjMaKAMeprCSBReQiapyoGjLMQXmWzevkLJ2hUOMsXvQX2n+IHtRnISy4mWSfLEbLi5vlbpdG1tWQLxRBjkUo5+SGJXdfgNVWEWNX/DmJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=aJDqtLwY reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="aJDqtLwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=XoyQ8ZpwFC
	1SyQUSXdmeJ6c1Gdm4rFbRFgDkaJFNew8=; b=aJDqtLwYxWw5uqtiKBBd6bsQHZ
	ud10RqUtZYh5/LX4LS+XeDMzajHv8YwWEFF+HhClzn77Yvr7YJHU8HonZUjfq5ND
	7/9jQXxF2HqNUqijwbq32eRIY59CLmWa2wiPMyIp+9vdLRju9Y4adi65lI79WUl5
	7rEDW/UOuLULOf9Ys=
Received: from wmy.localdomain (unknown [115.53.188.159])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkA2fjONHF9q24VJAQ--.39318S2;
	Tue, 21 Jul 2026 15:15:28 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: simona@ffwll.ch,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2] fbdev: core: Clamp total_size to smem_len in read/write functions
Date: Tue, 21 Jul 2026 15:15:22 +0800
Message-Id: <20260721071522.106306-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkA2fjONHF9q24VJAQ--.39318S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1xtF1UKF1rWFW7ZFyrZwb_yoW5Kry5pF
	48uF93Jry5JFyfGFn2k3W3Way5J3WkCr98t3y3Ja4ayrsIyr45ua4xJFyakrW8A3yDXrn3
	GrykJryxuFyDCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUjJ3vUUUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUBEWpeO3l7+gAAsg

Some legacy fbdev drivers may incorrectly set info->screen_size to a
value larger than the actual mapped framebuffer size (info->fix.smem_len)
during mode switches. This could allow out-of-bounds I/O and system
memory accesses in fb_io_read(), fb_io_write(), fb_sys_read(), and
fb_sys_write().

Prevent this by clamping total_size to smem_len when smem_len is non-zero.
Virtual framebuffers (smem_len == 0) are unaffected.

This is a hardening measure; no specific crash is fixed by this patch.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
v2:
 - Apply the clamp to fb_sys_read() and fb_sys_write() as well to prevent
   similar OOB accesses in system memory framebuffers (Reported by Sashiko).
 - Update commit message to clearly state this is a hardening measure.
---
 drivers/video/fbdev/core/fb_io_fops.c  | 16 ++++++++++++++++
 drivers/video/fbdev/core/fb_sys_fops.c | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/video/fbdev/core/fb_io_fops.c b/drivers/video/fbdev/core/fb_io_fops.c
index 6ab60fcd0050..335f16d2cc23 100644
--- a/drivers/video/fbdev/core/fb_io_fops.c
+++ b/drivers/video/fbdev/core/fb_io_fops.c
@@ -24,6 +24,14 @@ ssize_t fb_io_read(struct fb_info *info, char __user *buf, size_t count, loff_t
 	if (total_size == 0)
 		total_size = info->fix.smem_len;
 
+	/*
+	 * Security Hardening: Defend against buggy legacy drivers that may
+	 * calculate a malformed screen_size. Clamp total_size to the actual
+	 * hardware mapped memory limit (smem_len) to prevent OOB access.
+	 */
+	if (info->fix.smem_len && total_size > info->fix.smem_len)
+		total_size = info->fix.smem_len;
+
 	if (p >= total_size)
 		return 0;
 
@@ -88,6 +96,14 @@ ssize_t fb_io_write(struct fb_info *info, const char __user *buf, size_t count,
 	if (total_size == 0)
 		total_size = info->fix.smem_len;
 
+	/*
+	 * Security Hardening: Defend against buggy legacy drivers that may
+	 * calculate a malformed screen_size. Clamp total_size to the actual
+	 * hardware mapped memory limit (smem_len) to prevent OOB access.
+	 */
+	if (info->fix.smem_len && total_size > info->fix.smem_len)
+		total_size = info->fix.smem_len;
+
 	if (p > total_size)
 		return -EFBIG;
 
diff --git a/drivers/video/fbdev/core/fb_sys_fops.c b/drivers/video/fbdev/core/fb_sys_fops.c
index be96b3b3942e..e97cf02f7c70 100644
--- a/drivers/video/fbdev/core/fb_sys_fops.c
+++ b/drivers/video/fbdev/core/fb_sys_fops.c
@@ -35,6 +35,14 @@ ssize_t fb_sys_read(struct fb_info *info, char __user *buf, size_t count,
 	if (total_size == 0)
 		total_size = info->fix.smem_len;
 
+	/*
+	 * Security Hardening: Defend against buggy legacy drivers that may
+	 * calculate a malformed screen_size. Clamp total_size to the actual
+	 * hardware mapped memory limit (smem_len) to prevent OOB access.
+	 */
+	if (info->fix.smem_len && total_size > info->fix.smem_len)
+		total_size = info->fix.smem_len;
+
 	if (p >= total_size)
 		return 0;
 
@@ -80,6 +88,14 @@ ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 	if (total_size == 0)
 		total_size = info->fix.smem_len;
 
+	/*
+	 * Security Hardening: Defend against buggy legacy drivers that may
+	 * calculate a malformed screen_size. Clamp total_size to the actual
+	 * hardware mapped memory limit (smem_len) to prevent OOB access.
+	 */
+	if (info->fix.smem_len && total_size > info->fix.smem_len)
+		total_size = info->fix.smem_len;
+
 	if (p > total_size)
 		return -EFBIG;
 
-- 
2.34.1

