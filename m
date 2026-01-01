Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FEB2DE6EF;
	Thu,  1 Jan 2026 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767281152; cv=none; b=KLveZq8qCZx9rek4p1Db2OssJDYxsGtztBG0r0yujfEJHaRGrMl+NezLP0WkK2t/hISxJvdE04YZOArlCays3aLWZWheidBwmOlpmd2M8vGiK/BPB9+Mv2urDyCDVIbIyvyAYgufP2LuK7YxQ19mbzmjxkuAhJPZMV7FoprQ6/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767281152; c=relaxed/simple;
	bh=/PRAWLk1+pSHIN+oE7HMAv23it2DWPyzsrdtDMwQB9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ir9n3IOlDwTKwTsjgxXEQ52LP3ZrSWcf9gt+M0sKcbKooiyElajO0XTeN7FtWCC7sIaA8EZ7k1Kc7eDUu1m1bGQDdJfvmeLUBF8qN2plbGRDBh/IjVobMhRj1YgVO+DF83FX725d92Ns/hTRJ+TlQGDXKWzfwG69Ido52V8VPlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOu9Gmw/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOu9Gmw/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79926C16AAE;
	Thu,  1 Jan 2026 15:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767281151;
	bh=/PRAWLk1+pSHIN+oE7HMAv23it2DWPyzsrdtDMwQB9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qOu9Gmw/qz5EFdv+hSR2W3VzNET+Zfr9HOgruJn+ydot06HNKv1KjYj0nK9iXJxXV
	 wwD5KcRv2Rqtc6QC9jEgrBbdYfwceeuu1ZHxoh+b834D3L79+ISb4o66mFXNU+Cvpo
	 xcHJXmLnP9eQ8DIyZRP6OK3OaSLWI8xifV4Jfh2QrXGImjTloz0coBGdfInurVfr+Z
	 N0tPNWZQteUmIjTK2ZZp86y6revzzXPOAZh18AfvVvd8f9ECw4gv52xMde02Xyz2Kc
	 5PeflIPLRTu1H0d/XwHKIWZSddaa85PE74gpg82TYt9s+DzKS7hhKgjhmep8zPEVy3
	 6XwsmoRhCvdJw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 01 Jan 2026 16:25:15 +0100
Subject: [PATCH v2 1/6] video/logo: remove orphan .pgm Makefile rule
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260101-custom-logo-v2-1-8eec06dfbf85@kernel.org>
References: <20260101-custom-logo-v2-0-8eec06dfbf85@kernel.org>
In-Reply-To: <20260101-custom-logo-v2-0-8eec06dfbf85@kernel.org>
To: Helge Deller <deller@gmx.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=/PRAWLk1+pSHIN+oE7HMAv23it2DWPyzsrdtDMwQB9k=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJlhE5977zg6YfvhbWbLtdZtERBYIBg/j6thn9ZBiahG7
 RvuQdF+HRNZGMS4GCzFFFmWlXNyK3QUeocd+msJM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GuoAmQxcnAIw1XbTGf4K3AxbusiD12/mu9OnN61UsdWJs13et83b+PCbzfczZY5eYvjDb3k9asl
 25Zt229nunuDbUqbqeeG1quaHoD3Oh7edFe9lAAA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The kernel has no actual grey-scale logos. And looking at the git
history, it seems that there never was one (or maybe there was in the
pre-git history? I did not check that far…)

Remove the Makefile rule for the .pgm grey scale images.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/video/logo/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 895c60b8402e..8b67c4941a4c 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -30,8 +30,5 @@ $(obj)/%.c: $(src)/%.pbm $(obj)/pnmtologo FORCE
 $(obj)/%.c: $(src)/%.ppm $(obj)/pnmtologo FORCE
 	$(call if_changed,logo)
 
-$(obj)/%.c: $(src)/%.pgm $(obj)/pnmtologo FORCE
-	$(call if_changed,logo)
-
 # generated C files
-targets += *_mono.c *_vga16.c *_clut224.c *_gray256.c
+targets += *_mono.c *_vga16.c *_clut224.c

-- 
2.52.0

