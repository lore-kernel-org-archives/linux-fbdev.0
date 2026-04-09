Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3148A3DD53B
	for <linux-fbdev@vger.kernel.org>; Thu,  9 Apr 2026 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775745716; cv=none; b=A7Sod460++MlgfWJcDMIcKOhih5/yx3DddvVOB4RdqG68g1tWQbFmFCZ6M1xVaHBmrmxGV095aJ634KGjljB9htQsYAy0GMs/4alvQy8c3CEH2FmXnEgWfh/sucdawJk24HQbGggBXvRungOilI4/At0rE6qq3VEAMzPwrmyfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775745716; c=relaxed/simple;
	bh=+vHcx9lI7yya0W7s1XmjAsO9BEU7Hgjmcx7FM3fwsWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h6xZFXkX1Bgc9pYtfDEmLQp5slg4ENpCXBIlTXeA8WubedNZqPpjvuA2wxPkj6aMQPupT+hCfMp/EBQD+hNNhhy4Ch1KZzNmW9Hm2ZPs5m7HdtUDtZLPkbPLo1UT4GMvph+38fCOk+uvGPDi4rhJCZ6I1TuRdBzQOwzwmvYwQIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptaV7+lV; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptaV7+lV"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b4520f6b32so841932eec.0
        for <linux-fbdev@vger.kernel.org>; Thu, 09 Apr 2026 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775745714; x=1776350514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynn/Tv7vt536YLRzFScHBlkRRyfwxHMbDNUUOzExOGQ=;
        b=ptaV7+lVaOPFrmQlgWW2RICSmM+Hj2KIMdQ2kcVUjed9FSiIGY/Jt+L0fc9/XrgHa+
         emLpFncsasZT/BCNNrVlGRgH8g5BFHLJ25Ku44H/22oSHQA09oRhzpOfGecGpT3M97TL
         pk2UzNqwqvwxSlwh3Aww1fLdPzBxY4LPewoAab8lfIwEcqHPiudftHegQMCG2iFXqdLz
         p41+hfsWgW/ooFlAknPYouWXaE4PgDHoMJOpAMYLTPnzIOumOd/WAumcdA6nF9Ki2aap
         qtvrtSZ7NqlkTLIWjsykojQnWw/1r8z7olJ+ccqzy0FypLUjIlc5GwgH0BcpSmTimwg9
         9PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775745714; x=1776350514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ynn/Tv7vt536YLRzFScHBlkRRyfwxHMbDNUUOzExOGQ=;
        b=cJl4EwQeAxKTukKrgOAuPjghSw+Xdadj95aYxbl7rSwaAeGE9TQbtMq+2JGl2kDjXg
         QoQKaa1Pp+IIUqb9Hkb2vZTjFo7qyr/7bTfuL499/WqCXOmt8E8Fim5XzzYKMgIxariP
         6IbpK9o6iUbFRDM7yUOfvk3z7UMCoU2W+F4yNYwqrp4PYsKzR3rAx7hZpa4EgLmNDPjD
         U7/IlGPMcf0SjEhUxnpn3m0P1+LsdO+8s8sOBlYwh2inO965o+EpIMrbsWIHy64ux0+N
         9A72nILR2yB8rid/OZUGPWqU3Rkx3dtF8Kj771OK2wy1NLPr+DF+QGUJXwPVY8D51xYH
         0kSg==
X-Gm-Message-State: AOJu0YypkThYNF0ljDdbdS0F2/IAMpUwSTKRkJjiUawKbvo318uz9t4Z
	xDYQ7dFUjj6jE8U44LsX3eSCIz+2UTWwAQxojbflcsjN15hKoImtNTbv
X-Gm-Gg: AeBDieu9ebrQd0eX5ixUz88EgaMk7ul1SswhY3Z894/33cVN2j2B6MXH0sNcqVgdVIU
	hpUdTqWvUDLIYX6mXXwb9gGY4kw0qadRoWXv4oaedG678jas4VIJ1b8KAaYy6mb9eZoW3ioDjlY
	BmGrGiAGPEPew0zFq0y0xCqTg8MH6uSzqxm2oD9RovYVJ0bO8YKuCafAmqNb5NDhaoUV5ZTgiNX
	ecManecLR/1wCnxatQPd/PZGp7vJvqpqvwf6EctNO/SsS0GgVpF3WV9X7h4G11ibV+04uwCkBp+
	lZbiXTq+GBg3dr2+GLvP5vaHMSg8g/pmUUWt+bI1DzQsAWOn1C6wQVIzl1eIlwiCE2AvOcXzXZL
	SYzydi7R5hzTImsSYVlX3XGLD2BYXXqoM390ywnvSmew1GRM0ZkUOSTAdVh38OMIMPQa20QzLtt
	xHyXk2uJQn4x6Wxb87v0W26PNcdg5NvdgQWE5zXR9sRmZ4YKoVRFXfegXg/v4ZrojQ4w==
X-Received: by 2002:a05:7022:ec17:b0:128:ccb7:7fa3 with SMTP id a92af1059eb24-12bfb76edb5mr13072445c88.34.1775745713994;
        Thu, 09 Apr 2026 07:41:53 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c07a8703esm20363284c88.8.2026.04.09.07.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 07:41:52 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH 1/2] staging: sm750fb: return -ETIMEDOUT on timeout in de_wait functions
Date: Thu,  9 Apr 2026 14:41:18 +0000
Message-Id: <20260409144119.21500-2-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409144119.21500-1-dennylin0707@gmail.com>
References: <20260409144119.21500-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hw_sm750le_de_wait() and hw_sm750_de_wait() functions return -1
when a timeout occurs. Replace these with -ETIMEDOUT to use a proper
errno value and better describe the error condition.

All callers check the return value as non-zero, so this change does
not alter existing behavior.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index a2798d428663..3809401baa3a 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -502,7 +502,7 @@ int hw_sm750le_de_wait(void)
 			return 0;
 	}
 	/* timeout error */
-	return -1;
+	return -ETIMEDOUT;
 }
 
 int hw_sm750_de_wait(void)
@@ -520,7 +520,7 @@ int hw_sm750_de_wait(void)
 			return 0;
 	}
 	/* timeout error */
-	return -1;
+	return -ETIMEDOUT;
 }
 
 int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
-- 
2.34.1

