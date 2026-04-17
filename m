Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F735C19F
	for <linux-fbdev@vger.kernel.org>; Fri, 17 Apr 2026 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418420; cv=none; b=GGaCO2od0cluaHNb6eR9apmgwtHdXF4VSTjOL3xjlqTxGxffwKnkaXktbbDoBbSZ9sjKEkGTwn/hlAkOxOJDjpxUwTfO4ny714khEozuIZx3n3cUK0dWSbkdwvIXwQbZcxGhMTXpKZG9NsfGIRMa5yOVXOqfv/Wu0Jud9LYavoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418420; c=relaxed/simple;
	bh=2Otf4kXRw2fvNYPA2gD8YpzlgN+/Q3fixkyMGHGZlqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTdZwqfFAH1yuWL9kIT4lyNinULflk18lwwOv963TQsBVqA4M1R64SSBlz5cTCajKTAtvoaEswTd655Dh7Y7fEsFmvYT4HVMurV7SvAh+pXm9Tc6pcA/wAyfkz/0NYu4UpLD1LJeEgLoLrYUrmr8zBIZHwrNBI25iykvMPaDk88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/gNzmqR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/gNzmqR"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36143b0dbdbso149479a91.2
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Apr 2026 02:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776418418; x=1777023218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMX7hr4YVNh8uAt3LdTcIDPI1RjqIWFFZ3Ztn6YuqVw=;
        b=U/gNzmqRbsYgAVhu35eqr2GXJsJIhMo2mR5AS63MSmkmODIXyUadUZoOogh6OER+0m
         9ODlpMOAIjCkymsGB8qWzkcSMJPok1obLTwxAwy+vmF3NZG2wVpoo1FxgpjE+iX5bMTe
         wtx9TkhWniY2owcqA9/jy3Fkg5at8DNsRpo5mYP0uOb5yfatA8YIymbMZLRR/nTsPN7L
         EtzE3msgf51k/P+VmuTtVlJgThJsYyl6rpQq9e52iul3GWDR8SjRm8md4ohzs51D4XCu
         ZazA6Q6goHSd1JY1zHFhIHJEOodn2gTQAWkkYD2YJjJCMD8l9JR4+Vu6eOePZA7wihYo
         w2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776418418; x=1777023218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vMX7hr4YVNh8uAt3LdTcIDPI1RjqIWFFZ3Ztn6YuqVw=;
        b=T0NMVBE0WQwyUxdlSmeCFlcObyGXGFYBalu8KDzldONbZl+8gBLkzxBLy8sbpl2TU7
         o8+eTZGahAw1MKq4qVDMU2PuaE1eA17lperxNrOgkOoo43saU9UvMLxfbcpd7CcO+vPs
         ycaHpLiHQvrepNS2JZn2fDnEQzli3Yg0p3GNQ8K/k3uCTW4TorjdY2qX+qhGfaf4tubE
         IiHhCmLNvp0lOw81aaY9zCZYRZpHSE7CJH2ffAH3dc7u0felR5o9DPDqQP8bYd7sDNXf
         iG72ByDsn7801N2XSTOg+7hrziAZLP9806ErOd+VuVowSaLjb0uDaUBR4os3Oe4fBKpZ
         ALBw==
X-Forwarded-Encrypted: i=1; AFNElJ8R+r3dNN1mNMoOc/XLhXAxNwxIpNpcIYZcFX1EbgIVDQa/BSHmADAAJTYV4lYT9x41YtL0WaUY7vuy8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrVQJf2ZZAZJeYZZKx7QkPPnXn9Io+d3dP5li3nOk0Apk9tdbI
	uZeHQFRCvvmksQItQPNBsxp88AfpQEPSBccPgVac8KCO6Qb/V9gBN0qB
X-Gm-Gg: AeBDies+RnDR/RbXlWykF5JwNk5iNMwt5zAj6GQj7maXm+vlDpbQcAsMw8kH+wt7rtO
	AjEvHJ5RLD1gOU46iFjmIjTI9ztKL9q/SDymTIR9n1mLbrD/hQYianKRtT75gw2Xoh4jrf64nUi
	DXMTUVEt2cceVmdZOwYiJtv/kCisN6v4m0lNHxjw+TbbE7VBbupbks1LuRWKc4l1hCOS80kQoSQ
	Av563G7kPff3zeHVf+p19Mz1UjQWIzbmDX+EkyGB1pOquKLL7y6nKuKn/Mf88/3d09M6yryynHD
	rmnYcFBHRMnw2jk1qkeKQ95A/NqEAR5eH0KR8IGIanxOHALgq9SHRYmwi8b2m/TTGhNAdrMh3rH
	xi6ei4pKJ9RuaICkQn83pbClJc8zJ7gmzkLV/fYiLYv42h5ys8riq6vqas97V8oKEATHM6Udl23
	qlHHt8kROWLfoTYIGs20D/STqAh4Btn6dC3YOHGakcULMFFNiEVeEseYqtWgnk0/pkupyY5GEUx
	GNBEluyi18AOtWDkpBU7z9DhHZtYU1f+9Y=
X-Received: by 2002:a17:90b:518f:b0:35e:5051:fb13 with SMTP id 98e67ed59e1d1-361404a78aemr2176490a91.26.1776418418422;
        Fri, 17 Apr 2026 02:33:38 -0700 (PDT)
Received: from lucifer-Victus-by-HP-Gaming-Laptop-15-fa1xxx.iitbhu.local ([103.151.209.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140ff2e1esm1410806a91.8.2026.04.17.02.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 02:33:38 -0700 (PDT)
From: Sachin Kumar <sachinkumar905846@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sachin Kumar <sachinkumar905846@gmail.com>
Subject: [PATCH v3] staging: fbtft: clarify TODO comment in fbtft-core
Date: Fri, 17 Apr 2026 15:03:03 +0530
Message-ID: <20260417093303.33670-1-sachinkumar905846@gmail.com>
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
v3:
- add missing changelog for previous version
- simplify TODO comment to match kernel style

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

