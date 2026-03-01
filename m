Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1568430BB5;
	Sun,  1 Mar 2026 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328531; cv=none; b=tsG6HngI/dOe0A6CA+792hw3FtQRfRgzL4llZLT5rM15315xEWy+vexm135qD2P5BgIexeRQKwsmPHWnNYWKjy8pZhhAWigosfYUNybz7Sj/21h+mgp1fL8fmZEmIlo5z0tWBVp/OG9SJ10t6pJHi7CVnwjIQibj4P+TjQL+oSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328531; c=relaxed/simple;
	bh=/g6RjrAebEf90HjBSRoFN3k9pHG6/2W5hM5S4qH+qNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KSTKmhsenKOWz4eqhgD/3NZH4uqj0nPchD7twT2GeBE45TwfcXUiqZ4pAPz/XwpNsO8TfK0JsZPPvqtYyerIFYCP3AcR3DlkMEMkjRCdGgP6p/VUTA8Rpad5RtVdz4CnAltNbpq53IqRxOWxi67hr80u0SBAfwLHz51+PveCc6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0USjE6Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0USjE6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0625C19421;
	Sun,  1 Mar 2026 01:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328530;
	bh=/g6RjrAebEf90HjBSRoFN3k9pHG6/2W5hM5S4qH+qNQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Q0USjE6Q/eD5OrlpvwRg3uhl/Xyjbnu/arEc0JqZrD4jDxBgX00AdFnF5zLLXSkqv
	 DNZmZZ61tjLud8seteyTwz7rPWqdge3sgpAYtuROEeMOOyz4208nu9CLT+ZnYp2Dpq
	 uv9evO/FjZLDfAoU8GptDsQqB/P1eTtGjB3UP29EnfpBTEsef5YRFUwUULyO6t7DUa
	 VEfDZknFTfg484vZyq2pQp3LSsZhphgAYpJpsVocluAt9hIxwsbqHHcj8RpsiPFQgy
	 tUKmExqLVoC0oHOifgbOLIaqFDBYUgQJHv2vF8jphKQL0q2gq1mYTNabMsObp2dHhk
	 nRwAdkDQh7qUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	a.vatoropin@crpt.ru
Cc: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "fbcon: check return value of con2fb_acquire_newinfo()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:28:48 -0500
Message-ID: <20260301012848.1686605-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 011a0502801c8536f64141a2b61362c14f456544 Mon Sep 17 00:00:00 2001
From: Andrey Vatoropin <a.vatoropin@crpt.ru>
Date: Wed, 17 Dec 2025 09:11:05 +0000
Subject: [PATCH] fbcon: check return value of con2fb_acquire_newinfo()

If fbcon_open() fails when called from con2fb_acquire_newinfo() then
info->fbcon_par pointer remains NULL which is later dereferenced.

Add check for return value of the function con2fb_acquire_newinfo() to
avoid it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d1baa4ffa677 ("fbcon: set_con2fb_map fixes")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/core/fbcon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 34ea14412ace1..36e380797a9e4 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1068,7 +1068,8 @@ static void fbcon_init(struct vc_data *vc, bool init)
 		return;
 
 	if (!info->fbcon_par)
-		con2fb_acquire_newinfo(vc, info, vc->vc_num);
+		if (con2fb_acquire_newinfo(vc, info, vc->vc_num))
+			return;
 
 	/* If we are not the first console on this
 	   fb, copy the font from that console */
-- 
2.51.0




