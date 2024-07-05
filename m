Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860D146A8E;
	Fri,  5 Jul 2024 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172413; cv=none; b=W4OiH1Rmn5LJ8aIHXLgojf5JT4zu+oqwcXn/DIuN4nQ5ZYSYwrv4rPmigion+6yGKTYVEbEwyD4PR0ebWo1UnZKBMJhQJs+yEqfNi4km1xtrHqDE2CyFdEvDRRdoUFcHEMHkj69SoRwJ5HMWsB/i51Z9QW0dyQF66IiTO+kmOx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172413; c=relaxed/simple;
	bh=X/rJElrjxX53DIdXJSciIy4hopd2eYYkhKvDK+vBV9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nyULGdi0Kv6KQYgJrdznrB7lfHkT0KXFr7LbeeeatZBk8cNRYeteSvyAK6mDAcH9wcRSsCSmf/BIMVpujxKYsaH4J6B30BxXEQLR3zFthWeESddECFRTA/kw5Qg+G+2htvWitZcr3clPSUT4Jxey1xS1d4kPvTDELNUQSqqiPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABXXkZpv4dmjEEkFA--.59861S2;
	Fri, 05 Jul 2024 17:39:54 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH v2] backlight: l4f00242t03: Add check for spi_setup
Date: Fri,  5 Jul 2024 17:28:00 +0800
Message-Id: <20240705092800.3221159-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXXkZpv4dmjEEkFA--.59861S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4xAr4xAr18JFWUuFyUKFg_yoWkXFgE9w
	n2v3yxu3yjgr409w47JF1fJayS9F45uFWrWF4v9a4SyasxXrn3urW0qrnrGFyUZr18JF9x
	CwnFkrWfZry7JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbc8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFWl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8KZXUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of spi_setup() and return the error
if it fails in order to catch the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
Changelog:

v1 -> v2:

1. Use dev_err_probe() to match other error paths
---
 drivers/video/backlight/l4f00242t03.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
index dd0874f8c7ff..4175a4603071 100644
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
+		return dev_err_probe(&spi->dev, ret, "Unable to setup spi.\n");
 
 	priv->spi = spi;
 
-- 
2.25.1

