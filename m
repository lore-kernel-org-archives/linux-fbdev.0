Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F129813DB83
	for <linux-fbdev@vger.kernel.org>; Mon, 24 Jun 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235759; cv=none; b=Buxlpxcweq/5cZZefEFkj2b8qJcb/OgtAPB6eNoJLsJ3bMrMyCJiaU40ekUHSxOzXjwT8NMbpyntRkGaAiAdGUvZ4L0ALu2x5I90Hi6KQBGnB33nGIm4srlI5YRTsLVAD7tsi7weuaq8gFuXVvwV9q0hM3D7+sj0djT/y3H2wJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235759; c=relaxed/simple;
	bh=8eQ3vjWbIPNKuR00ZsA+8U+jf29/BI77yt+GVwyLS6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oRox4JX3gFGo2dWtUCdh9hbBECIaq4hWCHWYCz6WsfVPv3PU0XS6fXQ/LxnfPiA9bYZv8evY+2Nr2YUFaLgfVUO0/JWy6p4LosfGXK2IrEBji5IXarqtnjkB6dCvQGzTMnR7IVLFINUqSm4aKZOVuPxr+O0y6N0E8Y+oepb3yv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvSHYiCf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvSHYiCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E997C2BBFC;
	Mon, 24 Jun 2024 13:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719235758;
	bh=8eQ3vjWbIPNKuR00ZsA+8U+jf29/BI77yt+GVwyLS6U=;
	h=From:To:Cc:Subject:Date:From;
	b=nvSHYiCfHEXLj4nyHmXwZT3bnft5CSmbgDuQWyL5boDFTHbKKg/JCwxGIiU8gCBO8
	 uRSFZWnb204PWvsiGogWeqhfDA9gYjldF0/Gu8TsqlTn0SdXXz/0UghDH4BFiw28RI
	 ZuwDJFm9fvwwumPt96Zzd4SoKh4ZHPoWjXB8e2DGTVIvV0JoQvd5qd61GWIePwcS1g
	 x/s53S0KMZ7QIw6ZyDDqLWTA6IYE0LGPtoqqd+N+fe9CccUBvfGVWo1ZYes4ajDT4g
	 7/16a2WO1p4kXUV7N51OmJQGadmQuF3MD8rb1Gp1vddaVBx3EYB6w+7Kcl8AhB6sLL
	 bGFttOMlrRvsg==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] fbdev: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Mon, 24 Jun 2024 15:29:04 +0200
Message-ID: <20240624132905.1245221-2-ukleinek@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=ukleinek@kernel.org; h=from:subject; bh=xekor7BpsrcZ5xz5Zo5vwbnz9/ZrRZLKRNB4Gve+3UA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmeXShGQ6GmX9WaV1ylibHoJMCVX8p4Vcjw86+p XuHx2uFTUSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnl0oQAKCRCPgPtYfRL+ Ts/vCACzjHkYq9eKhcW9TqLnmR1Jc+TGYte+X1GTpUKTliNQP8sAK1r7dO/5VeKOO4U/lZXQQha efc7SFj5jL0dinYFv4PFgV6zi6v3MeBoZ4EXpeunTsvqRi2wkcWQPm3cjCzQcsNp7Gn6ugb3S4E xXLpdm8dQ2pBiKJXbSghFJSKDy98X6wpF2YLzi86DLc7u2FiA/KdKOwMjVvDYzSeitp4P4gor0M kjoxcMs3cDaPAyltjb/a8ssmVjNTjQAfFOpsIpR0SIrCqfpwSPua+91xMfh2fhf9z58SU/diKpP gT9zVfi2K+dHJTUxaeOLwPlewib7tfkf8cR5Oso+Ra0ZAdGI
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/matrox/matroxfb_maven.c | 2 +-
 drivers/video/fbdev/ssd1307fb.c             | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_maven.c b/drivers/video/fbdev/matrox/matroxfb_maven.c
index b15a8ad92ba7..dcfae770b42d 100644
--- a/drivers/video/fbdev/matrox/matroxfb_maven.c
+++ b/drivers/video/fbdev/matrox/matroxfb_maven.c
@@ -1282,7 +1282,7 @@ static void maven_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id maven_id[] = {
-	{ "maven", 0 },
+	{ "maven" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, maven_id);
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 3f30af3c059e..aa6cc0a8151a 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -782,10 +782,10 @@ static void ssd1307fb_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ssd1307fb_i2c_id[] = {
-	{ "ssd1305fb", 0 },
-	{ "ssd1306fb", 0 },
-	{ "ssd1307fb", 0 },
-	{ "ssd1309fb", 0 },
+	{ "ssd1305fb" },
+	{ "ssd1306fb" },
+	{ "ssd1307fb" },
+	{ "ssd1309fb" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ssd1307fb_i2c_id);

base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
-- 
2.43.0

