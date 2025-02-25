Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE81A2389;
	Tue, 25 Feb 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501881; cv=none; b=dkkIAwEOjW954HFJe87d642EltImTDP81+GADv3OudMcI+pqmicLe6SYu4qKjNhmN/W9ahipU1X8Dlerim/Y1sYLK9FW1Jm6sHXJBDjWWs4PQsZn0HyLG+M31elSC8j8rpRDMHwgbEHqHmTF3zbIt7jallEWLqsT8cViL/MsIFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501881; c=relaxed/simple;
	bh=ZX5eNqfG2UfwSXd6a7upCgYYCJX3G4CmXLdSAOkFdSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4Vb8wPFaUGmeSvZiE2QjDFnZu6EM1BlvJ9VpdA46HC+uPwr/p3yl2nrgtoUqB9NUac8RhAWAKDGHywL7LIxwCCo7QghHlYCyuBRHYTNSCdctEn/4RMKcmNhkxCKdzNvjxArF18BDObBTO33maQoaU2LA2djJSqT/FSNLKiUufU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuNk+zdQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuNk+zdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1971CC4CEEC;
	Tue, 25 Feb 2025 16:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501880;
	bh=ZX5eNqfG2UfwSXd6a7upCgYYCJX3G4CmXLdSAOkFdSg=;
	h=From:To:Cc:Subject:Date:From;
	b=SuNk+zdQlyrpthP0q5lo3IgJRdelSpuQfAw3eUDvMCuvc3oczkl84KZsDd0KMNZfk
	 y86wUN5PYNfThF0Z8diUpfOyllDDJoJvm14DlAFKGpdQx6vVngAvcZr+ip6IJiXJ/t
	 cZ3VpsqFPJGHK44Q+yxJJGBipYOaybJ0nJiIDzVNpd94Q4vM10Bxoe1JwLJJTHrGqF
	 fEbmXuA0KKGVQ2V79J2UiHMjpuVx0DCYR0UddJGpG0aFvg7Cqn6LH5FKel9R6wpMpd
	 YJXF7Oa3Z5ES2Wn1LRO6j18IM3Y4i8Q00+9QPyvgpyEEHv0OG5t5wTUW7oiyXIX2ic
	 efdrgUHKDy8nQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dummycon: only build module if there are users
Date: Tue, 25 Feb 2025 17:44:21 +0100
Message-Id: <20250225164436.56654-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Dummycon is used as a fallback conswitchp for vgacon and fbcon
in the VT code, and there are no references to it if all three
are disabled, so just leave it out of the kernel image for
configurations without those.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/console/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index bc31db6ef7d2..1c4263c164ce 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -47,8 +47,7 @@ config SGI_NEWPORT_CONSOLE
 	  card of your Indy.  Most people say Y here.
 
 config DUMMY_CONSOLE
-	bool
-	default y
+	def_bool VT || VGA_CONSOLE || FRAMEBUFFER_CONSOLE
 
 config DUMMY_CONSOLE_COLUMNS
 	int "Initial number of console screen columns"
-- 
2.39.5

