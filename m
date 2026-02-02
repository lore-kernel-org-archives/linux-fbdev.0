Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7287296BBC;
	Mon,  2 Feb 2026 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018954; cv=none; b=n1su/gzJDrh3neYiRYIFX++zLLa5YPzfjA3XYgkJEhYoNPaz1X81muytpHCX5jPsKZacrO7/URLGPCNZhMFzc3I911joXEGKDiFNNV74E5w8DY/A5qLySau46XR3WnhjzTbR0z4Ck053u+vyMIN8X0OB2X0ogJT9JrQJigwM3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018954; c=relaxed/simple;
	bh=EFBy9xCWMUNJeDcgUBZJ1oyld1cI3bDI/ERL2y0TraY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PDioD/Ed1IutouiwyKmtz2r9jp4/tK0z/hctOvufmQ0kZguTKV1oZxZCcXu2ATi02bvbIlSBcYe0FChLwRfRL1lyfV/WpV5kalzWyYtZBGlO9k5deYHGQtJnCzOm0zN5FZFmK8ccy0M+ahFWPONZf0OXwu3kjBVYsXPCqCnjR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowABnD2t6WIBpLa_6Bg--.7048S2;
	Mon, 02 Feb 2026 15:55:39 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	linusw@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] backlight: sky81452-backlight: Check return value of devm_gpiod_get_optional() in sky81452_bl_parse_dt()
Date: Mon,  2 Feb 2026 15:54:10 +0800
Message-Id: <20260202075410.155375-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnD2t6WIBpLa_6Bg--.7048S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF48Zr17JFyxZrWkWr18Grg_yoW8GFWxpa
	4qv34Ykr92v3y8W340yr1xuF1Sga13JFW7KF97Ga4a93Z0yrs8Zry3Kay0vFW7uF1xWw1Y
	vF4UZF43GFWkuaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUfrcfUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

The devm_gpiod_get_optional() function may return an ERR_PTR in case of
genuine GPIO acquisition errors, not just NULL which indicates the
legitimate absence of an optional GPIO.

Add an IS_ERR() check after the call in sky81452_bl_parse_dt(). On
error, return the error code to ensure proper failure handling rather
than proceeding with invalid pointers.

Fixes: e1915eec54a6 ("backlight: sky81452: Convert to GPIO descriptors")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/video/backlight/sky81452-backlight.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
index 2749231f0385..e3e5306fab84 100644
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -202,6 +202,10 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 	pdata->dpwm_mode = of_property_read_bool(np, "skyworks,dpwm-mode");
 	pdata->phase_shift = of_property_read_bool(np, "skyworks,phase-shift");
 	pdata->gpiod_enable = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);
+	if (IS_ERR(pdata->gpiod_enable)) {
+		dev_err(dev, "failed to get gpio\n");
+		return ERR_CAST(pdata->gpiod_enable);
+	}
 
 	ret = of_property_count_u32_elems(np, "led-sources");
 	if (ret < 0) {
-- 
2.25.1

