Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA19C524F
	for <linux-fbdev@vger.kernel.org>; Sun, 18 May 2025 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606197; cv=none; b=M348PFwbp+xCKTnk6WHZZFSaS2c4EIA4i/gvsboVIE2MldIUOtWYWo+m1AJ/McFwVR/jfTVIcmhi0mL7Pt3IgIABPfgGI6/fCqtbEYtyVSkq6MxU3VsBjNm3he2xs2qU8pGa+KFF9oXqVeXfxJ082bDK6cfwMBwo1rq6BdunagA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606197; c=relaxed/simple;
	bh=WUUkI/runPD4UYFAWLA4UTyBwT40Tgtc9DAcQ9wpeAs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m0AW2EjxjvpVoYl69AEc9d6mnuWKr/mCD8s5t4ZCZCUtYKN1SKAaYfiYciaTCDcM47lO2M//Sif2kloMhYqn17hoxbPE7vQGpQWSvnZwScUYLdeLOlGaRNU1iKmChXC5h3/WfbxNrLG3JDVl0y5pGPHPquGupaEFg/yk2ixQtDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fT3uo6N0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fT3uo6N0"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-231e76f6eafso17362095ad.0
        for <linux-fbdev@vger.kernel.org>; Sun, 18 May 2025 15:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747606195; x=1748210995; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gfhLPxw+UZ1Sf6wlYpIDTg9JpsqEdC+eRzqAuOTaGg4=;
        b=fT3uo6N0ZQPyMUX5Oq+U2o5G/9C0QmdW8XvdejeAHu/7JF5df3it0uQJ1Glyo767bh
         9sxuPR+dsGFvcIUKROSEE16EejLsFQnVcgwwoQq0EN5aVOLwgn5HyH2/3l9j7oZmcwqi
         pb82bEdhwPUy8OYBpbhFqSsKcOWA5DjVahOM5c9aZwaF2GUR5jOH8zw/ygmZVHwSx0fy
         EMJcbdPt/YMymz1xRMzzQ/9uURStrDWe+HNpfdc9iLdErQbIL433KpsB1r4RP8dCv4EU
         I3S7rqZ0FiP5mpj3zSUnewcgrTULs+cigVm7dpV8IVgM+n3GYwKZ+jOL7ePQ1UxXBhsk
         kM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747606195; x=1748210995;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfhLPxw+UZ1Sf6wlYpIDTg9JpsqEdC+eRzqAuOTaGg4=;
        b=LX2GXQ7CwDaYUZnmokF282noXjLLGMCZmBdmlIR0jH8vBQq2VOei19YSVCFwCDeO/j
         kHTiRwEt1zjQ/geYNkBpIa+2dlbvdYzu4ICnAIbCjyvc2+PibtsgxBfDZVBc67Aj+Jjp
         wDg62QkWODrzOGJmKbhnDCgzHx58SPpeL6cZHiYRb9t5KjVyNqIxWHYtloDqpuUsvNLL
         9N3RVwcqI4upX+PYvrLJFBPiRepf9esJK5BYScfhnCyeBHAViRkkdkaqKOeVwmajGudG
         cnsFcgAzONYKRuM2shlSH2ORzypzMXEt7XhYYSV1zceCvKDKvFaN+mzBpRS3sHUDkIKN
         MouQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ93DNNRc4jUWRhaqd1uR/AE6UkDOHro+90x+545TwFs0Yha7x8NgwoVFBQiTlIt69dGtAJSiD4hfuqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuj0uYncPVrskb3nPpwEVp0x6n7FRjin3EJnss6Wlm0XoSww+5
	sif1HRh3pVA8egffLAgAaI5IOxihs3fP10gZ980eNjBiYYzoRdLJuVd50EhwK0AaAH9RWdcw+uf
	AtIWkEIz0/QuVMLverSFxfw==
X-Google-Smtp-Source: AGHT+IE/fmUAhEdNDzUegq5lLa6Q8dX9Z5TuEMtadBh3S+h8FbzaC55CAiy3l07PTwJodpEclNws7FtKjuJY56b/
X-Received: from plrj4.prod.google.com ([2002:a17:903:284:b0:22e:327e:32c8])
 (user=ericflorin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f44:b0:223:88af:2c30 with SMTP id d9443c01a7336-231de30281bmr131476915ad.16.1747606195043;
 Sun, 18 May 2025 15:09:55 -0700 (PDT)
Date: Sun, 18 May 2025 15:09:45 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <cover.1747605658.git.ericflorin@google.com>
Subject: [PATCH 0/2] staging: sm750fb: style cleanup in `lynx_accel`
From: Eric Florin <ericflorin@google.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Eric Florin <ericflorin@google.com>
Content-Type: text/plain; charset="UTF-8"

This set of patches covers two style cleanups in `struct lynx_accel`
defined in `drivers/staging/sm750fb/sm750.h`.

PATCH #1: rename `dprBase` to `dpr_base`
PATCH #2: rename `dpPortBase` to `dp_port_base`

Eric Florin (2):
  staging: sm750fb: rename dprBase to dpr_base
  staging: sm750fb: rename dpPortBase in lynx_accel

 drivers/staging/sm750fb/sm750.h       | 4 ++--
 drivers/staging/sm750fb/sm750_accel.c | 6 +++---
 drivers/staging/sm750fb/sm750_hw.c    | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.49.0.1112.g889b7c5bd8-goog

