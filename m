Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E603A21CC74;
	Tue,  8 Jul 2025 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001099; cv=none; b=NudqwgVGH6z4XxDMw34+jvpYY1I+7fXTwPPbB+yZualDd1fLPqOIgUzpZ2k7L+ZoWjSr0yQ7b8bwGN1npD3g5yiPJQkN9xOhCW2+7aYKIFiypUMtuiaQw1MynPoP5Tf5Rd+YiBptUWijYI9GCzv0jHhd1MTOMeOCu/3i6Xn8xxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001099; c=relaxed/simple;
	bh=vyzLeqzfjfLrgQF2+83v6jXchD84NALdKNJprbDH+Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZFwCeDD9mTc5e03Julm13JxOndL6regsfkMNA4NfqYi/siFBrXMR8EqTP8UzAQakj87v3LJ6yfAosnfQZesGV8ArW0EaqQPBSfELPemvFoLdvG6ytPy3rbFaOsgfpzNdaDLhlDwY8cOUUk9rpwR2ooJg3b2C8mTdlajPgNtrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhUbRTIt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhUbRTIt"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso9307383a12.2;
        Tue, 08 Jul 2025 11:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752001096; x=1752605896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMoAvbrxtKsq6oPqfXZMpup7TKaRFl1WTnF7F859PKc=;
        b=DhUbRTItwy8ddZWmGCRLIQYtbzUt8T7XHtvjdUVnQu2I+xEZMdolxaIvTdSkZ5E220
         16sqLCqJ5rfxPWufTOyOAXWaJY9bL/crKXJgoP3R7hu8Bzfel4/1VVuO2oFd4cWpbpmh
         olw3oy4y9M+H1WuYzFFVz4UU5+I9fabQDDUysEu4AKK7hW+pptCZyplALulZsbduDJNZ
         ZESt0r1G3vprRM+BHdiCbYnmTv5Izhmi6z/YzsXS0LUPLgNwZHs6qZS3uzRWGqY4wVKD
         M8ssLYja1YF5E4uLQC1dGM6kDesC0rMZZ3HFTFRPAgdu/x2bW5CsUI5WGzwwSdxsBi6M
         ZPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752001096; x=1752605896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMoAvbrxtKsq6oPqfXZMpup7TKaRFl1WTnF7F859PKc=;
        b=J+0VG7xh2LRPWYVERWuigdJ6GtPHvzI4dE0EwgQ//VZmfGBur/rEGfar7mngDKcK6k
         JaxrH6Dw0vBuAOV+vE2cY3a5PQnSEiHj/uiWqpztaiKdetOLGal1AyRNcxmk3WRkFFOR
         je8U3zhAjwky852y3+/28P9mHI5KjJD3eKu/pGjOdiLrkuMztqXFf6nxuhCcHlmXXVbn
         hbMKyyRdjuDct1jsB1gUpDLuGYSvBlzGDSbi1rlbTxJMWUOwpygkqJ0Ab6AZjkFtGqiV
         dH+iDBr4hJeoJeWd0x2OQXmnHCANxHlc/UADiXJJBi2BswZO8fsiYRlDmBjcz0TZXH2g
         zpkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFUHnLBZz+44p8WIDFsPvNpSfmI53rTsnjvUSchUcW3+yIwptu+PIBC9q6eSAR0RYW4Up1r/ePiPvhdZ47@vger.kernel.org, AJvYcCXggP+hH7s6JUq62AdAu5P8oO8t3PRm57ymBUvIJDUCmlR0VrMPI+BBOO5MzroPfr3OkBUkhYYNlKQjxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaSr/NMcjOqTieHy6CgWp9gDFWZbzvgcqgbQ5fcr1GGHgDkJan
	r5/1erIpAZB94q7ZfBd/xmWLaUFoGbXFvEldUiYKD8TOXyUqx8Cu+V8z
X-Gm-Gg: ASbGnctULCf/qrmdLD4o+6c7vYZCwDIiB/N+O7MKbYKPkWsGMvEm7pHmx0cUBavMJX0
	hpMVOQxqqoVb/62ptdTApcqJJcD6JMfL2/Y0yLOWR3ljM5JlBu1t70zsR6qvnlUWwGTrQTFqW80
	sFCj5acH2Kzjwr1/wMhUGHomapxVGHlfaOOe5iVQKrXadpfsg1+ZHKLv3JijV4KxAnT2m5b07mO
	MZES1IgxAUHP0Y7MMI8eqUXT8OaMt5gJu/b7bc433tVCgv5QerUs+reWPurwdIRT8k/fbQlTFlj
	B4iTVPKZ08PoZ6E9oLyhBrmHoUH+59KMXvkC7ukss+VWFhuOd4Gz1xCaz5z7ei5zzeDSeWdD0Mt
	yJ/FQmDdJrrB26Qi4qtXcPPG6FdYkaeqsK+fuHFNHSu1CqFD9Wk1rX0KBce3ccT2ulSIo/qYYVq
	UsTw==
X-Google-Smtp-Source: AGHT+IGxD8PX5m0JgMwpN5yrcudA8c3K7G/eD45JopdPDwwopxw+BvbVLALmoGz+TMoVO6eJ8ePL0w==
X-Received: by 2002:a17:907:72c2:b0:ae3:f903:e41 with SMTP id a640c23a62f3a-ae3fbe42971mr1842396766b.54.1752001095820;
        Tue, 08 Jul 2025 11:58:15 -0700 (PDT)
Received: from kubuntu-e14.homenet.telecomitalia.it (host-87-21-242-88.retail.telecomitalia.it. [87.21.242.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac45easm935366466b.100.2025.07.08.11.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:58:15 -0700 (PDT)
From: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
To: tzimmermann@suse.de,
	deller@gmx.de
Cc: giovanni.disanti.lkl@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fbdev: kyro: Add missing PCI memory region request
Date: Tue,  8 Jul 2025 20:57:31 +0200
Message-ID: <20250708185808.845692-1-giovanni.disanti.lkl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <55e427bc-53d6-4ec8-b86a-99bd7367d5bb@suse.de>
References: <55e427bc-53d6-4ec8-b86a-99bd7367d5bb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas,

Thanks for the feedback.

On Tue, 8 Jul 2025 at 5:10, Thomas Zimmermann wrote:
> Could this use pcim_request_all_regions() [1] instead? Cleanup and error
> rollback would be automatic.
> ...
> Instead of manual cleanup, you're better off using pcim_enable_device()
> [2] in kyrofb_probe(). Cleaning up is automatic then.

I've applied the changes. I noticed that the driver still has manual
ioremap() and pci_ioremap_wc_bar() calls inside the probe function.
Should these also be converted to devm_ioremap() and devm_ioremap_wc() to
make the cleanup fully automatic? Or should I do it in another patch?

Changes in v2:
- Use pcim_enable_device() instead of pci_enable_device()
- Use pcim_request_all_regions() instead of pci_request_regions()
- Removed manual cleanup code as it's now automatic

---

The kyro framebuffer driver did not request its PCI memory regions,
which could lead to conflicts with other drivers.  This change
addresses the task "Request memory regions in all fbdev drivers"
from the file Documentation/gpu/todo.rst.

This is addressed by using the managed device functions pcim_enable_device()
and pcim_request_all_regions(). This simplifies the code by making error
handling and driver removal cleanup automatic for these resources.

Signed-off-by: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
---
 drivers/video/fbdev/kyro/fbdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index 08ee8baa79f8..86e5d60ed0ff 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -679,7 +679,8 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		return err;
 
-	if ((err = pci_enable_device(pdev))) {
+	err = pcim_enable_device(pdev);
+	if (err) {
 		printk(KERN_WARNING "kyrofb: Can't enable pdev: %d\n", err);
 		return err;
 	}
@@ -688,6 +689,10 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!info)
 		return -ENOMEM;
 
+	err = pcim_request_all_regions(pdev, "kyrofb");
+	if (err)
+		goto out_free_fb;
+
 	currentpar = info->par;
 
 	kyro_fix.smem_start = pci_resource_start(pdev, 0);
-- 
2.43.0

