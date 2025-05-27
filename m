Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4FF86347
	for <linux-fbdev@vger.kernel.org>; Tue, 27 May 2025 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365895; cv=none; b=RP22UhNyQ5jk5S/IFqdLFB6TpuZpyOFCw2zfAJ7HWc474wNuH7hMANCgapmRKKZjxlXS4Qy7mOuxJT+KfWe9d6j/GbFfdG5ZXB2hUtIcqlYIJiGu50fzR44Oi9ZIVNWD0CiYdiXZANPTo66kXhyw4o1oCnLQRY2OSyD0Cn0NZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365895; c=relaxed/simple;
	bh=BAHBdkQJKTMWjTYd1N7GqR6d4nnM047AWC8u6YKpT1g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o3v6OCCuQZPWeRx73N4YKCfySTI2MHwyQmcjb6j/o1zG5wYBmqBS6ALo5CvYdJMVobXIIIC2Of7VeADJ5lXQaAdZlGp1uXej4fKviXTqUu3FFjvodrE2jqU+zrmiEsZ9Mup9jqrv+y1dGzakdvsXvBp6r9ALxQU7aHEVKE9fbws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k108hRjI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k108hRjI"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23425b537aeso24666535ad.3
        for <linux-fbdev@vger.kernel.org>; Tue, 27 May 2025 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748365891; x=1748970691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/JvhhsVzxZpk7DMVkKHCJuZXnAATuH0obboMI/6t6mU=;
        b=k108hRjIrBfx9OLPw11n09lDC+YSvRwjhJi1UWs/xazNCvHvAPRUeZOSIkyxLclB2+
         47OuQK5kLKXEXJZPj3KXW/8SVMc/F4175JfDFsOux6vy7SMi5dAPz6Xwrcm2z1qx1GvS
         80OdXMWak0zA9lM4tBwAUgsmS8sbQsVBBAvxwPuVCBFRzcTUPM/lAP7nbOGqdVwnkcva
         nwnfjSlpBVQh+vIvHKPvBgblxiV0ulaiCGYP0IBOdawSFjVFb6ugnvIAdlIiFXD/iYTk
         XpMMEX4uOZQANsl8PGVMg20uHaovtUOhJLs+0maKbMY2zYDbnsBn3+BgZoiDM8vgxSCc
         qEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748365891; x=1748970691;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/JvhhsVzxZpk7DMVkKHCJuZXnAATuH0obboMI/6t6mU=;
        b=i+DgZehSYGOiUrCjY0ZtOJNiUhGgyGt2MnMT/As4pLeiyTNf47/WHlmyBpRPhOnfg2
         tcDjGUcJsy1TAOllo7m5e1Oh6jPskbVgLBGX2yLE8HQ7JTfmSCzBphT8Udm9d92LGlx0
         ujNJV+tzKVdq8Pmq1n3wD3uJ+9QprSbN1stKvRDjG8HprfyN+nlJiwq2yNcExRgCEgpS
         vu8fafoMqCqSQiddqMb/6u3W60zPNqPGfarie9OY7AAfEoJdCNlY+/Ydv3yUjV5q7kIU
         kKin4Y1Osf/msFWCKUFUqLu+gT0FAzmZERitHFD9xkq/ebA7Ww6DFTp4k1QUg+Mb7MgD
         5CyA==
X-Forwarded-Encrypted: i=1; AJvYcCXYeR6ZVzMax63512iYL/kAzKJx6MpnB/7Ey93uG25FaecDd1Y9jI6gzqQTu+OV57CVd9AEWqyhBKHCoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQE9uvY+WUt6wHc8WgBpcxmiLVYtO2DnPLOzGizspChG4DBRRH
	DvRVGIex5Flw2D+26iBkgenRitdPqulthRcLJbrEP+cc/IpvkpOPZJP/gNeM29bKOaTKS/WCZYO
	06uDZDsDNF3wEbPen8cRZ9Q==
X-Google-Smtp-Source: AGHT+IFlObLHeHzUVU0aoa/6zQoHjEBLIMWsx/uXdkET+437ZwqTAGXDxMMkOl3bzunvlhVkDNDYu4RJDS5pvyYQ
X-Received: from plu15.prod.google.com ([2002:a17:903:368f:b0:234:7a8f:b8e8])
 (user=ericflorin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3a86:b0:224:23ab:b88b with SMTP id d9443c01a7336-23414f48ec8mr186992505ad.8.1748365891579;
 Tue, 27 May 2025 10:11:31 -0700 (PDT)
Date: Tue, 27 May 2025 10:11:22 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1164.gab81da1b16-goog
Message-ID: <cover.1748365488.git.ericflorin@google.com>
Subject: [PATCH 0/6] staging: sm750fb: cleanup `sm750_hw_copyarea`
From: Eric Florin <ericflorin@google.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Eric Florin <ericflorin@google.com>
Content-Type: text/plain; charset="UTF-8"

This patchset covers style cleanups in `sm750_hw_copyarea` defined in
`drivers/staging/sm750fb/sm750_accel.c`

PATCH #1: staging: sm750fb: rename `sBase` parameter
PATCH #2: staging: sm750fb: rename `sPitch` parameter
PATCH #3: staging: sm750fb: rename `dBase` parameter
PATCH #4: staging: sm750fb: rename `dPitch` parameter
PATCH #5: staging: sm750fb: rename `Bpp` parameter
PATCH #6: staging: sm750fb: Rename local var `nDirection`

Eric Florin (6):
  staging: sm750fb: rename `sBase` parameter
  staging: sm750fb: rename `sPitch` parameter
  staging: sm750fb: rename `dBase` parameter
  staging: sm750fb: rename `dPitch` parameter
  staging: sm750fb: rename `Bpp` parameter
  staging: sm750fb: Rename local var `nDirection`

 drivers/staging/sm750fb/sm750_accel.c | 46 +++++++++++++--------------
 1 file changed, 23 insertions(+), 23 deletions(-)

-- 
2.49.0.1151.ga128411c76-goog

