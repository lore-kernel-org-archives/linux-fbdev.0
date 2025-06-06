Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B9C27D77D;
	Fri,  6 Jun 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749200546; cv=none; b=EnjWkJLpotqR+6fuEL8/nuDN7i9P4lrNN3zFm7MNCgPyDY3F56T+QJ5RSdv0sdwEN1xUSjHyZ8fOeWP8QLUvTFoV0sgvX6YE9J9lrwphnNfCTh2pkxCZ47xZuhrXGO7EON0KQtPb1bTEiGvOxglOCsyFamo/T3ExOou+MH0Z2DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749200546; c=relaxed/simple;
	bh=SUg/2IsqpTvBJEpg+iRuOKCO+q9ArJPcqLY/JWDpPc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qjrf1kamWcwhET+vYSA+ZwvLlP3sY8e2seepFfNnEKEJWpU0s2Pi5TFJt7AJrlNcXIEdleffwXOaBv/UZwFjQcw4OSy2lZPJcbLToPmQJ8Em/QubNTcnmRu6Fv0sJXC4WrWdormtfgQS8SkwDaPVIv8x8DEfmMab+Vzr4Z1pJHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DltjEQ3E; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DltjEQ3E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=B5+6GNo+Kjy0W/tpeCAop2tkJ19hyv2rEwEglFG0DkA=; t=1749200544; x=1750410144; 
	b=DltjEQ3EQqTX6ibQgo9SoRDmADgzTZwPg0DfK68ZkBr/tVotp+jEcqyR4deYrR/z/YVp7OtdyOn
	QHZ7wYYT/8n1M5LmRs5G1OQIM4i77b2pTHMt9rlr+p1t4UrghtiYl5v592cXQq+GrDJsosUZaqk1G
	HIFy3MjKv5cmUEG3+BGR3jI7pEg2zXgNasbgq+SZKd+yo9aAQMekPI2U0eeZvvGrMuocZh1VRqpQH
	IIcLxRdmXk49GtEZ+6VhctBBIzc4o9Yk01rAxh/O/5OGgb0fhbo+zZQRQ0BTfQEbMnOajeAOfjDex
	to2oKeUNKIrPz9hLLtNQioK7MtvSTp2MgLww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uNSxx-00000007YlN-1iap;
	Fri, 06 Jun 2025 11:02:21 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Antonino Daplas <adaplas@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] nvidiafb: fix build on 32-bit ARCH=um
Date: Fri,  6 Jun 2025 11:02:19 +0200
Message-ID: <20250606090218.15826-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Now that ARCH=um no longer has IO port accesses, this driver
can no longer build as-is. Make the IO port calls not just
conditional on i386 but also !UML.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/video/fbdev/nvidia/nv_local.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/nvidia/nv_local.h b/drivers/video/fbdev/nvidia/nv_local.h
index 68e508daa417..93aff35305a9 100644
--- a/drivers/video/fbdev/nvidia/nv_local.h
+++ b/drivers/video/fbdev/nvidia/nv_local.h
@@ -80,7 +80,7 @@
      (par)->dmaFree -= ((size) + 1);          \
 }
 
-#if defined(__i386__)
+#if defined(__i386__) && !defined(CONFIG_UML)
 #define _NV_FENCE() outb(0, 0x3D0);
 #else
 #define _NV_FENCE() mb();
-- 
2.49.0

