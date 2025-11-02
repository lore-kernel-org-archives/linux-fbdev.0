Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537B71494CC
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Nov 2025 23:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762124518; cv=none; b=giMPtwBkfnLpSf13xdpKAY67CdXtT5OA1LsVB1VGz6+KHwyR8cmhqJOATV6vD5ehvzlNu9E7ciVZIxcpDSHeGmp4bSLB9H1FJEjjmbIErFEMs83pandqoLHcGRejwEv99gubIKykA72PCD/wljobAaocxnvd4p/EiR7NASumdig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762124518; c=relaxed/simple;
	bh=GfVeVjIlMgPT+UemYVUldkkWYQW4Y6aC+ZVdDKwyYkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rj/PreT2XmoJlrUXI057gYkN8E7moYDcO9q5Gkrx2eQchLZe5sG8BcW6Aw3Kv/lKBNm8sQAx6g3E961Ieb6nuHpKMRr/EaWG2a+hCsmN5TN8w+ZvOW9hG6lGOn8QN3PWXzfklCtf20gwCdldeiAGIxUC+lwiOBSbQaIaptZIMyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUkjDt9R; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUkjDt9R"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3de7e765439so250392fac.1
        for <linux-fbdev@vger.kernel.org>; Sun, 02 Nov 2025 15:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762124516; x=1762729316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZdylP5ZHtnXQ+DVmn1YWZdzLTkE7lGMQKzASiLTEus=;
        b=MUkjDt9RbHjVyAkU5gXQuS9G/kixy+7cvULzbNsDNBuAcHAzLiu4AO+3SNwVMRVX92
         ErLxSGl3o0hf5l2sJ5OKu7n2i0xA+xNCasGd/1StB/o1U3MA7YIW6AlXaONjfQJpG60u
         PyWh0NJ7Gqfdisoe/IT+BfSLkL1SYcNCqYNWbLTT0JCfruDtmiWFVwQDveGDm6pba3VX
         2PHcoES3rPDupapC6A0H/+iC/XGggZMVYFkZ3IXmzOiEi/9UeWU3dIO4dtTIVOUrXGQn
         0SXEyg2FgakqojF4b1anlzEy8aAqp+dyzfgdsoyJwQ+pN4/XdyBW3MuZldzb2aJvIpoH
         359g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762124516; x=1762729316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZdylP5ZHtnXQ+DVmn1YWZdzLTkE7lGMQKzASiLTEus=;
        b=VWlJrhbwQNer5eilIdeQLpEGrHp2DOB6RQrx5mtBb3p+tN5O7BVUWGGu1fexfZF3Wk
         vTrdeEZNhKeSgWNsb8ldo/f0mcKqEWA3XSL2WkxNRxiVkbWTEP9kzOKKx3zMD8hwCjPI
         59r7whSL24I1ghK+1BqNvujzJkQZvOYyUaJ4Ih/cLj/ZXScD3zwpbOIYYFaOLjN3JZGX
         iydB8BWXpraAt6vunlf+oKYrvu4+U1ZV1W2OmCeEPR1N0WZcBQC3DFjBHLJM6uyCK+al
         b7mKJOZjD/KR7mJD9llCOBwIwfSRT30bv9Ul2UNchf8D/WHfYdclzx0SDzl9jh1gc+33
         85WA==
X-Forwarded-Encrypted: i=1; AJvYcCXFEi5ZMH8OqDzSwm3+Fsvn7NAtshrWtww/TMDlOhv8N4qfTfjdyiWxz+tI30uth7MDUljmG6JvSyXOfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWyRaaRYEGD9ehIMiMv1s0qUF9QEA0PdO3NbVcG2EwhIZDNYmE
	pmkn/Cdo+FV5gFo0OOgiO4h21XVmjRWdjlsf30YSAJ8ipnF8ceQ05mKqM8cwUHCSZbA=
X-Gm-Gg: ASbGncusqbzAK4aNZDHBg+M45aCWqMhCa20eSe65SRFwoaeKxdzp1+7jrmXZmsJNdIF
	8S1ig91SjROWlCWezwGjdu4ioRxetm6dAzh4+Vh+pmxBVJLzt2++RxWUvb9HaPATIgF+/eQF4eh
	Gz6BCRomiQOdOWHM2CmGlFgqvv/pDCKmCyiYzZQqS+ovncz8PYQYhJ/JdZdtov5W1XHi4FonJ/2
	o1smHIfmv6R2rPAA+fi+bRysW6zFqUQn1+l4jK6bvF4TgH70DMBOeOD/Q2dEqHMDp3Z2feBAl3B
	eL20glYGyjpW1Vo9V3YzluhwT505XaiqYUoLLvNSnVqVb7GdJGIiE9w25hPXerAcis1gpdeveNU
	4gNNp8VCm/OtICDWKKKtvfIS8ihHh7G4PRoiITLo9EQQcyXJBvRippAe6LUuwD01YK1oPPEvZBs
	4A19gRgtsMfB2/U0iNt/HJZZGeWAkmlw8=
X-Google-Smtp-Source: AGHT+IHxfEHo5U2Vd+PbcXp5r4xXTkBS84lXTZLCP09zNu4A/UZWHNNp54bKGFACytoMbouth6qfew==
X-Received: by 2002:a05:6871:8012:b0:3d3:ba60:ee19 with SMTP id 586e51a60fabf-3dacc9e2d35mr5145141fac.42.1762124516282;
        Sun, 02 Nov 2025 15:01:56 -0800 (PST)
Received: from localhost.localdomain ([104.247.98.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3dd9a924727sm1210628fac.15.2025.11.02.15.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 15:01:55 -0800 (PST)
From: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
To: sudip.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
Subject: [PATCH 2/2] staging: sm750fb: avoid chained assignment in setcolreg()
Date: Mon,  3 Nov 2025 00:01:39 +0100
Message-Id: <20251102230139.1720-2-cristiandelgobbo87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251102230139.1720-1-cristiandelgobbo87@gmail.com>
References: <20251102230139.1720-1-cristiandelgobbo87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the chained assignment of red/green/blue with a temporary
variable and braces. This keeps behavior identical while improving
readability and satisfying checkpatch.

No functional change intended.

Signed-off-by: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 9740f2705679..fecd7457e615 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -537,8 +537,13 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
 		return -EINVAL;
 	}
 
-	if (info->var.grayscale)
-		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
+	if (info->var.grayscale) {
+		int lum = (red * 77 + green * 151 + blue * 28) >> 8;
+
+		red = lum;
+		green = lum;
+		blue = lum;
+	}
 
 	if (var->bits_per_pixel == 8 &&
 	    info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
-- 
2.34.1

