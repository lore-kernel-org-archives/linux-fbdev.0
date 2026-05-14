Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9A3DE434;
	Thu, 14 May 2026 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778749017; cv=none; b=g7JD87HafBKUndpmY47ky7ABYTxBgZPV68JSdTRRjzd7mpNKjEyr1LbfctC59/sT3VR8aPlu7c7e2+JTltbrW20JZUcZi7b1M4hLxvEcw9kwzcaSGeaBr/saImVGFiMlUzEuqQcd/CfQ65VHIPSGgfw///UVJgu9jcffiiEW1QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778749017; c=relaxed/simple;
	bh=4ckolnik1QU/BiDznbYuVH0yfh0dnAnH4Tldd7Bq9z8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uWHPx27K+PPblby7LVWg4CPCe4wYf3h4T65uuPd2gXGUv5cEGbKdDWgABBG3Xv+zMEx9eehj9aOyENKM8A6TcFhXo1QRVqI8OYS3P55pzUOllyDcynMW5BOyH99h7hQ7evVzv2XqKyO2Cfi7O8/v526PYC5Pir5+w3QmBVieY4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mFb+5fkT; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mFb+5fkT"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JanbdM56CkwBqJ6g/H1kv8/ziSFNkUIn/j0QG690EJs=;
	b=mFb+5fkT7AH65DQImojKQzSLQDBYrAYFC6/4xWScuPyOQvxrl5MxTR/TDlA93aVW8VwB6POD4
	KHqIxWN/P6cuwNCLryxNK4H3P1pNWMDetoLjOhFrmuDPwD8nCXBsnEtp5pZexjHkJtZE6LHdLRn
	4pqMvPJ/P3/xi7ywv35Tei0=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gGPBy2MWlz1K98N;
	Thu, 14 May 2026 16:49:14 +0800 (CST)
Received: from kwepemk100016.china.huawei.com (unknown [7.202.194.64])
	by mail.maildlp.com (Postfix) with ESMTPS id A345F40563;
	Thu, 14 May 2026 16:56:50 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemk100016.china.huawei.com (7.202.194.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 14 May 2026 16:56:50 +0800
From: Jiacheng Yu <yujiacheng3@huawei.com>
To: <deller@gmx.de>, <tzimmermann@suse.de>, <simona@ffwll.ch>
CC: <sravankumarlpu@gmail.com>, <dri-devel@lists.freedesktop.org>,
	<linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>
Subject: [PATCH] fbcon: Use correct type for vc_resize() return value
Date: Thu, 14 May 2026 17:19:18 +0800
Message-ID: <20260514091918.1607234-1-yujiacheng3@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100016.china.huawei.com (7.202.194.64)

The return value of vc_resize() is int, but fbcon_set_disp() stores it
in an unsigned long variable. While the !ret check happens to work
correctly by coincidence (negative values become large positive values),
the types should match. Use int instead.

Eliminates the following W=3 warning:

  drivers/video/fbdev/core/fbcon.c: In function 'fbcon_set_disp':
  drivers/video/fbdev/core/fbcon.c:1494:14: warning: implicit conversion from 'int' to 'unsigned long' [-Wconversion]

Fixes: af0db3c1f898 ("fbdev: Fix vmalloc out-of-bounds write in fast_imageblit")
Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>
---
 drivers/video/fbdev/core/fbcon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index b0e3e765360d..641687a734d5 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1440,8 +1440,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	struct vc_data **default_mode, *vc;
 	struct vc_data *svc;
 	struct fbcon_par *par = info->fbcon_par;
-	int rows, cols;
-	unsigned long ret = 0;
+	int rows, cols, ret;
 
 	p = &fb_display[unit];
 
-- 
2.34.1

