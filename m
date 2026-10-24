Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792865376;
	b=rP55E5ZnoqbntepOdAu8cUkv3yTRUTEXUAs+AhWHwbru9r2mLQkmxtEVVkK+FADvSeyC
	 1BtEpEWZFo33TA0k7BcVXrg9WldBru6t2GWk8DRjT8SpKLcTswotJO8E1jYU66f6ffmay
	 3Is+v6CSD5cFVy5jN/a1i0avrQ/nUYKCTaAMlC/ujWQ/gzd4//YjW8IU7Qf+MzLSguu6z
	 tiwKW19C+BrrIeSkUbmP3lID9KXPh1rKh3jEw1bdb88wskG1tv8MmZHxpFzJcCLLo50DL
	 tPb0VUj8KZFccuUHb/TYkPlfDMNKmEDIRN3+cZaaj9192j8RIh1tTdSsTgCmcQ8DM7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792865376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1do5SZCsNsXFNjC3kteHvHno5OZSZlN4oGD9w4JlcOk=;
	b=pCXczu51Ll0ZpvzpZtM8wG4d5cf4pK5rMm5AVeou66KorO1oWHswJ6Q9paZXyOQMpsve
	 g1T5GnPPTG2Jp8feZm0C9xoRGrkc/TrDtxKA31pxEDPrkqOn3EFOsUOj4g2Otfvx0vNZj
	 FaDL2U9KWil8aPeClt8oF6D92bEs1igit49T+u5IhYCy1SODVFpmKh/Cc7a9To6NR8BEK
	 bvYeIc7FrgfixJClHMW87kujOF7BuajJjsXRUT8ELWVRCBjFxvo52+rqauvA/Ju8t7rho
	 KO8i5qTM8OTW2IN9BtKlcNwnw+bP1YYDNx2kQ+H/gFK5d8LZ4rPKzb9iZ/+za3+BmeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CgLabGsW;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F35B606A31B
	for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 18:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F35B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CgLabGsW
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3282db206d3so2999194eec.0
        for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792865375; x=1793470175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1do5SZCsNsXFNjC3kteHvHno5OZSZlN4oGD9w4JlcOk=;
        b=CgLabGsWu9Qgfc/Gq8E0HEFES6Eek5LmDQjn1UieZ4EaH1/W8ZFpZN79PY6RXOsMIn
         KJdkHykrbj90WNV8V8B/pSBMFjKNJp48N7C27gAPL2HN0VbY89aLHA+DyVA6MifC03f6
         R9rDF7YAyppLydwDG5M/z4DOh1VT4R0ZDcOceJfTTtY6ybczyJ1JdSAjPT3UuTyoWG83
         xm7DVN0Wq+/3jjyqToq3XeomaFVG/JVaq40aaSs9oSsF40x9MNBhA9bWZW5Xby6cZhBP
         nrFwygbFocDLCsFq/l1fokooV7WaV3eFJJu0XrTt5rpI5/Axr6o9wnKQteSeyv2bHeHl
         vbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792865375; x=1793470175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1do5SZCsNsXFNjC3kteHvHno5OZSZlN4oGD9w4JlcOk=;
        b=ayUizZd9yP3BIFcBk0tWtQKmwmnH19A69Bt7Dr+F13diH+0bVkrGAM6IRIgdMeXvOO
         6YM8NMePiYbie0WL3VSRpPv2bZKM0fg85EYQiOayzj9MgCojkhp4CBRjVkc/+/Ru3ONI
         wPeBwiRiwjAgKnTbVLgVCY7R7eVfPWw1I3Rkxf34+wBoZXyrnvHkdpKba5jKYmQslkX4
         iqVh0Han2Ws0PE/th02lBCHXy4s8sKY63wKtxoLg2drewlDGOTeTTBnspu1YPJbMVJIe
         NE2xFd2ifc6q2FMeSva5XUP92q1v3dIT+cg1rp6P8Xho2DBcp5akKNfV9Jjty2X5oPZq
         8iLg==
X-Forwarded-Encrypted: i=1; AKwUvBwI62y3hS14Y77AI98b+XNoqQm7n1iRs4a/NeWphLe1XDcXc2piG2L5zp7bDZKVBatoV+8hhzAUknqX7A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ07rOjyRBH0RumgjwrnS/A/wvxLLf8i/X9he4IkIzU6v+xBZ4H
	JjcOBvDUPxuU6muAgAyBJiuXeK76Xi0B9fxQ+8vxLPTDQLTSfdSjuocP
X-Gm-Gg: AYBFou3OY9Q+0tu7d5ngJ44lSTiZZSHFWw/92jYpNbVEjHecnWj5+VxORa/tSvGt98F
	jazBLAjUvGECtTtHKBSGriy5FSgoKQbaF4bS2U691GimkQpQFk3P0FiconzUyC0WdB1JpOSnlkx
	KRRdk1G0gok0ibh6M2CWgTmzqI51meea3d6TD7u8tShc/3YYEHTuVzdYtYxaIwpcJwNfHGdyVP1
	rEyJDGllvqmGFRJPvKiW2KX3tY13AKvmUT9C1WrrMJWxry3kTeJ0u8kT9BP6VxxJeKUpoUk1J+V
	Fxfl8IzhLVr9EQj/p10dokeWkW9BiMm7bZ2a1Q9vVLdXswWIJEh0f4uXCkgZ2yl4n5mgRWTY6nd
	tRj44JAw74HY5PURyvg0/Ab87c2GFVRGr2QsXq+97PK/eHmZQAtyxJzIZEYwvZZzoFQJExlTz9W
	GItm6DVXDH6A9pXXYbmf2wGnlu1SxsCHNI8XbvNU6JMTAeiNuoMdGwdBIU27smtpegNWPE5Rpfn
	aUdoC1h0FdiHTpFUFjlHMxf1cacBL+eJj15Qvatu2bJc9ZBRlLu3kpxwznmZbig/j5P/eX1MGE=
X-Received: by 2002:a05:693c:62d2:b0:360:8a6e:640f with SMTP id 5a478bee46e88-369e8625854mr3682464eec.39.1792865375371;
        Sat, 24 Oct 2026 11:09:35 -0700 (PDT)
Received: from himanshubakshi ([2401:4900:1c9b:1c1b:d646:355d:1105:8655])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec865esm8020891eec.26.2026.10.24.11.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 11:09:35 -0700 (PDT)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Subject: [PATCH] staging: fbtft: Fix line length warning
Date: Sat, 24 Oct 2026 23:38:03 +0530
Message-ID: <20261024180803.108872-1-himanshu.bakshi478@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>

Split the line in fbtft_init_dbg macro to keep it within the limit of 100
columns and address the check-patch warning.

Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index c7afb0fd3943..fd7f8fc2afba 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -424,7 +424,8 @@ module_spi_driver(fbtft_driver_spi_driver);
 #define fbtft_init_dbg(dev, format, arg...)                  \
 do {                                                         \
 	if (unlikely((dev)->platform_data &&                 \
-	    (((struct fbtft_platform_data *)(dev)->platform_data)->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
+	    (((struct fbtft_platform_data *)(dev)->platform_data)-> \
+	    display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
 		dev_info(dev, format, ##arg);                \
 } while (0)
 
-- 
2.56.0

