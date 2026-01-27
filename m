Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C5348860
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Jan 2026 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769514159; cv=none; b=Mk2ujAemiJYn8PW8c6z1j+NPRTTJAsnHZeCI5uocpYlIYWwlGv9ecWlOq8DRnLbsPfO8JUWMn2/X5+sRccXpunfyGRnjNob7S5XUxSTFiEoZ/qODESnP6YX+NETziIZuV7NC6GQ1lrlMyU1WsgAWlLa+Puo580J19cWqfNYKpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769514159; c=relaxed/simple;
	bh=I1YbETf3vj7uic50zQNizt/haXBDl33BQXN0szPIW9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dc16O+8oAxbmbqR+XwWIoxfCHmM4ta0z3Fxi3eeABERTtzcv1j6orsvxzHkifwU1I+ExXnu0/wvLEt6NUASPrj57Jbk9N0AZm2ZF34kiyjpsiMmaD17vdfHeQqI8H/CjBVwv5e5aMdNhzTVAP28UNJqbN3mjQizvgMyqkzh7CGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFO9qyXT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFO9qyXT"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so47639565e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Jan 2026 03:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769514156; x=1770118956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XcOqH7ds3TDnQ6ZR40/AeZU8rusGJW0TMeBJLRBCCfY=;
        b=JFO9qyXTdC6nose2yrNTuA7y6/w7mMNjFb1RKBLTtdK/CrXSDBjWp4phlictWszHsc
         1ytDe7RafwS4qXNqm0k0/D+GTnl3dmH8IEdXM+v1TLhBHAzbVehJMmH7aDzYcODn4Uv7
         yZ0Ki1OnRATKlmd60kK3KOjyOU30Xv0E0QdJJqoyfN5hDak9d01Q/eeobPwxxP4zWqvk
         5JK7/bCs678ioNxeTb3FpIyMn5sGPWHUTHNhsCqKjmisAI7SW6YIDGJEUo2ooYk3af8V
         wqyBWqu6yzL6gJXA1uu2fAht7sEPIZnkhYBsqufGHKpbzPUGUadkh7SSlfptPnl5Zzoi
         Sr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769514156; x=1770118956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcOqH7ds3TDnQ6ZR40/AeZU8rusGJW0TMeBJLRBCCfY=;
        b=MyOaBG/K6wGB4vI11b5A1WU0bLWyWuGtUs1MsUJ4iEkP1O8nlMc+ebay5jFgH5qzr1
         UTesYAT1a8UJ4t3gtnFV9oaKbS+0/YLo6yXZFgjUQSwdbOCapbWgVgMkiaB3v5TI9uxn
         N25LM/LxpGCZHIweAQw1iV7bNwk2B3oJRXVTXSicicpyswqoG81UAbopR+c+U3QyIhj0
         a1jWNTXZeLzlLcIheOMSrqulTj3VCJtDuoA8Ng1gVtR8Ql4GCIvV/qKOejA0MiPLV3tT
         undO++s87IO7YZqFhoR8XyRY85ItGz59ihDbxRsz4Hm7IHMOsf6JIGTxevY0gUhY2lb9
         U0Ww==
X-Gm-Message-State: AOJu0Yys5sn6jBtOibGL2+D5gKR8qkaxrs7xUHWKFna63lEFl3Mh2iqt
	FGeyAgg126RgsoBuctFqrynf2lCt+s7VJ0C9P8xrd2MzyUVTRp+w8zas
X-Gm-Gg: AZuq6aK1yEg/d0iRG2kbdYr/OjnWhrbz1bcRPGqNqqvnpNXo0JGE+odMMeWlFM1HVVk
	sS2YTm9PPrn3cWfw7JUovTZW7nupLiNoNBe6V+kKI7o0spOs88vYO1z+sBFEQ+6jxRb1gBi/Rd8
	Xcqhn5km5cmbdiPvkafqOy1yAqEv8KM63hyP12K0Z0HVmGi5v5aZA3etSwPd9AaHzhEozhQpL9X
	Evztgxuq7re4CfjSx/0qy2IrX2M7VHdXqu86KFqhfr1Aea2exz7csJBfi/HYMQKR77DchUvcwTk
	2cr6Xgl4bM+EBBDHX0k7lZWmJUfDi7dngkr3dx0k/GOOdWQC30f1/gtgJ72xPFAFTLQcMNtvUuy
	q9+rfh7nTnpIBp/V8M9eWLOl4XrxmQUf2Wftn0rg1mjYrF3rCKGFV+KSMsWzJj2I5HCEW/eYcqN
	oJCec0uQVcmo6rjtEKKK4=
X-Received: by 2002:a05:600c:21ce:b0:477:9a61:fd06 with SMTP id 5b1f17b1804b1-48069e33806mr12386615e9.8.1769514155837;
        Tue, 27 Jan 2026 03:42:35 -0800 (PST)
Received: from Madhu.broadband ([83.106.123.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee30dsm52189425e9.6.2026.01.27.03.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 03:42:35 -0800 (PST)
From: Madhumitha Sundar <madhuananda18@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Madhumitha Sundar <madhuananda18@gmail.com>
Subject: [PATCH] staging: sm750fb: make fixId array const
Date: Tue, 27 Jan 2026 11:42:32 +0000
Message-ID: <20260127114232.29504-1-madhuananda18@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fixId array contains constant string literals, but the array itself is
currently mutable.

Make the array const so that the compiler can place it in the read-only
data section (.rodata) instead of writable memory.

This fixes a warning detected by checkpatch.pl:
WARNING: static const char * array should probably be static const char * const

Signed-off-by: Madhumitha Sundar <madhuananda18@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fecd7457e..ff590061c 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -740,7 +740,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		"kernel HELPERS prepared vesa_modes",
 	};
 
-	static const char *fixId[2] = {
+	static const char * const fixId[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
 
-- 
2.43.0

