Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF52E0B48;
	Tue,  9 Sep 2025 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399881; cv=none; b=Cf3MFj5Tm12UuywCH/l5sBlFN/Rju2imRgGa2RZWIS2R0wh2PeLkU8svs9mRZvHt+7+sP7Az/C1GNgZ242CJ2spdS4u/aSTyJAcO8ybsvQ9LXx2eCZse/nm0XHsFv6/y7d9q5dmHvPQT35TfFyQT86mJfmmtCb1YkFL5DMFmp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399881; c=relaxed/simple;
	bh=7KhPgY9CNs+EyWne3MtjBbauIv/3NliTxGyLPRrBtVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnVcT2Ji/T73H0sGktIzOceiM+i77AQ1mWhLgKgXMpcYvYm6bSW/vfIpxB829FjDVe61SDs2zRMAHBVbJ/gFTm1weYZRBFpb11lzmpi7ro9G4B4y/IM7V6a7T1dCZ0pkdaLcKcHUt/FV5SqHZE0LruGfJRDes7TG4fLnLxmyOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKhtXNrj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKhtXNrj"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7741991159bso4633381b3a.0;
        Mon, 08 Sep 2025 23:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757399879; x=1758004679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgXaASlXjGFVjUJ/ZBrWtnsm4G9IgZXSsCGm5rp0YN4=;
        b=VKhtXNrj9v0cFuJX7QfLc9aG3N1EIwIuH52WpdMdoLrWljWj6H6ZEeL5HLmmOKTPGH
         yXo1JYHcQf/Ijyc9rIqEsTuV0x2/cpq3cVmUboxe81GgMZscIqTnG9O+VVsrckXG9N2L
         UuQYsym35gbjgwdbbOfUa7DUpCRes9ufaIEsny3XAZQAojZYgP/PqGtjAOB7rqlc9k+a
         LF6amcwm7id8XJ+Dn0L2+FJ1lpuygJvUVH0x8FZeuYp6Gi3isKUlBZpTZpK3RS1+utkN
         6IYuoT74RdHO4R1z8B/DqZ0JPZ0A37jcHOkpqBYNTd0NvYrdDPwGvwN/yS0jXNt0/gSy
         XEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757399879; x=1758004679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgXaASlXjGFVjUJ/ZBrWtnsm4G9IgZXSsCGm5rp0YN4=;
        b=nNAU+gklxCwkl27sEIgxivwlqrGVycqOwWzvEwYtKan0YrCFd378s6E9srI3KRBw+I
         SdRedy3Io5jdHCGsZK3dNVAeQYCIfKI9QOKnXQh9VyBz7RztYj+cqg+LMnx2msuktyVG
         uA9QGpJg7rHqarAhp0U6UGeXPVTywGtADmWC6zzSq3n/CBgWGpP/e6uRVwVr9LWAL7a0
         KJE4T0OenKXT3ahc56+LtwK+LE65xMBbmWraQL1jW7TnQwFX3gV2sKt6AeDpPSuympc/
         HEYva344k2yU2ANL56g64SAmipyebPKjGvYov5/tIXKBZW7JA0wEwMUuqE1aNrYV08l7
         lYLA==
X-Forwarded-Encrypted: i=1; AJvYcCViqSgf3uHgXZm+gePxy54ZWL8tJA13kCC8GwD5TnnI2p31iiERVsqaIVrb/TfZG9BI51w5pyWpqL4/V58=@vger.kernel.org, AJvYcCXmLK0B/g9kCjwfElsxVZwm2xnllrh4oYcVklwd4rVxJSfPRFNT7PxXaYuwgV24ew+zVZFKnkdj9vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVE9cx4HlrQQvC3KQ2a4d0Bl/mXmgG4qpwxzXinzuCG+f/BVn+
	J8wslaTeBuhpnBrL85KuUARAexN6j5oNGp64gfFlIqOaiwUSoTlZcRTX
X-Gm-Gg: ASbGnctvCOSxM0MnsTCC8LpT+RXu4Wwt+PAexvj5GooYO2a6TpAPI/iOQMDMmSAK6DR
	NomN64Au4+lqoiYOm+KN6bD5uakY5tMkhyAig51CLpmhWi/4+SEh6ICWomf+ZrOa74EDByAXG83
	fIEUOrcgthw7JKKDKhk9/r1bAk+A3nRXadC4uqIVKOiaiWSSz8Cwdb25lrRbweWTi25YPg2QMG2
	+JVHV0pkqACN4UkHaEPDfUMiim15zfE99ibY3exkwfNLzB8QQFPzDLEVszPV2cgLmdo6OE3lJ6j
	GzvmXIbcxEPKcrTidepU1fXGkjxl+WgR/p7OsVz4hSZcbQBJiTl//1nfV+wNawevsLSwmRuMsTv
	3N3hlxyI3msPioWp55SWQ3fhxwZG+iMT11KPI
X-Google-Smtp-Source: AGHT+IG6+uKhAARr7UhkwbpUZaECdPB7dPFA+WM5GrddjHbis2bBcSqGfb34MVFU/2f1IDfS0fsxGQ==
X-Received: by 2002:a05:6a00:1a8f:b0:772:2850:783d with SMTP id d2e1a72fcca58-7742dedf06emr13704013b3a.22.1757399879056;
        Mon, 08 Sep 2025 23:37:59 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77466290d84sm975093b3a.65.2025.09.08.23.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 23:37:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 49A9C41FA3A4; Tue, 09 Sep 2025 13:37:56 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Framebuffer <linux-fbdev@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Helge Deller <deller@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/3] Documentation: fbcon: Add boot options and attach/detach/unload section headings
Date: Tue,  9 Sep 2025 13:37:41 +0700
Message-ID: <20250909063744.30053-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909063744.30053-1-bagasdotme@gmail.com>
References: <20250909063744.30053-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=bagasdotme@gmail.com; h=from:subject; bh=7KhPgY9CNs+EyWne3MtjBbauIv/3NliTxGyLPRrBtVk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBn7Tx0s7WQpKWwo33WmoaP/l4nBEv9vbeycaUnb5V3+s 2zmPMHWUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIn49jP84V5aYP3wy4o9nyNb Zdti/25iObrHI4fx3oeHJQI6P2sv8jMy3GPlYzxz01k2cKGpS9rPqjKeHZ+WS93f7HxvZef/TbY FrAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

These last two enumerated sections headings are in normal paragraphs,
making both sections merged into "Loading" section instead.

Add the headings.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/fb/fbcon.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index 212f7003cfbab2..b9ddc145aa9f6a 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -74,6 +74,7 @@ Possible scenarios:
 	 over the console.
 
 C. Boot options
+===============
 
 	 The framebuffer console has several, largely unknown, boot options
 	 that can change its behavior.
@@ -172,7 +173,8 @@ C. Boot options
 	The value 'n' overrides the number of bootup logos. 0 disables the
 	logo, and -1 gives the default which is the number of online CPUs.
 
-C. Attaching, Detaching and Unloading
+D. Attaching, Detaching and Unloading
+=====================================
 
 Before going on to how to attach, detach and unload the framebuffer console, an
 illustration of the dependencies may help.
-- 
An old man doll... just what I always wanted! - Clara

