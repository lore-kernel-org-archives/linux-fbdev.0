Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A611D1D5AD4
	for <linux-fbdev@vger.kernel.org>; Sun, 27 Sep 2026 05:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790485981; cv=none; b=VaKuc6YYPIkjEmyJOfzp6uh4n6FQi3nCg67vrTGC+oC8hrur379nzoc4WJ0FeHdET/JhRySQMjagqpAlG2pPn6BwF7UTGnOEJb7gWZcp5QeT3kuw3bwido1d0QaGGo+728AioImvtaSV/sDEuJKrcHMwBa++hpekvlLsAc7GSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790485981; c=relaxed/simple;
	bh=RiJf6iWK+usISOd4aWwdvTIAae1wviS3r9OeiNIPnXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTaN5E54wsWJyrgCjdfAdRPgzm1F1mEKkczm1DJU/PWP5Z80GoioSbGypgKIcboZ6bbxsoF5uyki8O0nOuDzVwnlF0Y9IUmqrwwK1GXp15t9tklxsvAAH7WOlnxL6h07vhIvit2Twri/K+vw/SmCBzH+dafIuGWzlhTf6lq6u8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKMkqb0u; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKMkqb0u"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144e32aaa1cso1098395c88.2
        for <linux-fbdev@vger.kernel.org>; Sat, 26 Sep 2026 22:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790485980; x=1791090780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Li1CFbWIegv8mAz9zTeIVGn7vrMtVUxmg53aaPsA4qQ=;
        b=OKMkqb0ulJGop6tQIeJoEPqwqtm7VoxOO0R58ltrHWx1jAWwpwJZRIBMcm9Mc93tIx
         9DeGyFJwzq/swIr/AOoT3GDJNrFpnSoQv1gKQoRutNq2AbJDq3ZJG0eVPZw3P8jAtTX7
         /ZD3uhQbIs5Izsypzm54IJrV8Mbqda9VNs0uJbfK0SEQbjizqAa0w2f9KQTTWOs0F0v/
         4K+5qmOUgd94R8pemW4VN1Px4RDrJOD0l8a3A40x/XN7z3peXpT+zvNhqdyCtDhrDSel
         TPA7lCFK71dS1nqR6CjpZw+ZEVeNEggSK6LsNnag3g8n8WS/xs79J0mFJb7L/9CjRHix
         J6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790485980; x=1791090780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Li1CFbWIegv8mAz9zTeIVGn7vrMtVUxmg53aaPsA4qQ=;
        b=2J1NteI8kbplAYKbgSQZIqu/OcNLPui3BleDA+TrcNdrv+q6z9jPkfJrlcafQzxOjX
         ubBjGRLAx70Pi0m0oQxi5wlLIIFeLHbHNxYAGsynnNiMvC4KRW40um4Kap4AmOclEoAZ
         H8micaRv08HzoFfjcq8rYc924g+LUfTfRScoFAK1+vxwxioJfo1RErur0FjAb+J71GE2
         Uhp6TYbLsV+2C4S8hyhojy5xg0r8abKoHqydpDAAumQvxK05PaW7X3vdX32G7U6HwWkw
         aQZXyA0JIynDYoBcvyI8OF0VznSDg21Ee3RWHz93P7SLXm0WXoRa7vgywBCqiJqHt7BH
         WlnA==
X-Gm-Message-State: AFuF++m/N+6q1PpvG5mRwoxdgr5ReHJ8jVBsGdXalmbIcXZFHSDULinj
	+eZRZIVg2yAN6as6BU76S8mIqvFMJlQj66U76DbMuro/0p57PeV9bgr3pIrez9xPWWOzeQ==
X-Gm-Gg: AYBFou3u0w9p2bHmP5n9ILMYfeyuetRVri8FoDsryDWtk1gzFBXHJ1Ny9m/qc4bo765
	ks05yhbEigm3413764acTieR+amiLTM5u/3XJ+jYqDHIeWgHvUrsWs27ltreJeDW7dt2mw5Hr8y
	T36ILkN0u5U2yqhJ1wqm8EdqEFJ/qmumGhx1sFMVxu5ApGbkNrGfr3H1K2mV1slw+nkmT4KNkUV
	zanzKS5OigQzLSEJXoo8RiGiUy/Z8jurohIERlkZTQm1OUtPbUHGC1psdhWH06r9To/4Man4aHS
	IB8BIQ4SpZ0ly8q++QcL5hviYSgFjZj48Xfo2z3w4ZxPLG3bqAZhUAG+h856tCBivl4dydes5rf
	JIbGcnRn5yaF3lrYZts3yfHxeSVFZlbAGAeUXf2ziLIKkGkegkhNmvqjsoygfMJotV9Obcgswno
	o4k6siVh7X4CL15CUn2aHtYceyhgaahGjSyVBsL2fsqH1SBmweBgFdaeuUAKzAK88m+H7zAgC1D
	ASMNJHAJWce3o0+cVV6kKUqOjpbzK/eEVkPmXet/oyiDIEUJCA4jlI20KNCjQ5+PQD/NRmpfr2a
	isNYResf5YuK3/3Ew/6WWgatB8s9hZ+MBPaOObIcIBO3opJX20pzkXfpMJDs
X-Received: by 2002:a05:7022:ba2:b0:143:297d:21f6 with SMTP id a92af1059eb24-146d0497c6cmr6882989c88.35.1790485979436;
        Sat, 26 Sep 2026 22:12:59 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145aa0cb7bcsm14790970c88.2.2026.09.26.22.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 22:12:59 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] MAINTAINERS: name the deller/linux-fbdev for-next branch
Date: Sun, 27 Sep 2026 13:12:56 +0800
Message-ID: <20260927051256.2752154-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T: entry for FRAMEBUFFER LAYER names deller/linux-fbdev without a
branch.  The repository's HEAD points to branch master, which mainline
already contains.  linux-next merges the for-next branch of this
repository (Next/Trees).  Name that branch in the entry.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
This is part of a cleanup of all T: entries whose repository HEAD is
not where development happens: one patch per repository, sent in small
batches.  The plan is at [1], and why it goes out in batches at [2].

[1] https://lore.kernel.org/all/20260924033200.3615554-1-matthias.goergens@gmail.com/
[2] https://lore.kernel.org/all/20260924101844.2403008-1-matthias.goergens@gmail.com/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 140eafcbbd78..b275a2254738 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10339,7 +10339,7 @@ L:	linux-fbdev@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git for-next
 F:	Documentation/fb/
 F:	drivers/video/
 F:	include/linux/fb.h

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.55.0

