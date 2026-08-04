Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B94963B6;
	Tue,  4 Aug 2026 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865119; cv=none; b=XQCnS9odoUqCmbhSAsRmTVDw7lfxXaHZ9JwIUXODzI0R+T34Mc2Hv0GaQ72/4caW7o5eWQUftJ76ydqAZzm/bEVwRuAmqt2G2fKb21x0FomBCztBxhoYeA5u9cilhsxILV0qllBcmj1USPmCVpq89Qk0PWSpj/suJJXB+TC5IJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865119; c=relaxed/simple;
	bh=R+vAnRrK0oXxdIQugdIsz/oaG6gtNJSYPcp1mcmxQKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ps5M8iEWyWyDc0/ij9FqWosjc1GGC+ntoZi2wzyCmDU6m6MMAzRig9tWiUZ266PSr+6yI2x9pZiZETz7AGy7zy/59nZSazRReU7gr4lVN+DiDyLqusifVc3WeqNPODdiC13KkbUlDtr2qqVYIXJJXB8oesoy5kJPgBMtAVtc7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BWtjAnYD; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BWtjAnYD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8a
	Yz02xTyJO/l2KmFoJ/kQQG+Rq6gIOacd76mSB09Qk=; b=BWtjAnYD8GplBU5YLB
	D7vS+gmHa6gM1MOj3tA17OJs97AqUSNy9PZk1BQP4QfdBZVAF0WfZgtp6MH0KCk8
	2mSNKtByYsWjSphnzOIbM/g7pwpqLA+Cir/uHLC/vyZ+Go6pSH/WWmZ9i8Z1Ul1U
	FPY3ymMYBR5fUVBcKXI25eQoQ=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnb91UI3JqCyemNA--.22856S2;
	Wed, 05 Aug 2026 01:37:25 +0800 (CST)
From: sh_def@163.com
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sh_def@163.com,
	thomas.petazzoni@free-electrons.com,
	notro@tronnes.org
Subject: [PATCH] staging: fbtft: make dirty_lock IRQ-safe
Date: Wed,  5 Aug 2026 01:37:12 +0800
Message-ID: <20260804173712.176017-1-sh_def@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnb91UI3JqCyemNA--.22856S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF15ZF48WF48urW8GFWkCrg_yoW5ury7pa
	12qa45Ar4kWa1Fv3y3Gr4UZF4ak39Fkr4DKryIkw1xZ3W5Crs7Wr97JFyrXF1FyrZayrn5
	AFWrK347Jw4UGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRdhliUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRUVdGpyI1VzCgAA3i

From: Hui Su <sh_def@163.com>

fbtft_mkdirty() can be reached from the fbcon rendering path while
processing printk() in hardirq context. Meanwhile, dirty_lock is also
taken by fbtft_deferred_io() in workqueue context with local interrupts
enabled.

Lockdep reports a possible IRQ lock inversion involving dirty_lock and
console_owner. A hardirq can interrupt a CPU holding dirty_lock and
enter the console rendering path, which can attempt to acquire
dirty_lock again.

The following lockdep report was observed on an RK3566 system with
CONFIG_PROVE_LOCKING enabled:

  WARNING: possible irq lock inversion dependency detected
  swapper/2/0 just changed the state of lock:
  (console_owner){-...}-{0:0}
  but this lock took another, HARDIRQ-unsafe lock in the past:
  (&par->dirty_lock){+.+.}-{2:2}

  CPU0                    CPU1
  ----                    ----
  lock(&par->dirty_lock);
                         local_irq_disable();
                         lock(console_owner);
                         lock(&par->dirty_lock);
  <Interrupt>
    lock(console_owner);

  *** DEADLOCK ***

Use spin_lock_irqsave() for both dirty_lock critical sections. They
only access the dirty line range, so the IRQ-off regions remain short.

Fixes: c296d5f9957c ("staging: fbtft: core support")
Signed-off-by: Hui Su <sh_def@163.com>
---
 drivers/staging/fbtft/fbtft-core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index ca0c38221c16..193643d0329d 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -298,14 +298,20 @@ static void fbtft_mkdirty(struct fb_info *info, int y, int height)
 {
 	struct fbtft_par *par = info->par;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	unsigned long flags;
 
 	/* Mark display lines/area as dirty */
-	spin_lock(&par->dirty_lock);
+	/*
+	 * fbcon takes dirty_lock while holding console_owner. Disable local
+	 * interrupts here so a printk hardirq cannot acquire console_owner
+	 * while dirty_lock is held and create the inverse lock ordering.
+	 */
+	spin_lock_irqsave(&par->dirty_lock, flags);
 	if (y < par->dirty_lines_start)
 		par->dirty_lines_start = y;
 	if (y + height - 1 > par->dirty_lines_end)
 		par->dirty_lines_end = y + height - 1;
-	spin_unlock(&par->dirty_lock);
+	spin_unlock_irqrestore(&par->dirty_lock, flags);
 
 	/* Schedule deferred_io to update display (no-op if already on queue)*/
 	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
@@ -317,14 +323,15 @@ static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagereflis
 	unsigned int dirty_lines_start, dirty_lines_end;
 	struct fb_deferred_io_pageref *pageref;
 	unsigned int y_low = 0, y_high = 0;
+	unsigned long flags;
 
-	spin_lock(&par->dirty_lock);
+	spin_lock_irqsave(&par->dirty_lock, flags);
 	dirty_lines_start = par->dirty_lines_start;
 	dirty_lines_end = par->dirty_lines_end;
 	/* set display line markers as clean */
 	par->dirty_lines_start = par->info->var.yres - 1;
 	par->dirty_lines_end = 0;
-	spin_unlock(&par->dirty_lock);
+	spin_unlock_irqrestore(&par->dirty_lock, flags);
 
 	/* Mark display lines as dirty */
 	list_for_each_entry(pageref, pagereflist, list) {
-- 
2.43.0

