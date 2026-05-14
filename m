Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B343D7D65
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747090; cv=none; b=jSmRAhfhRCAmbsG40exVj1v+8NNjOe8KloMzXiNIWLLLm/6FH/SgCKTpEGk+akGpG74org0Dk4tvM1bEjSBZUJdgmfmePYq66I7elAHLkKj0Pnht1jXlI+UPoqS52tJrjzFRuoyLALCsc8N+zEsXdcpAkqA9vaYZNQPMbQyS5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747090; c=relaxed/simple;
	bh=pQaCeYC0L+OsOx7Di+u7X+3Jw59KU+5kmLZBiKVWt2s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JYQdjnNicYGesUzA7bUDFPf3ZCLo6JY8UPuqYspJyb1Zze9eO8DXlR2SIZi9ytGdy+BqVFFzEYLZH5onbhG198XHZxFTdOX+uV2xZGWujbJAEGjbQSEiCarmEgF0QxMKf+QySgzoFw4E1MBkfnll7TVwCtcinV7teAHflphljUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=Rmq8yOMq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="Rmq8yOMq"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c802803ac17so3486920a12.1
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747086; x=1779351886; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mgvCm8MfJh47lqaqPNfqzc/xfynw7OZOiaI/rFvWqY=;
        b=Rmq8yOMqZYztneBTFB08g0ydIO+lue4teTAjYKrx0C4xgLcEBTWDD57MTSzVwdOWZ0
         MlbldvkvlF7j/mSvsQKQwJpyWQhamjbFMTZqi0WNJkxXqEfHRQQ9RIEew36JmwTqiag3
         Q3sPCIuD/OSyEit+HBnZiYDJK6GMymxdT3DrWoj0+kNG+dGvGG6TIeJADb+FNpqa/kAW
         vYp128wG1OP4QGEQKWF/ixHwiKChMf5slEOzMlEm5XkxkgGb+QKMhuadWh+BKv18nIOR
         bKwxHAinDKuPFXpQZsVuyODdcgevIOg42e4iBwr/haeHR6OsZUH4XatUmhGGO75D8DS8
         NSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747086; x=1779351886;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mgvCm8MfJh47lqaqPNfqzc/xfynw7OZOiaI/rFvWqY=;
        b=mJz7UNTm0dmvrsCVcgUn/YeDWpyC6ILammzcYWQXLVXr5d/JtGlk6QQBKJ/iDQyfF7
         +3HDeCXegDWWlOMVOV0nkPfVXu2XiJnh0aPVqCN6bvTL3yaDKp01JshqvS9aoSb2QVw3
         lnJ3wLXyFT7FwwlrYEob21pM4P+mxxzVZFUuTQmHrWi3xpGIFCfoc3zX+VF9Wd4gJmLr
         t8xE+R0D5Qm2wS7dn7Wi4WLhWT+YVwEdiYjat30VIxEPxOnxRnct1G0yNAI5aZ8SG89R
         0sMODM4t7xvR9QvDnYMGuFKWfOXTzp1zuNLK1qYzEVWwRuce7hM+Rrk/2XtUq5qQM1RW
         FWew==
X-Gm-Message-State: AOJu0Yx9msh6gIJIQToLVmlKJb1URkQXF+ov/uI9t6usOY12fvC68a7t
	M46eCB5yjijw6TKTKT/oWvKbkoZfMshP/keAjgwEMo0kZJhqH0/SweilBbcxO7xVs98=
X-Gm-Gg: Acq92OHQk6cuLISgmARIQyCjpHlonB5Q0yeQ+jEcvCtn6AZcD/Mnj72UPXAxJz5+ut5
	1Pgt+USL4QlD/PRUcGHxKj8GKF34O+slWvotzwPQLewZo6Dr/bGXieAi3wSav9bc3bPzf1nWVl9
	/HvDF5xGb1QwIRbgOD7UZYZ5+72YehvhApvbiQLdjDL7yLC95MA+evrV79s9U00ael389OvTkio
	gL/2olWNh0Ha08bxE55+D4kvoAaw84dqcK0VB62h76jSeNv3b0oH0hHFtLSiteN2i59t2aHbJSF
	Ic/pyPqGBwP+ooAAUxeO3Ce7JKx/go0WzYU6W3I1XePLjn+sYZ0AiZtBWNeR/Y6fc+kCaM17Z7y
	s3ejtNUlMHXOgLtF18q8rkDmqzrY5wWd27drNU6hI4ya5sjlgTlKXeU474bZWl+jf7CVhdCa+Lw
	q3ABFOTC9C32/GOALZcJAtosuOxYRNO9WOPvda59PGTHQyRzMhyJ3pQzPKH/c4WE4D/hDtlkNls
	bKdaeg8WqcUWJL5HHiGJAO2XUCls+l0TkH1lss9hHGcNQTtZO7kcLc=
X-Received: by 2002:a05:6300:218d:b0:395:ce56:4448 with SMTP id adf61e73a8af0-3af7f97ae44mr7226883637.25.1778747085948;
        Thu, 14 May 2026 01:24:45 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:24:45 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Subject: [PATCH 00/14] fbdev: fix various memory leaks
Date: Thu, 14 May 2026 13:54:29 +0530
Message-Id: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL2GBWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0Nj3bSklNQyXUvLRFPjlGQDc1OTNCWg2oKi1LTMCrA50bG1tQBF/GH
 kVwAAAA==
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

This patchset fixes some memory leak issues present in fbdev drivers.

Since commit 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
fb_deferred_io_init() allocated memory for pagerefs and returned an
error code, but the existing drivers which call fb_deferred_io_init()
were not updated to do cleanup. The first three commits address this.
- fbdev: hecubafb: fix potential memory leak in hecubafb_probe()
- fbdev: broadsheetfb: fix potential memory leak in broadsheetfb_probe()
- fbdev: metronomefb: fix potential memory leak in metronomefb_probe()

Probe functions that call fb_add_videomode() or fb_videomode_to_modelist() 
sometimes did not call fb_destry_modelist() to free the allocated
memory. The following patches address this issue.
- fbdev: radeon: fix potential memory leak in radeonfb_pci_register()
- fbdev: carminefb: fix potential memory leak in alloc_carmine_fb()
- fbdev: i740fb: fix potential memory leak in i740fb_probe()
- fbdev: nvidia: fix potential memory leak in nvidiafb_probe()
- fbdev: s3fb: fix potential memory leak in s3_pci_probe()
- fbdev: tdfxfb: fix potential memory leak in tdfxfb_probe()
- fbdev: tridentfb: fix potential memory leak in trident_pci_probe()
- fbdev: uvesafb: fix potential memory leak in uvesafb_probe()

Since commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller; clarify ownership")
the fb_get_options() function transfers ownership of the memory
allocated for options, and so the caller is expected to free it. The
following two patches address this issue.
- fbdev: efifb: fix memory leak in efifb_probe()
- fbdev: vesafb: fix memory leak in vesafb_probe()

The following commit fixes a simple memory leak.
- fbdev: sm501fb: fix potential memory leak in sm501fb_probe()

All the patches were only compile tested.
The issues were found using static analysis.

Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Abdun Nihaal (14):
      fbdev: hecubafb: fix potential memory leak in hecubafb_probe()
      fbdev: broadsheetfb: fix potential memory leak in broadsheetfb_probe()
      fbdev: metronomefb: fix potential memory leak in metronomefb_probe()
      fbdev: radeon: fix potential memory leak in radeonfb_pci_register()
      fbdev: carminefb: fix potential memory leak in alloc_carmine_fb()
      fbdev: i740fb: fix potential memory leak in i740fb_probe()
      fbdev: nvidia: fix potential memory leak in nvidiafb_probe()
      fbdev: s3fb: fix potential memory leak in s3_pci_probe()
      fbdev: tdfxfb: fix potential memory leak in tdfxfb_probe()
      fbdev: tridentfb: fix potential memory leak in trident_pci_probe()
      fbdev: uvesafb: fix potential memory leak in uvesafb_probe()
      fbdev: efifb: fix memory leak in efifb_probe()
      fbdev: vesafb: fix memory leak in vesafb_probe()
      fbdev: sm501fb: fix potential memory leak in sm501fb_probe()

 drivers/video/fbdev/aty/radeon_base.c | 1 +
 drivers/video/fbdev/broadsheetfb.c    | 8 ++++++--
 drivers/video/fbdev/carminefb.c       | 1 +
 drivers/video/fbdev/efifb.c           | 1 +
 drivers/video/fbdev/hecubafb.c        | 6 +++++-
 drivers/video/fbdev/i740fb.c          | 1 +
 drivers/video/fbdev/metronomefb.c     | 8 ++++++--
 drivers/video/fbdev/nvidia/nvidia.c   | 1 +
 drivers/video/fbdev/s3fb.c            | 1 +
 drivers/video/fbdev/sm501fb.c         | 3 +++
 drivers/video/fbdev/tdfxfb.c          | 1 +
 drivers/video/fbdev/tridentfb.c       | 1 +
 drivers/video/fbdev/uvesafb.c         | 4 ++--
 drivers/video/fbdev/vesafb.c          | 1 +
 14 files changed, 31 insertions(+), 7 deletions(-)
---
base-commit: ba2e787b4814ebf9ab5f6a84181678b67eb3677b
change-id: 20260513-fbdev-99a53dc0754f

Best regards,
-- 
Abdun Nihaal <nihaal@cse.iitm.ac.in>

