Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF473EDADB
	for <linux-fbdev@vger.kernel.org>; Tue, 31 Mar 2026 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964659; cv=none; b=UGbistMfRTdh9jT9/2laPQRVXbMkyn2ltAVb0vvzP/Dfju/UcYhm6cHBVb2rfWzsRdpKdGEfKLxXTkaNqSVtR25tb0RZK+2AzIkQ0qa6WZ6FS69HGCPXpBsX9t6qohPEQ58JhGk5iBh/XSBZIxGEMQi5mFSq83xeHuhzR+6Rbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964659; c=relaxed/simple;
	bh=ZH3kOGmDEO3gADrpfp5Lcv221yGM51+kYEM5K/9HhGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j/+nlLKY9qIvyyu2kleRY1v4nJLgwr7XflEN5BkSIQcpn+xS1gFNcbLplRDWgdlXCN4VB8gPP1bx/PK3s8p86L+brUar5zV2in+TGjtxjV3jaQUs7pI02c8rKCDPFA3Y7nSOmZ4OA8XWzCbMUu2d91CkYmK1XTdiVxRvPxQMbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWl5edkj; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWl5edkj"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2c4db6bca03so1361911eec.1
        for <linux-fbdev@vger.kernel.org>; Tue, 31 Mar 2026 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774964653; x=1775569453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyvLhjVhNdQz9p6/7OsJVs/MzdJnZrYRiPF9CcTyMdI=;
        b=HWl5edkjPwyx6VMz7OxpklDxyTpo25KfQm/GPJ140REnKgzZJNUwdr4Dzhfjq9kdMw
         iUd1FWtwlsMik6oMgsgCUDBoTSlDhi5dww5tTVI3yStJQXAFnP4Hlnqo3Xm19uM5zGcA
         /+Aat59EpN1PsSLJ3EBkwPye3064Dv8wgJ/JQXEP8/+tthUgj2SYAJbvuC+zuKiQZWHf
         yi/brOp/FtPX06dS8dORU6y+43oq+9oWlFHUHSxgIRNNzInq6XFPfNnKBfBG8qZvvr5z
         eODGqQJY6zK5Nclaedqb1V3XAK0LxPb2MO1CTZinpUt/7J+MzMxmDjAfQLq/u2AO3yEZ
         PriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774964653; x=1775569453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LyvLhjVhNdQz9p6/7OsJVs/MzdJnZrYRiPF9CcTyMdI=;
        b=catfcH8Lw+01o4/RPEIkuBPVaE2P6115Ch3F1YTHqZTv0NF+cnm7NMve8FZRYwA1R2
         C8BQLNAuu3rD/wvoXVeveUNOtrlx/cY4KOYyxAZWbuXLUDRtOaif/Wvc04mDuTIfncAk
         uCbBc2ntXU5Kr1tWzzPvFNu5kuBJLN1NIBlXf9pth9HUXaVYPwmqYgbUThDzggfGrVj/
         93G/U0cpXn+F/1oAJl9cGb+pHe4CSkHqHkeE8jIW5t5hlPdRvwCKfCNGa3yVBxW1Y+BL
         VmMUP/cV4n5ARJuCmyzu+/NWw9LZsa+TmWdTZn5lgECxjXWR4zBGfN+KuRf/sIRJnIAR
         fLJg==
X-Gm-Message-State: AOJu0Ywa/wVLos67tSlz8jq9l4WBFfgK5vy2lAqF54OrVQDTLGgWF3PC
	pRCjItVXjtCgww++6ktDO+T70veEu2E5wt6ERYtInjkgYKB5cj9snEaS
X-Gm-Gg: ATEYQzzRu9xDfx0fr2wvHN9XC8faxRkW4ZrV3fnUNdoGlinVzLdl8E/Ft2hlcXNPjqx
	/G1jY+ck58R/gJAUhvwKWF59lVKA8lLLi7D2RldXmJLWU+V1DKpray0XS6f0sKi9ItmzaNGqMcE
	on445Px0Cta+iGN3+tmyW91Cc8zB6npJQtQ9lUKNel8MTDLc3p+TL41TRDutJGCrib4tOD0gxKD
	gDgTo1T+3qMHXPs7O84rc4GHvgUrf1/6AK3oIUOAnLxdYykDknILPXRQ7IAHjPE65uRHOZOTYFu
	7FZBoFcj4w1feAzmuVPAcLbJw5h1Hd3kFZiKcp6v4TLgZLRVR7TXLnnnNEl9Oeh/4Qt4Zss/1Js
	Ks0Gq4cXMauTx2uWx6dDccmHtTzg2BY96p/jeOmhSxwJOzcXB75wA7Zt7qtjjoI1Vu91VMF5oOk
	wUgwWgIJoghXOago/gEk28/dJ8YP5VaxoC7iXiidEtI0u686l6xFbAsvZTp200IUuxJoGcPQaci
	IuwYDddtIWNlQ==
X-Received: by 2002:a05:7300:d718:b0:2c1:7480:ff9b with SMTP id 5a478bee46e88-2c7bd4704eamr1507424eec.18.1774964653067;
        Tue, 31 Mar 2026 06:44:13 -0700 (PDT)
Received: from localhost.localdomain (58.sub-174-193-131.myvzw.com. [174.193.131.58])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7483ffcsm10002469eec.26.2026.03.31.06.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 06:44:12 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2] staging: sm750fb: constify fix_id array
Date: Tue, 31 Mar 2026 13:43:49 +0000
Message-Id: <20260331134349.18998-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331050738.1547-1-dennylin0707@gmail.com>
References: <20260331050738.1547-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the static fix_id array const-qualified so it can be placed
in read-only memory.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 62f6e0cdf..795e9164b 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -740,7 +740,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		"kernel HELPERS prepared vesa_modes",
 	};
 
-	static const char *fix_id[2] = {
+	static const char * const fix_id[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
 
-- 
2.34.1

