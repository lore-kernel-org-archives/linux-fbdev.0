Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF38146D76;
	Thu, 26 Dec 2024 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735180096; cv=none; b=OOQ9q9jzpu1ml3fa0sqekUIvqqlI1v5ToDD8WmH27SiEl7n5dljbJz9mVpDLyxILZKTBObijN5h9P+id8iGiYvabxJUywjKYjzzKa8TqU71kTiFcKU8cj6TWCe7LR8l4Kmm6oJKXv4GLq3s0ShS9n2kyNjLzEMBAghUK+ZRcQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735180096; c=relaxed/simple;
	bh=lgi4msL8jzD/sDnb7usEXE5HwG/3xkJ44+z1/D61tF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=At1NsyKOrb3D5kBQh9mOx3+1DJ7Ty1DC5LXJ+nXUJ5YxZFPA4T1HEYg1rKxgl5AeO5Uez4KArW3NxKuXHBOPHtqiK/Lx+0c/hNZefxJwBr8t/UYW1kzNhlx4XEJRQUDteKEq8RjsVj6LRQO9yYh5sXo0pgKNsLomy9BhgXLLUJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=B6Llc0TQ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="B6Llc0TQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=pHpYoWcC3a1yibTmmSQIGYWTas0Sv+4pH8WU+FAozOM=; b=B6Llc0TQLzww4Rky
	/dbg4HPyp+UBtHIXR5WjD4HGbvJDFE+hF5DvZoCmGG6meYjfz1OwGYukGVk1XBBh3PSLPVdieLhEk
	j4iUZDaO19Pl9D7Yp5AmRZ6JzB2AyMmU7z0QyMCmjPn2LU9xRX5Rl3tmcF8ZEZu/ymOa0r+6GznYn
	SFdJ6TKExnFsQnLzF4weKJ3t0ROAzdisHOBvoXMHo/LPSNFuyLvGzd/2bO14RfO6q9k7PgYbO4DrM
	OSB9Lm2hhNbuZth/24DIaECh74tb2F8qFsUzX3J145VVJA2oX/GDE6kK3XjneaFC0p0uJWgVx0TwS
	cVut6VQakL5qkxo+Yw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tQdbR-007F0L-0b;
	Thu, 26 Dec 2024 02:27:57 +0000
From: linux@treblig.org
To: p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	deller@gmx.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 5/7] gpu: ipu-v3: Remove unused ipu_vdi_unsetup
Date: Thu, 26 Dec 2024 02:27:50 +0000
Message-ID: <20241226022752.219399-6-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241226022752.219399-1-linux@treblig.org>
References: <20241226022752.219399-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

ipu_vdi_unsetup() was added in 2016 by
commit 2d2ead453077 ("gpu: ipu-v3: Add Video Deinterlacer unit")
but has remained unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/ipu-v3/ipu-vdi.c | 11 -----------
 include/video/imx-ipu-v3.h   |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-vdi.c b/drivers/gpu/ipu-v3/ipu-vdi.c
index a593b232b6d3..af9631fd4256 100644
--- a/drivers/gpu/ipu-v3/ipu-vdi.c
+++ b/drivers/gpu/ipu-v3/ipu-vdi.c
@@ -150,17 +150,6 @@ void ipu_vdi_setup(struct ipu_vdi *vdi, u32 code, int xres, int yres)
 }
 EXPORT_SYMBOL_GPL(ipu_vdi_setup);
 
-void ipu_vdi_unsetup(struct ipu_vdi *vdi)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&vdi->lock, flags);
-	ipu_vdi_write(vdi, 0, VDI_FSIZE);
-	ipu_vdi_write(vdi, 0, VDI_C);
-	spin_unlock_irqrestore(&vdi->lock, flags);
-}
-EXPORT_SYMBOL_GPL(ipu_vdi_unsetup);
-
 int ipu_vdi_enable(struct ipu_vdi *vdi)
 {
 	unsigned long flags;
diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
index 8870f65c9a8b..c9ed4b6a408b 100644
--- a/include/video/imx-ipu-v3.h
+++ b/include/video/imx-ipu-v3.h
@@ -463,7 +463,6 @@ struct ipu_vdi;
 void ipu_vdi_set_field_order(struct ipu_vdi *vdi, v4l2_std_id std, u32 field);
 void ipu_vdi_set_motion(struct ipu_vdi *vdi, enum ipu_motion_sel motion_sel);
 void ipu_vdi_setup(struct ipu_vdi *vdi, u32 code, int xres, int yres);
-void ipu_vdi_unsetup(struct ipu_vdi *vdi);
 int ipu_vdi_enable(struct ipu_vdi *vdi);
 int ipu_vdi_disable(struct ipu_vdi *vdi);
 struct ipu_vdi *ipu_vdi_get(struct ipu_soc *ipu);
-- 
2.47.1

