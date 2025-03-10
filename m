Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADBA2C9A;
	Mon, 10 Mar 2025 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572614; cv=none; b=uyLlbe0DbArfizgwQq9v/TTZN8kylbRXXSl9BaVjs7PMq8X1SZWUUV9SZzJeeM1AEyzS64p+UbIZBwtU3tHKn0ZgV+5U4E/Or8v8FmHhb8i9D0ps8wGgFUk7cIRgRAX86fcPQ6rGzmS/ELHysQYvTkzKBLX20AIWMTEj9oOI5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572614; c=relaxed/simple;
	bh=ieVV6CJ/Ra+TEPn8aN2lUekyNG8zVTbU8qGoJ6x1JCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IUETlgLfxTiIMQg42IX5NdJvD2Jb3CoX/JFlKxiUkJLcm54vxvUSerwHCTGPNJUrJm1Lnhi8e4JcJtOm5FPTB12kq0GZPSHAhg1iRORru+O6ACl9LUksblXclQV84YCOGZuQME5d4SoPioY7CkpzZHnwK8JE5i8d7/GqpbAIVQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oG5lFVfo; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oG5lFVfo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WQbkt
	5MbX6FWnP6mNnh/2Ztp8PMd5g3lbLTTqSinn6c=; b=oG5lFVfoOiSoCuZhwK6aL
	5Ohoqeol/tXcQ2ETIOgUYVjLKQ2JQ0oV4IL7oTfqG/tiMznTz3qIx9QMsdtVKXsj
	M0b0kkLNgY+Z/UGLbcfSNIGATX7U79OHYRNZykoK5W5/O/vX9vwuMejUEOjbx4kt
	Ate2Qr2P9lqD3iGbT1yuhk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDXTzNYRs5nFOjSRg--.17921S2;
	Mon, 10 Mar 2025 09:54:34 +0800 (CST)
From: oushixiong1025@163.com
To: Timur Tabi <timur@kernel.org>
Cc: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH v3] fbdev: fsl-diu-fb: add missing device_remove_file()
Date: Mon, 10 Mar 2025 09:54:31 +0800
Message-Id: <20250310015431.43387-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXTzNYRs5nFOjSRg--.17921S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWDGFWxWw18ArWkGw43GFg_yoW3Zwc_uF
	15Z395Xr4UGr1kKw1IgFsIyryUKF1qgay3XFs2gr95J3s7uw4Yq3yjvr42grWDWw4IkF9x
	tw1qgr4jvF1rCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1nXo3UUUUU==
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXAQMD2fOO+-mFwAAsX

From: Shixiong Ou <oushixiong@kylinos.cn>

Call device_remove_file() when driver remove.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
v1->v2:
	add has_dev_attrs flag.
v2->v3:
	drop those extra checks.

 drivers/video/fbdev/fsl-diu-fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index 5ac8201c3533..b71d15794ce8 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1827,6 +1827,7 @@ static void fsl_diu_remove(struct platform_device *pdev)
 	int i;
 
 	data = dev_get_drvdata(&pdev->dev);
+	device_remove_file(&pdev->dev, &data->dev_attr);
 	disable_lcdc(&data->fsl_diu_info[0]);
 
 	free_irq(data->irq, data->diu_reg);
-- 
2.25.1

