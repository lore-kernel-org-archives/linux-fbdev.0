Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9063535DA55;
	Fri, 14 Aug 2026 02:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786676205; cv=none; b=Fp33+PJ2+A4Xm5rzWK31WPdZvP4Fldd5CsV5m6sq8VkrVUHzH6NNOP3DKboVYNbXa8eFAEdbXLtKkicNb1VOK7UpfejpiSmOYmMg0SP6x2vgZyXui5Zy4iCWr4iqVbWKMF3ve1uFAfbfYlZBBIpcqclvsIhse5PJ3UguQvjx3fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786676205; c=relaxed/simple;
	bh=l4fgEss7c8eEwIyy34L9uCdiPiodnl8ogKjO5QyXKoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0XAx8Gc9WaB8AXwLS+tycILCg37S6JuF2LSTv4eDy6f30J3QLNwxRJpqFB8wBEHte+1i2JqqjnN+KRNShqBDWHwYDwHbQqoQdysv/CqFfNvWRPU6Sui8KpCdGESE1dMMUAV4NKOk3nlp59VcXroY+cTgBTIffYF75WgkifXEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C3L/T7MZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C3L/T7MZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=zbky2Bpv4AINcxZq0H9Q0Wkjam+9jh7ePSFufJNMOnE=; b=C3L/T7MZSNxdlHLTLN/6kiOLHs
	pMURvi48uRh0dgxpa0C3lChgT5UnhjpcObla0HdPc/m4qDTNp13Z6lDwGT5PcnKdrhKlN5E5aJpCB
	zkz9AB2X2rzvAdfKqeyk1ZqbMOd6g/NsY5qkhkwtDqgcb3KRhqcUthAJDfSnz7n15zFaqryAgpmMK
	hrtztCdnhOvOQZKs+0l8vI9s9rnmlrqz1Hb59xSgdhER4JB9E5HyqNVC/VZF+M1UTy9Rnqrv8xIfL
	EYsgl0Ce4y7eeU+wwuiXu8EalLIBNLGIKYkdypJ6Hy0B6+rpvzE39VA0XJrJtDY3cfCTX5+oAan3T
	y8jyMMWQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wui65-00000001sfm-0YwG;
	Fri, 14 Aug 2026 02:56:41 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	sashiko-bot@kernel.org,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH 04/04] fbdev: maxine: fix maxinefb_init() return value
Date: Thu, 13 Aug 2026 19:56:40 -0700
Message-ID: <20260814025640.2782161-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A driver should return a negative error code on failure of its
module_init() function so that the system recognizes the failure.
Change the "return 1" to "return -ENODEV".

Suggested-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260809234810.982500-1-rdunlap@infradead.org?part=1
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>

 drivers/video/fbdev/maxinefb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20260812.orig/drivers/video/fbdev/maxinefb.c
+++ linux-next-20260812/drivers/video/fbdev/maxinefb.c
@@ -160,7 +160,7 @@ static int __init maxinefb_init(void)
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
 	if (register_framebuffer(&fb_info) < 0)
-		return 1;
+		return -ENODEV;
 	return 0;
 }
 
