Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9772948C3F5
	for <linux-fbdev@vger.kernel.org>; Mon, 18 May 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120514; cv=none; b=Y7VO5AXcpU7Oyv472N3es6T5ryIHQkFhCRPACjpL7ocQFh2pzbrlVT0UkSTmKbipedFU/7+B5lddoDljgWOcCSPY7A0oZ7dQECLcEQ8OdrBy/T6qhR+/bqtKyETzePqtGCaF3d9qfImh6lozDFBq9X0Uz6g9mlYlmn/WONY23WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120514; c=relaxed/simple;
	bh=OGkgFGp6LugTlj9h3s9yMhDwtp+l0mAgRR7UVtWHGOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qQ6TGPbYc5Bua0xhVDLMB7SjMFVqhBU+HDZjuqOi7v3yIG4R8vlypg0U6emqyZWPR2r/uY5lO8E1Nt1pIT4mfVizgWxCJnjX3crbGfRh/8AsEw6/vd1BcBF6+pk2p2peL1o+bj3swr1nH6KLBgK/I9CmphF7+m1C3EhkcrQaiAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=k65BiRkA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="k65BiRkA"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so14316875e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 18 May 2026 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779120497; x=1779725297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=klhCbReF4bvwraqj5tgeEa8fE21QJBvT1nSsOgsaMQ0=;
        b=k65BiRkA7UFXVCsSYQyd03//rVgbTjfTNcCdXAPq2ZuZ06CfACBs0PmuY8KKqbCXQy
         dK7QTZ4voub4np2hKsn7H7D4tDwcZWvORuZ7xwcLHJ6kZdc6XVDfMAYjePgyMhs96msd
         XwM+KbqymiB9BqL6e298Zp5k2QvEqcOpX6Wyn+z6zNDu2B0koPKALvna+KaNCz0eKfYv
         0lox7R0q+u0gEgqFdR7iEijMOFpEey7k5jSTErXI7Y/hGiqUHVxFdUH1k+T3Gx9+2nMb
         R/cp6i8pubZIs3eU1qDce3OWuXCwfL339khovsLX8rgyTO0vH5nzyjluNyJqMWvMFuMR
         v45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120497; x=1779725297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klhCbReF4bvwraqj5tgeEa8fE21QJBvT1nSsOgsaMQ0=;
        b=GKjBOZSdJ3f0enYKv/cP9iNwPWlIAF7AJ9m1R0tDafJ9hRy3Y5uu8KjC4NjgkBQ+am
         /gLzdRfH2zcHLyycLi3hzhij7UZahURGCT2rehHhCrzQIIBdI2Vv+GxpikOQapmkUTEw
         rVszW9Z/28Aj3tKqUwMgK67tafxxsyaJLfFR97p33Y1piPJWfUy5WiUuSTWKDEAqAISZ
         gxDydgXJwWKznYRN1StUUeZsyVC41uXY3d2JZHbUnnRRBIU5GN1g7HkA+dsAYIvg99Wr
         GYBjEpKpX0tI8G6L//Lc+F8eP0BMzHIJdzzRpUk3E8VWVa88GddA48HsQ64wulZgLmI9
         tkYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9W3W+RYEC35dL/tfUo8jC4jsrMNj65pfDDFRhsJ1Dy6aTnC9ZVmnP1kIk4B+nir/4G1r4Xb1xZJYcyOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ5L49j34pUIJgiuqjYJTx8gInMaJwSQQbZQwYlAZmWsj4vmw4
	eJdjt2mBZsSsUsZ/2hbwgexOXrGnE6YoMlcy/H7xvgxN6GqPZS8tF+qaMLrKT3Gb3kY=
X-Gm-Gg: Acq92OGAC5UfbidIRoFxchE3C7MLCQ7X6cLyF/JT7KWt0B+Ax8aecFHhecqFCpL7qe7
	z9Gf+9dfi7U6IwoHhIh0IWQPyZ+vwGSFS2TNgayO9jGUVq77nx/Z4gN1E3fe6HIVxx/L4zHjMSv
	ae4teUPsJ/XWMBIDRoYEVOVcwjGdlSL4Haq1UDKQaLrQ/6v3MoBozE2ddCyh5l5v8jKdPXidCiS
	lsIkG63P1S5BizDmKuLXPGUskk1kIFGStsSj6JEcp93pufvHgFc3aSfG6NierGRGxeKO2xNoAj6
	VePpvIo7B5zPYmab4I6I5Zzl5AvJU/tE8JUOgAvLA8YsP6F7oGgK/utifjWiM1BULodZCmgEY0C
	SkGT70/8/BZSGEPBAGXOJgBjP+mftA6SV7KnZBA8IHHer6renzq6qMwOrAiEICIq5Xs59hPNDSG
	t4/GAeR8d6g7JZYUhdTZlv272KTGuHhzAVCv3l35dJ5gCIVvggq3JYjelDAhNHUagBS+c/agKVy
	pum0rikcFCOlQ==
X-Received: by 2002:a05:600c:5010:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48fe5388407mr229341615e9.12.1779120496908;
        Mon, 18 May 2026 09:08:16 -0700 (PDT)
Received: from localhost (p200300f65f47db041bee4d0e08e9609b.dip0.t-ipconnect.de. [2003:f6:5f47:db04:1bee:4d0e:8e9:609b])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fe4c8344asm451511985e9.1.2026.05.18.09.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:08:16 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Kees Cook <kees@kernel.org>,
	Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] fbdev: Use named initializers for struct i2c_device_id
Date: Mon, 18 May 2026 18:08:08 +0200
Message-ID: <20260518160808.802423-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=OGkgFGp6LugTlj9h3s9yMhDwtp+l0mAgRR7UVtWHGOk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqCzloUdKnlf1Nt0f9T2X5K0WZQuKiEsuchNCdO p0WhYruJqqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCags5aAAKCRCPgPtYfRL+ ToDpCAChu7Mt0FJO95cXoBAYIIM3KUwcbBPBDeu8Kca9LfxWt9XVv2BUjY5QtNspxJu6Ez2N2TP Z2cURRnOBwE8O3KjdbwNJjr+lVk8AH38Y3mCbdWfWkEcTCJj5cODfIkEqc8A2QGpQFkdP08iTyT BUNRyt/cYfrrdb9ec9MAvxZLNKlsOgAAsOct7FQJ6nG0z5x16P6LHSviAmX/UPEWI2T1a+tlsxh fAbHKNLPAChBddKlLJSwj/vOL+NlI0MiJMMxz8o7wpQosPDwHqE66VWm1xc+iGYN/K1FBqKuqX+ ag/qOmumGPWQovBtXg6ImIw+bF/pAqpZrUzGm3DQ84SwdX+0
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

While touching all these arrays, unify usage of whitespace in the list
terminator.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this patch is part of a bigger quest to use named initializers for
mainly struct i2c_device_id::driver_data to be able to modify
i2c_device_id. See e.g.
https://lore.kernel.org/all/20260518111203.639603-2-u.kleine-koenig@baylibre.com/
for the details.

This patch here isn't critical for this quest, as no driver makes use of
.driver_data, so apart from the better readability this is only about
consistency with other subsystems.

Best regards
Uwe

 drivers/video/fbdev/matrox/matroxfb_maven.c | 2 +-
 drivers/video/fbdev/ssd1307fb.c             | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_maven.c b/drivers/video/fbdev/matrox/matroxfb_maven.c
index 2ea65da6075c..fe057a0b57ec 100644
--- a/drivers/video/fbdev/matrox/matroxfb_maven.c
+++ b/drivers/video/fbdev/matrox/matroxfb_maven.c
@@ -1282,7 +1282,7 @@ static void maven_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id maven_id[] = {
-	{ "maven" },
+	{ .name = "maven" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, maven_id);
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 83dd31fa1fab..644b8d97b381 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -784,10 +784,10 @@ static void ssd1307fb_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ssd1307fb_i2c_id[] = {
-	{ "ssd1305fb" },
-	{ "ssd1306fb" },
-	{ "ssd1307fb" },
-	{ "ssd1309fb" },
+	{ .name = "ssd1305fb" },
+	{ .name = "ssd1306fb" },
+	{ .name = "ssd1307fb" },
+	{ .name = "ssd1309fb" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ssd1307fb_i2c_id);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

