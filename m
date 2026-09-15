Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCAB2DECA3
	for <linux-fbdev@vger.kernel.org>; Tue, 15 Sep 2026 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789433573; cv=none; b=ehmNWYf30jjiAvq91p5p0iBba7clSEtZZQEDaoMdEMx1bd00CWMJxyEp8js54nO72ogfipuH8d9jZ6nCHKY5oM9eUm9CqaQ3j3rm0SpB3Diw7nwMvobrzgvfdPtBO88o216Hd8ynu2hVTtWjdPfgECH7hjN7d8OVzQ7ZQcY9AWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789433573; c=relaxed/simple;
	bh=E99Dz8Xkzhhbw+xuuQIQ9G+/9ex1yfLS64o2aGg11Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CBwAdAdUnd+EsnwBatqeAUKsJaroNWtP6O18I1Qjrq8lcnMj8XFG3xsj4KWaRwXsIsYmUTnZpVfYjvgocpJoxk3dMQwTNfO6CzDRqQw/RTeQ6Ap1WzZx6qEzdoqy4DqyNpkzv6B/kLL+ZPD5mWk8WnTEszBqfiq6dyoVjukpKoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1CTYEDm; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1CTYEDm"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a135ffb08so283577185a.2
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 17:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789433571; x=1790038371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3FqhYN8GqnOvyCCd51Tqy0N6wSmRpiZ4v7QBDM0Zgas=;
        b=F1CTYEDmcTExQNcdaz3vsmywKGilJoxn78ItFjbED8LVZnB/4daP0tpTU0Bt/2Yi49
         xvk7Hca0PAt8yv6cMTjSEHKNBHzcHlMEnRF7L2vel0P4e965YE7lKB2mDYs5Ij7ZgAs1
         +BcQOK0Jr6yfZruAEyKQqdUMXIrY0n5Hii9yc13N6Px/BCvZHBrQG6xKRSxf6DGyUvIw
         0dS9yFjlmSIu7lmpV24v68MNTi4iRBAVc0qbT9EvtxnRJlC/SazFqk7RxYdOBzb5haFp
         DH9nrawo//d3JIT2Gbf9L/raZa8jKkrydYO2yAQHCjvYcP3b3rGLSGedcpr5ld+SbDVS
         /40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789433571; x=1790038371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3FqhYN8GqnOvyCCd51Tqy0N6wSmRpiZ4v7QBDM0Zgas=;
        b=E92u97h3legnetFhNtZ5daXOFWAg/fgHxolOAiM+I6dBNUpWDmVJ7h7mF0J/GQfT/g
         0HEAk2i+avhCWqCQDo+Vy79Yvg3EpEDY95R8yuBy6IKkfhfrfZr7t9fDKOtVSHsRYH2I
         m/832lqEMwnJ8RFwSq2jVIYs4XOPbI/Vzy2GS2oman/Owc0ivCFvVGGCUtMWXrww90xR
         lgQND0KMqlHe9HHV5pSGvekETicp68rWvjvY5D724yyoCl52yxLscOAedJ8nuaoC0xFz
         LqHB7MIfqq8SnEUVNcOG2NHzuvi0cP1qbCtZUBwdazL1WVsy4+jQpFezLnqKJ/Pg8Fy4
         cH6w==
X-Gm-Message-State: AFuF++mevq2TeTC8bW94q7K4fF8Zt6aO0GPhQ6zwUznv68pQAzr9V1DF
	hYKGn1pqHHyDjbBsZiIL2UBFOqAioSuPvS+9+dkTb34GKEeQU41Pf9qjM0PSp30=
X-Gm-Gg: AYBFou3dhYqWC9U95UpBP4xMVzNCit6a/B7mmn6ZqAjSLpwCidnhkLQPQnhBmQC4oS0
	WoWo7j3lf7BUc6Gxp0DZoJJxER3781bgkFBte7PUCBvK7z2VAnHQCMUwyAqvKJkUlUOxz121sTl
	5uC/y+OT0oDHzocT0Nm9Fkl4Ww95c47lwbrqFQrtNXzxduwL/reay9j6afEV0fVzipNUEplY/dJ
	zBQxU2YmH8eop5AhpR76wWIeahzGlsurV7EGTz26s6mBzpdivANfMYXEAnPhuhYbXVVAMS3el01
	pLvWHQ0VJoUYZGwUFWzQd0KT0v0EPZP2/q8xfoaFrezD47PzxGoclLV48p91x2+HgyaTrQmMTx/
	gE2H5bZ4ek4iuElLQrm/aVydVy2/g304c/LeuQ/ftgWsnE6ZYKzPXOQZMEZtn+Urqd3KCww1zVu
	yLg9byUHRr7QZwrPUIBZXyzvoXHiPX9JYAwCzUboJAOBm4RraZ9nGukK2aJ9xCcYCi6z+HuncMp
	ExwGd24tnH9CRAdj2gGujziLPRoACioZODwqJf84TMzewfO02usnJvBli7+qFDPN3aHSFieb0rN
	Tc1xCtytvN+nXmZZ1nJEp9e6WwP000ab6A1EMe0W4SRY2XUmhGOspGtBNqGNIEqF
X-Received: by 2002:a05:620a:468c:b0:939:d913:9a74 with SMTP id af79cd13be357-93a29bbcd86mr667300585a.46.1789433571426;
        Mon, 14 Sep 2026 17:52:51 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ecea9f35sm1063205785a.7.2026.09.14.17.52.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 17:52:50 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: kyro: Release WC setup on registration failure
Date: Mon, 14 Sep 2026 20:52:43 -0400
Message-ID: <20260915005243.51683-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If register_framebuffer() fails, kyrofb_probe() frees the framebuffer
without releasing its write-combining range. Release the range before
freeing the framebuffer. Earlier failures still skip this cleanup.

The missing cleanup already exists in the initial Git import, before
the conversion from mtrr_add() to arch_phys_wc_add().

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/fbdev/kyro/fbdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -759,7 +759,7 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fb_memset_io(info->screen_base, 0, size);
 
 	if (register_framebuffer(info) < 0)
-		goto out_free_fb;
+		goto out_free_wc;
 
 	fb_info(info, "%s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM\n",
 		info->fix.id,
@@ -776,6 +776,8 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
+out_free_wc:
+	arch_phys_wc_del(currentpar->wc_cookie);
 out_free_fb:
 	framebuffer_release(info);
 
-- 
2.51.0
