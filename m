Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27071392;
	Sun,  9 Mar 2025 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741508194; cv=none; b=Vp3hhTeOC1P7gx/kuUDO/30/TsRMQ9fppnChA5hViRJCcp1i5zdmb+OCFhq4+N7y31NhlAx30PCkS1fl6+zvyLgoiKoCzhrYX5uS7wkeEnxd7mxBSWGaX7UJPacw859LMqK9wFpeLY14ofLG6I6yXMMXuUp2WW0e0/1jprT7M0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741508194; c=relaxed/simple;
	bh=8RrAX5zsyl2v8FK4aVmcG4yXL+EivR7DK0ueJdHYnHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NwZBzip6s1uTtluZ28Pew1cJEae7xd6yF799Rq6uxhENh5TmhGmA/0mWxE2ygt3mP62NJm0rxoH3caz1oGQ8bRNNOWlviEIeNjZi6kn9XJZIvYs+Wb3uvh9U5sfoV8owqXlLt/BhrF4pJ9khdg/F+S/8KmX3tU4lVLufZ+8G+7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lCl0Jg9h; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lCl0Jg9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=FeXfy
	9DrSiD94bOaNEUCI5BYPJ0acvCrnQJISy1Gcq4=; b=lCl0Jg9hrmXh76RBaqg4D
	UKHfyG+h5HgcVkZIesTPeGzzQxzTfhAxVQ8UhzjkgRYWJr6ZnKQPfMMQl1KzuzYg
	XxfUXEtWNiuNRnvpGtTRMu1vieckxIxSdGOyqIX1MNApxObRoYHygGkGRTAp8Ja7
	GGdj1hIbpUNF2YJltREvKU=
Received: from DESKTOP-DMSSUQ5.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBXBydJTs1n+NhnRQ--.8762S2;
	Sun, 09 Mar 2025 16:16:09 +0800 (CST)
From: Shixiong Ou <oushixiong1025@163.com>
To: Timur Tabi <timur@kernel.org>
Cc: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH v2] fbdev: fsl-diu-fb: add missing device_remove_file()
Date: Sun,  9 Mar 2025 16:16:07 +0800
Message-ID: <20250309081607.27784-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXBydJTs1n+NhnRQ--.8762S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy8Gr1rCr4Dtw4fKryxGrg_yoW8JF4DpF
	W7XFZ5KrZ8Jw1UKw1DGrWxu3WrXw4xA3s3ArW2k34a9wn09Fy8Xa4kJFy8AayFyrWkC3Wa
	qwnrtrWFvF9rWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMUDAUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXRELD2fM8CDgGwABsJ

From: Shixiong Ou <oushixiong@kylinos.cn>

Call device_remove_file() when driver remove.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
v1->v2:
	add has_sysfs_attrs flag.

 drivers/video/fbdev/fsl-diu-fb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index 5ac8201c3533..57f7fe6a4c76 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -384,6 +384,7 @@ struct fsl_diu_data {
 	__le16 next_cursor[MAX_CURS * MAX_CURS] __aligned(32);
 	uint8_t edid_data[EDID_LENGTH];
 	bool has_edid;
+	bool has_dev_attr;
 } __aligned(32);
 
 /* Determine the DMA address of a member of the fsl_diu_data structure */
@@ -1809,6 +1810,7 @@ static int fsl_diu_probe(struct platform_device *pdev)
 			data->dev_attr.attr.name);
 	}
 
+	data->has_dev_attr = true;
 	dev_set_drvdata(&pdev->dev, data);
 	return 0;
 
@@ -1827,6 +1829,10 @@ static void fsl_diu_remove(struct platform_device *pdev)
 	int i;
 
 	data = dev_get_drvdata(&pdev->dev);
+
+	if (data->has_dev_attr)
+		device_remove_file(&pdev->dev, &data->dev_attr);
+
 	disable_lcdc(&data->fsl_diu_info[0]);
 
 	free_irq(data->irq, data->diu_reg);
-- 
2.43.0

