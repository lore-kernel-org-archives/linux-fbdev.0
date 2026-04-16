Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52925279355
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365699; cv=none; b=crw9vZDlwN4e/rfIqWNt5zXgXfj08lHAm5+/RykCO0aHRSL4xjz8k37/ucym2bK+v0BFd2Tp1hgzzd8VhAGJ8eQK4ER4bQzEo4J2coyd//lXhCg5as4MXw+wlBmhaCZu4qB7ElFyOvQqLJkgKJ+qQmMcAQpAZdYJiP2jWeHEDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365699; c=relaxed/simple;
	bh=sWyB99+5sBWbk3HBJIRsGP07PNoJQbqM/Utdxj2XnjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmUEWrMR/3eR65QLOrRn8Cy+8Dz8A2hV03nYQnSg6pbKZxWDLVKt6vLjmxLRnbbBp8AJNCVRNtlQTfHQ70ls8A6LkiF9aJ69T0wpTapMTnF8KRe6hfWDr0HoCSjYoYBrh81cAGlcXw6kySLvdeukZbj48y4myrQg6XNNYLpDQjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ccn2WVuo; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ccn2WVuo"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so5223564a91.0
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 11:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365698; x=1776970498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLeKkfzWHS5ML4Om9B8pQ3L/JlsStI2i/wsWT7w+17c=;
        b=Ccn2WVuo3eCc+DDr/WJoJbfqD1j3yNVGZpZpocI4pFq/oS3UwgN+IaOaLgH4MZivYe
         4fNNuj1xaCBlKaqAG1kviqVrcytyPY8a0nZ4Ko05Df3QrPFfLgVfpu+EYzT7NPwBH93N
         XDkmzOrO9kiOPhIV3T7kntQP5I6M8ahqo82IFLNrAtuWECi8mL2/Isgi2EPeCN6vmi7L
         ahIkZuqitL/1DOaQj/D+1ZVdkWp6oPOBASB+6I2RQ9P66yAs9j9JsqYrqgE8xEifhHos
         ggIHWrj3QtVejaqp8P5afkCHDsY/4UpH97UR4WmcYTqbJcAznUl531y7RLXJd9RBuWtQ
         NQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365698; x=1776970498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PLeKkfzWHS5ML4Om9B8pQ3L/JlsStI2i/wsWT7w+17c=;
        b=bOCOMRwAerXSPw9BhfUHaCg0f7CtVZasRu4IdGoWIermFOcS1DqFIKiYaIeu5GsItM
         rdNzX494u6YPHKKnGa+JxW6sO0mM18WmLnMpJY3huaNpII3Hta7FGDSv4XCYo5w1apLq
         W6SpD7lD/6HTFLrYud2XsVVGqRSf7/Uwi1UMcHWkjaSKpA5noK+Gr5kMmV+59lPoJ45m
         agzxOAMaVpnWdR1sY5z4WOGRU5oo9w8jvkQhxDzKu+KjsF/2tZuV4jEk4nJ++tx2LnTy
         ig8x5Q/7Hlbcx4Z9QqeE1oLJIaGdSOwCHytrWmz9wKbtuqqjE4TEeq1IwFliuMggzVW9
         vbxA==
X-Forwarded-Encrypted: i=1; AFNElJ82f/sk5i/42ku8cdqfBeVQEfPPZHetamGAYx21wqUOa8VgfI3568Qi/h346Lrb6PTsJuVdZyIIol8XPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmAT6TJUuzS4AxS/EQEC1B/F35q8jrju5KMI2D1i/H+zsxvXyf
	E2vnAopFB00R2HW9IA6LaOUERC+Ko21dxAantqvQI5EJbGehG83lrBuzu0FoYLGXYFo=
X-Gm-Gg: AeBDiet72Ok1Nd0Kls1N5PT3GjbAOZOciEXhs2ZaAPb9pi2yKWsWNMWnnuSPERKoeux
	PSElU2DPnZqxLdorEtkmNjNzzrVpkrHD20FQ4p4JfwpKHScMyPKefBwMx+KLJZIAe8DGsb322E5
	BGQVDgil7skQZRlnd8bla3iUnBifJY7py9aN3fAg8p5rzbvufOv53MFW2UsL1SN9YGlWYp821ZQ
	+Ca9l3jdiQSEo8BS+4flQf27B8+ZzlL1qFxdh5iLZv2JxDA7iqVKpkNOqbDHU7DUKVyWwXLW875
	kl8h1IGCRUVmjkaC6lYOYQCn4nMyx0ZI3vFSpZXoWGuIqnbW2mnVpUmFHiHRf8u/sp453iseNbX
	//tN7+NbG3gazTij+OMFRNA4sC2rIWWgtK+i/z+pxjQrs12IwYktgnQwj5331joOMww8ussSujO
	B5IwSM9+qiJfFmfh1ed6h131pGvjNBZDgRI5LrhnjutqRG2AHywWYtwvYKPlNQTBsyeIAfgH48a
	IPP76arhhZajWKF2ZWTOQ8EUdPqYEsKeP6w78Xy9ZwZUA==
X-Received: by 2002:a17:902:8214:b0:2b4:5e7e:34ce with SMTP id d9443c01a7336-2b5f8f6674amr1059555ad.39.1776365697609;
        Thu, 16 Apr 2026 11:54:57 -0700 (PDT)
Received: from lucifer-Victus-by-HP-Gaming-Laptop-15-fa1xxx.iitbhu.local ([103.151.209.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782ceb25sm64369245ad.81.2026.04.16.11.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:54:57 -0700 (PDT)
From: Sachin Kumar <sachinkumar905846@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sachin Kumar <sachinkumar905846@gmail.com>
Subject: [PATCH v2] staging: fbtft: clarify TODO comment in fbtft-core
Date: Fri, 17 Apr 2026 00:24:38 +0530
Message-ID: <20260416185438.273165-1-sachinkumar905846@gmail.com>
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

