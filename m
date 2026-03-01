Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1E5430BB5;
	Sun,  1 Mar 2026 01:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328535; cv=none; b=cldEubXeKSj8Ncl2xBsvtNeLuresBDVu3bt3lhfsd391soFOpfM9qGt/GcTo4wQaEjxISd42MpY1uxopkFqRP6OV29pHFIPLNAvWwGO+zYZ5/d5rwyq+5WgoKkL3DDSWXwXXhxS82z3TGPYpLri0QNiolcXd3WNgVthmbac47UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328535; c=relaxed/simple;
	bh=0MKzHUz8phvLjDlqAvfjEz7XB2syf8ArvnBxtAnqS7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvtdcS5ZbP/v1d+RWvnfbDVGaRx0aDkTymZgp2bMGp1zMSZzDtJ4uoOws2d7R6IvPmndSSpKqkaoRkRkpbfu5cZFy+iE8y2vfA22FSRj/EgxrL2dIhi3Q3CzkFfPnbu4bCwz8vNMwwM/jxQo1M9k56iNYQSLhLvc9ZyER8p9lcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe1k2blc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe1k2blc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96B1C19421;
	Sun,  1 Mar 2026 01:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328535;
	bh=0MKzHUz8phvLjDlqAvfjEz7XB2syf8ArvnBxtAnqS7c=;
	h=From:To:Cc:Subject:Date:From;
	b=fe1k2blcXgXKrLsSlwuzhmAxyxr5O/JaUTl1nwb0N4aUY/nGyEyESqnlIq396hDV+
	 7Em+jcJM4kpSjgvRmPo/LXXy1+OMhx4Nx5PC2XQobdsFoImFoBgn3XEdRYxrtPJWdJ
	 0rZEsED9WDyOrwq4cJ8SUE5XKVMmXgUw+vbvgosrTCFRx/ZLwA0+Z0RxR5CpT958y7
	 zhBQIJlz8LRkPGPBj1WAF7oipYOJ3kmYTb6dYJ3rb8aFUOd1pG3dqCZUkwI/WHgQAJ
	 ggd5oRx0fRR6x50We53r8iTzw4ThFslrx2BRVSx12IEuyvDIsJnDEO18sd9QikNYAL
	 Vb39zPsYIpTtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	geoffreyhe2@gmail.com
Cc: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "fbdev: of: display_timing: fix refcount leak in of_get_display_timings()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:28:53 -0500
Message-ID: <20260301012853.1686707-1-sashal@kernel.org>
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

From eacf9840ae1285a1ef47eb0ce16d786e542bd4d7 Mon Sep 17 00:00:00 2001
From: Weigang He <geoffreyhe2@gmail.com>
Date: Fri, 16 Jan 2026 09:57:51 +0000
Subject: [PATCH] fbdev: of: display_timing: fix refcount leak in
 of_get_display_timings()

of_parse_phandle() returns a device_node with refcount incremented,
which is stored in 'entry' and then copied to 'native_mode'. When the
error paths at lines 184 or 192 jump to 'entryfail', native_mode's
refcount is not decremented, causing a refcount leak.

Fix this by changing the goto target from 'entryfail' to 'timingfail',
which properly calls of_node_put(native_mode) before cleanup.

Fixes: cc3f414cf2e4 ("video: add of helper for display timings/videomode")
Cc: stable@vger.kernel.org
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/of_display_timing.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index bebd371c6b93e..1940c9505dd3b 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -181,7 +181,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 	if (disp->num_timings == 0) {
 		/* should never happen, as entry was already found above */
 		pr_err("%pOF: no timings specified\n", np);
-		goto entryfail;
+		goto timingfail;
 	}
 
 	disp->timings = kcalloc(disp->num_timings,
@@ -189,7 +189,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 				GFP_KERNEL);
 	if (!disp->timings) {
 		pr_err("%pOF: could not allocate timings array\n", np);
-		goto entryfail;
+		goto timingfail;
 	}
 
 	disp->num_timings = 0;
-- 
2.51.0




