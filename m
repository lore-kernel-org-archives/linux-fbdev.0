Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C3F23C8D4;
	Sat,  8 Feb 2025 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010265; cv=none; b=StE3amoNdbXmvLrU2VnqPuZvx7eDPcxvEf40p0SmGk0EiN6ItPd/SeIUsy+alg7N6oXDcQcpTrIk6LqTZXhi5c+ae5x0QsijjDp0uwTd96MiRUS+kR8H9RDIy46fpK75nd6ElQPns/u40lr5KsTn+YjU1ZBzJZKuu2Xc2JXYTQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010265; c=relaxed/simple;
	bh=VGRG8R7N/hrZKx/aSr+NKCfcjmclVvhtZ352HaXqP/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FWjhrCck52lsyBLOXnP6MEK0Ma5lyUXsmIUz5HYeAlCtRJnexREi/V5k9rVtob4sMhR6iwarCFIGbH7SiJhhzioDk/YYYFrHvePGA+AsHRckz2yepjwODL4Sye/oRPzZIdZd3tYAcOc3mPk7haaVxOKLL2SAq86uOPkfHDkyu7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZoMhS++v; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZoMhS++v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FJHFR
	zNnEifHYNKmIB7Y5o2gTuLBBAspQuUOtDbOveo=; b=ZoMhS++vRlud5Xteoz1Jr
	E6b/AdX87wumrtvySKDrXZX6lBwR9cgiKFsOAcKFn+nhZfURWx7KSLp+fUgoobZn
	w9eOGbgBopWt1YWDyK+THd7upBIYiIlbTNsLsrOxCA9XZ0tSMH1lTV3Uvq9maSV6
	kjs4Fkj7YH+fHjs5QxACFQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3tQ_EMKdnfA5VBw--.59282S2;
	Sat, 08 Feb 2025 18:24:06 +0800 (CST)
From: oushixiong1025@163.com
To: Timur Tabi <timur@kernel.org>
Cc: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] fbdev: fsl-diu-fb: add missing device_remove_file()
Date: Sat,  8 Feb 2025 18:23:59 +0800
Message-Id: <20250208102359.279333-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgB3tQ_EMKdnfA5VBw--.59282S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWDGFWxWw47GrWkCFWruFg_yoWDGFc_uF
	15ZrWvgr1UGr1vgr1kKF4SyryrKF1qgay3XFs2gFyrt3s7u3yYg3yUZr4jgrZrWw4IkF90
	yw1DWrZxZF1rCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1nqXJUUUUU==
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXQTtD2enL0MPhwAAsf

From: Shixiong Ou <oushixiong@kylinos.cn>

Call device_remove_file() when driver remove.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/fsl-diu-fb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index 5ac8201c3533..8c91af9a9156 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1807,6 +1807,7 @@ static int fsl_diu_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "could not create sysfs file %s\n",
 			data->dev_attr.attr.name);
+		goto error;
 	}
 
 	dev_set_drvdata(&pdev->dev, data);
@@ -1827,6 +1828,9 @@ static void fsl_diu_remove(struct platform_device *pdev)
 	int i;
 
 	data = dev_get_drvdata(&pdev->dev);
+
+	device_remove_file(&pdev->dev, &data->dev_attr);
+
 	disable_lcdc(&data->fsl_diu_info[0]);
 
 	free_irq(data->irq, data->diu_reg);
-- 
2.17.1

