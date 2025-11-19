Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6542749DF;
	Wed, 19 Nov 2025 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763540780; cv=none; b=DuQBMgguA7/zxNlMGrn5zKOPK8mNUdvhmiLtW8mWtidAl4FaGasSJ1IGVnVeVKP4CUHawbUIynxTw2i5ZcQxBJ8stH+xY/xtCEtSuFdAVe5YOF0cXnrwuxw8MYxJVvlEpOR+DICm+wWMwnkM6mQmDyPo3PmNaVa4DVf/QDOGSgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763540780; c=relaxed/simple;
	bh=QHwp4lY2HPcPahRZXK4LaMFm9Mk6v/c6AOOPuydO0fQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U7HDJFwRd7KHwpVmsa5W0Fe7JPOMfyxw764eWi3X7sY7TKOj/9fXZytZ02clpu+cTj5kXHM7LRRn8lVCCG5JKdCJpdyKrwDIkwsiyRg3dEbUVIQ265YbKx1fIWFgqIM3pno+j8kQHbfrtUcCjKOyoW9F90Rapc3h/4UeoHNc6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGDICVXm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGDICVXm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3C0BC16AAE;
	Wed, 19 Nov 2025 08:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763540780;
	bh=QHwp4lY2HPcPahRZXK4LaMFm9Mk6v/c6AOOPuydO0fQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YGDICVXmnp62M+m/7hr9sSqXloS+MGgedTPrYk/pLl+l2rgjZqFbXBQ5ZosJsUYdS
	 i+0G5pfd9uQiLc7YhUXHk8zJpHG9ZSGZ52vZHCyMyqbZnIKLsT4Ig5DbW/lvB0zcqf
	 QN1Dsi2gvEnXSFlfIUg/BvKWCtBMhzFqaGApRycYT++8ykzP2Ao1IVveTeBobiz25F
	 oTQW2hPd3ma/E8c4/yT36bPI8YyATLqGa5N4A0+FNwb3mooSN+/jxfK72cD68Jye/q
	 LxTiMv721Dd3GhzluRiKfPtRA9NC7AgBOElGbsCYRDuN59csbB87sAzN+QbtKDVHGj
	 8xJZIsny1RM2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840BCCF258C;
	Wed, 19 Nov 2025 08:26:19 +0000 (UTC)
From: Petri Karhula via B4 Relay <devnull+petri.karhula.novatron.fi@kernel.org>
Subject: [PATCH v2 0/2] Backlight driver to control backlight behind
 Congatec Board Controller.
Date: Wed, 19 Nov 2025 08:25:45 +0000
Message-Id: <20251119-cgbc-backlight-v2-0-4d4edd7ca662@novatron.fi>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAl/HWkC/3XMQQ7CIBCF4as0sxbDtNZUV97DdAFTChMNGCBE0
 3B3sXuX/0vet0EykU2Ca7dBNIUTB9+iP3RATnlrBC+toZf9iIiTIKtJaEWPJ1uXxTASorwsWuo
 J2ukVzcrvHbzPrR2nHOJn9wv+1r9UQYGC6KxoHCTK4XTzoagcgz+uDHOt9QtIFpQwrgAAAA==
X-Change-ID: 20251118-cgbc-backlight-35c1109db0b8
To: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, Petri Karhula <petri.karhula@novatron.fi>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763540778; l=1068;
 i=petri.karhula@novatron.fi; s=20251118; h=from:subject:message-id;
 bh=QHwp4lY2HPcPahRZXK4LaMFm9Mk6v/c6AOOPuydO0fQ=;
 b=9AC+En9IdiAecmW78tFIvc8DEAPUbK4EcxwsMxWLlAHkyp8BR55ywXRluE6Le3nArv5o2KFH8
 MmL/x2bWw96B8p+bpE4kNLQHot5Ap5+sTkR3z0nXz7slK4d6uuzMZfX
X-Developer-Key: i=petri.karhula@novatron.fi; a=ed25519;
 pk=LRYJ99jPPsHJwdJEPkqlmzAMqo6oyw7I421aHEfDp7o=
X-Endpoint-Received: by B4 Relay for petri.karhula@novatron.fi/20251118
 with auth_id=567
X-Original-From: Petri Karhula <petri.karhula@novatron.fi>
Reply-To: petri.karhula@novatron.fi

This driver provides backlight brightness control through the Linux
backlight subsystem. It communicates with the board controller to
adjust LCD backlight using PWM signals. Communication is done
through Congatec Board Controller core driver.
    

Signed-off-by: Petri Karhula <petri.karhula@novatron.fi>
---
Changes in v2:
- Separated Board Controller core driver change into its own patch
- Link to v1: https://lore.kernel.org/r/20251118-cgbc-backlight-v1-1-cc6ac5301034@novatron.fi

---
Petri Karhula (2):
      backlight: Add Congatec Board Controller (CGBC) backlight support
      mfd: cgbc: Add support for backlight

 drivers/mfd/cgbc-core.c           |   1 +
 drivers/video/backlight/Kconfig   |  11 ++
 drivers/video/backlight/Makefile  |   1 +
 drivers/video/backlight/cgbc_bl.c | 281 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 294 insertions(+)
---
base-commit: e7c375b181600caf135cfd03eadbc45eb530f2cb
change-id: 20251118-cgbc-backlight-35c1109db0b8

Best regards,
-- 
Petri Karhula <petri.karhula@novatron.fi>


