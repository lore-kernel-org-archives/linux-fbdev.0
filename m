Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD0C1C27
	for <linux-fbdev@vger.kernel.org>; Thu, 21 Aug 2025 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744385; cv=none; b=ccCKgqtYQYO4yIEa9EayoJjMyGlsbGnHeJHv8Cw8s8kcXOaay/ZSAO8h5V+sD+vnhUjhNAXicCQYG9GgwlBgPxTFO8GmLAZ3O7r6fLznI9TtGA3C+fDM2XnXNke83wQEV7SxKkQsLu6dVML76WY1OyN/i9frICBP+H2CfO0lp7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744385; c=relaxed/simple;
	bh=O5vOlQ/yORUzJnoN8Xns+1b7FCsqzGgEM8MAyHDSfTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T6mTFRAnyip3VFg1Wlmu74udlroKtqTJldH4eWAl6ARrLp2BSJVk7EAgo1ENJWm67j4vRMVma647COotAfSaA9uze4U5IeICaLfz8ksoALYdaGJP7m5GsbfPqG1jPF4uBB1T5sUGi9gbFB7LIomcWJpyb6Z6EP/0MtwVoBLDdDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 4BB8A102AD; Thu, 21 Aug 2025 04:46:09 +0200 (CEST)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH] fbdev: core: fix ubsan warning in pixel_to_pat
Date: Thu, 21 Aug 2025 04:42:48 +0200
Message-Id: <20250821024248.7458-1-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It could be triggered on 32 bit big endian machines at 32 bpp in the
pattern realignment. In this case just return early as the result is
an identity.

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/fb_fillrect.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_fillrect.h b/drivers/video/fbdev/core/fb_fillrect.h
index 66042e534..f366670a5 100644
--- a/drivers/video/fbdev/core/fb_fillrect.h
+++ b/drivers/video/fbdev/core/fb_fillrect.h
@@ -92,8 +92,7 @@ static unsigned long pixel_to_pat(int bpp, u32 color)
 		pattern = pattern | pattern << bpp;
 		break;
 	default:
-		pattern = color;
-		break;
+		return color;
 	}
 #ifndef __LITTLE_ENDIAN
 	pattern <<= (BITS_PER_LONG % bpp);
-- 
2.30.2

