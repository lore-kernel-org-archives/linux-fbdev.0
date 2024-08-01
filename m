Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BB04087C;
	Thu,  1 Aug 2024 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722544511; cv=none; b=AkSEzHvoBHG8oIR0G74rpiM1nTX2ux1wP9nkYN/5t/mZOKxje9GWQpcEIAMqTAhT1PfShgO5wAXW5FssJdhS1cphQ8VwKpDbMTUlO7ihZSOb1lj9B9lwGxI5VN2arMeW+bQRocqI5q7reToSJg0uDYbHJJv9Pkx1dVMwD1Zbtes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722544511; c=relaxed/simple;
	bh=GijcUiTt68Q96OPRDPIY1ay6L8eOrhzbTBhn72rZnzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mm3PckaGMEKGdBj8rplSt1582BUP7uuZYncbAnJFjLyffcRjjR93POnOxtfIHxnB/RFp7Kx0VRgqyTnOGlULhX4QxuP35odatph4o+yVebXhIs16gjRn58MR3776wB0DgBdsaMMzvcnhC04L1beJmLdLipgRYF3n7H0m9riJ88M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=PAfL57iQ; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="PAfL57iQ"
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ZcVmsD1jSGdLxZcVnsXLwg; Thu, 01 Aug 2024 22:34:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722544499;
	bh=Xt0EwvNrOXd4uCSAzGoq0YIsCyBB78A5L44qPdMyuXU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PAfL57iQ0ZLvibrFotWhGKkDVY2G3/37BXsTNpCqDxRURps7ZEsUwvToXKtGVlJ8I
	 TuRAFWL9YSGx53PF6y3SYahGr3hhKfDV2wXbhdzID/gMmLqdtRhLedSqSwRl9v9mQn
	 JkFp0ADsHj+c9eZKNZ8Dyi5ib9qxHFHc38GcNcd7lQz9Ajt2gDuETZ1TY8/ou9tMHb
	 VVVk08XIewv0oWpl1D6aF47B4q8TQbDf62xklc7h0uF5fcATKWzJyIS4UgoIkmh/9n
	 AQSeUxr+aUl5XH5N93Y1iNjGUU64Ozn8dD/QtUFirnAVLBvhSkDXQN7YZn3qbLKkB6
	 /cupi8Id6foVQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 01 Aug 2024 22:34:59 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2] fbdev/hpfb: Fix an error handling path in hpfb_dio_probe()
Date: Thu,  1 Aug 2024 22:34:39 +0200
Message-ID: <ec4a9fbbff184e40d50e1f12e6df161ff5119f21.1722544445.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after request_mem_region(), a corresponding
release_mem_region() should be called, as already done in the remove
function.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
*Not* even compile tested only.
It is provided as-is

Changes in v2:
  - Apply a minimal change   [Helge Deller]

v1: https://lore.kernel.org/all/dc4fe3d857849ac63131c5620f1bacf1a3d7172e.1722191367.git.christophe.jaillet@wanadoo.fr/
---
 drivers/video/fbdev/hpfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/hpfb.c b/drivers/video/fbdev/hpfb.c
index 66fac8e5393e..a1144b150982 100644
--- a/drivers/video/fbdev/hpfb.c
+++ b/drivers/video/fbdev/hpfb.c
@@ -345,6 +345,7 @@ static int hpfb_dio_probe(struct dio_dev *d, const struct dio_device_id *ent)
 	if (hpfb_init_one(paddr, vaddr)) {
 		if (d->scode >= DIOII_SCBASE)
 			iounmap((void *)vaddr);
+		release_mem_region(d->resource.start, resource_size(&d->resource));
 		return -ENOMEM;
 	}
 	return 0;
-- 
2.45.2

