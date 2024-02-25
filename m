Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244EA9443
	for <linux-fbdev@vger.kernel.org>; Sun, 25 Feb 2024 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708843650; cv=none; b=HwWnyoer3znECFIQXQDFa+2FiKHo+Oykj2hcCLirzuKdgKKfOx6tTXBEFVL1caTkEQhFzBlBCFzHLOTZ7kAvEQUyRBDHe5pChLFQXQIKNwnkR4ycWKLTbaqqj5tb23uKvlj5pMsmsCFFadGLtEK5cvb1ia9IBm3M/ybyRJDEhyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708843650; c=relaxed/simple;
	bh=YKwC/ei/4U0z7yRBMBOlycIs3Tdvan58ObTypyZhS8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G65x/r/CRPiPRm79gzvH+LLNyZWBPnpO2VNWrOgGPmemEZU5cEDV9eTYHhvvMu7VUNSJahoWE53KTjzIkOsoUf4QxFlfl95vKEPKqd1kqBTPu8P4hbNpIF+cwWD9a5xDNTbyjq1m7zOVBg/4uxJ7o/a3sfBAz6XeWtD8JAlkLaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=piIAc2PE; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="piIAc2PE"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 621426049D;
	Sun, 25 Feb 2024 06:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1708843648;
	bh=YKwC/ei/4U0z7yRBMBOlycIs3Tdvan58ObTypyZhS8s=;
	h=From:To:Cc:Subject:Date:From;
	b=piIAc2PERi+kMc/Tlm4QZJucjdb8100JLjfzCFxUBxO55hHO7ozpP4mpgu3m9DVDi
	 TxZSpFqariESKNoh2d/R3wVHzSZqoyN2KS1noZd9tIPQabz7W0dZSnAHgUbrdTpK3D
	 NUxPubA37ed5DnzbKSZ+et6NcitZND895TpyhQhllElwR7YjZAYrji8QhonqOsvVg2
	 2v50qFhGNhfIxMHb1g2EqWN38HwuFpb/EzLm4Jmyv1/EsRqhSakj0iwpTLjmbUtllB
	 vyu+yT+W/NBoHb8ck0ov9ClUMPUWwTVw6kvYM6r3gyTrZAQ0ipmis3VAXRcOhxLwk/
	 ZwUc8p1L3Cxmw==
From: Tony Lindgren <tony@atomide.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v2 0/2] Fixes for omapdrm console
Date: Sun, 25 Feb 2024 08:46:53 +0200
Message-ID: <20240225064700.48035-1-tony@atomide.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are two fixes for omapdrm console.

Regards,

Tony

Changes since v1:

- Add FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS to use with
  FB_DEFAULT_DEFERRED_OPS as suggested by Thomas

Tony Lindgren (2):
  drm/omapdrm: Fix console by implementing fb_dirty
  drm/omapdrm: Fix console with deferred ops

 drivers/gpu/drm/omapdrm/omap_fbdev.c | 39 +++++++++++++++++++---------
 include/linux/fb.h                   |  4 +++
 2 files changed, 31 insertions(+), 12 deletions(-)

-- 
2.43.1
