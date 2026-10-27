Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117391;
	b=QQQdBAa83Qawu6FM9E25w+VHWOPsoQ80g5rZ10u7OO9Q3ZvhFY91YmFiPc6SCOLgHY2m
	 j0fya567aQTXSzC+PsfH1J1Raz8JXp5zaikLleEkclG4inIq6bhykeMTRKjtFXTo/rv7p
	 fSw0wD3tG/9xpRD29hB64wxMQT8RUwME6uPgZnDSWsujOS5mSD7xXj2EcWxsYVHXqOLkl
	 ECKYI9gtEIVWrrC4zDZnwSIKHsKHzC91luxD0zPygUv5atNj2kba03QBBzjLX03tlywL2
	 uNw1G1lDu3jKunWqVsPj9WZtmpNSdk8b+EwVa0AMi0eE8aqNjOXfStuqsfo7UY7QuMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zXxn2I5xRz6x8frUdiRRQE7jhrWj+wttl0bEoQMCRfs=;
	b=eBC+vvk/zAoox0IWoVKQBsSkGFZpBx2Fio05yzmO6ummqaBoF2piywqe7pFxZrW2DaVv
	 uzyLKoLFJrjUNqNy3wD7nSYfnH1eWLgxEN3DbZWAkNjBqa4pMYYbRT4OKDY1WYwhpHetU
	 KDd4rN/9G7Cjkp6isETm7Si2ChMJ89Jq1wtFlUw2iOELC4SWhwoWD+hW60+0Bmtqr2mgR
	 S3PWwOcy4eZgRKAo9kbTudSEIg4KvaDbIA+m3saMSbyVfPMVQ1Flk37xf78h++fMY3p2A
	 DPVY9eECtHZvdtLL/qyLoLJ8I2NTte6W3N99oTi8PQ3wbH/5zaDMEQj1ZI44EGcbDWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zF3ihAUz;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63092606A31A
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 16:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63092606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zF3ihAUz
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so34581eec.1
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 09:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117390; x=1793722190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zXxn2I5xRz6x8frUdiRRQE7jhrWj+wttl0bEoQMCRfs=;
        b=zF3ihAUzXf8793o6L+4QfNxIyt7f+13AIXnDYsk7gzSuy+4xL0fzt9p9lf3HEzXuM5
         qHU/hijXmCeOGtpwK2JXmMpkP3fNEQYZ1OQw2el+ubMKdUVFE7EsutNErbR/r/9JXVXp
         mMlw3MubtOyB7eAfF6nHNoxQDK3JarQM2lKMkH2sna7MvF9MP4JDICX2s38DpdMSeFCE
         1kDMz2vrztRfnTkgtj2jqCf716FuVBMsWxFrtMnOf4xjjFhJa+csbQ1t9VwJh5aVj63/
         DhpZNQWV3xsgEZkc4/WPBbRJNTm66g+hY0eLtIdjNlm3TJOShzIO1QtZybQ1R/rUKOqy
         3TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117390; x=1793722190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zXxn2I5xRz6x8frUdiRRQE7jhrWj+wttl0bEoQMCRfs=;
        b=Z4j2oVSoWoqfesl5rwVojfuSPVzJXorPc/gckXK1gSgLHQYPl+yDwxAK9HttihREZQ
         hauJWujkd96BaEU/mgRFUfj9m2AliK05HM+MP5UulMwZ0W8sxbOr8sesjt0I8LltXBlc
         GGQmXAcNgS2RvRneUQQTeRRJxy0hPD8eCYrk9LOy3LjmwZjQK52mE6Y9ylkyT21eIMZz
         ANUzd0Io7WwHQG+GfzzIpwq+lWxkYrqcaIB4Ldfpfm0Zl3xni9+jiQDDGYU/zx4UBmt+
         vXcsQzBrfNbTVrugj7INpaDcP6s8JFvYwsU+EZjYrfup9M7LqbhDbQwAa/jeINuR9tvu
         g75Q==
X-Gm-Message-State: AFq9FYIA8Ckb7NeJSZdG9uifqiYs7RMTFMVG1MximMR+H8cjhWHlGY1C
	5bkXoGwavaBgO9ArbLecRlCvxZ2waYfmJE8z5creLYGxvw25dPCYByKq
X-Gm-Gg: AYBFou3wSGuPB65M8f1+YU+HZ9UWl1YIfiVQfOuHWDA6r5rWG+86pcXjkA6OkOdJ0OY
	IKjiBu+iKxmC56skgaYrXhyam7aOsw4BdAIhXHN789Sx+E8/YNviPS+QooPnfpUI3+x1G6MXzNt
	8Ceg9/n7RoWWN3lRS08+tS2DmG4zBjSvz3d/wm9xDWkmyPNWdiMyRiZB1TebIwi7HbXjV2nRfLx
	NzIYHwZG1yUIe+cx6cNaxp3lae2trUykX34yAQb7M2QclIUTl3klX/qzgp396xNNKYYjT9lI2iG
	NHHGW06RgQDAJ5L1CZ2/Qt5xDDg4Cw1sD+0FVC36zFV71Ti36R10W1hPWqZhQblFBWBQuCmv5Xw
	F27uk9k6rkd/4ehynGbhd67Awhrgn5RiHYOaS9pgeRqVnujhcxX1RXldb81RQjyvRsQOBKckSOX
	9sf+X7JlcSY+hLJ8mwFj7l0TTxbR/Umi55POVDZhHHhLCV/O01f+ZN5q8C5L6XDexMLy6Pp6GXQ
	JobJCd7fy0YM05ZgkrZdFfctXRYJvLorVMYKDUcjld5PmLbKHysynzneZNsT2stAUSwGsZ5kARY
	3UpNPhMMzmhs5NGtZ9uUzzPTRqsO9Vo7yZ5FnK9ks3SzhR7Oxg4mj+Vf5g0EJj2ElgFJ0r9Zzfp
	Zjw==
X-Received: by 2002:a05:7301:d192:b0:353:7e33:664c with SMTP id 5a478bee46e88-369e8610eedmr14636189eec.37.1793117390413;
        Tue, 27 Oct 2026 09:09:50 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daa3a8sm43061239eec.16.2026.10.27.09.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:09:49 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	co+b0df61d49532b2ee@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] fbdev: vfb: Validate framebuffer geometry and memory size
Date: Tue, 27 Oct 2026 09:09:14 -0700
Message-ID: <20261027160914.3787276-1-bestswngs@gmail.com>
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

FBIOPUT_VSCREENINFO can supply a virtual width large enough to
overflow get_line_length()'s int multiplication and bypass the
video-memory limit, allowing fbcon to write past the framebuffer. The
offset additions can also wrap, while an excessive videomemorysize
module parameter can be truncated when PAGE_ALIGN() is assigned to
unsigned int.

Cap framebuffer geometry at 8192 x 8192 and video memory at 512 MiB,
keeping the stride, framebuffer-size, and generic fbdev drawing
calculations within their destination types.

KASAN reports:

  BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
    drivers/video/fbdev/core/sysfillrect.c:24
  Write of size 8 at addr ffa0000001671000 by task poc/198
  sys_fillrect
    drivers/video/fbdev/core/sysfillrect.c:24
  bit_clear_margins
    drivers/video/fbdev/core/bitblit.c:247
  fbcon_clear_margins.constprop.0
    drivers/video/fbdev/core/fbcon.c:1410
  fbcon_switch
    drivers/video/fbdev/core/fbcon.c:2261
  redraw_screen
    drivers/tty/vt/vt.c:994
  fbcon_modechanged
    drivers/video/fbdev/core/fbcon.c:2693
  fbcon_update_vcs
    drivers/video/fbdev/core/fbcon.c:2732

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: <co+b0df61d49532b2ee@bugs.sh>
Suggested-by: Helge Deller <deller@gmx.de>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v3:
- Clamp visible and virtual resolutions and offsets instead of rejecting
  oversized requests.
- Clamp videomemorysize before PAGE_ALIGN() instead of rejecting it.
- Add unsigned suffixes to the limit constants.

Changes in v2:
- Limit virtual geometry and offsets to 8192 x 8192. This retains 8K mode
  support while bounding all generic fbdev drawing calculations.
- Cap videomemorysize at 512 MiB.
- Keep the existing arithmetic types now that all inputs are bounded.

 drivers/video/fbdev/vfb.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index de137b2bdaed..deaa3e9c758d 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -31,6 +31,9 @@
      */
 
 #define VIDEOMEMSIZE	(1*1024*1024)	/* 1 MB */
+#define MAX_VIDEOMEMSIZE	(512UL * 1024 * 1024)
+#define MAX_XRES		8192U
+#define MAX_YRES		8192U
 
 static void *videomemory;
 static u_long videomemorysize = VIDEOMEMSIZE;
@@ -142,6 +145,10 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
 		var->xres = 1;
 	if (!var->yres)
 		var->yres = 1;
+	var->xres = min(var->xres, MAX_XRES);
+	var->yres = min(var->yres, MAX_YRES);
+	var->xres_virtual = min(var->xres_virtual, MAX_XRES);
+	var->yres_virtual = min(var->yres_virtual, MAX_YRES);
 	if (var->xres > var->xres_virtual)
 		var->xres_virtual = var->xres;
 	if (var->yres > var->yres_virtual)
@@ -159,6 +166,9 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
 	else
 		return -EINVAL;
 
+	var->xoffset = min(var->xoffset, MAX_XRES - var->xres);
+	var->yoffset = min(var->yoffset, MAX_YRES - var->yres);
+
 	if (var->xres_virtual < var->xoffset + var->xres)
 		var->xres_virtual = var->xoffset + var->xres;
 	if (var->yres_virtual < var->yoffset + var->yres)
@@ -434,9 +444,12 @@ static int __init vfb_setup(char *options)
 static int vfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
-	unsigned int size = PAGE_ALIGN(videomemorysize);
+	unsigned int size;
 	int retval = -ENOMEM;
 
+	videomemorysize = min(videomemorysize, MAX_VIDEOMEMSIZE);
+	size = PAGE_ALIGN(videomemorysize);
+
 	/*
 	 * For real video cards we use ioremap.
 	 */
-- 
2.56.0

