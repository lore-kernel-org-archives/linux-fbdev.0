Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983788;
	b=yrooR+SDwEqjeUXlkmGbBTr0RKMtT3oKLHwH9TlFcXErIYZ0uoqPT8ari8a10VNe0U8r
	 n86ykWcEJfHIMxeEdS6HpY0m3XShMQSj2y3BQPKYKpzCtFfnz3kmOEfWGdSshqvDo17OM
	 lm4O/7H5biQkyfSKEbtNqekkvJEUAOaeQxlii5ric5GQeLXWpDqI+F5bB1q6ehGaH81Lv
	 XrIMen1US1EIQ+jdTNtgXL6o2fcWyHlc4KtIQgvNNV/+iVW44fEvUjwfWh+mxUqE3iZhI
	 GgPFgng+3q1Oz3zoAQp1Lm4GwstHZEw0L0k6nT7mjt4r6fhx0OWB4TYZy128gGrW2Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XqDNg4W7673UpH/nlCNn5xwA3tbLFD35COXqGvji1qM=;
	b=42FP5Xwgbbj/XpIHLUMLZhN8OnMxwgSSxoMGwkh8+06hgvun8rxe0uaYAnhmFOXnQ+67
	 Y3lEPyl+k6ZRS+71fT4ABPjCoSoWUwWWxeM3XWmkdfPZaMd8NYTDU0xf5jWzE3irqwAT/
	 UVjlcuAk3TTN1ikmDrjwnasR7RGzP3XoOVNyFRS6M//oiVTXlZjZ/LTmyPlPQ5mkD/es7
	 rVUVDlPUQW5Su6sVvHqiQpxC+zjgX221o2R/Fhqde5+Z7z4jdQ01xcq/sc1tX6A/+ZQdH
	 4Y0yWooCrkYYm+ZQBIXemUPd+78mxiCh6pD1OwehN28Ft9hvcQ4r1JZg6nTOElABnBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bitmesra.ac.in;
	spf=pass smtp.mailfrom=bitmesra.ac.in;
	dkim=pass header.d=bitmesra.ac.in header.i=@bitmesra.ac.in header.a=rsa-sha256 header.s=google header.b=Z7TODvfW;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BAD606A329
	for <linux-fbdev@vger.kernel.org>; Fri,  6 Nov 2026 16:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3BAD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmesra.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmesra.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bitmesra.ac.in header.i=@bitmesra.ac.in header.a=rsa-sha256 header.s=google header.b=Z7TODvfW
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so490542a91.0
        for <linux-fbdev@vger.kernel.org>; Fri, 06 Nov 2026 08:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitmesra.ac.in; s=google; t=1793983785; x=1794588585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XqDNg4W7673UpH/nlCNn5xwA3tbLFD35COXqGvji1qM=;
        b=Z7TODvfWLWlnUBtrtersYwQUYVhj4fzJY9Lc8GcTOeZhyHaj0S5aWlEYl50CsTmACb
         /r1AeD4v2ND4j5tOdAfUCPmzu8ccWt4YtViOXR9FzMWWZi2wSIzrG6s94uVSYdUJRRbg
         W3kQ3dJH1ToL7EK2Xk+/lFTVhum59/haUf4Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793983785; x=1794588585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XqDNg4W7673UpH/nlCNn5xwA3tbLFD35COXqGvji1qM=;
        b=A1l1fypci1eoOtpuuA6AkNaCUWlfBtrpU0+eolnyQZDVYMC0kiMjwUrAClYbPsQ4i4
         WnMTzgB1guYMIgOteeyrrQmUCM0l6fTQ2nVTaHT/QR02RKmZhFT7sAbsBv+vqdXh3P/O
         j1tuoJv65IHkbGhCQL65RaFH7baV2QCz8fYLQZ3xEp8R3PSCbA6HORrx1eQgTICuO84b
         rtQl340EECHYOR+aeFIsCaJWtoFTjYbQBtzaSJv0qcCJSWBzVM/oA4q3C4v0NGrYd2SE
         JF9Pvdgy7rUexlkTBWSVwGxFmhagJeFAIsNiSF/y+bJL/9kQ/HZDxB5NfcDVvvHLS90r
         LseA==
X-Gm-Message-State: APuU4Z/pHx2maC9fL2BN+fuUWTjpC8Kug1036Oocz+f4QFvfoOHsGPuh
	nQpTzVUBiC6Ns7iw0sXW2WwlgXsiq7ULAdm+oJ7FQG1zZ1fBKtevnHBhDwuKnXyx9w==
X-Gm-Gg: AYBFou1OXHlsEcGkbNi0Hd9LlGA9bhyhA8zNX41JYWu7NKkFPPvSIQ1AeJerMSOgcNZ
	MRgBgHrmoPWmQs9p0CIS/WF+S4tgK9jrp22WG/Q9uixwUTu2/onA3nJSNDtIKbvfaCs5/w+0EF2
	wE1bOioDpv6Qc8+WyhMYoubt1G+GF5rzpa/9nfedu1UqN/1sDJw7EQkVn3VMIvF3wM9zQzRYocF
	Ttevxz7qnrgCzkZp4RKQlfpgofajmvT4e+8yZ+1o63LIu2dC95X7FmMVY/PgYSr9KLgsWp0dBFC
	pcJ7QzT3irYsV6zhi8XeFwtL8/BmM/vtOeGET2ut8sssVxtXm5VKvT+6Km0chmT48iSkOqOQidZ
	MuqkbxhGUl+3Aar+ebv0e3KSj3OtF0RK6xdT0uEHNgN39w597DQcZaCfITgvY8HIGAYOQeAFuZb
	BGk5p9wd62B3TphEDnQy8qXYrAgVhuv8E6E6gQ+1ermrXeaT/x5b9+FiMoxpHD3MWliQyCUd0NY
	2EJ0gHuLpJBgA37Jv5UfLqGP8JgCl1cOe8AvKPBmfNPE8oTdZDlVOimF3o00FBfQQ3vyQxIFozK
	z2rv8KXsFglhzrvL1tglExQDURExM/w/ZNhWfJSQpqrog6qYWXtxJQ==
X-Received: by 2002:a17:90b:540f:b0:3ac:80dc:f40c with SMTP id 98e67ed59e1d1-3b0db6d7586mr3040386a91.14.1793983785266;
        Fri, 06 Nov 2026 08:49:45 -0800 (PST)
Received: from fedora.bitnetwork.com ([115.245.53.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc4dc7a8sm264494a91.3.2026.11.06.08.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:49:44 -0800 (PST)
From: Kurmapu Sai Devansh Prasad <btech10487.26@bitmesra.ac.in>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kurmapu Sai Devansh Prasad <btech10487.26@bitmesra.ac.in>
Subject: [PATCH] staging: sm750fb: constify g_fbmode array
Date: Fri,  6 Nov 2026 22:19:35 +0530
Message-ID: <20261106164935.18502-1-btech10487.26@bitmesra.ac.in>
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

The g_fbmode array contains string pointers that do not need to be
modified. Add the 'const' keyword to lock these pointers, making
the entire array read-only. This allows the compiler to safely move
it into the .rodata section.

Fixes checkpatch warning:
WARNING: static const char * array should probably be static const char * const

Signed-off-by: Kurmapu Sai Devansh Prasad <btech10487.26@bitmesra.ac.in>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 21e310274330..47d2917cc1d6 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -12,7 +12,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel __ro_after_init;
 static int g_nomtrr __ro_after_init;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char * const g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview __ro_after_init;
-- 
2.56.0

