Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD07541D112;
	Mon, 14 Sep 2026 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376988; cv=none; b=GAcHWVxBac3EJXw+kmt/679U9oMAbBo4jejegR03PSfAWN/7OOoPuuXCt5WAn7htFAUfEnrKaiUoJfJkwT2aOvFE1Mljc1Sc6AcXgTkL3923CipJptRbBvQFf7uqu3v/yvfzc5ZHeSiSzflAbRAQ6zdq2UwcL3xS7mVYcbLGK+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376988; c=relaxed/simple;
	bh=QJgGQfU0m8+74hKWTGhWk4d30YwlNS1/Mh4tlwkbBxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYsXSOxrqu2hY+lA2wGrd8fcCGpmH1FMn9iAwyXpKwXnNWo6ggqc6oSx7fZaLdqBi0LxzxRQ4y4UysxIvX/yF/zlOsdnWTFIH1enJlDhyt+XoDAUu/Vo+xcggpQnoHiCDqyas6//GkXVUcGkCardJlCMwzu2ZaJZn2JGywKGZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=EuPUdTFY; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VYQU0d5o; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EuPUdTFY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VYQU0d5o"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hjzqp57f4zKmwd;
	Mon, 14 Sep 2026 11:09:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789376982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MHeW1CPKnaVftcIvrFx2pYex06w5p9ZRk+t3E962Owk=;
	b=EuPUdTFYedeOhhLAtPjFL+sdg6UWnxKIhVjx8z/UMXjcKiWSswTCVu3ST+x+fBYkDa2i/M
	CUHSDpYXJ6Oic7sSFfP5ISQE4ApPs//q3Sxabk/cpuKRAm7s9ESFwlsBMtRg9mNKcvtqol
	FDB+T28/GkUB2A19eyOyDPFwscPYNkWQQgRNt5fE8qjjG7Rb86ADCYn5p+197VQ59Iwz9S
	D46ogYFT4D8z/QpoWQUk5gVfHoi/UvIX+rkJt0pfb4SttrULlXu/BqCpXgEyGca/2k2iTx
	VLl5NbF1ubAcsv8r13DWcnaPbfLfnY6x6GyB8Nja06sx4fDEKgNgv/ywQbEmOQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=VYQU0d5o;
	spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=manuelebnerli@mailbox.org
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789376981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MHeW1CPKnaVftcIvrFx2pYex06w5p9ZRk+t3E962Owk=;
	b=VYQU0d5obr2NLWOaeJ7auVMl49K6W9fJEIhD31PqQDmDAx73IJowN0+VY1qt1bXgKiWlHo
	EE0pEBNXpmJF8BqF9s342OWImZc9PowGg6voyEror3RCENtAkyxjI+ZxprDVH77HgZH+Bw
	1W80zqIyrmwZ++KvS0fAzdE0nZZD97eMCnM0fv7sDBErNixOXGBq7bH9JasE+XP7a8U29Z
	5HMkc5nKJUT6AccK6lq9yEM9wtsHayYfT5EpYbRXaPsRNNIEdIi39SYIIX5Uf4d9azjHHj
	FnIu5KOExuufia4AttASzDCepv7Uf90t6W2tlGszd1SEIXV5nLazuk7rNNqWwA==
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: replace number with sizeof()
Date: Mon, 14 Sep 2026 11:08:58 +0200
Message-ID: <20260914090858.9939-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cw4btzrgu7sahhkxa6erqcjkpep5yxpt
X-MBO-RS-ID: 00adecfe0b933e12e23
X-Rspamd-Queue-Id: 4hjzqp57f4zKmwd

Replace integer number with sizeof with the goal of prevent future truncation bugs.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 drivers/staging/fbtft/fb_ili9320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
index 0f98267a7..655778392 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -21,7 +21,7 @@
 
 static unsigned int read_devicecode(struct fbtft_par *par)
 {
-	u8 rxbuf[8] = {0, };
+	u8 rxbuf[sizeof(u64)] = {0, };
 
 	write_reg(par, 0x0000);
 	par->fbtftops.read(par, rxbuf, 4);
-- 
2.55.0

