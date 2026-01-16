Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FF021B185
	for <linux-fbdev@vger.kernel.org>; Fri, 16 Jan 2026 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557479; cv=none; b=td56Yf4nSLE7UNqBlX9HoiGR1nY5/+ILqS3jx3i698oUG1KD0oyTewXVf2GfEI55HMQ0xFfSIphL6uCDwrl64yaOVgIVwBPan4T/UNClfTVO9ZyzCpD5CZLibBJNUNvpL6cQHcoalF4cfMLqRkvg6M06JTrRQh3IrEwlB9M+Fjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557479; c=relaxed/simple;
	bh=zPajOeekjwnH1L2PhS0ee7WaYai94vHkoloTqOoAN40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m8oYg/qw36w5ydo227p9FRCbDR+GLQuo01jznpA0z3RNNmesJruWjVFYGcLOehuYQy2GmHXgqcZxX3P93j1M0UiKCm17wgXld552T1zoQC+6UhUipdu4NRpGnvMpuf3UfJDukj8STRf5Lg11E5SzayffTt/jPWtGZ8oJ9n1EILg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jv3/nlXf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv3/nlXf"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so1712439b3a.1
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Jan 2026 01:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768557477; x=1769162277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z9cPCZbEtZqLhkXtHvfyAqgg+9cdVAULaffu1JjYDN8=;
        b=Jv3/nlXfhvQFpiEurxigKUSHBU7WN0QprWzBMEaL/q7SL/hpZ/kFUjwcutb/ofL619
         Hc6pH/G/pxG2pOhqHCAT4mQFIAutJEOYcNDrWfbGJyDEDGa0jHo0zBQD4f7UXbb6LVMb
         V6oT/F+SsMQWoI9dWjkg7xtT1womNWd/go56zbFZ1cewaDokMElV+jBEKBM91vqIlkMI
         C1t4ehRsUElV8JpK/9Qw4PRdW9yX5nZc0IdQ7Op8ujtaB+EIRFW1YoNQ3VGR9qRAV+z3
         2ZVHLf/Pnr3S5Xlfw2vWQgAf0TSXMKfpoxuGTh5w4/1TjSmcCH8+IoUlBoVSPSG76f20
         ctzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557477; x=1769162277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9cPCZbEtZqLhkXtHvfyAqgg+9cdVAULaffu1JjYDN8=;
        b=EZIxn3NdBV2+D0i7HjOg77k/FPDag9nKxCcMsq3TIdqXsusHThUkW51f39IkEXMGFX
         PU4DRx1zkKUrqWK9VFmLqXx3JWOJYtMLWVBojRk4OrgEulLtMqYCNsEtgXn1dupNcqea
         ynJFZDUoF9aEiCMsU/8RSJ2eKft4u4mJV+0pEac+OSK8ygTr5ZAYHlgzDdarxNRterE7
         8vzsl/QaqGk2u3VJHHv5lAEbJ/JfJyAz+MGWC1PXMSx+9B1CR4ZIWzrWwnpukJPYOQUN
         VZc5XOxg+kjQFPWgLs0HGV/09TCB1lvFeBqOQEYn5NvmNIMzKg9FS6ie/jWC7l43IFYs
         e2BA==
X-Gm-Message-State: AOJu0YwDgAeJZfw5OZpIacLp9IhM7OCTXmZNQ8gqfBJNrmLp55opvl03
	BldtKIp2fOk0N/L3TzBDuzTPZhA1ASYjER9ddNj5ob7gGRej5nlMX+oE
X-Gm-Gg: AY/fxX5u+A25cIjtpMkMn+U+QtTyUBcwfLsHyzHnU30rCvhk2mn/sz7UNpDLFxPaTu7
	6xp8XMPk+nCwRkQWG8ZVT/+eFJnLhnik7ZLJzlsGto91Umkb8b1BHWmxGMlwaEgm/YHnY3R5BhO
	aAEpWCe7yQmkEpMgYa7dE8Szbb9owXmweFwBBBR+7j0Rohk1f3C1pftC+8e3hW/DoRYdIRempWQ
	TisJ5639YlK1tCrlfpwVLEi6AH4PypXOlyuRX/cfyybhwMnbxTOB1ddnDbwvAh0w0zvpojrcM43
	Pu34uAWcza9VVIOHDPiy3lgmW3utOcb6cZoJ57rJd3o9+5VGVeNKn08BKOThje329zaA5H9rV7G
	jQb4u9xtR+yktwa2pXUYyT6m2RDmBcdmCfKpe6li1WAQtCJoREDjAud5EpadevEeXmHi2iXavLu
	kJj+wgstoxzWeyQ4eoju55NSA2D9cQY4cpkiEWad0jAyYCnqdQq1i8uD3gPX60Qkj7ocHexGNkp
	bMaVWyowcrJXl7vN0wyKNCs7YKhZPmN/eYT4/Xd32QP2dk=
X-Received: by 2002:a05:6a00:4c86:b0:81f:4063:f1ef with SMTP id d2e1a72fcca58-81fa03a1fe2mr2502376b3a.54.1768557477372;
        Fri, 16 Jan 2026 01:57:57 -0800 (PST)
Received: from c8971f1abf06.ap-southeast-2.compute.internal (ec2-54-252-206-51.ap-southeast-2.compute.amazonaws.com. [54.252.206.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa108b252sm1645230b3a.7.2026.01.16.01.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:57:56 -0800 (PST)
From: Weigang He <geoffreyhe2@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] video: of_display_timing: fix refcount leak in of_get_display_timings()
Date: Fri, 16 Jan 2026 09:57:51 +0000
Message-Id: <20260116095751.177055-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_parse_phandle() returns a device_node with refcount incremented,
which is stored in 'entry' and then copied to 'native_mode'. When the
error paths at lines 184 or 192 jump to 'entryfail', native_mode's
refcount is not decremented, causing a refcount leak.

Fix this by changing the goto target from 'entryfail' to 'timingfail',
which properly calls of_node_put(native_mode) before cleanup.

Fixes: cc3f414cf2e4 ("video: add of helper for display timings/videomode")
Cc: stable@vger.kernel.org
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---
 drivers/video/of_display_timing.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index bebd371c6b93e..1940c9505dd3b 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -181,7 +181,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 	if (disp->num_timings == 0) {
 		/* should never happen, as entry was already found above */
 		pr_err("%pOF: no timings specified\n", np);
-		goto entryfail;
+		goto timingfail;
 	}
 
 	disp->timings = kcalloc(disp->num_timings,
@@ -189,7 +189,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 				GFP_KERNEL);
 	if (!disp->timings) {
 		pr_err("%pOF: could not allocate timings array\n", np);
-		goto entryfail;
+		goto timingfail;
 	}
 
 	disp->num_timings = 0;
-- 
2.34.1

