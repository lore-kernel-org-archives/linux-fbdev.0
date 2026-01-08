Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45550094A;
	Thu,  8 Jan 2026 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899178; cv=none; b=F8IZxQ6kkFHt5zVVQzQQsFkab0L4qJLIB647k98Z7glUMXmPYhuynDuozpW8aSJJ2g/DoO0BQnSws8Ysbd5KQwCVq2/gRsoR98QUpt7lJlZ6fdDUYKVkDW72MtU1hWxm4irqNvjRuH76o/7UHGCV+SbsZNwlXw99Nnh9PS76f80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899178; c=relaxed/simple;
	bh=/PRAWLk1+pSHIN+oE7HMAv23it2DWPyzsrdtDMwQB9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMcc7JucI1stTiRmnjX9swZ/uhXnWI+kJ/HR4gm6aJQFGGbaMscrsoBZj9hnYErR210GZTzQlARKApPfFqtkgJ+zSsxhmB3wlBBYC80m4pRwM4eFJQcQq+44WrXP3B1typPZf1RxRnqGS84fKDnqAdMT0n7x2hElxCPyYE32hLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwpkY7F0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwpkY7F0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B3AC19422;
	Thu,  8 Jan 2026 19:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767899178;
	bh=/PRAWLk1+pSHIN+oE7HMAv23it2DWPyzsrdtDMwQB9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mwpkY7F0Iu0FcR3SP6Il22zWmZ1elNrSPEjTHengfCKA96zgl7tca+G7Yzfz4bozK
	 uz3YW5Pfq0aR/G8H2DetyGzIWga26t2vPR20Op2CQ3UmEGZc6C8ZYCXF+L85TkxzrV
	 4wqqiSo1QyfdmbH+Rb7ZKLit8nEzjp3hhbpB1MzBlxYXRGHZoZx/yXB4V7Gwv9JnMV
	 WetgwnC+jrWNzSDdNEW6BJ6vlCYDDlGDIqrab2O237FRy7nIc3SR8OVMSXaIQPwEkS
	 AlrVsAGyV8Coln1IOdXAHBu+RyWX2wy/98eWNwBgHtQoffWWgaGQjNp7XQeUZigphw
	 0/qTeGC0l01uw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 08 Jan 2026 20:04:49 +0100
Subject: [PATCH v3 1/7] video/logo: remove orphan .pgm Makefile rule
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260108-custom-logo-v3-1-5a7aada7a6d4@kernel.org>
References: <20260108-custom-logo-v3-0-5a7aada7a6d4@kernel.org>
In-Reply-To: <20260108-custom-logo-v3-0-5a7aada7a6d4@kernel.org>
To: Helge Deller <deller@gmx.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=/PRAWLk1+pSHIN+oE7HMAv23it2DWPyzsrdtDMwQB9k=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJkJDDw/926vlPZ5/iO2LOtt1dqDf7+bnWAu3Sn5ql7Oq
 yXjaLZIx0QWBjEuBksxRZZl5ZzcCh2F3mGH/lrCzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 hjpAJgMXpwBM9cIvDP8rSkT0zd/yfddf8ZNX80fH3XlSrT0r63xzF6z89EP9lbQxwx/OGxmGkzJ
 OZKYlcXb9+dD8UN7jucHnTN2dR7MUNnjODWYHAA==
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

