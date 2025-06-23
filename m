Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713EF1E3DF4
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Jun 2025 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661101; cv=none; b=A9pqhd4jKOLnqOET5MxjVcIywiU9BjpKNr/b5cawUYV01seI2A1W2mThLTDmBUY9OG1HymHh0pFa5ry3l74xBFziduwv8Smk9q4/5+QCD3j7pWISzBh0oMA+qne8grMG50VKfsXYwd6GoIMhZUkmdLRlf96Wg9m0adAX7urh7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661101; c=relaxed/simple;
	bh=D5wB8GTFVDuCJiFhGrONiRmhnC4J1aRZ8kfkMi+2S7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IN3YrLR2eMz1VYLr8WCi7FoQUr5++OFMnrTr1Bq90Zf86CuzaoNGnfrrDn3GNd+jKCME8cTj67FccAYfnwUurh/ZBiYwgJB9C68P3bCIRVICfGjCDORfhhpLAm1EI1CJnC5ow/MxiFofTOdg8I1PhRBcHDNu90exz36zkVoyZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=c/w3szZ8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="c/w3szZ8"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adb2bb25105so611281166b.0
        for <linux-fbdev@vger.kernel.org>; Sun, 22 Jun 2025 23:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750661098; x=1751265898; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbu48gx7NEhId69+qzMyPOiXCZJK31FbL3aO14F5yf4=;
        b=c/w3szZ85ohMGqFSsB9gaUZl9R9aJ9UCT9FESYf62/xJm0K0LI4gWQCsZFw4J7tXSC
         IdVgyxIsf4jtHrqnZgsRh3Rals+o8eJuzZcxB3H4jb3+6YLKsPV0HGwy2UBm+rjpEHSQ
         Hp3jkP/PsKYs9G/MhU+J200fIP7XP2ylUr27dgZ3jW8ZOPmh1f1Lb+q8Z5ZefKdcpwkU
         B8Pzrx2DU3iTHhvesHUgvAca0+eTdBiXW7AeA+h84tjz8uAc7Kt//lIFXHqJSAoO8UNV
         c8DzL8/sLbkx4QqIMzNDEeyfgjHU/Vj8PLrU0LtdxgyiGG3xKo5XaY4CRGbKWKsQUduZ
         h/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750661098; x=1751265898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbu48gx7NEhId69+qzMyPOiXCZJK31FbL3aO14F5yf4=;
        b=TyL2NimTA/xdatY7Q+bAELIUMaULzJfvJchGyS5CRVkivP2vbHl6WCkuBxB0KYEf1v
         yrS0IrS14+5+i1z10Fiot0VjsAVPG9GzaO3bo4gx476caJoQH8TFV4U7jA49T+jYBSyq
         QQyTHOW4YVBoq9LdBbqNs9VcjCoTDw3A4v7JhV8ape6OBm7G+V+r16W9Reb40g7dJ+xD
         UVMyiyFARTs2LRuOxeGN4BCo7uEwBhF07jIEVi661TFBjcgHyrtF2i4fbv4+KrV82MT9
         RhRodY1qZDhtHf46P8aOWeFDEYbjSkl7wao0ganLMweWuNUeSx2zl88gXyyO7JDFCbuc
         /2iQ==
X-Gm-Message-State: AOJu0Yy9bAMuD+LmCwwARmnnq+h/m6DLUS/pk2cBbYrlmtBRMzsGDUpY
	F8P7q5dn0YAs+k5IM+QvsEMfCW6OYnPTg9ics/5CFp+0xq0/XzMWRv41UxLdqNgvji8=
X-Gm-Gg: ASbGncuwZeKbIfZiJOd01MqLls7KpOWBnzRaRm2gwBnpytIhluiSydUV+VURLx6XzFl
	U3OG9e9gWEAKjjzpAO95R3x7MbCD9X2wm1n0JdCIgiYIAFKlflPHwhHUN+xb8WxtHvxbN2M2oxa
	53YCnr5s8owhoMWsWTOAzU4tdRxP/PtQURYPs8t5SHSkew4cjpSKNFgq2TmLVU6LE5bL/eSirXL
	2ZP9heQFu9r/YJXrcZGy/VnWHc8ognYUr2W+0cIgJRfPX2M13I54JHRYrlv/aLXQokXDEImcYAM
	rfPtCjDbKlgm1rUYbtiBsaLupG88y2RZkIFGsLaJGpcLJ3CJsNvEMhQnReTuU6ILRnPcL1BSAww
	fky5yzQ6ZqZ5SPKgB3xeIUG8V9YlW8W0r
X-Google-Smtp-Source: AGHT+IEOzTOG7c7R00rqnL+INk5sjS4mj52ZR4xU1BeF+DiFIb5jKd4us01mqAW9xyhdkYM3Dd47pg==
X-Received: by 2002:a17:907:fd87:b0:ae0:6283:5d58 with SMTP id a640c23a62f3a-ae062835e1emr846280766b.1.1750661097735;
        Sun, 22 Jun 2025 23:44:57 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ee4ce9sm659258266b.69.2025.06.22.23.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 23:44:57 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 23 Jun 2025 08:44:46 +0200
Subject: [PATCH v2 2/5] drm/sysfb: simpledrm: Sort headers correctly
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-simple-drm-fb-icc-v2-2-f69b86cd3d7d@fairphone.com>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
In-Reply-To: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750661095; l=812;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=D5wB8GTFVDuCJiFhGrONiRmhnC4J1aRZ8kfkMi+2S7c=;
 b=NmoLdHl/zy8/Ccu5xTGjwDXOdaQQcr3O/5YtL18RtixZv928CEKzL1gkps+b4W6pfu7E3uThf
 DcKk9lC2NhrC1nEiqi8avoRWgJ/zlM71+o1oVF8JKPfU6UAHI/If7RX
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Make sure the headers are sorted alphabetically to ensure consistent
code.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/gpu/drm/sysfb/simpledrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index a1c3119330deffc9e122b83941f3697e5b87f277..349219330314e3421a6bb26ad5cf39a679a5cb7a 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -2,9 +2,9 @@
 
 #include <linux/aperture.h>
 #include <linux/clk.h>
-#include <linux/of_clk.h>
 #include <linux/minmax.h>
 #include <linux/of_address.h>
+#include <linux/of_clk.h>
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>

-- 
2.50.0

