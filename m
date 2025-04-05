Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC3D1F462B;
	Sat,  5 Apr 2025 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743858247; cv=none; b=MVnCgNrPNtu3gOy3sheyny99PowA1zNHqciRQUwA9lO36jto5kmk+bOkVzNeqXrljCEBq5jDSFVAsB0NeYUCOYIWh2wNINcKokITewyCvPZ/meIAv9OiKrD+CuQrQWe8AsuB6hHyU3EzmARU7jY23cCEK62qwXzKHOH8s/L0gjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743858247; c=relaxed/simple;
	bh=z46nsSq1v/0fvClzA4Zas3TDcqFixPfx6NddUMaqlWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aY+QOKI4jsfOvAmXFkOytislXjqb07gl1fgMnLwF2PBlhxo6hCvDe8wHnrYklIoWq3oMl7+VCSfkccSIabL0zqGacS2U0WV122typuqMr+eC+v/IN7xgWbtJIgISLOGi5tz9RLqTZlv25F/BWKSstJV+nxwUSQJTEuEopYwlGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ6Zn7g8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ6Zn7g8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so9421655e9.1;
        Sat, 05 Apr 2025 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743858244; x=1744463044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pxfh28JgrgsZ43718+Rog7hGuSrWMc3dc3Cy5VLEAE8=;
        b=KZ6Zn7g8LiQwTdkI/WC0hvPwDDgT/jDVaA+F/VIVyzlVQhYL0AlVv6q6FXoYuEohhS
         ky+hxBzM6QgQ79Nz5tcFvrTMXKaUUYwyvk73BGHBZgPChDXtWXWaToUk19qDwj0mRQWp
         69a8mHI7oQ894qUnYjFttHZuMeqEK+ZgvXQ3P7Fulrt4VO3lNCcgemF4dtxnsK/cfg9d
         F3WcLzOfvCgBG525gCi4MsSyPffeKhyr9HU9MAXvUl6o5SmycpS9m6u1NUjezVfsatrq
         fwMFWpvtBIW5KO6tVp4QASkr56Ifk0CrJ20nbEvkwyfk/7VRGGSphYpGC2Hehc1rTrUm
         ONdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743858244; x=1744463044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pxfh28JgrgsZ43718+Rog7hGuSrWMc3dc3Cy5VLEAE8=;
        b=TVdM/9pt6z3UuoSJ+WWQLpbveciThlL1OxEoQ7uwruzHgul1lDNwxCMJYeKvDSbr7m
         D1gGlDSsA9LkVPrGGrSXVTTs9o3JhDq+XwzFw41T1SU2T0WkCYiUgr/IuAXpwyGzuB2Q
         QTyclbUbIj0o1+VfXsmpZ4uDoToLdWenPBT0Ytj8Agn2lRfiAYL5L9HH3KGSyFAAqsR9
         Fah0+MX4poa2B+nMMXE5qMPO+Xs7myz6v+PgMIoKEvr8KJvoOWI9uGerbfL3t3ygnt9q
         odbMZbLirYub12l9lB8UsOqRnYSOzrnptaPb2y7NMjZOsVQZn9ISXdcmNg9CMRw0oj+M
         tvrw==
X-Forwarded-Encrypted: i=1; AJvYcCV5SixLE1eEmSDXH3OY7y+4br4R0fGsAn5YbwNkwFSyKRlk0GsrScloyj7YEb5AAtlo0nvI3Vdb8h7AnQ==@vger.kernel.org, AJvYcCWVRa890VechCcgFKpm4xQdBqfbaa2lYBoRMN+69IEedP8CvQW0J1Sg9V+wsBWk99g13PXbW3K4OVwQ9Mfz@vger.kernel.org
X-Gm-Message-State: AOJu0YxSTrJH32B4VUpm5hV7CVbPkWck0v+d6WpX9V8yOBwvnqVMJ8dP
	511Pei6xFijhZW1ry0BQ08y9Fiq5bKL13p5y9KVhg6JMWmaSpwUO4q/Lr1yl9nY=
X-Gm-Gg: ASbGncs8ZHcCz4dPSepBVd1bZ6gz13rpahhFYT7NLkZlDYBgxgRIzLhikBZ6bWV5a2W
	3rwnnIWSFU7LQoO1psyA68sGBJ1V6c7VVOBsi9BhPVK074Df4YAEIpSUaa5QHGWya+O2w/05K4E
	qfgrSsHT0gMvgioNdEOFtocmZvvJmi9dpKZWp/ey+E10utgNWUSvjkiVDWW8hjU9digw78NqCVD
	rKMF3F4VK4dx2YEcHqaPFyZP2EaEHb01pF16RqfmPuHdd3NVO22VY4SubC2RDUrL6XoeiTngnzZ
	9cVQdNuoOZdghxQZznbf88eQDA==
X-Google-Smtp-Source: AGHT+IHp2ifiZ/9ShiKCeTO0TCWC4tiuyrTuNMDGeDxptSNFiNVkqkoRgcTZPKMSoLltQhDn++s3vQ==
X-Received: by 2002:a05:6000:2486:b0:390:f699:8c27 with SMTP id ffacd0b85a97d-39d07ad5183mr4714928f8f.12.1743858244452;
        Sat, 05 Apr 2025 06:04:04 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b8ae1sm6972141f8f.51.2025.04.05.06.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 06:04:04 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH 6/8] staging: sm750fb: change sii164IsConnected to snake_case
Date: Sat,  5 Apr 2025 14:00:57 +0100
Message-Id: <05de0fb87ed53015cd01ef9460996597ef1e09c8.1743857160.git.princerichard17a@gmail.com>
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

Change camelCase function name sii164IsConnected to sii164_is_connected
to conform to kernel code styles as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164IsConnected>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 1ce44c50617a..ac1aab77da28 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -22,7 +22,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.get_chip_string = sii164_get_chip_string,
 		.set_power = sii164_set_power,
 		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
-		.is_connected = sii164IsConnected,
+		.is_connected = sii164_is_connected,
 		.check_interrupt = sii164CheckInterrupt,
 		.clear_interrupt = sii164ClearInterrupt,
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index c8db6ceee9af..6ce15b7816d9 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -350,14 +350,14 @@ void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
 }
 
 /*
- *  sii164IsConnected
+ *  sii164_is_connected
  *      Check if the DVI Monitor is connected.
  *
  *  Output:
  *      0   - Not Connected
  *      1   - Connected
  */
-unsigned char sii164IsConnected(void)
+unsigned char sii164_is_connected(void)
 {
 	unsigned char hotPlugValue;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 9e289bf4a78e..90b7ae823a10 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -35,7 +35,7 @@ void sii164_reset_chip(void);
 char *sii164_get_chip_string(void);
 void sii164_set_power(unsigned char powerUp);
 void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug);
-unsigned char sii164IsConnected(void);
+unsigned char sii164_is_connected(void);
 unsigned char sii164CheckInterrupt(void);
 void sii164ClearInterrupt(void);
 #endif
-- 
2.39.5

