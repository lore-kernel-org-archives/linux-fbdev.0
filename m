Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F972D611;
	Thu, 22 Aug 2024 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307504; cv=none; b=evhysQhP0LEWVfAjhto3CzaxU8rVGUz0hVJQ79gEH4cqt/ke/Q+amyQOrRdPIB3corewMzvkPKXTCNcXz6MTQV4A2gJc+yqaJL7F3QoNvgfp0kcpMLUR4NVrbcRcaTEFPrnohqNXmupekh8DkHvAtz26C2/wzJ4aNkr7RSXmhlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307504; c=relaxed/simple;
	bh=/gP3X3boBmbMa/JR0/Zr3SS25RX0qvmCFT/L1yWkKsw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Os7M304/51dhhpkmNtXWJ8dBLR3YMdStWZsUhG3H+WPzBBYkjG9V2Fc6m8HFwdDgVMtbT07+NDD+NbtPZ3KiPtwAeZqrUvv4cxW9gLe1Z9r7T9Kz+oa0UggQJ4M+YL+PCIsBKUjFrNlwYeyJrb1xWX9aNK8z/0z2hENSKwtf/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WqCdF20nTzhY5v;
	Thu, 22 Aug 2024 14:16:17 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A825140360;
	Thu, 22 Aug 2024 14:18:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Aug
 2024 14:18:17 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lee@kernel.org>, <daniel.thompson@linaro.org>, <jingoohan1@gmail.com>,
	<deller@gmx.de>, <dri-devel@lists.freedesktop.org>,
	<linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] backlight: 88pm860x_bl: Simplify with scoped for each OF child loop
Date: Thu, 22 Aug 2024 14:25:46 +0800
Message-ID: <20240822062546.3490076-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/video/backlight/88pm860x_bl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/88pm860x_bl.c b/drivers/video/backlight/88pm860x_bl.c
index 25e409bbb1a2..720b5ada7fe8 100644
--- a/drivers/video/backlight/88pm860x_bl.c
+++ b/drivers/video/backlight/88pm860x_bl.c
@@ -151,7 +151,7 @@ static int pm860x_backlight_dt_init(struct platform_device *pdev,
 				    struct pm860x_backlight_data *data,
 				    char *name)
 {
-	struct device_node *nproot, *np;
+	struct device_node *nproot;
 	int iset = 0;
 
 	nproot = of_get_child_by_name(pdev->dev.parent->of_node, "backlights");
@@ -159,14 +159,13 @@ static int pm860x_backlight_dt_init(struct platform_device *pdev,
 		dev_err(&pdev->dev, "failed to find backlights node\n");
 		return -ENODEV;
 	}
-	for_each_child_of_node(nproot, np) {
+	for_each_child_of_node_scoped(nproot, np) {
 		if (of_node_name_eq(np, name)) {
 			of_property_read_u32(np, "marvell,88pm860x-iset",
 					     &iset);
 			data->iset = PM8606_WLED_CURRENT(iset);
 			of_property_read_u32(np, "marvell,88pm860x-pwm",
 					     &data->pwm);
-			of_node_put(np);
 			break;
 		}
 	}
-- 
2.34.1

