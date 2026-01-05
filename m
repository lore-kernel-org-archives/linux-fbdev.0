Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F46918DB1E;
	Mon,  5 Jan 2026 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607680; cv=none; b=D+h9AhkRkI2lXM2gYyYJd9BoDIIReYQu09IqSX3Weu5yHLCyAmjY8TQ/9uVpcy6g93+042r4XNizA62X3/o11UZdjMp2+MV5Ng6idF7QnKF/aBdGpJbMAktrUTZMHF6fSh/TP+F9Ffz0lLFw+IqozIQVe7AbHqrXr1XsLyKAEr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607680; c=relaxed/simple;
	bh=wFp9HSOiyAR4QNASZsC+VFtnRUa9CXE4DVndqG1HSE8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b4EJKWvU2x17LfFYlRGssNu5h2E+B55KnIkitEH2nubX5wlpsZo2b6ips9gLTeUDcghknhr9E9/X5cI6KmE0PGz4jBhv8y9oltHVjENs4oU0wxSxTuIXcJR8SJ9tknU8LuNtrHTJAVq7NrwUAeJ+xEQ5w267OuN5w6jk0NxtVbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dl9274zkgzYQvCJ;
	Mon,  5 Jan 2026 18:06:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 590B24056B;
	Mon,  5 Jan 2026 18:07:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPh2jVtpmezVCg--.49593S4;
	Mon, 05 Jan 2026 18:07:54 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: b.zolnierkie@samsung.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y] fbcon: Fix the issue of uninitialized charcount in the remaining consoles
Date: Mon,  5 Jan 2026 10:28:34 +0000
Message-Id: <20260105102834.359460-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHaPh2jVtpmezVCg--.49593S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XryDGw17Xr4ftw43Aw1DKFg_yoWkZwb_CF
	1UZryrZr4kAr97twnYyrs8Cr1rtasFgryrKasFgryjk347WryYqry2vryrW34UK3WjqrZF
	y3Z0qrs29393KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbo8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

After commit 0998a6cb2326 ("fbdev: bitblit: bound-check glyph index in
bit_putcs*") was merged, using alt+ctrl+f1 to switch the tty from tty0 to
tty1 results in garbled display.

The reason is the vc->vc_font.charcount is 0, it is clearly an
uninitialized value. The mainline is fine because commit a1ac250a82a5
("fbcon: Avoid using FNTCHARCNT() and hard-coded built-in font charcount")
assigns the fvc->vc_font.charcount to vc->vc_font.charcount.

Cc: stable@vger.kernel.org
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 drivers/video/fbdev/core/fbcon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 3dd03e02bf97..900c1ccef98b 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1070,6 +1070,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 						    fvc->vc_font.data);
 			vc->vc_font.width = fvc->vc_font.width;
 			vc->vc_font.height = fvc->vc_font.height;
+			vc->vc_font.charcount = fvc->vc_font.charcount;
 			p->userfont = t->userfont;
 
 			if (p->userfont)
-- 
2.34.1

