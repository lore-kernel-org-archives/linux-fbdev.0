Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26751200CB;
	Wed, 12 Mar 2025 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794349; cv=none; b=CvCovzRqIGykAmPcrbNmBp8szKlhR/YjDg/DFy060bR8D/TWlMEbflSdGRqs6KjJFR2TaFM9goXR2fJR6PuyzuVUomtpiDv8Ea248atv+jqwJocfhD0AzCt/pJdUB9BBzwQ3jFeEdjCnJyxCmb+gfbSZOP1iOGqIiOteHSbQM/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794349; c=relaxed/simple;
	bh=M/2kCmaZjgEX2aaefPZZ5jhTDkgfMc/YVLGbKFBPDPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dohzf6P2D7Jz1bmXvGukZ7CnqcVMx+dtsgWRz/5P3BeN6h0Q/GnNOa4chFWXBbkinlLkiKefxgVmHtnT9ceZKn9XmjmEDlUu9i7BHOW0S/E0zqG/oilVUDtzagwcNum445tv4CRSycxozA7I8EBC8cQ1pZkWkfpTy+z8MlVWh+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FTHvKwhR; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FTHvKwhR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Y9ZrF
	wpLjdeYrcCA7O95QsfXGi1MudxIC3XCcfV5JMg=; b=FTHvKwhRfNyhHzozYGZ1G
	5OTceGWbpDAtejyEGyo+ro8Ae7LgPgb3Vnt4RI3V/gWhoC/1iwYFloe3Mvw7Aziy
	/VCsKSC2QJWvrwWYGj4xi0H0Owe/RswvQJGzYaSvAqhDXFl8SolAFPHH0gxtpEdT
	5ZvGcFj7oemcXaMgfsQmX8=
Received: from DESKTOP-DMSSUQ5.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBnGxwErNFnmqUoAw--.31028S3;
	Wed, 12 Mar 2025 23:45:12 +0800 (CST)
From: Shixiong Ou <oushixiong1025@163.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH v2 2/2] fbcon: Change return value type to void
Date: Wed, 12 Mar 2025 23:45:07 +0800
Message-ID: <20250312154507.10881-2-oushixiong1025@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312154507.10881-1-oushixiong1025@163.com>
References: <20250312154507.10881-1-oushixiong1025@163.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBnGxwErNFnmqUoAw--.31028S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWDurykCw4kAFyDAFyfXrb_yoWftrc_Cr
	1DZr95XrykKry0krn0gF13urWFva12qa1rGr1Dtr93Ja47tr90qr4UZr1qqrWqgF18Ar4v
	q3Wqqr4Ivw1rCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0byCJUUUUU==
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXRYOD2fRnpHSAQAAsg

From: Shixiong Ou <oushixiong@kylinos.cn>

fbcon_init_device() doesn't need to return a value.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/core/fbcon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9ee5f8492249..619645ff4f21 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3294,7 +3294,7 @@ static const struct attribute_group fbcon_device_attr_group = {
 	.attrs		= fbcon_device_attrs,
 };
 
-static int fbcon_init_device(void)
+static void fbcon_init_device(void)
 {
 	int ret;
 
@@ -3303,8 +3303,6 @@ static int fbcon_init_device(void)
 	ret = device_add_group(fbcon_device, &fbcon_device_attr_group);
 	if (ret)
 		fbcon_has_sysfs = 0;
-
-	return 0;
 }
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
-- 
2.43.0

