Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D8E37EFEE
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Mar 2026 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640387; cv=none; b=OAITiMfy3ZKXDYLBJiCwzi3GD7d6Y0uAqzidOmCfN6FH77Cth2nHjHq2z0+VH/MtFxnc++4qxbX6hZgdoqid1vnXu5o2UZQCgugI6W7EHjSbYX5eUzxNdVVgzHBrrQO4h97zaTeX8VClmGKpsGQeE3rESvGdUm69tRCDtrZ7Cug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640387; c=relaxed/simple;
	bh=Ag7ohZyx7WzGrgeovVjTIG+wTFQaqlSfy2RCg9SR32o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KhqeOy8aSCyOXqlqUWMRimarnj4qjZiwEdLNm/ivCBSKsS9rRb39FX1wDsJRYPSeRLURQGYnBOHDJb5hFWHz/p6gSJfFvPOmTiNVzGhSIbFtL6VxaU8v3RMnAbHeIiGsFG5pG9u+ZKdvLaIAaaLd/BwmvIWTetnpL3atljJ02Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qegvgyu1; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qegvgyu1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E361B4E42820;
	Fri, 27 Mar 2026 19:39:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B152A60268;
	Fri, 27 Mar 2026 19:39:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A27E410451AEF;
	Fri, 27 Mar 2026 20:39:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774640378; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=mLE15DOQB0f7iSKKawPwRv0wOdSj7ZQm/qNs4WZOIds=;
	b=Qegvgyu1W8JnJYMq4q9eLQ444VFl4KFsHeFAnV54fbrX2TAkOZxHY/fEN63h9NFnixVQvx
	BPY/SR8goeDPamS3FT1mO1Ce0618hYAv+dH8A+AxV0cRVVFUd1R0qNtaBW3nq3Sw0aFFos
	j1tPyWHNrjgyXimpl2t8zTKnF4DiGeLYw6A0jHKfuktcNada3ozpQV5Nlwahpj65Mv9yiE
	fgaW96uHlfFTAFs10oVGbYOxUCaS8Lp/BLFwVdZJyImUq5bYwaDNDWoxuVOjGiaToehGxP
	piTwwHLfBZKZXCTAqh7bn1/1Rh4vKwWrq3E7EasJ1PwmEfHtrajiw6TSUKhc8g==
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH 0/2] Remove redundant X86 dependency for the cgbc backlight
 driver
Date: Fri, 27 Mar 2026 20:39:31 +0100
Message-Id: <20260327-backlight-cgbc-remove-x86-dependency-v1-0-4851c9e95371@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPPcxmkC/x3NQQ6CMBBG4auQWTtJQajiVYiLMv0tE7WQ1hAM4
 e42Lr/NeztlJEWmW7VTwqpZ51hQnyqSycUAVl9MjWmsOZueRyfPl4bpwxJG4YT3vIK3q2WPBdE
 jypdb4y7Sd7Vtu55Kakl46PbfDPfj+AGmm8yidgAAAA==
X-Change-ID: 20260309-backlight-cgbc-remove-x86-dependency-40a7c9516459
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Remove redundant X86 dependency for the cgbc backlight driver. Additionally
the driver is added to MAINTAINERS file.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Thomas Richard (2):
      backlight: cgbc: Remove redundant X86 dependency
      MAINTAINERS: Add cgbc backlight driver

 MAINTAINERS                     | 1 +
 drivers/video/backlight/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260309-backlight-cgbc-remove-x86-dependency-40a7c9516459

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>

