Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848651;
	b=ODL8TwbpcK/zW5Eeu44pa7jNp2zkSzMQoeKKErJTgUayvGH/M+sbFCBgSKTSg6GKzrJ0
	 VTjpIE61qKuJEsyVVg6CWr3RhnJOVwjPwJHhak8zsXgIFB1E34BL/ZLumz6uJOQVcdHvb
	 Z3LauJAkm6GKXcPrIqkf20UN1hZBhihSzHtq2ZnqJAKy08eb27BoaEJ4oOL3qWwsNtkFV
	 XkTHwLtnCNCYHfbNas5gAlCIi3oEUz/kz7OtZyAu/eXZ02gyxbL3SLEXkzUPz39AUFrzz
	 LSDTzJEX761BGBxxL9cP5IW+6GW0qLb4R4GF46OQILpVQkFP2GrDd9i7Do3FHfhPZaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4DbzmzBdqMsmHhWCEehq33/otLa9/Nzdgb28dQA0Wv4=;
	b=gVRC6n3tznl1Xy70Ds0Rj6y1EhivA14El5IOSSqsTogrYJSQX8qfbqDaNXHCkb3fONME
	 ysKFsJu3mYFEXaIMGiBQP0zrDb3DqvFJ10F8tBQB6ugQNIfqqAmvMd8BlkUlsO+RVIH71
	 egpxTIewRRNoxgOCmZePKrVULbyui5gThVkkSQo9oAgo52R2eOBGcKhF8huz4JkXzmfMT
	 5K9CLE47QlCDpiqMzMqVkpDbLEDFIQvjm/Kd9Xu0/sL+2oMohBsZfPse/loECCqWkAxUI
	 J2lYr0B4lRjGWxX9Qvh6oQLkcakd0aog8KDLKwfIQ8Zmj+0sjuIZBbB7Z5nFb7bz8Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fKCW3TaU;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804B606A31F
	for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 13:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0804B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fKCW3TaU
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-369f33df08eso5407eec.0
        for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792848650; x=1793453450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4DbzmzBdqMsmHhWCEehq33/otLa9/Nzdgb28dQA0Wv4=;
        b=fKCW3TaUkLtvJNnt7o3RLXMA1pInnCCBv6ficgwjY+pANp4QZ7vEmbo0Zrhjj9PJL0
         IAXD9rJYAyVr8+DmgFPvjpzPDtNRh7RDtGkA5Gj1WxQeqopavUcLV3VhXTxDzJHpFNB8
         M6s1kC5YCwT8UlN4NCUzalOYbPbfJKSc+sdjcpIWb9CenisaYAYgQ4/IpYhFvU+WFvYZ
         af9Bq3tBxXpzLLmVIE1sWMTh9hduqDgm9fAQSK/bBvNoGaP4Ms94PI17QSJl4HQUtLr0
         AhshiD8gbaheK7kxXtnnTmaZS8r2lEvvSXqnnhP1L9hxXdnY2k+cjqHyQVNIHlnpY95X
         pwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792848650; x=1793453450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4DbzmzBdqMsmHhWCEehq33/otLa9/Nzdgb28dQA0Wv4=;
        b=AISaMuQFJFRKsfJgMGuBNPRwhJfbBXTWeZfzruR/GPEZypo4/Y/zPvcArYjafaUpX1
         44InpVOCwvf2wvdHme6EKLUI81wgwIVz5ZemgnmflGThXqOmOm1+pqzyyaJvKt8+Ds7t
         uJGW7oTnlMGh/VAsy6G4ycsk17yH/ykP+c/BMM5JXtR/m8AgMuUYla3R9tuIiujFowIP
         giq7PY9hHuRf7ZlLprwX6xwOsunGQQRme9vChheWYa2+VC331mPFYRhEY084q2zLn4CQ
         TwU5VoVLFgmGHEuHsZLmpy8ItpoHmua70OfV+XhLDkxil7hWPE40bsTn9/dyN2T4j+3E
         aZTw==
X-Forwarded-Encrypted: i=1; AKwUvBz5UFmex7iQQBdZPkqkPv0geToEpRsHCKhedfZoBKHBk+Z7qnJyyl38Lt42E3ZHTfjd3XFMs11ttilJXA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJbunwdb+Vk7sdpmwx4JNB22BeZl3R2qXLf6HUAvQlbiO0cpQGo
	m1dl9ctX9HpAVet0HPQ8eBCurqN2xCUbOPoebrsd+tcWksPDTWlSVyTI
X-Gm-Gg: AYBFou0HGJ832cyl045gZBU+O5xhlZv5fu3bG71ZIf0eHs1M1EhsKkQeow3760WDyiL
	4iZSw+bCtBjy08jNOzluHSSIuOmHqhlhk/s7GyXyiexy6N/ECxAaF5dnCobhu+nNOJVHO6AxzRU
	GddCsJmaa1P5kEmA7L0imzKMcwPplRgDzVy5j1pGba+EyUN9w+muMK3lttdNgcgkVwV2ZfSCB6H
	xWujw6eaNPV7SzZrLEfdvk+knXDdIGsHIx6XPOnzhMbb0CE4WyibKtSD7m9cv+oNQxkwfw9XcwS
	/twXik6wFJdwyYQkTM1dSQvllRRCJPlYKmdBIpenuxU+9cgwt6ggKiBfS27zYoWpRruHt//c3P8
	7MqR9PysRXOhHEW7HycIaaEjFllOoaaoRFVCk2bofRnI8U+nHzLhITIn+CxuoZbxKz5J58ut898
	SFoACB5RLgfomOz0nAxkjvwfPVchoAtfZNXAjAqRpqDjI79/rGKQf67nMjVunYFXsTHKGJCYeH6
	rCY5+EVPTPP3bI7JfpJFo1raYfwO+Ffiog6nDK+BTMUmu2AdCXLZe8=
X-Received: by 2002:a05:7300:1c1e:b0:360:1637:404 with SMTP id 5a478bee46e88-369e8660d3cmr3083001eec.33.1792848649998;
        Sat, 24 Oct 2026 06:30:49 -0700 (PDT)
Received: from myarch ([49.36.79.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm15908129eec.23.2026.10.24.06.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 06:30:47 -0700 (PDT)
From: Aditya Nagar <dev.adityanagar@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aditya Nagar <dev.adityanagar@gmail.com>
Subject: [PATCH] staging: sm750fb: constify the pointer array g_fbmode
Date: Sat, 24 Oct 2026 19:00:37 +0530
Message-ID: <20261024133037.160112-1-dev.adityanagar@gmail.com>
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

Make g_fbmode a const array of const pointers since the pointers
are never reassigned after initialization.

This fixes the following checkpatch warning:
  static const char * array should probably be static const char * const

Signed-off-by: Aditya Nagar <dev.adityanagar@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8b93bfeb2..c3f391cdd 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -12,7 +12,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel __ro_after_init;
 static int g_nomtrr __ro_after_init;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview __ro_after_init;
-- 
2.56.0

