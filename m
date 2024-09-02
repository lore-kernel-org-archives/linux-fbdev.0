Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A606C2AEFE;
	Mon,  2 Sep 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266899; cv=none; b=nMQvBRNcUBE0ABkWzp3/Fe9IGwxzlZZH7uac0kcA8qr0U1xyaNjQAoqTtlqI6+v4MoldJXfHrp5qmudlZqcUUvM8tuQdU4+859nuLVxMslUEc9ZCYJ3tw/qs51z3Fsmpa8r1ts+8no9ywJ/geZX4tTfXWa2WsRYCCTxq1KliAAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266899; c=relaxed/simple;
	bh=FkDXqQVLz2Rs3cMHHnpWWaLG0Fto8N4bhy2NWUB1Dag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WT4zn2JIcXf/173ulGzzjSWDgsB2hD6bnXZMSG7gfpHs7AUlwYm8CGjvVkMyAeXTXehdy7MwY2My9wENd6aPSe4dLY/Oa9aAjpY2libbRlXpGtrzX0zfL0SBvZSJdLeMhwM3X/Ft6YiC8fdxt43ZMUXovFlptGG2SmrjxEowHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAC3vn7De9Vm2TqHAA--.23060S2;
	Mon, 02 Sep 2024 16:48:04 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: deller@gmx.de,
	dan.carpenter@linaro.org,
	tzimmermann@suse.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] fbdev: imsttfb: convert comma to semicolon
Date: Mon,  2 Sep 2024 16:47:30 +0800
Message-Id: <20240902084730.4111387-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3vn7De9Vm2TqHAA--.23060S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47GrWUJF4rGrg_yoWDZrXEyr
	12q3yUGrZrAa1fKa4xKr13uF9Yy3Z5ZwnxXFnaqFZxAFy7ur4rAry0vr97G3yUW34UXFy5
	Jryvqw4SyFyfujkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUeFApDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/video/fbdev/imsttfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 660499260f46..dc4e659e06af 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -995,7 +995,7 @@ imsttfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 	bgc |= (bgc << 8);
 	bgc |= (bgc << 16);
 
-	Bpp = info->var.bits_per_pixel >> 3,
+	Bpp = info->var.bits_per_pixel >> 3;
 	line_pitch = info->fix.line_length;
 
 	dy = rect->dy * line_pitch;
@@ -1036,7 +1036,7 @@ imsttfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 	__u32 Bpp, line_pitch, fb_offset_old, fb_offset_new, sp, dp_octl;
  	__u32 cnt, bltctl, sx, sy, dx, dy, height, width;
 
-	Bpp = info->var.bits_per_pixel >> 3,
+	Bpp = info->var.bits_per_pixel >> 3;
 
 	sx = area->sx * Bpp;
 	sy = area->sy;
-- 
2.25.1

