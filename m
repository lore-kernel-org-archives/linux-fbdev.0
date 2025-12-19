Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A90B2D5944
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Dec 2025 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766123025; cv=none; b=IEqLcFlO3Gb5+rcmUBudjDWWWXTdKBD2FcSqgsiBTxEcax1X9Ss4GpUvQ7qU6P/tjN7DeXQr2Jz60dEQvwX3P/1rdCuJWfhSax9RamW2S36oK5tx1R0dE4cG+o4FgAkjSq4w3yoeneMxR/fJ0l/FUKBJ4B3WArBvh7zzcSB5Z+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766123025; c=relaxed/simple;
	bh=86Kzw/hKU0nrIm8xZ8jpwyS+2DiCcDwmWTX+qvqHhFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btKcmQWX7ASdML6Zo8t4YH8MC/oeN+sLYl00Wm3D256pL+W+yWXJUd7dTUDkwhyX2dkfe+sAZ3DGTXNGwqzypzcK+5kXaR/nxtdUyrJcrFs+EVICXDb1S0dg0C6eO/pZyAcv9xNmDsL9KW5wbKmHqK9weEuZ0ROODl+SPPx2iGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVNZt8B0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVNZt8B0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0833b5aeeso18519975ad.1
        for <linux-fbdev@vger.kernel.org>; Thu, 18 Dec 2025 21:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766123022; x=1766727822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKkdwzvSXz/T9pEqrvQ0VdQLUSbrQRl3ctUuH0zUyRA=;
        b=UVNZt8B0eRLdEbUBBnh2zpWq40lqCA+elXS7xzOsTlxlq64QBnZcxPvl6QfxP/kPDT
         tuXIMj94oId9VJbpPx+G/bm80iRYbpaCAu8RODiJajR18I4ieuRN99MjU8TsGQPoGFNX
         5CKj5ktHIgjWDVv/0QFpcpnuqGLBmDPFxCtHOf06uI4Xy3P/SlO46/+d5p+VSEjSK9D+
         ydRm1K58ClGnvON/LdC8qscoEp+kN74teNXzFC0Rm5O+bS2vXp1JzBewGttJ4BSJgdr0
         QLl/irSolSQlNtO1DLuj70gqlfog37mLwDcMVgUru9SmLfsZbKxc6nMQj53KgubYLbPG
         nfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766123022; x=1766727822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fKkdwzvSXz/T9pEqrvQ0VdQLUSbrQRl3ctUuH0zUyRA=;
        b=OLRSD4J6KuJDiLRObQvjSI0VRQ7BlDrw7RWvUjiWUHsLRnz6CaxgyaUzkDlzt+QT8A
         Ad+jMGGt87Gsu9KY01tVY2rpAvH6fn3sf+dsUW5cvqcASzJKbdaxBjgSVfe9M8HSIsfY
         99wodP4Xenvsgl1FESoA64ppRmxFfsxIZiR1tsLjHOftOetDsgS3jOrE6/KtaDr5olTa
         QzzXCwytSk08LLmztwuNe1ZIG/2/QmJp7rwK2+S7kH9P/2M6+1Z1yFvOAxvUBhezrC88
         +sHWMOXiNDC9CA7184zOlb1+hQxaIgSzCMLiS2ks0yWBvT/yFpKpypAL5IUMZtErIdq7
         9Jqg==
X-Gm-Message-State: AOJu0Yw08SqXxMWJx3tCYZQpmbKhiaZ9KQomLvn/aDycgwHT+u6/JmYC
	mjfGmDmH8Jy/EGl8+f3WIkmnFST4Xl7bFzeAd6ix8zifgos86Gka6ZRDKnSjKIso
X-Gm-Gg: AY/fxX6vq4rbWqqMOJLUKNDF6aYZW/CYt2fuSkjIDnxh8N0gahIpUUORSYj9V6qMKiz
	me3VtAiWjhGLEd2Qb3AaaFHZ8nCXYCbxHbPb+qn63Cc8o2UROieA/io5PrDW7CM/DgrX0ppONXy
	fkIsSuAW+aYaoRCUFvtJfQfQ9G/oUyRCA89qs1KegNY3s6HfQeAVG8Ar6c/6rX/4ATch8Twdb67
	u1pioyxa/OHnhkxnlcyvGq8ECE56HhTgE8m+Flisp3d28uVkGhhLYqWlIdOZ2I4q/o9CyqCL0Xv
	rhd0HbNjBoye64Cem/hSnkmBu4pat2bmNFhKCc7EeQpbsm5kBCpl00M35BIfmvmgD+eaf7WOHi2
	CxnwJIFoZpg4WZZqpNbEeT0Hu18YMT3S1h+YMCaIlXN3E/CSK4HLH8Gn08o1i1iQU7BEy2jiscm
	X9bmN8rkD+PkMO6voo+NAc23JB5vATgaMF7hek8ZO/Mw4=
X-Google-Smtp-Source: AGHT+IGRBz3LEiHHY3N36Lf2Jbdyl+OtCRRLAqx/kmUDLPH9d4n3KvJgE1piBAVSSdqL472NtK6Xtg==
X-Received: by 2002:a17:902:f78d:b0:2a0:c35c:572e with SMTP id d9443c01a7336-2a2f2836480mr16751125ad.30.1766123021882;
        Thu, 18 Dec 2025 21:43:41 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:5160:2cad:cf88:afa5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3da7dabsm9878955ad.25.2025.12.18.21.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 21:43:41 -0800 (PST)
From: Chintan Patel <chintanlike@gmail.com>
To: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	tzimmermann@suse.de,
	andy@kernel.org,
	deller@gmx.de,
	gregkh@linuxfoundation.org,
	Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH v2 1/4] fb: Add dev_of_fbinfo() helper for optional sysfs support
Date: Thu, 18 Dec 2025 21:43:16 -0800
Message-ID: <20251219054320.447281-2-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219054320.447281-1-chintanlike@gmail.com>
References: <20251219054320.447281-1-chintanlike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dev_of_fbinfo() to return the framebuffer struct device when
CONFIG_FB_DEVICE is enabled, or NULL otherwise.

This allows fbdev drivers to use sysfs interfaces via runtime checks
instead of CONFIG_FB_DEVICE ifdefs, keeping the code clean while
remaining fully buildable.

Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
 include/linux/fb.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 05cc251035da..dad3fb61a06a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -628,6 +628,15 @@ static inline void unlock_fb_info(struct fb_info *info)
 	mutex_unlock(&info->lock);
 }
 
+static inline struct device *dev_of_fbinfo(const struct fb_info *info)
+{
+#ifdef CONFIG_FB_DEVICE
+	return info->dev;
+#else
+	return NULL;
+#endif
+}
+
 static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch,
 					   u8 *src, u32 s_pitch, u32 height)
 {
-- 
2.43.0

