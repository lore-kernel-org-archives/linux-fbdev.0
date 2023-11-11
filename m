Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E7125A7
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qqa01oJE"
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C03346A3
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:49 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so454683866b.1
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699368; x=1700304168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fPpjqbZXDXnwfpqh3sU0UKiF5sG/PgBCsBX0KBupbI=;
        b=qqa01oJEJHpp9rHoh5vg7Qq1KNdMCp9dlgvZF2IS1Gh2tY56HgjH54JcSQfIoJ0txd
         rieCF/lk+6uM2wQ2U8WhhURh6kTFbCasRFjc4fOCBHCRPUIGw6Z2ir5aXoo/mTLqyPl/
         /Gz5VEeW+XobZguHmXCHMEnK1lLx5uZYEVc+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699368; x=1700304168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fPpjqbZXDXnwfpqh3sU0UKiF5sG/PgBCsBX0KBupbI=;
        b=wzu45Bli4IaKTBe4m/oOvonRBahpFEjvTD8BAJQ4EDh1+OzjPhyJRy4s8DUJfdPNrL
         Co5bGQWOc4YEqKjdctgG8TilimJ1EeznLuwgV2bP6kOIt5kHPK8OtzZQxh8Vilphx0a9
         RGGeE9bDUYbagXGxno9n+xXfk5ZCfLPab5UidfeMagafjMkO79oZ31pJtiw3ORHFOIdf
         K/JriQX3tv+ditsn7uTdqwvK7H+JkkMQkS8sron69c3k2v/SHPLMpgxca7h5TlHJDw3B
         NdIiiffT9cv6zXLx5Dajk1neFAhYtVjqEIaE3t4YfISWU5pMrdAFfT65s9ahgyK1rRTd
         l8QQ==
X-Gm-Message-State: AOJu0YzsPbMpWqFerK+0dlkChPCR1a0bVIzgxnGDk9MkjnEat4tQuFfe
	beJgvppAa6CCIeE5kmfJkhm0IA==
X-Google-Smtp-Source: AGHT+IHstjBS6znxzWZl5i2bWmEodHYLi43ulh4NK9b9RQW7CPLRH4hNONaMe+WD/i4AMw1LubUCfA==
X-Received: by 2002:a17:906:f247:b0:9d2:bf19:88aa with SMTP id gy7-20020a170906f24700b009d2bf1988aamr1056461ejb.59.1699699368178;
        Sat, 11 Nov 2023 02:42:48 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:47 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Helge Deller <deller@gmx.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 09/10] fbdev: imxfb: use __func__ for function name
Date: Sat, 11 Nov 2023 11:41:58 +0100
Message-ID: <20231111104225.136512-10-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
References: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolve the following warning reported by checkpatch:

WARNING: Prefer using '"%s...", __func__' to using 'imxfb_blank', this function's name, in a string

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/imxfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index a0172ff75c46..8d6943f0bfca 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -576,7 +576,7 @@ static int imxfb_blank(int blank, struct fb_info *info)
 {
 	struct imxfb_info *fbi = info->par;
 
-	pr_debug("imxfb_blank: blank=%d\n", blank);
+	pr_debug("%s: blank=%d\n", __func__, blank);
 
 	switch (blank) {
 	case FB_BLANK_POWERDOWN:
-- 
2.42.0

