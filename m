Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1932A18F2F9;
	Tue, 20 Aug 2024 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156676; cv=none; b=YfxjPXCFM/um1qOTkpqSYR2/oFLNSu+byeTVzC2bD6ds4ArvF+rbEsfaWW+e/tjyYl3aLSzHz9Bvs6gNZZjCumPA3L+VEzAe8M7GHGKbYl65iVWNMDVfoOIeWGmBCCouYP+9LfZ1XzI9Udbli4tX5vXiCaF3sgCnlB8S4LmHZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156676; c=relaxed/simple;
	bh=/gl7sUOyLfOV6tT0Fv5q8hQg44Sbm+6uyWEkL5X266Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z7m5+Kw+PLpo0b01lcP0WUiBt7xvTB4cvBVEnt6egEkVYn30aH/uD9XZce01E4aAROP2NZwFAjqnnKUl/bkY8CPB2LbSseJJPxWRgy/8UmxcnvTmi+vKp/W06OUitR8WbRptb8eu43n1jOpfn3HIiaNEit+LpE8TN6kaylXJ+BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wp7nc1KrmzQqDM;
	Tue, 20 Aug 2024 20:19:48 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 423F2140133;
	Tue, 20 Aug 2024 20:24:29 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 Aug
 2024 20:24:29 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <lujianhua000@gmail.com>,
	<lee@kernel.org>, <daniel.thompson@linaro.org>, <jingoohan1@gmail.com>,
	<deller@gmx.de>
Subject: [PATCH -next] backlight: ktz8866: fix module autoloading
Date: Tue, 20 Aug 2024 12:16:28 +0000
Message-ID: <20240820121628.42321-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/video/backlight/ktz8866.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/ktz8866.c b/drivers/video/backlight/ktz8866.c
index 2e508741c0af..351c2b4d63ed 100644
--- a/drivers/video/backlight/ktz8866.c
+++ b/drivers/video/backlight/ktz8866.c
@@ -190,6 +190,7 @@ static const struct of_device_id ktz8866_match_table[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, ktz8866_match_table);
 
 static struct i2c_driver ktz8866_driver = {
 	.driver = {
-- 
2.34.1

