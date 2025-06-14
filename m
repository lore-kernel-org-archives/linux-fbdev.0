Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6323DE;
	Sat, 14 Jun 2025 01:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749863003; cv=none; b=Z6+1tmy6U8+508jCqyxzScq1Y8T0gn1xqQJywCRT4tTFb/pYgb/XO7J8IPOzOWl2lv28qM48yneyCaKJk4K7+I50TToWRujPNqGm1tEDQE+gK4WsCC1PlNo0odVt8vfhh8SgVCAXQyO2IpYOd6HmgbZ30llYm4/VU/XaYgFSp/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749863003; c=relaxed/simple;
	bh=bx9XqlOPG1HpAffebukwlXEvNCXYob8Z/P9udGMfNkM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LDDumcGUu6DgFh/2f25q8zOgzqOOfeiB4WlW0Ll9pERCXi3nAWLZqT/urqvoWXjpIIP9qykXiBwuzfe5KOmD+bBnsBaMuqgS75jNsmhH2NeazgDz2smnt0fUIzzFKd1yLfGgUCMdyVk7Uwm0iHZYge6/U2jRZ5zfjhP5rnchvRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzIOydXi; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzIOydXi"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-708d90aa8f9so26337157b3.3;
        Fri, 13 Jun 2025 18:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749863001; x=1750467801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45jf0gP7QjTTPLFpULqujGZqfZ7lIP0Ebdkf9ozISuA=;
        b=kzIOydXigTBX1NH3c/452LLONv/WxtD81iVxGSh8De4dAyVqm1ccxyydYh2b3W3I1D
         U2tRvh21zRu8i0dZ5K7NNaMJkX59f2xgcLsC+Ow/T9NowaSzdsjQwjbjzdpJssW1eubq
         MGJsyCNN1S1k8wBKmtYC95kxHknaaoIGdQYwALjgL9O4PAUC23W25HL1ga34OLwiy5jH
         pVYEYaYwUi93NPLbjwSV0uhXNkUjwqmf/T8xZvAJN5AaMpdxCKdRzmc7JhtiKRse7Haz
         ALIM9LIM9JFsly7El+Aj2MlS8SvL9dT5tKMXHsmBSqLwL1oBveVUJXUTZ+u155iuuDiP
         uzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749863001; x=1750467801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45jf0gP7QjTTPLFpULqujGZqfZ7lIP0Ebdkf9ozISuA=;
        b=uPTi2xjz+8W2XV7cQ3pXecDIjJpiqzUtCqSn/LtDeDSVl7ePWC3ZIizMaKhTiPSd4u
         geW3ROB4/GXEEJHDEvTkhwFWLsNT0XL6ho4FnX/J4phYRYdQnRctgI69MIXegIwPln1e
         frE+S9/1CW+2hi75ioS6nBjDy8U90zEDdbC+79gDwei1eompWBAQaBrzFc4uORnp6Zz3
         zNYi7tkAX8PTTYCXPvFHVS6ZZ03RcPU3Q4zYAffATuTry96a+zXp0EAasUZCaov6Tf6m
         hMhy4DBZFBcsfXr+EMDqhjxeodOpfWaV+acIwpwsxVcYpDazNiMQ6vyMAKBUuJlQYApm
         jv2A==
X-Forwarded-Encrypted: i=1; AJvYcCWW/tcVdyaf1VEvyVJ5wXwt+mimtOCwhrPfNECu6CFIhHVyeO9jpMXCDJn0f3LY/brhsA+BvE8VQrwkIQ==@vger.kernel.org, AJvYcCWf+abiFoqKTmhBPotGGVKBpHc4L0iS8VXDyX85QFasJ2+DrQfTBAWN0amPPlbFgrsK6UGMy7KsH8mY+Ta3@vger.kernel.org
X-Gm-Message-State: AOJu0YzH0+xUht1TBvxVLk2VtT2ETN6gZnkBr3zfQU/nRKklOvXuXoBd
	7CWRmE1HdiqsIt/V+IUieFK/KpponH+jtfMRDBkKEKE7fsyRQnV9UwcJxJUJj3Bw
X-Gm-Gg: ASbGnctLoyCgvgekEbeaY8fuzf6SmSUJwTLIaJTuzToEE1b06D4mreF/C+IKCxIvyBj
	OQF4PBaFepLDTKKGbHnp4gZIjtwj69ikEwXBJtSQ0UByWbhNZNT36p+lbHRD4n838M8Z5Z02WHe
	pqdDp+ILQAzD8BDEvA+65pDE8sERl94utPiYAvtfan+aYH1p9ullV4/iCrPGiR7OOQIzhBC/2Lr
	w1IT3jT3GZQ9iWIPwztKW5yhrJSxglMn6AcaY6gFuzovq877UbIMI4tXHL228R0rkD0NZ1ntbDv
	tJjvKVngPRSxVFipFO3rfD4wqlpEn3dBg0uHdfmgbucfv3AtOrdXUUIdinWZAPULW1g+iP4O/tO
	S
X-Google-Smtp-Source: AGHT+IHmXSLPMx1K6XEijZ+aaRJwCSHJWyEvchSbPlDWmGU/iFQOIYE/s39k6qttoIL7OYrx8thaZQ==
X-Received: by 2002:a05:690c:23ca:b0:710:d950:e70c with SMTP id 00721157ae682-71175475514mr21836157b3.28.1749863000992;
        Fri, 13 Jun 2025 18:03:20 -0700 (PDT)
Received: from trojai4.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7117157067esm2967597b3.41.2025.06.13.18.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 18:03:20 -0700 (PDT)
From: Alex Guo <alexguo1023@gmail.com>
To: deller@gmx.de
Cc: FlorianSchandinat@gmx.de,
	alexguo1023@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: via: hw: Fix potential divide by zero
Date: Fri, 13 Jun 2025 21:03:18 -0400
Message-Id: <20250614010318.3128558-1-alexguo1023@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable var->pixclock can be set by user. In case it equals to
zero, divide by zero would occur in viafb_fill_crtc_timing.
Similar crashes have happened in other fbdev drivers. We fix this
by checking whether 'pixclock' is zero.

Similar commit: commit 16844e58704 ("video: fbdev: tridentfb:
Error out if 'pixclock' equals zero")

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
 drivers/video/fbdev/via/hw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/via/hw.c b/drivers/video/fbdev/via/hw.c
index 66afd7be00cc..31e0cac91889 100644
--- a/drivers/video/fbdev/via/hw.c
+++ b/drivers/video/fbdev/via/hw.c
@@ -1488,8 +1488,9 @@ void viafb_fill_crtc_timing(const struct fb_var_screeninfo *var,
 	if (viaparinfo->chip_info->gfx_chip_name != UNICHROME_CLE266
 		&& viaparinfo->chip_info->gfx_chip_name != UNICHROME_K400)
 		viafb_load_FIFO_reg(iga, var->xres, var->yres);
-
-	viafb_set_vclock(PICOS2KHZ(var->pixclock) * 1000, iga);
+	
+	if (var->pixclock)
+		viafb_set_vclock(PICOS2KHZ(var->pixclock) * 1000, iga);
 }
 
 void viafb_init_chip_info(int chip_type)
-- 
2.34.1

