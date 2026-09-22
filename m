Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55555C30A
	for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087346; cv=none; b=hVsDK1nntDeEJN6GVeg1yuSFAUo9zI0xLImvm0VuT5RCcCwLDOrCPG/89CYH0cMvNs4VnC5VwFge2/EzCoXrhPaeGabjE+zQYqUbRFpqDu92kad11OY2oyojs4/FZ0bbOsIaM4ElX1Ei6qiA7EaKIhAeTDienCbnB2arMXHy6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087346; c=relaxed/simple;
	bh=c7JTgkgxiJZzFcL8GFK3Qn5+caW0zeCIOU8xJz6971E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rb6zLgyWlQv7QSvlsk+8Dar5I15lZq5kCOjhUOh2rCTQ35sm231XeBT+zBaxH6xnmWi9jtT65Lq7VMzniP6pL/IZYtWeGJu1VIL+IjbZSRkQK2YX2HMYir5JMSXxyud3rFfWhZPiBeahCxvvms/4s94RrKxyJ9M0p5djg9RZPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/HmVCAm; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/HmVCAm"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a316adfso3098666b6e.2
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790087343; x=1790692143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CeGWyXRyZoZYh2jsPiBOqtY72lLN35VvTEYYsvF2fT4=;
        b=C/HmVCAmc325FCdDxGC47T9vrwN6uHt3G2JnmPUspZIDSFiHDOogL1BD2p9Q3igyKQ
         r3tah1fXxI4V9aSF9ULievvRSjwq4/wdq8kPtVBMSf4Qnf+qjHHCkxHyCqVXwU50IMO8
         Mej3S35j3NANmHphAr4TnZpKzsO+9fJ2i4psNl1G3UTkFMo5fBCAySrXpCJtAyF/pj5W
         kEV971d3rX8kyDlMEHTZeFAqh25NPIkbhCq1AkHWoEKet3miZYvVcgPHP75XNkikoVru
         r9641US6fsTcV8VmhrdUxNGH20MwOzYimO0g7i8JKLxGZFAgBvc90cjnmYZoytr41FYe
         IsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087343; x=1790692143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CeGWyXRyZoZYh2jsPiBOqtY72lLN35VvTEYYsvF2fT4=;
        b=UHwagNNXaawKsOlAypUn+UB+yPisZ/k68BXHU1TephUOuX1enSCbDBO7xqD0KSGlmk
         uN4dm4mSEzl7y2qhZ3/b4RYWT03FQtGu2Tp+OxfsziLrVhKU1E/Cwyo7Ji9mQJwtI4xY
         w9KAClYtJ+KqYDqNwx0DDLm3LYuY1yyez/civnIjqxaiLsCxboZXS1ME7tNllPb99vnC
         XNux6QoHjeVjOWs+OoIDgEVm++V3yOq1s+21QoVT8ydtC+SnaXTEUuSoUGdtOQeEro9j
         a7f0c5OV2HXcgv5Nqk5faadZ8qIyQVvKRVy3vHRypqBnh1NN77MUuA1YeX13BjPMzMdO
         ZBQA==
X-Forwarded-Encrypted: i=1; AKwUvBxAYilbox7Mw1i9ynhGRCAEhHtM+1ooEs0erwzu4bGX3O4IFjJiK6o8HPD5xWs6Dp1C0rDa/oRmO0UBPA==@vger.kernel.org
X-Gm-Message-State: AFuF++nCfpk4S0lFg8qGXwGY/d5KXQixMiJ+WR5yaiF4ycomCLpPCy7f
	jJSbHeeM/3Sb+FEauUO7D/43ASxv2Lbumbdo1VEI42stFfs1sjbV8yJe
X-Gm-Gg: AYBFou3m+33sEn328398uZs1i34If6wTw6wb7uKbHVRYxIso6J3WnSzYvcSA74Uv/sU
	wOq+BPa0BJu4h5ODynGAPtFIUxTHDFWE8I5AfoHgTk6ebxswwtTX6sMu72K2tYdmyZUj8k0QLKF
	3CGcq05uDTZyeGjmOKB3jMN/u+SoPsW8Wr58XVOGniwkzk6tk/J3CLgov8SdHZF4RQqvylNJ0aE
	TFa0g7hm/pb8AiK8Bbp4MpGt3KZE0BKjoIL611ylGkKozhyjVbGnhgVrqjZzOL576aUACogT8sP
	ld90CWzl2UqbEa4mA8SSs4huFhFdb60HPg+86kqH6NbXIGTlAAtdgXT0OYc5XluRYU21aNlYKgT
	zSnDBnnOBpT2gGXn8DvqzJeOKwkZQREVbBsFcVzZs/11fyjxMoy7s7KfD/KA6SpyF8Fqc5ViISk
	+4T+3+IBt9BRsE9QgEbSzckpk7L5JubeYQIkSO/1RuHfGTBgQn+psOCZibTEL1MCfrY0xKNuSDP
	H9vqD9rvS6M/ZZI/LyuxyTk14jWzdAzGUmpAkaPz9Z2m4U0rC74A//Tmzx4iBZU6rEJqtApn1SK
	bFFNXbxFvejYcuR8rM082TqZXVPyPOXYeGlf7kxIVncxL+Nz5SYWSWgO2A==
X-Received: by 2002:a05:6808:30a0:b0:4c5:4eed:b447 with SMTP id 5614622812f47-4ccf6a74ebcmr15126478b6e.1.1790087342564;
        Tue, 22 Sep 2026 07:29:02 -0700 (PDT)
Received: from ututo.. ([2803:9810:87dd:de10:611b:6da3:8cff:cdf1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d4c0dd2244sm1467147b6e.8.2026.09.22.07.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:29:01 -0700 (PDT)
From: Lucas Costa <2000.costalucas@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Carpenter <error27@gmail.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lucas Costa <2000.costalucas@gmail.com>
Subject: [PATCH v2] staging: sm750fb: free cmap on framebuffer release
Date: Tue, 22 Sep 2026 11:28:51 -0300
Message-ID: <20260922142851.46724-1-2000.costalucas@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922035302.167378-1-2000.costalucas@gmail.com>
References: <20260922035302.167378-1-2000.costalucas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cmap is allocated by lynxfb_set_fbinfo() but never freed, so it is
leaked when the framebuffer is torn down.  This happens on every unbind,
and on the register_framebuffer() error path in
sm750fb_framebuffer_alloc().

Add a lynxfb_unset_fbinfo() cleanup counterpart to lynxfb_set_fbinfo()
which deallocates the cmap, and call it on teardown.  In the alloc error
path it is only called once lynxfb_set_fbinfo() has succeeded, so the
cmap is only freed when it was actually allocated.

Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
Suggested-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Lucas Costa <2000.costalucas@gmail.com>
---
v2:
 - Move the cmap deallocation into a lynxfb_unset_fbinfo() cleanup
   counterpart to lynxfb_set_fbinfo(), instead of open-coding
   fb_dealloc_cmap() at each call site.
 - In the alloc error path, only unwind the cmap once
   lynxfb_set_fbinfo() has succeeded (Dan Carpenter).

 drivers/staging/sm750fb/sm750.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8b93bfeb217b..68b6d4fe79ca 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -825,6 +825,11 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	return ret;
 }
 
+static void lynxfb_unset_fbinfo(struct fb_info *info)
+{
+	fb_dealloc_cmap(&info->cmap);
+}
+
 /*	chip specific g_option configuration routine */
 static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 {
@@ -910,6 +915,7 @@ static void sm750fb_framebuffer_release(struct sm750_dev *sm750_dev)
 	while (sm750_dev->fb_count) {
 		fb_info = sm750_dev->fbinfo[sm750_dev->fb_count - 1];
 		unregister_framebuffer(fb_info);
+		lynxfb_unset_fbinfo(fb_info);
 		framebuffer_release(fb_info);
 		sm750_dev->fb_count--;
 	}
@@ -936,12 +942,14 @@ static int sm750fb_framebuffer_alloc(struct sm750_dev *sm750_dev, int fbidx)
 
 	err = register_framebuffer(fb_info);
 	if (err < 0)
-		goto release_fb;
+		goto unset_fb;
 
 	sm750_dev->fb_count++;
 
 	return 0;
 
+unset_fb:
+	lynxfb_unset_fbinfo(fb_info);
 release_fb:
 	framebuffer_release(fb_info);
 	return err;
-- 
2.43.0

