Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7670F3803F1
	for <linux-fbdev@vger.kernel.org>; Sun, 24 May 2026 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779664544; cv=none; b=QGOpao4ujtActWe62imRzYpvor8hm3S+A3dOCIcYrReC4g2PsrMfV0oTzcO1EE2L7yOe3YKI/ZhiMBU+OfcKWYOs5KiarDQYWahFwHQmBo+J0Zyu5OFhO+3m6LHUCkBnkzd9niuqvkRYXSvyQZkazHkS4sv8wXsCO/PvNkdv2z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779664544; c=relaxed/simple;
	bh=zRsIIkYWxUAHXaqjGccQjZnRNvo5X6ZRqEJRag/CxMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1Ynke47lq9WzLBFJb3l3ATNiznYDF2Wn8KjA08A3K1A3o0iDJAZHLaCbx97bfKCOzamYH4SNZMn4QXqDVA45WqLrRT+d5PnwcRvCf9YpmO7a+43MzUDwIxHJ7Y3ITjQpnlEmHslTId98HYn8r46mOxRfNQjn1lGOHgJ1F36Lwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaZ2cV7F; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaZ2cV7F"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so22696775e9.3
        for <linux-fbdev@vger.kernel.org>; Sun, 24 May 2026 16:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779664541; x=1780269341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N06fKJaRN8beCU0hQMVMkOCfMbF5Qshtu1L4HKr1oT0=;
        b=jaZ2cV7FKO+ky1sGCm+XlGFbOsVragBaUKfgXeYMUI0/bCU5C0SQ2KqEut9UxHQ5K2
         pJ/2Z9cNwyfo6OuYnP4Ojde1CkVpcMUnVk4OC29RCQ6v7htG+BaBv45MFKShN89A7b0S
         XPwqEoMHpRuIYvQsVP8oNUOwfTd5xg+3ELBZNHA6LNpUWg++BE6Cvhh/rDq0hrn2cbVq
         cUJT7ucqkOLJR6v+HRXeKhhW6UXy3KyB29FHQ7/3yxu+5l5jLPl7UzO4Wm2IRs22UgGY
         e7IuwK8MXSavojLvcdZWqEpJu9SkT3S4hcMyxFH4vfBeUAR/1pCVwa+J4x82CpM4LLU8
         7kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779664541; x=1780269341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N06fKJaRN8beCU0hQMVMkOCfMbF5Qshtu1L4HKr1oT0=;
        b=KbDlMPKXWFAXc/DBOcDcMAyIsWwLGzV/rPk86dAlUyI20rQkokYl7jv3l+8d+Q+U/Q
         J5oP9PFbOhTia0DkYO+KY1tLD71cctC+EVjmRvkdIIqP4hfFb8UZJzrpa5MJXI0n5tRi
         aRNpWElPXtiMNgXhSbSZjywbH+GcKDw3jT6o4IwpLvCcNQtt9/oAceNwLOa0dkDcSF5h
         tZamRP4zSxzfTAD55hsxsfunxeo3Rbqkva8w5lE/JGmdGxje+9pAsGc2muhJ+rebQZrp
         ASsXwemMJQcwkn3uJg3ZsF7r1g9MSHZkGfq5hI7cBptNZsVJCjUt9IIc0qOys193f+w7
         ITHw==
X-Gm-Message-State: AOJu0YxMiK0cfp5+atlpwdLGtwyBhvwCyVNzrBCgnj6Gmm+4zaNFoY0/
	ml/THwcvRHttYeyAI/itK/Kk+h8vHFWfcXTT1xvPEvQ3usbMrGeGdoW5
X-Gm-Gg: Acq92OFwo7MPRyioXp08VUQbxP+1r6ux23f3GHlHHiRfrao4hTOFIwguRoqkWXjofbw
	w90CWevqZA9p6Uqfj1D4+aSiHx0bLSU/CPjfuvSqTDEuwUCXwRRKmNGjmyPuSx3f5qnlUofmkx0
	hql/v3Dftd9amtCbewGn69jQLmPPA6D7QK0I9b1H1pRpb442fM7St1uTBd+ydFJnfnqwt2Smg9r
	AE37fiNU6DBRpOzfFuB/dnadD8+qntBW+dEhir9TzZEVF/mrfhG5+wKZw0SgaaFJ5DUWaI+6ueQ
	G7s+xZl+JRJM95cJVd2RmoYHRfaxTEsDPqqG6/ZDNTvfJqFepPhx5ML5ME4VA1MqHtoinNK7Iee
	o8vqB7deCTzFh1cYojxT5uQTl7r1tfzDWM0gTOANQKi87XXmnO75CpeaxAzmqj3zNJqEgi09YGU
	Iq4MGD2K3B5zB4qOI6cnzfwL8yf/M5xpIo/NM6A1KDcF4U/wCnjhYx9dc9OTQ=
X-Received: by 2002:a05:600c:a011:b0:490:50ff:7943 with SMTP id 5b1f17b1804b1-49050ff7b15mr124483445e9.5.1779664540796;
        Sun, 24 May 2026 16:15:40 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042d081f5sm93600515e9.5.2026.05.24.16.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 16:15:40 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH v2 0/2] Staging: sm750fb: Change camelCase to snake_case
Date: Mon, 25 May 2026 02:15:36 +0300
Message-ID: <cover.1779661132.git.michail.tatas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change variable names from camelCase to snake_case
as per the Linux Kernel standards.

Michail Tatas (2):
  staging: sm750fb: rename setAllEngOff to set_all_eng_off
  staging: sm750fb: rename pvReg to pv_reg

 drivers/staging/sm750fb/sm750.c    |  6 +++---
 drivers/staging/sm750fb/sm750.h    |  4 ++--
 drivers/staging/sm750fb/sm750_hw.c | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

--
 
2.43.0

