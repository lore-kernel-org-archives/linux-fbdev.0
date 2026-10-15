Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E149EC7F;
	Thu, 15 Oct 2026 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052987; cv=none; b=lmkOroTTEZJW8Xnh7tvPhr05ff0cM4frktd2Pv6gIHH2HFqPF6Rn58n9BlMUAjY37B7DhSbsvVXhNOaVX4/TD4jqsgI65CnYmLQv3E7in34ms4fjihYjiZ9h2M/B40nLl2ZziF8wRzH8O2DnLdw4KrodN/SJkdLg7dZSeb6f0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052987; c=relaxed/simple;
	bh=9qie4MYwVdtRbyK8ZixjA0/7sKUS3C+EBjroQCNo6SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bblW6iNmKkr0BJuhc5SWRkSZQbOa04W34ia3dzghk45H+hfldajlVV8XuU8QYgvCux2oBXwV49RNQGjKgRdvY6gy4MF5JGWBIGqlZHM/mmu/D/Iu48rEE/o+WAB9GIvNkn6W4TbWiUE9haQroImePWImJ7XgkxqC3EeiagsvKZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Yx5prneR; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Yx5prneR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=d2
	wSfy1ouiPWLrgp3sJUvgB+WhxTFo9bRTRUFOtjxXI=; b=Yx5prneRCgKZMYx6Dh
	QIvqdZf2aOdAsohQcemYSWWaZwCZDwcZ21UIDULsRQ6IKA2V4Lb5ATwQ/DZd/H5u
	/2MgJY76rkwmlyRAqnh7Mauwp6NOcf+p1wegAicpex+uFOzDC3q8/m9TwgUocE3D
	1nxURGmRNtNUfQIwWshC5w2Gw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAX5xeZjtBqeS4mEA--.26264S2;
	Thu, 15 Oct 2026 16:28:09 +0800 (CST)
From: Xia Yan <yana06070@163.com>
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: remove unused CRTC cursor fields
Date: Thu, 15 Oct 2026 16:27:57 +0800
Message-Id: <20261015082757.10371-1-yana06070@163.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAX5xeZjtBqeS4mEA--.26264S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrW5AF4UGw1fJF4fXr1DWrg_yoW8Gryxpr
	W8tw4DCr45tan5Kr1DJFs7WryfK343CFyxGa9xG3909r1Utry5CrZ0934DGrWUWF4rGw4r
	tF98Zr1aqw4ktFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UP9N-UUUUU=
X-CM-SenderInfo: p1dqtiawqxiqqrwthudrp/xtbC3xqYH2rQjppBNwAA3a

The v_cursor and o_cursor members of struct lynxfb_crtc are never read
or written. The cursor setup and update paths use cursor.vstart and
cursor.offset in the embedded struct lynx_cursor instead.

Remove the unused members to avoid keeping a second, unused set of
cursor location fields. No functional change is intended.

Assisted-by: LLM
Signed-off-by: Xia Yan <yana06070@163.com>
---

Notes (validation):
    Compile-tested on x86_64 with GCC 12.3.1 and CONFIG_FB_SM750=m, using W=1.
    All driver objects and the combined sm750fb.o built successfully.

 drivers/staging/sm750fb/sm750.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index fd1cf9e..6e427d1 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -123,9 +123,7 @@ struct lynx_cursor {
 };
 
 struct lynxfb_crtc {
-	unsigned char __iomem *v_cursor; /* virtual address of cursor */
 	unsigned char __iomem *v_screen; /* virtual address of on_screen */
-	int o_cursor; /* cursor address offset in vidmem */
 	int o_screen; /* onscreen address offset in vidmem */
 	int channel;/* which channel this crtc stands for*/
 	resource_size_t vidmem_size;/* this view's video memory max size */

base-commit: cccafd0f36d8c30d4dcbdce26971dab15e8ab25b
-- 
2.33.0

