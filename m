Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC931F543F;
	Sat,  5 Apr 2025 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743858257; cv=none; b=MuxaL3QUk0haEQVUuym1vHOVc/M4J+kvJt3Uq0ysaT+bGbaXarV66K7k32ACWv0LHQeZ+d7wdnC05ZZUfngjSRRPnL1HLDriyMgtUZgkG6LTN97zbnlQlrdfpcxT4p8kZw2rdN29oIadxmv1kwCd9HXGvJHgLJ7Xd53QNGikR7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743858257; c=relaxed/simple;
	bh=u6zEX+t1aVIDzy0JiAoJ7d4d/Fs9Xyppen8tPxxJuLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TRhPPDit5CZQcDj/aZrAukPMka0w/jV2id12JRI3FlE8v9mMcOx9PRNq6EwcIE1abFz3RSozKr0ouRYxMajTl7bUg0N6NO4dd2EFObYTo9Ak1d7TH0iodMpl0/p1WuUAtgzPXzOw/beu0W0ko2ygWB+mj3JLmuWa9NfFNR/T+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo9LL4LB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo9LL4LB"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso14034185e9.3;
        Sat, 05 Apr 2025 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743858254; x=1744463054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvS5tdlccUpYMdewqVDUL2P1AZVRPsP3RNJi07oU4SQ=;
        b=Zo9LL4LBwWQjnjnBoKNjaA+TlqGKlC02rE78y8TcFRmAYRRtrX7JeKXSmlAwiF6QN/
         8dY+ZzjpcVNypMFNaPqlP+wrFI5mqw0G1EMs2xg/AUPnnkYVdLU51C8jAdhkcdTqsKu4
         3lOI3j4rkdIxa5wUb6LCLDkgVlNmwq4ZK4HtwQJMecBvgqXrHqV9QIg+XN/sWX86Uo1o
         zXYYrovgQE7z8czeJUTsCeOyo5zWj7jWNpc3doazDA/dFCpG/Og0Y3sODUp7FRFwJDWT
         zDJv4BaHdgb+p6jUEpTl0Y07v0KeJZrNqD2gsPnwkOhJwB1QJoiGJWVfNC3F7jbZvZTK
         k1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743858254; x=1744463054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvS5tdlccUpYMdewqVDUL2P1AZVRPsP3RNJi07oU4SQ=;
        b=aHn+a4pNqTg92roFxT6lLyXHs7/j+7tt26cg3rXdcptHjZw/jnEH6V0ZoF1LrbdMrO
         ZuzrkdILQqxJQnoiomijW10kvENAZFN2HgmZJ2u6gORP33PZebi0w4LWy1mYJsQ+j4H6
         LbWSjUa42kntsm7IL3XcruM0EEGKCAqs3m1j1Iy02LsQxFmN0OiOv7kO/eQi+9LdbSdS
         UXmzie0OlpMKjj9JE53zRrm/70/CCIv04NmyJqM80R4taOZRUUCts/30+WgPuZP3VPX4
         T5/328rmeP42aeEzpBgBVdFGKKfVfdTBKvDUpYKfOY7qXSHygXhsk/oYZeNx37qJTgFA
         o1Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUAZdTqhIoVaxG5Rpkvqe1k2lTlab+ozH3PCCvAq0sWu2dU3sNR3EPOKdbv36o3oR+x3KjdAgTkSLjZKoto@vger.kernel.org, AJvYcCXN9GrgGK1z4HGQWN2oUNhMxd5S10A3WkGilPGdHGR99kSCFPadPQu9xfjCPiSKVUG0Z/si0x1uFUpUvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSuPBJZK+MNuoDA93qPBP6puBgF7wcY6bbyqgJ5wWmJFxYs09F
	m2Hc1DFMACZaKVT26ySjCfsCTKOoWvHs75+yywG6TjSzSnHbyl4M
X-Gm-Gg: ASbGncsiAyQgxZB3TneKMjykP6UvtDoJNJtrtEKtteCQrsjjo2/DWWHf0REd6YpqDHR
	YwGgMcATAnlIVR5CwT0Awz1pRTg5iCuElhes2BtrFMG1mIypMe1xzs26jtgSLqNNcIcRKaQsA69
	GKYlimaIrUbwHduLj2JXwwgpI5s3cEy6jK+WQUQxSg+eREa1U1vAVjmsukKLq/lz5JHjCoyeFGI
	T+7FRLIsZ37jbM449gTL/Zd6KuLyXjWOfv6V/j2hnTVymzfVgWFhN2ZOQhg3kmcyc5iYH4NR6Cc
	HuavaHiOYsJXl4cjh4Am3FvHdJcCw8v7fnEM
X-Google-Smtp-Source: AGHT+IHOwYmH927340bzKQVz2LAlQfBxREpeEz9WgBTxIKQAqpKwCdhf1W12WOkzi9kwshim3Iz1ew==
X-Received: by 2002:a05:600c:a0a:b0:43c:f689:dd with SMTP id 5b1f17b1804b1-43ecf8d0a37mr51510425e9.19.1743858253423;
        Sat, 05 Apr 2025 06:04:13 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec366b571sm73287435e9.40.2025.04.05.06.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 06:04:13 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH 8/8] staging: sm750fb: change sii164ClearInterrupt to snake_case
Date: Sat,  5 Apr 2025 14:00:59 +0100
Message-Id: <549b645b265edcb793458a534427f75f0ea343c4.1743857160.git.princerichard17a@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1743857160.git.princerichard17a@gmail.com>
References: <cover.1743857160.git.princerichard17a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change camelCase function name sii164ClearInterrupt to
sii164_clear_interrupt in order to conform to kernel code styles
as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164ClearInterrupt>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 1def02be4cce..6fef1ab484c1 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -24,7 +24,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
 		.is_connected = sii164_is_connected,
 		.check_interrupt = sii164_check_interrupt,
-		.clear_interrupt = sii164ClearInterrupt,
+		.clear_interrupt = sii164_clear_interrupt,
 #endif
 	},
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index aebde3d8b903..fc725a9952d4 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -390,10 +390,10 @@ unsigned char sii164_check_interrupt(void)
 }
 
 /*
- *  sii164ClearInterrupt
+ *  sii164_clear_interrupt
  *      Clear the hot plug interrupt.
  */
-void sii164ClearInterrupt(void)
+void sii164_clear_interrupt(void)
 {
 	unsigned char detectReg;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index aa3f34c13979..ebc173658f0e 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -37,7 +37,7 @@ void sii164_set_power(unsigned char powerUp);
 void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug);
 unsigned char sii164_is_connected(void);
 unsigned char sii164_check_interrupt(void);
-void sii164ClearInterrupt(void);
+void sii164_clear_interrupt(void);
 #endif
 /*
  * below register definition is used for
-- 
2.39.5

