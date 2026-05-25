Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5483E170E;
	Mon, 25 May 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697724; cv=none; b=Kz1ddLCbd5z9hmHLZRVhatFytJRJ9SR9VUcr1yp8dLRy3sskVoZLNHMZ3lInkX2mWTXPyxsinIfWbI8khJh2h6kuQHTPqldvHY+LTXsrDQWlvwju0eNNXkrD/E3WrOF//beOGHXUm80GATJCoWHSXiKO6Ww4yKIFvJc2If5CnPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697724; c=relaxed/simple;
	bh=NZfLiJfvfB00XpmcuP2gbCB0+9eB0vlPmkNMokZQsIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TA4v/qSpYJknKkRRVNVT5y/5m7iGYsx2Yrv9Z/+QFSAo7dJCzHfLy4W0dWMZZFjZy1wrth/TUlvs7tUKT9+b8qCtoDVN78EOHEfscKwofWazpc/cHchbH699Cf9x6lPG6XQvrmhAOCYpHi17R3pTPRdT8OPjjRDk5xaQlZV2aec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Rniw1FlN; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Rniw1FlN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Lv
	ACdezaJFlYc8/KTHh3irWUTEDg1QmiaXKDHI/aTuA=; b=Rniw1FlNKuOkPC2s2p
	5iB3TBIi3J9EgW31D+0kQiss3+57X+HYFScsNUfpTpr+ThVJi/iP/WepUzqzc7vN
	ZSu40NAecn5cuDd6DVo8t+V28fRjkaICGgvnI4G4Bxxa5849ewBEevJI/iilS9pe
	Iz/HauwxrtvX00aWekT3nIGVo=
Received: from 163.com (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAHGrD_BxRqrB9rFA--.116S2;
	Mon, 25 May 2026 16:27:47 +0800 (CST)
From: w15303746062@163.com
To: simona@ffwll.ch,
	deller@gmx.de
Cc: tzimmermann@suse.de,
	ville.syrjala@linux.intel.com,
	sam@ravnborg.org,
	kees@kernel.org,
	yanquanmin1@huawei.com,
	syoshida@redhat.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH 7.0] fbdev: fbcon: fix memory leak in error path of fbcon_do_set_font()
Date: Mon, 25 May 2026 16:27:41 +0800
Message-Id: <20260525082741.600003-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAHGrD_BxRqrB9rFA--.116S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWrKrW5ArWkWw17Zr13urg_yoW5ZryrpF
	4rG34SkFn5JF1jka1v9w48ZF4rXa42kFW5WayxKa4Yqr45CryUCr4rtFyUZa98GrZ7WFyS
	vw1jy3yjgas8uaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5SdkUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDAAOhhWoUCAPvhAAA35

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

[ Note: This issue was discovered on the 7.0 kernel. While the current
  mainline has already been refactored to use `font_data_t` (which 
  inadvertently resolved this bug), this vulnerability still actively 
  affects the 7.0 branch and older stable trees that rely on the legacy 
  userfont logic. This patch provides a targeted fix for these stable 
  branches. ]

When fbcon_do_set_font() fails (e.g., due to a vc_resize() failure under
fault injection), it jumps to the `err_out` label to roll back the
console state.

However, the restoration of the previous font state (`p->userfont =
old_userfont`) is erroneously placed inside the `if (userfont)` block.
If the failed operation was attempting to set the default builtin font
(`userfont == 0`), the restoration is completely skipped.

This causes a state machine corruption where `p->userfont` remains `0`
while `p->fontdata` still points to the previously allocated user font
memory. Later, when the console is destroyed (e.g., via VT_DISALLOCATE),
fbcon_free_font() fails to free this memory because its `if (p->userfont)`
check fails, resulting in a memory leak caught by kmemleak:

  unreferenced object 0xffff888127ea0000 (size 33296):
    comm "syz.0.8726", pid 33224, jiffies 4297754643
    hex dump (first 32 bytes):
      a6 e4 f9 dd 00 00 00 00 00 82 00 00 01 00 00 00  ................
      d2 09 6c bf 52 8a 7d d4 ef 1d 59 16 51 86 32 bf  ..l.R.}...Y.Q.2.
    backtrace (crc 4a0a57dd):
      ___kmalloc_large_node+0xe7/0x180 mm/slub.c:5214
      __kmalloc_large_node_noprof+0x29/0x130 mm/slub.c:5232
      __do_kmalloc_node mm/slub.c:5248 [inline]
      __kmalloc_noprof+0x5fc/0x7c0 mm/slub.c:5272
      kmalloc_noprof include/linux/slab.h:954 [inline]
      fbcon_set_font+0x431/0xa60 drivers/video/fbdev/core/fbcon.c:2525
      con_font_set drivers/tty/vt/vt.c:4918 [inline]
      con_font_op+0x94d/0xe80 drivers/tty/vt/vt.c:4958
      vt_k_ioctl drivers/tty/vt/vt_ioctl.c:472 [inline]
      vt_ioctl+0x63c/0x2ee0 drivers/tty/vt/vt_ioctl.c:743

Fix this by moving the `p->userfont = old_userfont` assignment outside
the `if (userfont)` block so that the terminal state is unconditionally
and correctly restored regardless of which font setting triggered the
error.

Fixes: a5a923038d70 ("fbdev: fbcon: Properly revert changes when vc_resize() failed")
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/video/fbdev/core/fbcon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 666261ae59d8..a38545dc8416 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2461,8 +2461,10 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	p->fontdata = old_data;
 	vc->vc_font.data = old_data;
 
+	/* Unconditionally restore the previous userfont state */
+	p->userfont = old_userfont;
+
 	if (userfont) {
-		p->userfont = old_userfont;
 		if (--REFCOUNT(data) == 0)
 			kfree(data - FONT_EXTRA_WORDS * sizeof(int));
 	}
-- 
2.34.1

