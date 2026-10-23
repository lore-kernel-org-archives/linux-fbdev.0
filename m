Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764715;
	b=h4mXLq+8+oWH4Wp6tKsWwlIf1Kw9vOBNeN/UfRr6asvJBiroDeeEamd/Gamn55z95nmK
	 /i1M45zG/uD6/wzJIduUXcyDk/sJ7xOG4IU9viiFpC1I9KPU5lhdY5hZv7MMTLmekYjkt
	 jKcgdP7r4XDQS7BQaHg+Vtci4aXPyTsZzpReV9p6IYxNMTO/xNkBuresBWfWU5bDoFRjM
	 T8Hfrxgy+k2mUvqCjwUhBVaXCU8JVIlxN5qV+3hEOrTwxs3aqABox7mtEyTQxcHBiJlk+
	 JF2If3TPzWxG0081+QQ1S5Frmd6Z8qQgn7yKCjYkpuDn18G+Mx0/1DFNQaeAbudZMjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764715;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rXPPl7lB2R2i1WkyTB9sGHV8QF0hiesETUsWnIMsNEQ=;
	b=Ye7ftG30TOZXDqBR2vBqAOLC+GBCebGBtA/sKrMahu6sX5o4rzoe6IY8mmqxmggL6txL
	 gwCcZBVcbJBHMpWq++mNvsmlUENufy6rJ24N98z0NSYfVqAlJgnoZ3f1a/HtwgQ8j55rk
	 E3RMMScKzC0ZKEH683VYB0PwErcg99YjXKConPwXpKBaCURugc6txkbmtMz1vZhe7aMwY
	 dtFZXT5xiVJLbgc/CPYDvTkNZlPnZxkYLfxWSU6TUVL3T+NcVm0fgfi7XxuGt3VFKr6Sy
	 JXbczNbp2+26eCV95ieRnUE/d/oODSIdVVcz9C3nYh/Ta7/akeYAiveLEKZ+qW8d9bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=zMx8727E;
	arc=none smtp.remote-ip=43.163.128.49
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B35606A31A;
	Fri, 23 Oct 2026 14:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7B35606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=zMx8727E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792764706; bh=rXPPl7lB2R2i1WkyTB9sGHV8QF0hiesETUsWnIMsNEQ=;
	h=From:To:Cc:Subject:Date;
	b=zMx8727ErpkCvqfPWDVNrWKtpArWIe57sHK9zU9+6mn+oIVNTPELDzSsCQbx/onvc
	 SIrqd1zhf5IQ+0oZuvMoy+xwOuJcqJeBPmULNtCXL0vYu9YkRwC2pI1SpWmT+4KyLW
	 vW1qJey1su39VC7TtG5eJit2FEYgl2DMKbFTaOQA=
Received: from shuai-VMware-Virtual-Platform.localdomain ([223.88.55.50])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 2EB9A4DB; Fri, 23 Oct 2026 22:11:43 +0800
X-QQ-mid: xmsmtpt1792764703tmljcyd4z
Message-ID: <tencent_968494FB97743E0BB87C77D318AEA118F606@qq.com>
X-QQ-XMAILINFO: MDJWyUmJdVqKygtk9b/8RBPTmJ4w5khvrZ2z+fO8jS305/pS07REO+J0i1LzTk
	 42rONfGX/s76nG5EwOozDku95Esw8ayfGXCJz8kivuJAsxQXQY2pxmhjsGqgAvPqqMKK+qAGlIuh
	 p9a0zluw+HoWHuZE3O1yxfyCmdh5jVBQipJZjJP+soJ7PPaQMxdny9AiINlSdX+DRLLFopE7ViYd
	 Cn5fo1iLvTFbTXJVuGcZOlvvQGPJzKezXOggMA4TImy6FWBSNRRjc/hOFPMpGga0HLqDRPLCsR6X
	 hThrHVUjSZ3HQBf2WEK0G9j5kOva6LDsmyBCHVA4u+Hc2jvXv5dz37D5EhtKOJvgFoEYO6UM3i8Y
	 CGTskjq31uVqwGj9ZIbWvuXfbFPTJWnsLcPIyvGDcqli+SHdNfHMEGltgWDKm9R9nmN4aULO99qE
	 AVoHC3/cBrY8QLpxBIWc0DUfoSHwjR283y44c7xO6CmmWGUC3LxW2cZKuUIpooEWpbn2z/u6JfWi
	 JY/5FFw+UOi8nFSlnu1/4HX4eNgtimG7z+UizzDDXC5RhOMKrj1DoL8TBjPtpbF3L4fiIf6JSfg1
	 oddhZJX2EXwvHt9iowLQ2PYQOPlBB0eCQwlTKrx8MZz6/mTtzqubvhbLi4b4lc/2b3SoLaImKNY+
	 EoN2R6fAHWfP6+tx/soIVrmgEvU1lQVJ8ul/D70Mazi33QYAAocR26qKD01f+8CehM1pUQGiP5tv
	 Vg8SQ+sXzpbiAEE8MympLmoLLFI9Z2tNP+d0f3MRy3mOuBhQZe2Y4wgOtGEJUD+eid5o2YnmWqjb
	 b4ggiJcjB2xijPz3NP8KqRg4MPZlNdFh7PKY8Kf4lFFGXQ3/+8EeH0SbZavEficWDcdS9dy2Bqmg
	 yxloQ2WAgqKlgW0k/PlF1N6c70vB0HeyiNbl5wBCOyB29GKOYiDniWEc4shzk2RH5vhW/qOVT1X2
	 lDRV4Hdh+Dbf0NoCXhudJlQ9I10ev4FiUASgp0pWbYbujZhUbml7iqzHaSiMDIl5EUIi/1/TyJBu
	 kemTrPDlVbkER51nnA7bW27nuYQX3aKEmAwp/mS9dozdbyz0DJvh0glOER+An1+06+URIGcqZ6Vr
	 gOAqHM4UOkmmOcQvMrZj4OiZc8/ZWcrXxB3wd7aSBlLMYdXQ5HVWmwiTOp9yCFor3Yq9Ig
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Shuai Liu <847807867@qq.com>
To: SudipMukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev
Cc: linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH 1/3] staging: sm750fb: remove unused macros in ddk750_display.h
Date: Fri, 23 Oct 2026 22:11:41 +0800
X-OQ-MSGID: <20261023141143.183061-1-847807867@qq.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These macros are not referenced anywhere in the tree. This is part of
the TODO item 'refine the code and remove unused code'.

Signed-off-by: Shuai Liu <847807867@qq.com>
---
 drivers/staging/sm750fb/ddk750_display.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
index 7f713906dc16..097ecdfa6e79 100644
--- a/drivers/staging/sm750fb/ddk750_display.h
+++ b/drivers/staging/sm750fb/ddk750_display.h
@@ -22,7 +22,6 @@
 #define PRI_TP_MASK BIT(PRI_TP_OFFSET)
 #define PRI_TP_USAGE (PRI_TP_MASK << 16)
 #define PRI_TP_ON ((0x1 << PRI_TP_OFFSET) | PRI_TP_USAGE)
-#define PRI_TP_OFF ((0x0 << PRI_TP_OFFSET) | PRI_TP_USAGE)
 
 /*
  * panel sequency status
@@ -32,7 +31,6 @@
 #define PNL_SEQ_MASK BIT(PNL_SEQ_OFFSET)
 #define PNL_SEQ_USAGE (PNL_SEQ_MASK << 16)
 #define PNL_SEQ_ON (BIT(PNL_SEQ_OFFSET) | PNL_SEQ_USAGE)
-#define PNL_SEQ_OFF ((0 << PNL_SEQ_OFFSET) | PNL_SEQ_USAGE)
 
 /*
  * dual digital output
@@ -42,7 +40,6 @@
 #define DUAL_TFT_MASK BIT(DUAL_TFT_OFFSET)
 #define DUAL_TFT_USAGE (DUAL_TFT_MASK << 16)
 #define DUAL_TFT_ON (BIT(DUAL_TFT_OFFSET) | DUAL_TFT_USAGE)
-#define DUAL_TFT_OFF ((0 << DUAL_TFT_OFFSET) | DUAL_TFT_USAGE)
 
 /*
  * secondary timing & plane enable bit
@@ -53,7 +50,6 @@
 #define SEC_TP_MASK BIT(SEC_TP_OFFSET)
 #define SEC_TP_USAGE (SEC_TP_MASK << 16)
 #define SEC_TP_ON  ((0x1 << SEC_TP_OFFSET) | SEC_TP_USAGE)
-#define SEC_TP_OFF ((0x0 << SEC_TP_OFFSET) | SEC_TP_USAGE)
 
 /*
  * crt path select
@@ -73,7 +69,6 @@
 #define DAC_MASK BIT(DAC_OFFSET)
 #define DAC_USAGE (DAC_MASK << 16)
 #define DAC_ON ((0x0 << DAC_OFFSET) | DAC_USAGE)
-#define DAC_OFF ((0x1 << DAC_OFFSET) | DAC_USAGE)
 
 /*
  * DPMS only affect D-SUB head
-- 
2.53.0


