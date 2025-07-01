Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC906130A73;
	Tue,  1 Jul 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362861; cv=none; b=Q9+WJLeo4dcgtLD9m4cEKCkUOTkUPuoGj5rtmRCgHvXH+Ko7B2tWCfK7ZbIy/pjgjR7hrQcwwjQWP/D/LdcwVzcVK118Z4LwBjwcYcQr6b1jENITqcmFD50vOix75dBWFdtO99WhQ/dDCmd+mBjDNFuWVEh93/wCg+71Y2QeAbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362861; c=relaxed/simple;
	bh=bsZ5UdT4JH38E2rK4XtH6CO5bid0OUO3ry5BThwTOps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBa22YvF7dbIcU7ex9aXHT4K1sSx00Stfz0VcrclCuTO3zQZiOUvxWjFRrGYO7Htse8cZpoxI3EN7lt162Cu9LNGEkQhcHvXcqJPuWUslvbPmC6Gd/PlYFFcCcGOi0nPZAOlauAuJqAm/01iQxdBqr0LmfuTjFPYdUGcklc0Fdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4VwBtea; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4VwBtea"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so5469278b3a.0;
        Tue, 01 Jul 2025 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751362859; x=1751967659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y91NncPK7/NcNQ1UmJol8Fd0Ci46AhdIGyCjKnxZtQM=;
        b=U4VwBteaj0SOldqn4fB5wTpIx3POsQvDhrvut5/d+nosa1wu501EekC1BNbQaI4dIO
         LrdUw4VTsh1FOsu7DH2R8lShCthdmrH3uLHbxvYhPqFI5nPXtUXpbuKSMIDwb8flw1rx
         U41WgTCnR3YRdWLfJZ0LvqJF49OPs+zIZN6ZSq9kdwiIK0MIogkpYRR8S4wjorB2WJbc
         3JYqI6d9zqq2zHaKMeesN5adgqsRK2pn8hXB0pBO92agDjg98fQpXfKBcsEyOUQHsCt/
         EuwfwMynUygTJbfo3KKnl45s4iyhQIGjJntCKlKsjan/BUM9mZDvAONLXq9IHsPQ20yh
         Gpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751362859; x=1751967659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y91NncPK7/NcNQ1UmJol8Fd0Ci46AhdIGyCjKnxZtQM=;
        b=Ar+Cbt5J4Syy4HvDe7/49IYgW4sx8AhNAFpOyAokiVFaObkUzSt+2+J6VIAuKpSI+n
         V9uLdl0GLQv2fHgpd19n36WDDJWDkWewaMvueSasUMRp+V/R6UQFUVlyt1FkF7ub7Gzw
         zCRFCxgYz4NC6QP+VU1dopA/4BE93BwETTkd0qiyMk6i9j6ZkkeAwGiu4SHgNOTeSLL+
         qskIcQPhzBKrhsK9Fxr5nLfkqoelsDqICpPr03ujyaDhoD6KiGUKbOfjQXd9c2Jbprt3
         bczbebF2SuvWDDJg+HnhwmkvPqrpWmL2vqaR8b1SMrN8U2JYcatD4zGG0QisqCNlQ0NI
         V2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkP4mAbHGPdp6d+etNB3+g0e69nAwzn539Efx0Ii8F+c9KDQLR/+GmitrgQTHpYI/z+qmWWJxcED7bhiV6@vger.kernel.org, AJvYcCXqGpZu0tETEFqKaD/ghmn2Jx1fDWYURVh5BpvXBzZkeNfcKluine3w2F7pHWjsEYjMlFVYswemDfQnjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrmnE/VczwuxdIC12B2DVzov1TkLak9ZVHgBicqj8fljs2bIVo
	uUY4jSsH/fmP7VdIOxdlSnszMSmy6t8/46gKuB/PWIFkxTcDwBOPedNfcqVovw==
X-Gm-Gg: ASbGncuCF+zbkcYJ/VKNc6HGUK3foTEqWz3Xud2nAmCrEHrBxfzh5nCloqkq4rutYWO
	o+vtUyy977nPtdeFbRska86yaMQORO0CkNtMX8L1fdAYKltNwQeAR0hp91De3AxYzmhlkOfGNqj
	Vkah8QGVG4toiSmw4p3xHfTrts0bP/OWtpGc44/nCJyQ6NOVwehncb53rngjS4OE5z0YBFuN/Kj
	PTB5IKfrvUBveYPBNEV6wiFksCybbw/kZtTLMkGFNZnWA2sngl+J6CzjUAleWpAP/CQspsQJ7Iv
	OwzWKG7Xju/erskbxEd0iK1DyBvKyTp2NKBkQIRVLfxU/T1wPPkBvYTVSKauMv53dCE0C7xKQgb
	uJA==
X-Google-Smtp-Source: AGHT+IGVMTwoGg5+t/VBPlWizgX/TDlm9njeq315sfW+K8E17Imd2YRP7ugM+hDbZut/vexETw2A2Q==
X-Received: by 2002:a05:6a21:7109:b0:220:898b:2ca1 with SMTP id adf61e73a8af0-222c9a71c21mr4955815637.21.1751362859066;
        Tue, 01 Jul 2025 02:40:59 -0700 (PDT)
Received: from localhost.localdomain ([49.37.221.186])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74af57e7279sm10945766b3a.150.2025.07.01.02.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 02:40:58 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: andy@kernel.org
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	dan.carpenter@linaro.org,
	gregkh@linuxfoundation.org,
	lorenzo.stoakes@oracle.com,
	tzimmermann@suse.de,
	riyandhiman14@gmail.com,
	willy@infradead.org,
	notro@tronnes.org,
	thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] staging: fbtft: cleanup fbtft_framebuffer_alloc()
Date: Tue,  1 Jul 2025 15:10:21 +0530
Message-ID: <cover.1751361715.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup error handling in fbtft_framebuffer_alloc()

This patchset includes the revert commit for the v1 patch, and the
cleanup patch that is not yet applied.

I have not included the v3 patch ("staging: fbtft: fix potential memory 
leak in fbtft_framebuffer_alloc()") in this patchset, as it has been 
already applied on staging-testing

v4:
- Add a revert patch to remove v1 patch
- Not included the patch that is already applied on staging-testing
- Added Reviewed-by tags

v3:
- Remove a redundant check before calling kfree

v2:
- Change the earlier patch to also handle the error code returned by
  fb_deferred_io_init() and update Fixes tag to point to the commit that
  introduced the memory allocation (which leads to leak).
- Add second patch to make the error handling order symmetric to
  fbtft_framebuffer_release() and also remove managed allocation for
  txbuf as suggested by Andy and Dan.

Link to v3: https://lore.kernel.org/linux-staging/cover.1751207100.git.abdun.nihaal@gmail.com/
Link to v2: https://lore.kernel.org/linux-staging/cover.1751086324.git.abdun.nihaal@gmail.com/T/#md111471ddd69e6ddb0a6b98e565551ffbd791a34
Link to v1: https://lore.kernel.org/all/20250626172412.18355-1-abdun.nihaal@gmail.com/

Abdun Nihaal (2):
  Revert "staging: fbtft: fix potential memory leak in
    fbtft_framebuffer_alloc()"
  staging: fbtft: cleanup error handling in fbtft_framebuffer_alloc()

 drivers/staging/fbtft/fbtft-core.c | 32 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 16 deletions(-)

-- 
2.43.0

