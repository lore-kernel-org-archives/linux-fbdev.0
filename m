Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274585FB99
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710805596; cv=none; b=C43hkF7u/TAIjuY2LPec5qLvpkiP8vQen8MRhkL4PcIp0F0DnMkYJMWFdvrPe61RMUlwWVNtOGqUYdnw/0xtgAlGhTORPGArxgkyDDel5tJ7mVXhelrwbaiQYeT5VzU+yxklade/cAHp/t1EtUG6+oo2iVBCiS/B0QjT6V33GCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710805596; c=relaxed/simple;
	bh=SWuJT1od1lHkTaQ+y94pwMpDIt4RqOBKy+5+YAjUbf4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZiJngoUwdw0hxM6FfKzY4KWKGFoI4vqxUmj5OfHil64T2+vFBfL88vDzJI4kBqCU7MDtn5AIO4ouJaTRNGQ860dGAjtVTtt3a7Kvdcl3/AQV56SUXAL/KDQKt9vsylR4kX2oWJgw2W6eG+wD3ebnA+7GnsQAyNukbgwt71V76BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2VuDwZ0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2VuDwZ0"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60832a48684so76736017b3.1
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 16:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710805594; x=1711410394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lT28vCErvodzmWvEdtP7ojnGOwo1TugtSNi45cBTyks=;
        b=l2VuDwZ0O+mCqYjzUCoRSpxZdjBLHdJbTilEFvdppRrDtPdHK+7/I7TBhh52nOZXuu
         QV65Y7RAx0Eic7RrjoNpx1lAl+gpbzXeiVYgtHxGH0RWIgNr8u7cOjU1Q9mPmsxOzpiV
         PqTgBzzCtH4XseLw2IwMgYR65/9ElAR7Lhl7VHlmSAy1uRxpWvvxVFjYowHi86tlI2ts
         VxK7JWFCCN/2b1/gp2fMXM9ulxmWKF28tZ1UkqsKwbmSLLc9qrlwoCBCHTKtQe/xJR37
         j1r3tQ6Y56ByXHYDfDOP1bnhbJHt9tHDfqZ/Huqm8Ozlq8Bxa8osJGVJ1rpUBg8kgznF
         p+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710805594; x=1711410394;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lT28vCErvodzmWvEdtP7ojnGOwo1TugtSNi45cBTyks=;
        b=dvBr8DwG2Cq60F43flQ6Xa9AiGvFeK+v2aKhw7Qj7OXQ+e3RuQoVgSuNo1QBbFgVSY
         vua7BQdV36MmclhPEwx1IpZFUE+qShDZT9VwT2/I867o9a0v8Tnon5hiBmggeNmV/hwx
         BVW09NFSU3UmEI4OudF8hsrKpbDMRooTfzDFrPlAZmYKdJEqGbvz+tDUmZZNVgZhGmIR
         b+WA5AXS5GSLd5mnWgbpdhj6QzgqxCf9GFA+/2baVKwyJf978y/X1FToHnlwCtzUb20U
         81m433ITjlMuCC26qfSqHQQB/hdB4tavf2G0s9XRxM+Cy7UNfXxiDKks8Yy5YbKIsK/7
         UnNg==
X-Gm-Message-State: AOJu0YyKcVtdQfIOK0/mnOVkvuZOmZMTiIXhfXiqYNHop0O+MuDpadKb
	oC3FvWf/3rwigJ0Y55IRmS4RaHGOoqhz4h2gfxSA9LEiWXLzbZLUuEuZ2UpMlOTYcNnKiixi67R
	q3/GTR/EGsrsZsXuWcFliXA==
X-Google-Smtp-Source: AGHT+IFVl8OTSlqtieEkI8wlprKnHSBkJvt5RLX/AaTjUcSMTHpdrj19ejltSZTNHQk3a+JhkINV8z81NefWgOfVyg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:d64e:0:b0:609:f0f0:20c4 with SMTP
 id y75-20020a0dd64e000000b00609f0f020c4mr2543290ywd.4.1710805594283; Mon, 18
 Mar 2024 16:46:34 -0700 (PDT)
Date: Mon, 18 Mar 2024 23:46:33 +0000
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFjS+GUC/x3NQQ7CIBBA0as0s3aSARpbvIpxUWDQ2dBmUKJpe
 vcSl2/z/w6VVbjCbdhBuUmVtXSYywDxtZQno6RusGRHcmbG+tYStx8mlcZasUniFXNI3HD5GEu UA0acQnRu8n4mf4Ue25SzfP+j++M4Tu6YecV4AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710805593; l=1826;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=SWuJT1od1lHkTaQ+y94pwMpDIt4RqOBKy+5+YAjUbf4=; b=trEZV2UKkAi41dKgex75moannI2KQl33HA1LGTyC7NWX4DdBAQaDs4goCEd3ncaVz44gcj6o8
 7tqlG14jzZGAGKGyXgxHyxdOo/JVZkY5LfpDC2UOEB9knhmDvAxhv/j
X-Mailer: b4 0.12.3
Message-ID: <20240318-strncpy-drivers-video-fbdev-au1200fb-c-v1-1-680802a9f10a@google.com>
Subject: [PATCH] video: fbdev: au1200fb: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Let's use the new 2-argument strscpy() which guarantees NUL-termination
on the destination buffer while also simplifying the syntax. Note that
strscpy() will not NUL-pad the destination buffer like strncpy() does.

However, the NUL-padding behavior of strncpy() is not required since
fbdev is already NUL-allocated from au1200fb_drv_probe() ->
frameuffer_alloc(), rendering any additional NUL-padding redundant.
|	p = kzalloc(fb_info_size + size, GFP_KERNEL);

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/video/fbdev/au1200fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 6f20efc663d7..e718fea63662 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1557,7 +1557,7 @@ static int au1200fb_init_fbinfo(struct au1200fb_device *fbdev)
 		return ret;
 	}
 
-	strncpy(fbi->fix.id, "AU1200", sizeof(fbi->fix.id));
+	strscpy(fbi->fix.id, "AU1200");
 	fbi->fix.smem_start = fbdev->fb_phys;
 	fbi->fix.smem_len = fbdev->fb_len;
 	fbi->fix.type = FB_TYPE_PACKED_PIXELS;

---
base-commit: bf3a69c6861ff4dc7892d895c87074af7bc1c400
change-id: 20240318-strncpy-drivers-video-fbdev-au1200fb-c-7bc337998096

Best regards,
--
Justin Stitt <justinstitt@google.com>

