Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB68296BCC;
	Tue, 30 Dec 2025 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767133240; cv=none; b=BcrpdCdyZFdF2mGzFnoXCa3dxaFSRRFes7Y1joR452jl3qS6sX5H3wduxpwTHUyXXJevajOL5XVvVj6cf0xxFZOyywUtRuE0ZH3EKVBlxZqKDew4V4MKETAcc1b2PXouowd7MX5Wn8sq22ecoyiscNDcp4p2ZCJrMKmiLlJSNWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767133240; c=relaxed/simple;
	bh=93HYu28vnLOJFYlzQk99DQQ03zwR1Rvm0sI/c4BZlec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NA5eX9qzsLnqgZjn0wccj+hcQWp1p52YDPtVDERom3cX/XzvCO8irlEZmibmS5GxwChcaP29I8Yk2ADL22+M0evApdgoKraoUTiIbgBHVEnec62MTjZEjwqmqnzu+FeGlatc9yaVc0EytMUYN2FayqojuNsNfvXsKQdHF6fWrj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC8w2CDe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC8w2CDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D999C16AAE;
	Tue, 30 Dec 2025 22:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767133239;
	bh=93HYu28vnLOJFYlzQk99DQQ03zwR1Rvm0sI/c4BZlec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HC8w2CDewlFHvWeaOfy1pvO/G1dg9AWJQ/lAyq0YK8ImyxhYm/d4VcC+16QQ89t9/
	 VoF0WeBIYSz4Y7RSt0v2AXNWzM/Hl48GuyAyBemFPJQUWTXqJGBPsLTDQGwHjAIeiI
	 ixfqC96alZ1TUTv5k0WfdFTZ+vwE7QqgevKvU8eimKQ29VfHY/O1LQEj7MKygmc31S
	 PJcqx6sOB1xuzcc5JyqM0bnk08hMb9+I9LBZvSvODv7Efw1ZU0Nc8okDsBw3EAwoaN
	 fsz8sGweS3tbZugGcfHoye0S4Lm2ZSCD7Tyb74nnS/8+5GJmjgAqDL4a5zOXr7BiHp
	 gOwSFcWAeGNew==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 30 Dec 2025 23:20:03 +0100
Subject: [PATCH 4/6] newport_con: depend on LOGO_LINUX_CLUT224 instead of
 LOGO_SGI_CLUT224
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251230-custom-logo-v1-4-4736374569ee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=93HYu28vnLOJFYlzQk99DQQ03zwR1Rvm0sI/c4BZlec=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJkhAfLSrzMCFy861jOpryTlj0Pnymuh6eqNP6XEX+6O1
 a+cK7WkYyILgxgXg6WYIsuyck5uhY5C77BDfy1h5rAygQ0RaWAAAhYGvtzEvFIjHSM9U21DPUND
 HSCTgYtTAKZ60wFGhs17tmSpeWia8xswfyhW9jlf0Sxiv3Blxp/SFQHTnq21e83IsK3rm5X466N
 vi9tDbd4G/BDmu6kY2VcZ+bCMc6Oq5LM/TAA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

newport_show_logo() is only activated if CONFIG_LOGO_LINUX_CLUT224 is
set (otherwise it is a NOP). This configuration value will be removed
in an upcoming change so instead, make it depend on LOGO_LINUX_CLUT224.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/video/console/newport_con.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 242415366074..337e04236d6d 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -95,7 +95,7 @@ static inline void newport_init_cmap(void)
 
 static const struct linux_logo *newport_show_logo(void)
 {
-#ifdef CONFIG_LOGO_SGI_CLUT224
+#ifdef CONFIG_LOGO_LINUX_CLUT224
 	const struct linux_logo *logo = fb_find_logo(8);
 	const unsigned char *clut;
 	const unsigned char *data;
@@ -127,7 +127,7 @@ static const struct linux_logo *newport_show_logo(void)
 	return logo;
 #else
 	return NULL;
-#endif /* CONFIG_LOGO_SGI_CLUT224 */
+#endif /* CONFIG_LOGO_LINUX_CLUT224 */
 }
 
 static inline void newport_clear_screen(int xstart, int ystart, int xend,

-- 
2.51.2

