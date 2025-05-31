Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B9A1A23A2;
	Sat, 31 May 2025 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748726041; cv=none; b=na/I9sYPQv4NEdgLwUiCPFyH6A96/lWXH8gb4Uuhze8jFlaMQEJKRZJtcJOKpTL11SuQYT1QSdn9vVsR9nIbzTw+E7LqlZlt5qICrXOkd5bbgLDttDXRqQz3n6AUj8ihbSqmNMdNk65AgwvcIfLAg9YECKMqlo0gUuxIiPvP/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748726041; c=relaxed/simple;
	bh=VPPHlfqUzR98R1C0Hq7Qr40ovgOaO9nWuetLhV41n34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjZAJfcXbBonJ+6nDr6PHbqcQaGG602MoXIzW94DmuM9c5njtwDfpI09hWuX3R7J0pe5W5t0sLL+37zPQytA8xdkKgxFOSm/bc/C7k2+wQKk4gdD0g1hgXgMda1k7aLE32R5OtWWhGJyQrrPcmEh4nt4xY7xOjXCK9YOjDiA+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT1IYafa; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT1IYafa"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c27df0daso2504996b3a.1;
        Sat, 31 May 2025 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748726039; x=1749330839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+Hw/XilsTCcppc7+np/QVEAhg7lSuqi8GdQaDLo6eE=;
        b=gT1IYafa0Soyu2Ihk/rgF361gr3DMgHpkkUdWer7HBceSNTAJ5l9Rfd3eHli9tg5xJ
         0ZyqCdmpxV8C2gw/9qTsjQB390Cleylo+CIlCwWXKkoYK7z6AiQbNUgnedRsUIl+8IPr
         strwHY9ftPtqcXdqLZOglDLFISYjInIEn+E3ag+CA2yro9d47JDG41HginahhUrUsA9l
         jwomSFDayw9i6ZOtCHZTJzUCh0wIGdDL73QP/iATMXhUC49bM4gUnV3wsM7fp1t+FtcD
         ffeeX2JWrNXKy6h64+tccyuWjwKjH4iU28GD0sOnPId8Ayj1IPd0eyoFuNq7654L64sD
         AeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748726039; x=1749330839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+Hw/XilsTCcppc7+np/QVEAhg7lSuqi8GdQaDLo6eE=;
        b=R9My2MVbJNexzguDcYpOT1G5Y1/zUkAWoyrF4iykfC5LyaJjp5VnyxBeSVa26w6NGl
         h+vnTO33Rx+fyUMszh58DnP8+J7ayTN0SHDAKeTPmQevFD++7GKXtYRdem1ALLV2gH+L
         Ig2i1D6YtGcPw4NC9qMEj0g6L/zas9tpQAKt8IqDVfAgBtT04e6TPhvsG8jEOMMh1SbZ
         zuJc69pjTc+vPU3fgNsR4RnxAUEa544GRBFi4DhOMMBmBdPxgjTFwrbFNufyZ4s8YnVh
         js69T6HjhgUhkV0k9NxJx0MoXS+mjXfTJKW14hanfwwhr9YIwuh6e2y2DPWWBUMUOSsg
         Teng==
X-Forwarded-Encrypted: i=1; AJvYcCVDHFIK4YB41fvHB03G3hG9scgsJzWfkrqsBYTnZkLSF9FGL2vom8hVCSaot9ae3UpY7GN3KTpmWYcWRCZP@vger.kernel.org, AJvYcCW4hLSDfk7ARnhzV1xVi88+knWmYsHAJvjPFhcBdXkwCQIHLgZCfybdfhVWXBROVaq3mmrAoZHrCI2fvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyThjzStJpZzLoi7y/7cBnqIfXsnwPwaTttykwczyCNTckJ8Bb6
	UYlHSWVcC8fCgMX+1dStYqEKFTdlm0QfdIkSRGMwaz5lzhIwz9Gdy8i8
X-Gm-Gg: ASbGncsOHIG/yABp6+lbYt8AdmRdFsU2zJWd80YxaS/MZdmKZEYlvbGBDuCmt8Pv0Za
	/5dzejfZWNAlFk6pjLuI9P7Nd5kV6OgOAcu4RscuB6+lVX6DsrTiGlAOVihRhf1wRPlljJ4Li94
	1UUGedgLewugCck2fiq1lWL+Bh0sCKKyO6L/UWJ+q4ZKu4GlBRL6XH7Wk+XrW67syGR7+O4JbFj
	IRA7qlv2otetqjPUA+OPtrREVRhpxOmFtLrpGzjGWCyg8IHuwMCpcaFSjAgfy4zKvgWzD37t3p2
	PcA5CwHghDtanCVeGaDS2DTthVLlCEaUl0Jx/EsUK9TxzmL4K37UIJ4wiv7T2MvqIY/t
X-Google-Smtp-Source: AGHT+IEePTRjoDKaPPluoCvoyqlgcI2sBsl94rFvsSGnUDIVsgbH2C7dGBrEm5FdAVCErZEbDuL1Ww==
X-Received: by 2002:a05:6a00:a90:b0:73e:2dc5:a93c with SMTP id d2e1a72fcca58-747bd984f87mr10707720b3a.11.1748726039316;
        Sat, 31 May 2025 14:13:59 -0700 (PDT)
Received: from khalid-HP-Notebook.. ([49.204.30.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affaf9dasm5161824b3a.109.2025.05.31.14.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 14:13:58 -0700 (PDT)
From: khalid.datamax@gmail.com
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Khalid Faisal <khalid.datamax@gmail.com>
Subject: [PATCH 0/1] staging: sm750fb: convert CamelCase function names to snake_case
Date: Sun,  1 Jun 2025 02:41:02 +0530
Message-ID: <20250531211319.55682-2-khalid.datamax@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250531211319.55682-1-khalid.datamax@gmail.com>
References: <20250531211319.55682-1-khalid.datamax@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khalid Faisal <khalid.datamax@gmail.com>

This patch updates various function names in the sm750fb driver to follow
the Linux kernel coding style by converting CamelCase names to snake_case.

These changes were identified using checkpatch.pl, which recommends
using snake_case for function and variable names.

This patch is part of the Kernel Janitors cleanup effort.

-- 
Khalid Faisal

