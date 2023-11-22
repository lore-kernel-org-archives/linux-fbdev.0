Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQyaFcGy"
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A0F197
	for <linux-fbdev@vger.kernel.org>; Tue, 21 Nov 2023 16:58:02 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7788f727dd7so388467885a.1
        for <linux-fbdev@vger.kernel.org>; Tue, 21 Nov 2023 16:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700614681; x=1701219481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MFz25rhV/tQYJ/usJamHobIxJPBWkC1P9QKNu6+n9H0=;
        b=RQyaFcGy1L7mKR3OeWs2VDs5rwyQLmOgjOVuvLXDYwjctKynqb6HLMdxvPF2S2zxvZ
         iU15zO1YwWhdcoW22vzveet7H1czi54KDFThNLPyj1LSIqf9DR9bS7qw/L17itlIYYug
         GPZoqDNJurcqYsm6YVZeiD1fyQpVTo340NgyAb8QNe45LTdtlZakVFzujoyoPtR8Duj7
         P8ONOu1EKoa/G3dx9yXI1iui3VqbCt36tQYtQUwYRuIQ3PuPgjSEQ8dd4/s7majz8AyU
         bAL/KRA7mRhb5W0SWpdeeIhg3zMfRrOZ2WwYg11+dAbh6UN6a+FS6tshBEHQP1hK56/E
         4O1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700614681; x=1701219481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFz25rhV/tQYJ/usJamHobIxJPBWkC1P9QKNu6+n9H0=;
        b=ffB5NYefyyP58KQGNEEye9ww81c2OjkF8aAaGr4idYMLn5fghDkZDWuQ8grkw96e9L
         wTldXYt2h8xCzP+Azbn1OEDEWuBZ5uwKoWY4Bei/pmUfMYkz6yyD5qwNs8HHUrRo/IAJ
         C7AWdQ3Xbsox3ebx/2NlzVJY6AGrd/5fHtoE4lwwtX2iY68hk02nc8hki/GyQJI/j+ny
         nFHFqVkUKNs4XSfmdGH3sAk/ut9krmzp+WnQorBIsZHorz9b6xXU2waOWjGny6feQ/5D
         ox0j/7E7jFkRe/Y6EHBJOV6+/2NNkuseNubpygwwN1ZWIQibOoVDKIAaTepv9sjR5Fg8
         KXYQ==
X-Gm-Message-State: AOJu0YygiEle9RVsymqP2NGnE/sIgyWrq5rOak30nFtg7R7gtdcaK7BH
	DBvoFssfEmMdcrOaQP7djMg=
X-Google-Smtp-Source: AGHT+IHK5zmXtx2CrzmRrXrePJ8VaQvJ/bDCoqi8nx/Atu1M6AvENNujwhGE+whhP3wVQywcUytgug==
X-Received: by 2002:a05:6214:c41:b0:66d:12b5:68c1 with SMTP id r1-20020a0562140c4100b0066d12b568c1mr923386qvj.59.1700614681132;
        Tue, 21 Nov 2023 16:58:01 -0800 (PST)
Received: from localhost ([2607:fea8:529e:7800::80ec])
        by smtp.gmail.com with ESMTPSA id j2-20020ad453a2000000b0066d32666a20sm4427293qvv.71.2023.11.21.16.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 16:58:00 -0800 (PST)
From: Richard Acayan <mailingradian@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Helge Deller <deller@gmx.de>,
	Thierry Reding <treding@nvidia.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH] fbdev/simplefb: Suppress error on missing power domains
Date: Tue, 21 Nov 2023 19:54:59 -0500
Message-ID: <20231122005457.330066-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the power domains are missing, the call to of_count_phandle_with_args
fails with -ENOENT. The power domains are not required and there are
some device trees that do not specify them. Suppress this error to fix
devices without power domains attached to simplefb.

Fixes: 92a511a568e4 ("fbdev/simplefb: Add support for generic power-domains")
Closes: https://lore.kernel.org/linux-fbdev/ZVwFNfkqjrvhFHM0@radian
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/video/fbdev/simplefb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index fe682af63827..6f58ee276ad1 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -466,6 +466,10 @@ static int simplefb_attach_genpds(struct simplefb_par *par,
 	err = of_count_phandle_with_args(dev->of_node, "power-domains",
 					 "#power-domain-cells");
 	if (err < 0) {
+		/* Nothing wrong if optional PDs are missing */
+		if (err == -ENOENT)
+			return 0;
+
 		dev_info(dev, "failed to parse power-domains: %d\n", err);
 		return err;
 	}
-- 
2.43.0

