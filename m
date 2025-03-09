Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A010E5
	for <linux-fbdev@vger.kernel.org>; Sun,  9 Mar 2025 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741546473; cv=none; b=EBG3Z2Uy7AJkW1YDy0hVxZGFlfeU30segCRNSqvk9D3xf/pX6/Z9ImwfzeBX6o7R7g7/RihZ701/g3DwV/CDMypGZYZv4E3cyBpgDbzJgoyDbrreG+17VmVKZMAc7mcV0N2ASLvs/C57R7Fq9FN+/VDjofkNPRXwQ8F/sJCKnU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741546473; c=relaxed/simple;
	bh=+gRDX8vtcOI27B5QgVZXxgE4UbTZU3v9H5C4WLtBUvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AnRhc8Wzc1pDulBpVxE/qjTi6eFZvgWSNdJDP4XTuxviyFuG0W6UV1E7NRYRagQCnai7Be5b4Y+mUHORPrfTppp7YdU45bVMgWf+KfKpXhAs2UF4+odI/QSmrf1BsQjLbzrsn6BeHC54b+KzbddsUb6fdFVM8AcUyu5O9FCRw/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 55A3610202; Sun,  9 Mar 2025 19:54:09 +0100 (CET)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH RESEND 2/2] Adding contact info for packed pixel drawing
Date: Sun,  9 Mar 2025 19:47:16 +0100
Message-Id: <20250309184716.13732-3-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250309184716.13732-1-soci@c64.rulez.org>
References: <20250309184716.13732-1-soci@c64.rulez.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the nature of changes this is probably necessary. Even if these
drawing routines got way more testing than my patch submission scripts.

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0248c9eb3..ac9e23881 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9114,6 +9114,22 @@ S:	Odd Fixes
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/video/fbdev/core/
 
+FRAMEBUFFER DRAWING
+M:	Zsolt Kajtar <soci@c64.rulez.org>
+S:	Odd Fixes
+F:	drivers/video/fbdev/core/cfbcopyarea.c
+F:	drivers/video/fbdev/core/cfbfillrect.c
+F:	drivers/video/fbdev/core/cfbimgblt.c
+F:	drivers/video/fbdev/core/cfbmem.h
+F:	drivers/video/fbdev/core/fb_copyarea.h
+F:	drivers/video/fbdev/core/fb_draw.h
+F:	drivers/video/fbdev/core/fb_fillrect.h
+F:	drivers/video/fbdev/core/fb_imageblit.h
+F:	drivers/video/fbdev/core/syscopyarea.c
+F:	drivers/video/fbdev/core/sysfillrect.c
+F:	drivers/video/fbdev/core/sysimgblt.c
+F:	drivers/video/fbdev/core/sysmem.h
+
 FRAMEBUFFER LAYER
 M:	Helge Deller <deller@gmx.de>
 L:	linux-fbdev@vger.kernel.org
-- 
2.30.2

