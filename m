Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D023B63F;
	Tue, 30 Dec 2025 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767133231; cv=none; b=Ntq9pT9bNKNJKBWILbLf9tRGO90KPE+cuin4KJ5wxLIodT1IqTKAKxpMnMfI97pl4Was5XDZ78pLJX6ij+ntpfGdCMkgyore0H8660imb7yOz1GSWdb7t/BDGthctXEMiIoYU7QR0RX1odQtlLt5uP2vBs7eNtDgBE8rmlhuX60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767133231; c=relaxed/simple;
	bh=6I1rEjCG98kdXTPmhTpC3Bn5VqMKhdxPrgp53PclCTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aqSpEOPSj5cgg5rvWRiQ3d55sCfePIm21W8BRhcVvKQNjT6hoL6x/fJ/pWk1wrYFtiYtmTsl0d2dUthcAFR/B4YG+m9eb39249U0++n9ua7Tx5uHIXo4VYsRy4ous8Uo0o6yh37D2iyiFle55eT/B/EoywgIj2x0TdwnLp4D8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heaprSRu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heaprSRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF47AC16AAE;
	Tue, 30 Dec 2025 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767133230;
	bh=6I1rEjCG98kdXTPmhTpC3Bn5VqMKhdxPrgp53PclCTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=heaprSRuplV4FHuNIOHD+RI8xFWZsEThLI98xpea+vlBo2wemVEZMxnz7bP1c2fOa
	 Lk+7iWx0WQcSc5/p1wiX7zd/bO6v7CVvaTH38pvnqtPIClg894tnjsxqxkymkmpw+K
	 430haaHolWTSgMlZIr/kY3xlLonijVWsyTpr84y6dGk4JfWtP4TYMnwYHdsBRASRdA
	 giLkM6qBWWhxh52X2ApS3c7YPCCLZMcnLJIHJ4mcxJTFe0/y6259Znd61dzhT/sAiU
	 h1zQaX56hqITSNUXNffPiLfn/OvQWDx7S0i03x53lgrYwbw2fV/4kIy/i7O3fdiuiI
	 pOwatwMC3R4Jw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 30 Dec 2025 23:20:00 +0100
Subject: [PATCH 1/6] video/logo: remove orphan .pgm Makefile rule
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251230-custom-logo-v1-1-4736374569ee@kernel.org>
References: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>
In-Reply-To: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>
To: Helge Deller <deller@gmx.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=6I1rEjCG98kdXTPmhTpC3Bn5VqMKhdxPrgp53PclCTE=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJkhAWLXFKf84vZ1fND7fqbuwww1ptBnJsKzdb3q47a89
 pgTyJzWMZGFQYyLwVJMkWVZOSe3Qkehd9ihv5Ywc1iZQIZIizQwAAELA19uYl6pkY6Rnqm2oZ6h
 oQ6QycDFKQBT7f2KkWHLEnbmKas+2xsu2OD1WCNvfZ6xfBB3+a/webfuLmd5nzmJ4Z8+D+Nuo6k
 F/3/ZZHz3rJATvHrqZdHb0w2/A4/3zp5d+ZgbAA==
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
2.51.2

