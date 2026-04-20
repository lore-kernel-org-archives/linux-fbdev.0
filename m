Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743973D88E6
	for <linux-fbdev@vger.kernel.org>; Mon, 20 Apr 2026 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692702; cv=none; b=XRmF+yBWAneYHwN9Qw69PUI2WGvlzH5QO95vQOE+oYLsRXiSVTHICnjse++1SPIo1lXikxn+bEYxsJfDTahZy87jNsknlzXTDNUDc2XlRBXH+FIkMxVfwc+tDJmEwXYKPxq2Xzj+mKTsJDjgVojvOXB3VmwUq+F/O4UoQtL/h7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692702; c=relaxed/simple;
	bh=SHrsEy/TWPCXDTGyPfHap2Vc8jqcLC9s+Cpv7CgrHjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y9oFrtMtiOfdo3vvZeT5AKGdhQzJ7VBuw9IrLS+iPKc1h3mbK13RrnRldSJsl914ouMze132gLaBTuSKFsinWKpzKkfKItueMfPSNmRPzBWcV2/vU7llE40nYN7hvqKtz5jVTm+dbw73pnxoH4+FUCOWwnwa5xkmwZynKR/0HVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dERXAqKM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dERXAqKM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso26288515e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Apr 2026 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776692700; x=1777297500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y6I5D+MUBwqgLFI3UEdq1+aGHSj6YwJYf2U1wbo8yrY=;
        b=dERXAqKMhoTfK1C8SsidOOEjq01DdDobspS+uiEKipCbaDIUalCvWvHvZ02e251yxz
         tAZ2W8Nc2RiODOOOeNyn8Z7Rqfh/hSRIzWXh36F8pPcdxEP+Bi3L++Wuiu1lFDmh9cix
         LRM1oRzhpytiaOIqk4OfVICS3E9gNJYImqgJbZHkcIRGg9oa5Kkyv2FrOvLPYgFlWzb3
         UMvwL8L5cN8sAk7n4FvYnPSIPYOlRnOEegMVPcf19Nvvv2YkL5kL/wPBb9eAUM3T7mNS
         Ek8EF6HXBRDgA082bIpYVD23x09XZfV7+f5QI3CQqo3JjMPVY2JCaeg1Z0hMOQ+K/svq
         tsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776692700; x=1777297500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6I5D+MUBwqgLFI3UEdq1+aGHSj6YwJYf2U1wbo8yrY=;
        b=s8CTWXaTelSzwJV6LDFg6F73Jkpma9er1Lr5Dcrg+kYPyiqHWvCW9SuwI6I7XZgdRw
         pJoLKkiBreKrzw1ALNN+OONNhVqpCuVXL0oqT8qtUVhKvjKNl37+reZg9WCoeWf9JCHl
         OYZn2BgCLA9+5O80Q0/O2RKq+xR4oa8kGh+6LT7Ui16IEjx58NlgDbPOQw7CejFFKyLI
         anpmLRx0a/ZIAL4qXPs96MdMbAxXxlEV7rrO9U+gYJ8/6mbFpwwlYq8mn6n0QxKYLIC2
         JD+tbUZMsHM02SK6CdHY9jM/8pqVmpzGby0XA+0Mk0VVdCNpHLChDYFgr/Hv6W04b6yt
         JlaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8V1qLmrkHOgJlUbayJoDbvCeByf6jsJmt4VhHD+66FYyupBIh4dp3+EEcyWW9oPPgbWgB2X6EN1sOs2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbpOsehtjO9MLeOzDJtPkq0JQiUGAeR34e8KpHeka2NVjG5zqd
	QcMXUPrumzwNeEBs06kkxs5o70wSULPOz7AR3Ju6zcjFXY8pXPP+iUottemWWBJQ
X-Gm-Gg: AeBDieurPSRBGY7Q6PByJFnxDKWO8WaiDYOEn447FgEtIx+M0oDpnsPGuLEt0yf7BNh
	0hv3HCnPA8VnnoPy9+7VTpb18w1Uoit7WeQVhdsPnj7a6AVozDcNH+tLPBund2rqVMdhxHg0a78
	D4ojxUvJIRSH0ea9sd27YutA3aSrTQ3JgSrwIHX2ZrSZnu5XZ1uYWDDyX2/KirpjVW5MwEFQaKw
	GMa0QQpkGd86Z4WiDASAi+T6wsTHjIN/riSVTf8HoQk+xQbJ0q1d76r4ETYGwGS/AUOjA1xEqfn
	C/gsNBbiRXT3r+n2I5bLptMhS11UG1xLc3zueODXYywvlfKg+H3wkKYTKziy8mFPJJQEeT7jHOq
	QcJJVTaSAnrzWnh1GcWaCKKm09Zt9xzgIYpZQyGQMTubBfzh0ZnjMactPXpZSqtnmCNqOJE3sVc
	httrbTXswu2jFuC3/WRYYlbdo9JBNRpwHowxIl0JFB7xzlzYYvJoI=
X-Received: by 2002:a05:600c:890b:b0:488:a977:8d6 with SMTP id 5b1f17b1804b1-488fb775a35mr133481065e9.19.1776692699323;
        Mon, 20 Apr 2026 06:44:59 -0700 (PDT)
Received: from anthony ([2a06:c701:499d:3e00:12ff:e0ff:fea5:3d2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm29302178f8f.13.2026.04.20.06.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:44:57 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: deller@gmx.de
Cc: thomas.zimmermann@suse.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 0/3] fbdev: Request memory regions in platform drivers
Date: Mon, 20 Apr 2026 16:44:21 +0300
Message-ID: <20260420134424.77494-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several fbdev platform drivers call ioremap() on their hardware MMIO
without first claiming the range via request_mem_region(). This leaves
the kernel resource tree (/proc/iomem) with no record of the mapping,
allowing another driver to silently map the same registers.

This series fixes three platform_device drivers by switching to helpers
that combine resource claiming and ioremap in a single managed call.
cobalt_lcdfb and clps711x-fb are converted to
devm_platform_get_and_ioremap_resource(); goldfishfb is converted to
devm_ioremap_resource(), which also lets us drop the manual iounmap()
calls from the error path and remove function.

For clps711x-fb, resource 1 (the framebuffer range) already used
devm_platform_get_and_ioremap_resource() correctly; this series makes
resource 0 (the MMIO control registers) consistent with it.

This is part of the ongoing effort described in
Documentation/drm/todo.rst ("Request memory regions in all fbdev
drivers").

Amit Barzilai (3):
  fbdev: cobalt_lcdfb: Request memory region
  fbdev: clps711x-fb: Request memory region for MMIO
  fbdev: goldfishfb: Request memory region

 drivers/video/fbdev/clps711x-fb.c  |  9 +++------
 drivers/video/fbdev/cobalt_lcdfb.c | 12 +++---------
 drivers/video/fbdev/goldfishfb.c   |  8 +++-----
 3 files changed, 9 insertions(+), 20 deletions(-)


base-commit: 3f9357c30a44734d45e3093c521d52b2aefb09f5
-- 
2.53.0

