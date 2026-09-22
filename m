Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555082BEFF5
	for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 03:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790049202; cv=none; b=tsLyeKTNBOZupEk2yJ87XFoq7gGAfjv5OSDPy9lYHQkDEAwadLQqGEJrokogsHbLBbbWQlMqO5+LrEpHPi+IoYTDPKGIV+4mBrBycqQ+ZbEqUN1iSKxb/SiVgNhZDW3cCqTH0ECM4tOeZyC0yp666Jy/b8SjyUnKKZlsyvUUMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790049202; c=relaxed/simple;
	bh=oaig7IIc0/9Gc/HoBtE26gxovH3dKDsT0hiocoSqP1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R4b/ThUGO0A+TngErzj5zZtlOCukXVOxdLVdIoTqDCAengE93snfxYZoVPVTrZKm4B8P9BVna4X0mgbm2Bl+Z7aZsCgHf6N4PrN0vlYlUNymEBd+94QCbYmGGZk5wbJpk9SRibwBpQ3F2vMVflW3yQSY536zS0AR1NcTHMfnYkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYNQph9P; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYNQph9P"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c7f7cc52efso1508414e0c.3
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 20:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790049200; x=1790654000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Gh5tKcxiQTs/oI+I7DVxOINXtqMjEU216h7NUGcuQ8=;
        b=iYNQph9Pb+TjdSc/TVlixrbGxjRIrzqkT/B+ptkoqpZiNSy2siPWHwDDVw8DgTa5DO
         qdW5Xiauhgp+3m9rLeb8cXK32v2NQi1JD4EXMpOkOzh09fOtLMcxJZSScqvEwJ3/bLlB
         RgJBKXxMinPgWA0kOblezE5CkBBtfmmm3MmnhR8qlj85s3l5DErHa4RoD6RMSEpHXbnb
         w/hy0T3I+rvVdOTMzhojX62w+9IPPz6/TaIy7MPUrJbhrBxb692ta2BKIYLPifOL110C
         HO48NU3IfZ+7sZRhchg+Ht1dH3ZVONgyl34iptJfXIOKMsC2624vdTMks7a4bOuyDciy
         Cs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790049200; x=1790654000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Gh5tKcxiQTs/oI+I7DVxOINXtqMjEU216h7NUGcuQ8=;
        b=pgigyQxRIvnUMwttjb0Vq0YSQetjxRFMBOje/NRTqEphYhxWFpOI6PVvi910vek07N
         AU5IaJ/Ttz3euzcDLKizmgLsYrAkgYvJ6wrJw3cyxEgpBQmYWInbn6GlUvIlnXHpG3lm
         VHQAcVhC0Ag0ao1Q5CdGX5RhtlH6YNxcqNzluWBf61VP71Hv9eBENYwrlMqh6jc6K9G1
         nt7mtSvo3vdBKJhxQ2ofsU8YFL2sBuK2DMwTRG5Pr2j72hUxDQpQCbbACXkwO2MeO9R7
         OBCtOC3uv4q0L6aISMpT+OChBubuse9S6N03W5KjXxMmCPuss3YVYHTJOJja/ZB3s6L0
         sxZw==
X-Gm-Message-State: AFuF++lsYmZG0DuutwYkEP6dnYpypvTsPHEgKIx28pUJqYJbw+cS0xiR
	8r9pBr5P49XN2lyCgaMCTUwfKHlafaUkARjpENp8L1OgpqOdx7Va2tm0
X-Gm-Gg: AYBFou2K5WaD32d8Ae4NkEBxOx09XTuaXm2KHP7YXs9yKXoW+hLvI1MMTMLYjIcq/8J
	ZxumpwD63mc1AEp+IezjOURwLETrdqp3sZzTqZ2MsCKivHBmIWrxIADh1cxuG2ohbxfrtteTGXl
	TGCBcmVz7VTyKCoNqKuYA5qjq7H2ROUJj6Ss4UmNhpumsT6jvmz2ybhHEk+1J6Y7cwEnFGiA8BR
	rZ4Bynh5ru+lcrueOHQ2FgeQCx8Os8/YQn62Cz1sj8U3YuMbYHW5bLL2+RIG5Ns0c1AYKj0SnVx
	hn28eaCVImXfOD66o9e03usKEg/lZAOwUzH2EEUWdeqfpcE2M7cfMcxJzEcm3C3liQNiGNR8Ypc
	GYRWDpX6sTYpxRJD9Rwja1lqmLyFnp+xdZKOw+5a3e0yRvnkCZrCdU1btTlubDlHKclw9/263fK
	r62x+Jjf8gbYxlRzPq9zfogfhdMdIa8IVPvJa2HDD3pBvmZ0EaPRkpZawSiZVylPrMLORYCQ0qI
	+f/Tl5yM+HHAlvJK0x8K7MHMkI87FpkH677MjpdI37x/YKlBKwTE6DWADqMVn0iHZjpIzYwS12q
	XnvgoSml31NOkDNOYD/5sntiI5ZEv50Z5jBfCZD3++5SoZ8=
X-Received: by 2002:a05:6122:e261:b0:5c9:c60e:f4b7 with SMTP id 71dfb90a1353d-5c9c60ef783mr5263547e0c.21.1790049200145;
        Mon, 21 Sep 2026 20:53:20 -0700 (PDT)
Received: from ututo.. ([2803:9810:87dd:de10:9e9d:ca05:6a44:76ed])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9e7ce53dbsm525835e0c.7.2026.09.21.20.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 20:53:19 -0700 (PDT)
From: Lucas Costa <2000.costalucas@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lucas Costa <2000.costalucas@gmail.com>
Subject: [PATCH] staging: sm750fb: free cmap on framebuffer release
Date: Tue, 22 Sep 2026 00:53:02 -0300
Message-ID: <20260922035302.167378-1-2000.costalucas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver never calls fb_dealloc_cmap() after it has been allocated,
so when the buffer is torn down we leak.

This happens on every unbind, and when an error is detected in
sm750fb_framebuffer_alloc().

fb_dealloc_cmap() gets called before framebuffer_release() in both places.

Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")

Signed-off-by: Lucas Costa <2000.costalucas@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8b93bfeb217b..92412534239c 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -910,6 +910,7 @@ static void sm750fb_framebuffer_release(struct sm750_dev *sm750_dev)
 	while (sm750_dev->fb_count) {
 		fb_info = sm750_dev->fbinfo[sm750_dev->fb_count - 1];
 		unregister_framebuffer(fb_info);
+		fb_dealloc_cmap(&fb_info->cmap);
 		framebuffer_release(fb_info);
 		sm750_dev->fb_count--;
 	}
@@ -943,6 +944,7 @@ static int sm750fb_framebuffer_alloc(struct sm750_dev *sm750_dev, int fbidx)
 	return 0;
 
 release_fb:
+	fb_dealloc_cmap(&fb_info->cmap);
 	framebuffer_release(fb_info);
 	return err;
 }
-- 
2.43.0

