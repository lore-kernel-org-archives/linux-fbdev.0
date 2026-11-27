Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795760176;
	b=TjZUKdvdUH3VS8acGoMLx21t5tKet88nJoVpujCITF3lpV8i90ODTOfAISjQO9cH/m+o
	 OjUuwUPqs768mmqKH1RrC4Z/xhzNr0AFec+VJ2ZsKvlGWTZDABkAmCHMpNmbmJ+XClnxV
	 b1RKN+BNGrzeborao5rTF0wDvJ/r3gPRXkmqj198mZuNGKgOJWerZvS4qWO8IBRHavfvx
	 97gRNYA9IU57ajnHuN5FzCcJpw11ujQ2/rXKhpObeE3YlcwtJWeVwW6cS8nWNhCVA6xBX
	 UnTZ6lQfOEtatPKPzYJJkW3REQhvb5tT3fiqRKKf2zcTGr38DIqlCeZpWKV/VknB2Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760176;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=gQXNbkQwAa7GjvSJmbGidTm7gfji+hVb6jO+DrLVuPs=;
	b=pQoXjXN++mTqAsKVNoED+z8w8gUXIV4LdJhnSVCdYH14yVm5djmgxVtNQ6i5mte8+cHs
	 I8kpCe2WAjia1qYuAcENCUwcok5ZAWixbCOb5+9ulxbmMPcxV1NRU4lfqkTe4rgmJJJ6K
	 JpWyOvG8LeLv3fGEsTj4K5fvdXnUvi906Q3jigP6mOb+MoXS4vHqRyr5lKqBXkFgbt4W/
	 qnzGov+Z2USdzqzx9ctzOM9KtuH15xKcPKEg1DR4PSR5UsQ3VAh/6qfA2vkUUSH6Ykxe7
	 mOjwx34Wha4iIvg8SjgR3q/u5RAWFKSiGG1HNwW0fm1dr5OM2pq8FtuoE/fVRIPE0Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lQ2GUzQY;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF37B606A31C
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2026 06:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF37B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lQ2GUzQY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gQ
	XNbkQwAa7GjvSJmbGidTm7gfji+hVb6jO+DrLVuPs=; b=lQ2GUzQYRkEG7j4day
	cGKQ84LSs998FiD4xd+aYtZlMvPQbdylHu6dsRtPtVLgOKiF2gSdPE9R9hk0gesJ
	4Yx7Ua47hdJL9Gdc/hpffjO96V2PbM/dOGS1vX0mirMFlPxIDt6+Qa0cBNBWJr9p
	rkd9VaYkm5oxSpK7FMnQT+fcU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3_xUBIAlrQbxTKg--.62791S2;
	Fri, 27 Nov 2026 14:15:31 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: deller@gmx.de,
	david.laight.linux@gmail.com,
	akpm@linux-foundation.org,
	haojian.zhuang@gmail.com,
	zzhu3@marvell.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] video: mmpfb: destroy modelist on probe error handling path
Date: Fri, 27 Nov 2026 14:14:58 +0800
Message-Id: <20261127061458.387484-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wD3_xUBIAlrQbxTKg--.62791S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrykCw17CFW3tr45Gr1rZwb_yoW8GFW8pF
	ZxJFW5KrWYq34UKF48G3WUXFy0ka4rJrW7GrW29rZ5u3W5trWDWFZ3XFyj9a93CFWDJ3Z0
	qF9rtry8Xa47uF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pNeHDUUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7gMlk2sJIAMIOwAA3p

In modes_setup(), fb_videomode_to_modelist() allocates memory
for modelist. These memory should be freed if something fails in
modes_setup() after modes_setup() succeeds. Add a goto label and
call fb_destroy_modelist to do so.

Fixes: d2e8bae6d72f ("video: mmp fb support")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/video/fbdev/mmp/fb/mmpfb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mmp/fb/mmpfb.c b/drivers/video/fbdev/mmp/fb/mmpfb.c
index fc09d3ec3487..514b4b9c95e3 100644
--- a/drivers/video/fbdev/mmp/fb/mmpfb.c
+++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
@@ -605,7 +605,7 @@ static int mmpfb_probe(struct platform_device *pdev)
 	if (fbi->fb_start == NULL) {
 		dev_err(&pdev->dev, "can't alloc framebuffer\n");
 		ret = -ENOMEM;
-		goto failed_destroy_mutex;
+		goto failed_destroy_modelist;
 	}
 	dev_info(fbi->dev, "fb %dk allocated\n", fbi->fb_size/1024);
 
@@ -634,6 +634,8 @@ static int mmpfb_probe(struct platform_device *pdev)
 failed_free_buff:
 	dma_free_coherent(&pdev->dev, PAGE_ALIGN(fbi->fb_size), fbi->fb_start,
 		fbi->fb_start_dma);
+failed_destroy_modelist:
+	fb_destroy_modelist(&info->modelist);
 failed_destroy_mutex:
 	mutex_destroy(&fbi->access_ok);
 	dev_err(fbi->dev, "mmp-fb: frame buffer device init failed\n");
-- 
2.25.1

