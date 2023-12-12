Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfRp8Lcy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE37F8E
	for <linux-fbdev@vger.kernel.org>; Tue, 12 Dec 2023 11:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702411088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vio5W2CXh8VIVVnye0VQz+L8cj+HSZDsPzluUFJanUo=;
	b=PfRp8LcyVfUE/rUUSsymkpRuXQqwii/iTHaiHeyUwgXKVhEkHtcdRc8rHJgG2DVFKmXg+t
	iJ1D2r747tOP4FW73XxAIlLSW44yOdHC3AHW8bqIS0CICvdM8PuckmkLyqk6x5rLT5nJZe
	mKtyGpnLbREwnsx+YKlKQm5i3R2WGM8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-x_yx5cprOt6HseVtJUsQzw-1; Tue, 12 Dec 2023 14:58:06 -0500
X-MC-Unique: x_yx5cprOt6HseVtJUsQzw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5ce16bc121aso72108547b3.1
        for <linux-fbdev@vger.kernel.org>; Tue, 12 Dec 2023 11:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411085; x=1703015885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vio5W2CXh8VIVVnye0VQz+L8cj+HSZDsPzluUFJanUo=;
        b=L5aW4ycBKVxNzUmO85lgcMuRQmXlIPCRMfRseigXcDB8oD/dOc2BPtyPPLUrGMew1w
         WqvjUu7TNNr9oUSlasIktw8LX/BDE03BIeAwrKLpf0py7h7dIeOZUpq4rQWqDyAX/dgE
         Jn9gHsyL5MI9T1tNIG8s4Lq8lvUPvDVGVJIjwTBeBbIxmGBNfpBiveQNBrxTkpBj32Lr
         VuwzTWNsyteQ8yc460TklQjYbJBVbW6R9b19nGYNPnRo0ivvluJWeMMvJqiRU2DrwHKJ
         lhrRZ9e5OzXc3o5cBbmO8Q51D9rpsNy/lTc0ogv+ItBFF0lCHvfVHoSlsz+NRqdBtHIs
         kimA==
X-Gm-Message-State: AOJu0Yy8KntcGahzIBi49gr8U2/vzw2yWncwqsezhgvh8QSd+8baJbIa
	hr0H2LPzNX+5VGujJ4UUxWQVaS+hjc5f5dgcIn5D2a0ewLtOp+zv1Y5bmZSo2+WCSMx1s/XYqkL
	l46IMfN93P0hNJt+qlFizHPAJpfFyKS7Ueg==
X-Received: by 2002:a05:690c:3185:b0:5e1:e50b:ab5c with SMTP id fd5-20020a05690c318500b005e1e50bab5cmr1351520ywb.1.1702411085549;
        Tue, 12 Dec 2023 11:58:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzll/KfEEeFGXHCYWsZvQiNpoKwD81UlefsjiQ4B9Q//3lL6+1EqEwS9Dic0uVUQCzigLnuQ==
X-Received: by 2002:a05:690c:3185:b0:5e1:e50b:ab5c with SMTP id fd5-20020a05690c318500b005e1e50bab5cmr1351514ywb.1.1702411085342;
        Tue, 12 Dec 2023 11:58:05 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id g184-20020a0dc4c1000000b005a7d46770f2sm3985306ywd.83.2023.12.12.11.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 11:58:04 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
To: hdegoede@redhat.com,
	deller@gmx.de
Cc: treding@nvidia.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev/simplefb: change loglevel when the power domains cannot be parsed
Date: Tue, 12 Dec 2023 14:57:54 -0500
Message-ID: <20231212195754.232303-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

When the power domains cannot be parsed, the message is incorrectly
logged as an info message. Let's change this to an error since an error
is returned.

Fixes: 92a511a568e4 ("fbdev/simplefb: Add support for generic power-domains")
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/video/fbdev/simplefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 6f58ee276ad1..028a56525047 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -470,7 +470,7 @@ static int simplefb_attach_genpds(struct simplefb_par *par,
 		if (err == -ENOENT)
 			return 0;
 
-		dev_info(dev, "failed to parse power-domains: %d\n", err);
+		dev_err(dev, "failed to parse power-domains: %d\n", err);
 		return err;
 	}
 
-- 
2.43.0

