Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0AB13A89C;
	Fri,  5 Jul 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168748; cv=none; b=Av+Jd+tTA7q8hOkhGrA8VLrgp+CN6cOMDdw2fPXPi7hJDP3+P1/4q3rq94sYCNioxnFEMfzXdHI5rgWzqf/jHSJmhrICN9Ikg/YtmXTYA+0aUampCN4V2s3sUvTIIT34bDGoqblM2uwsBj95nvQZvXsPtKizP0kiDQhqTypJOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168748; c=relaxed/simple;
	bh=5fvsKBlfEtsQZGxnWPk3P4v8CcjcRH+tIFtsRrT5g34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lb4UAv7r1HcAn6xeag91MSJgoYDzdc/H6f3Hqhcp8mwJsN98M59kB2otZl4RujRYx4MpPTuYG7aaZQnpQuvhJ0z5XQfwpiL6ZFrPCjUoYRYRmkXfqpYUjHEwIYN5ZLd3XpIheCjmmQhWWnLgTMs5UbjaErobnDYLDOcnuFduiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAA3PeUesYdm612lAQ--.42588S2;
	Fri, 05 Jul 2024 16:38:54 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] backlight: l4f00242t03: Add check for spi_setup
Date: Fri,  5 Jul 2024 16:38:34 +0800
Message-Id: <20240705083834.3006465-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3PeUesYdm612lAQ--.42588S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4xAr4xAr47ZFyUWr1xKrg_yoWDGFXE9w
	n2v3yxurWjgr409r47J3WfAayS9F45WFWrWF4v934SyasxXrn3ZrWjqrnrWFyUZr18JF9x
	C3ZFkryfZry7JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb2kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43MxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjAhL5UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of spi_setup() and return the error
if it fails in order to catch the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/video/backlight/l4f00242t03.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
index dd0874f8c7ff..a4e27adee8ac 100644
--- a/drivers/video/backlight/l4f00242t03.c
+++ b/drivers/video/backlight/l4f00242t03.c
@@ -166,6 +166,7 @@ static const struct lcd_ops l4f_ops = {
 static int l4f00242t03_probe(struct spi_device *spi)
 {
 	struct l4f00242t03_priv *priv;
+	int ret;
 
 	priv = devm_kzalloc(&spi->dev, sizeof(struct l4f00242t03_priv),
 				GFP_KERNEL);
@@ -174,7 +175,9 @@ static int l4f00242t03_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, priv);
 	spi->bits_per_word = 9;
-	spi_setup(spi);
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
 
 	priv->spi = spi;
 
-- 
2.25.1

