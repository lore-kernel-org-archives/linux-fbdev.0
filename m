Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985D330D29
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365395; cv=none; b=G+XSlHAgQfxwzuaq0JbMLHTJdTbzhbnVxSDW3jDdXtkof6OHz9buxDqfkC3zsPWhI7Y88zm4uDbRyUS3hDm9WeioSmN9AoHvR44IlP5S1MU3w1SAhTdilw9BwSwqjS3wP8dhtlH5+Srqg1bGdrGqQYKmGFBCglgSMmoDk4twtDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365395; c=relaxed/simple;
	bh=sWyB99+5sBWbk3HBJIRsGP07PNoJQbqM/Utdxj2XnjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYjmzRINdPcq6ga0hMz+TzDVWagSstqfgy9fMrEIeTUemH45pojGOUolF/tdQsRVOv5kNS0Qyn5Ux27rBkQylLZTfW1GFRJC3uulFfxUDzSDAIuwXSaYLFEquFLEaVcX5OXgnMDtM1ot8SX+iqoTyevfeyhEaEdI6tNwqWeviYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2Jrhak0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2Jrhak0"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f8893bff3so88475b3a.2
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 11:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365394; x=1776970194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLeKkfzWHS5ML4Om9B8pQ3L/JlsStI2i/wsWT7w+17c=;
        b=Y2Jrhak0ErSZ7HQE1MkWGZhkixU7bKZMgFn+awlzzmSZmQoCr0/fvIa4BV1GykJz+e
         IdZshmWzxZYMfAfmTde+OL1vUJeMFkqHnTOGt7MMcveZYEs22GOjToEsOEyvE9KkuJ/T
         iYYNqZK/5ms3mu/cZo/J4iXK9QIjrPuO63n29ajlA8LuNJTXyJTf2wLkxO7zaKmTjvtg
         vnryNG3UUAWt2azkrydXN1SHBCLrVdJIS8QvTPpz/H0UVLgnyJ22Ng8XeTn9EAZ8GI1c
         DrmEPLm8lTzK7Qfwcozw0sYlwSrIl4MOYPewfvKRXQ195wgDSVI3QmmGG/cyAVKJ70bO
         ZPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365394; x=1776970194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PLeKkfzWHS5ML4Om9B8pQ3L/JlsStI2i/wsWT7w+17c=;
        b=jl8KzOZ+7zFlRqhsNzzDdJVnHE0SX2YEZK1ojP5fc2EkLmsMuRDWrPkWr7rCdQDeL0
         eqveWaROkK6cSDfQD6rKRYJ4T6LMM7WsCmuDtiYN+NYP1+CKrcc2twZoJMidbOojOoo1
         5s810fx3xuzpgE8hCZw4Z89qgV1szNxs4k4n6f3u3VU0VVBBFkR0rN/uKD8vxXgGTy67
         ET3EDGAb4V8DcDWjPvKKZldCpAPlGHVW0BzWKZJsahQGIPytjhCk1vrZnDWKC5yuJGm7
         rQfU891VHFD+agX+ApPCb4GvemdLm+A/r6lc4JY3KNCimxp6LMZzOdCuqNOADfBw/xU4
         zFdA==
X-Forwarded-Encrypted: i=1; AFNElJ8vogpGQOi/KR2LiJMztRJmKkKrfpHnsWKC2NwM80+L6r2Q1juvpyXjc9HvlZwziSHHry/HsKPX5Tgo1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuWAEMGS8qE4U+w+D0OkHIiAHMvMr8uokz2OJKPjOZ3BVRABvB
	x+/T2HCMInrC881Djb3zNjaZ4iwo4zmnjTHvSxIEP+t8zModhb1paQSB
X-Gm-Gg: AeBDiessvaZX3p3XyXWk0EjYBW86DPJCXmcrOYzkS4raupWMdnkNaI2vZflLfXiUoyK
	znoBj0d2mlHzwnDULcOGQhZHw+p6a9WGd0IdFaD1E6gLcERlCjq4IjX6no/hPtaAaqGbmkOHCwO
	3edqVirNSW7/4NyHSdWKf7Ul84aC4srSTuCDSb4d7cqcWbvJew1VpabXN6pNUCDmMhZEozDv+7C
	YbBXO5wZCnAq6Wg66PJfNPSzX5+m5W/jdq8w3YS60lkoAyO84VVltcsNu1HrPoU7Aem3rlb60JV
	D5jBq3gLJCxU4kMh3iD79A/E6C4pF7axoGVAQbopUvRRBwlczg+gSj/BinCFwRWXGkVong0JJQ9
	942hpxe0wBsp/m2zPa4bsD9PbOKHErtAlwXMSfPUSRoPV3tVhPc4pkGtRryoxNRJBKYYf4fWsdt
	7cM/JxhashSn2iTWuB77AUHLNyMP/XcUDzEZaEJ2Oz1SsrJyGKkuDMkVC/Y+WIbJ0ONVjYUeW5K
	5b/+46D7/bAuKB5Pkv9ce3plxXM64XlIrk=
X-Received: by 2002:a05:6a00:2283:b0:82f:6a87:f75 with SMTP id d2e1a72fcca58-82f888fe3f8mr508335b3a.33.1776365393532;
        Thu, 16 Apr 2026 11:49:53 -0700 (PDT)
Received: from lucifer-Victus-by-HP-Gaming-Laptop-15-fa1xxx.iitbhu.local ([103.151.209.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f69ef0b79sm5378617b3a.36.2026.04.16.11.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:49:53 -0700 (PDT)
From: Sachin Kumar <sachinkumar905846@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sachin Kumar <sachinkumar905846@gmail.com>
Subject: [PATCH] staging: fbtft: clarify TODO comment in fbtft-core
Date: Fri, 17 Apr 2026 00:18:28 +0530
Message-ID: <20260416184828.266168-1-sachinkumar905846@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHp75VeFZ7PDV_tT8tDibQk-VPkFFHsxiAHOAx-9Xp0N1ijvAQ@mail.gmail.com>
References: <CAHp75VeFZ7PDV_tT8tDibQk-VPkFFHsxiAHOAx-9Xp0N1ijvAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve wording of a TODO comment to better describe the
intended optimization. The comment now clearly states that
only the changed display area should be updated instead of
refreshing the entire screen.

Signed-off-by: Sachin Kumar <sachinkumar905846@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index f427c0914..cff838955 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -414,7 +414,7 @@ static void fbtft_ops_damage_range(struct fb_info *info, off_t off, size_t len)
 {
 	struct fbtft_par *par = info->par;
 
-	/* TODO: only mark changed area update all for now */
+	/* TODO: update only changed area, not entire display */
 	par->fbtftops.mkdirty(info, -1, 0);
 }
 
-- 
2.43.0

