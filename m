Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772103D7D8C
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747199; cv=none; b=DQs0wXy7CBdJzmPkf9jbJOJUBXXKTABsvCy+Qyit232N/a06Oi8SlZUeJPQL0/SXhhkfjv3lkOb33Q8xvPFI1P0Jw83B0jW+eXkVZHL8YejGqXgo/sOXzIq/9KbuenLQy+hPLTwKY90WC5c6PBSznUN3odruCNOq45vacwhecb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747199; c=relaxed/simple;
	bh=q9srtjbJ1sl6JcRmZJxPPbCeBahKD3KQiyJ6bLfY+1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OFOT4PFzJimojn4oKcuZnrPaEJBLjtuhTU34wBO8XCTTDb0nlQP5eCW+spl7i1cR9kb42k57JBMyXtJaSgdfADJNn4sf3sSh8GRZUW6owIN7Sc6Cu/FNm4xzeWiq8kjGneqrlN96/NLvPnX+tHahpvskPWe2F4N3HBmKhIBSNuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=hvGHDXkj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="hvGHDXkj"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-365eecc5885so7633389a91.0
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747194; x=1779351994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5YZ5/RDTjOVXbQmmL0DlnfYt163pcXn6d4m+SJiGG8=;
        b=hvGHDXkjIELYCviN+Dh/i0sb1VCRO4LwW3LYrdsWb+hpuUt17mCpevOp2jy3HeR9La
         8+SPx/sw70ZIWNTLy3LQmVFMBMkPh6CFXW1IjHlu8dnEbU3gxKeqLW96x6G2JiHXZcdW
         IdddwPuhLi2XDGuEumXYxN1Jg1L554pO54TiNvqg604WhC8IgMUkZMtnWdoZJEM2qve8
         3RQnh4DCLcSQOo6D184mG909f3Fd5j6lU6SmQ9a9EaM8kmpfuqfpUcjG9vlaO15RJRBw
         w06LvlQ+ubil2N3GunYnMpxOlfgJfyWZLuxgKhEYb6o9xt4cRnMuuBnRKpJtTUigcvgS
         jxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747194; x=1779351994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t5YZ5/RDTjOVXbQmmL0DlnfYt163pcXn6d4m+SJiGG8=;
        b=JsQkavXBp4ayg8EyUaUBYhZke7BgC/mksZ65h2hOW0T6p6eOgZfkB+ehp7RQNqsnNu
         ensNZcqVEDHsVVJgf7VkApvBKOE7PSY2p+N/8t8sV5bY9kHLneHlqktj82fM2F3acxTv
         uNHLGmTBYaAqAQPzW4PJ8AhTwSN4nLbqAIWErCbEY3/NpLrRHmOegbPJGs1vXoJAXgtA
         xjnRNkLdxtLiQxA195J0EuHMjt1aoepobQf/jeviuX/1Z9Cv9z/dqZjMJ5Ip7aJZ48VG
         +2DQ8YfVWlhOWXcv82fE/sJc7ohCj4BI0zsNArvEKkfP2EADdDohYs/OVLcrOhJYco5I
         3Riw==
X-Gm-Message-State: AOJu0YzyWlE59p+5kcYL9X8unzB8YY1DhLMuYZH6CBEmRFcyVmToOycs
	ixN0445CLYnrzSp3EgisRlTku3qbgSixXu8Rb9BV1U2Y7HroQPAzbyOURNC3/egejGQ=
X-Gm-Gg: Acq92OFBOmVLvwFJcP18pBZSs9YnhFCyoK4Wl8Lsbgvsr4EBKTRiwHWNhGckdTv+pEQ
	8bJ3bDUTBZcTK4ZGwyFATRaTmQS02n5iVc1rnv6/xbJpBIx+DumeOYsTy0Wmm5Nd9auZziY8w2p
	fh7c5ZxbNTDdbX8XisTHaNgEM/leTXbNlPNij/7fqbBF/JxRTxhDu7lIBHJmyocHpjhMWZPXtoh
	03UIRIPls7IpdZS7g3LgwoUpyQtH0TqmwWPFoRM6klpcl/hP0rBXh1NEqduBkItkQT9r5nfBPnF
	TR7UxRywHldm+8iH5B8WaX79AKq6XlN9q1xRG4qBNYFuP9zplBaKo8qGnVDxnKXIQxbafEe6z7+
	Lk50+hSmgFSfGs/gcESbe8VA+DKJmqOHb/sFCdmb5ck//m937qrI2t4aBYGuhRy9/4/29OJxVwN
	vaaJCqsuelO8yUHV7/dMKUXNRc+1Q4uquwMtDec39l1UaMnAO0h8UlmjfOgCWn0bcU4HgpGD54R
	tbJk+Cdyc4Uy+0B0Hd50CIP1gd1Qbpe/JH/k6bjUDKb
X-Received: by 2002:a05:6a20:4306:b0:39b:e6af:2d8 with SMTP id adf61e73a8af0-3af8016e0f6mr7940447637.4.1778747194198;
        Thu, 14 May 2026 01:26:34 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:26:33 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:43 +0530
Subject: [PATCH 14/14] fbdev: sm501fb: fix potential memory leak in
 sm501fb_probe()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-14-b3a2474fa720@cse.iitm.ac.in>
References: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
In-Reply-To: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Siewior <bigeasy@linutronix.de>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, 
 Ondrej Zary <linux@rainbow-software.org>, 
 Antonino Daplas <adaplas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, 
 Krzysztof Helt <krzysztof.h1@wp.pl>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Michal Januszewski <spock@gentoo.org>, Heiko Schocher <hs@denx.de>, 
 Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdun Nihaal <nihaal@cse.iitm.ac.in>
X-Mailer: b4 0.13.0

The memory allocated for info->edid_data in sm501fb_probe() when
CONFIG_OF is defined is not freed in the subsequent error paths.
Fix that by freeing it in the error path if CONFIG_OF is defined.

Fixes: 4295f9bf74a8 ("video, sm501: add OF binding to support SM501")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/sm501fb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index fee4b9f84592..1ee7842517b8 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -2048,6 +2048,9 @@ static int sm501fb_probe(struct platform_device *pdev)
 	framebuffer_release(info->fb[HEAD_CRT]);
 
 err_alloc:
+#if defined(CONFIG_OF)
+	kfree(info->edid_data);
+#endif
 	kfree(info);
 
 	return ret;

-- 
2.43.0

