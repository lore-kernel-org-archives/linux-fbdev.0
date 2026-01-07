Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012832470A
	for <linux-fbdev@vger.kernel.org>; Wed,  7 Jan 2026 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779268; cv=none; b=glOJ1v0afNUEfaz9RZ9ysJYcgju8L4rAJ5aKseyCp5K6gNEAMMr+4BKwXLvxfsKPMURnxKMo6i3Hvca3HdV6/pNUY1RnCOxYp36MQUu+F4tSmppzigRROEU1w8biKE6ZnkVCtww2wwBm4gQ75My5SS5o8z9wYF+i//IhZUw2u2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779268; c=relaxed/simple;
	bh=WKB97XOLcmwKc/51Ty+ofy5vOxBk561EYmTLKGHMsQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a7aklbODhQbWWaovIWLQyjGB7OWJYScNSGO7LZYN1mdMqaxvF9xl8bYJ/+LgS+x09eDLusoHlKsDNczyPc3I4fnoSh4Zyp226qMxYSH4A+NuJ9Id1EDJdUBzS44LKum0spe35XOzcxmzjoIUuI5nxDN2uzoNemmbaU0yx1mn7yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFH/8nJc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFH/8nJc"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477563e28a3so4672635e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 01:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767779264; x=1768384064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m7XMCM+IOn3MGIGHRABZ1A3vBtHG9JW07kumNbNmeQk=;
        b=iFH/8nJc7YgW4wu8JxwsiBLQl0AccX4kH/OjB7z6k6A/Mvo0o7rdEG4QSYBfJYI9Yj
         4vDL8fm9ZjdYnizHPV2aHLCxNrsN5eGo798GoyVcKb3vB2JEFoO/GFu8Mgil+7ng/QsU
         CpuDdxEtUeEivmhUj30PGdwW1w2fk+/9+cLltUJspg32k2wAWAp4G54uJk63jLMjdoNY
         gzN12rA9EaIMUkqQ0UjtCvXfLG9SChEN/1Nd1P5X5jsm6+Takepnctj8kpKPtEYsImUO
         yX1mUtos4qEe5UXCLkbGOYqRC1qh3PVpiR8KJknUH09xsyDV0wwSxHY/mob7WNzrKrK2
         Bzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767779264; x=1768384064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7XMCM+IOn3MGIGHRABZ1A3vBtHG9JW07kumNbNmeQk=;
        b=LI9ZkjedqI+pNO2aoeOaUtrVLkKPIikvdfuVDj1GaUXussuT+bOJ4TbwSWyReoMnk7
         sbjsZsC2cftTIRKhnILn/s/PdtI+D4QmYR5Qp5egrot/BtO6Tlo85IQetlR8mPRQkxnc
         qLGY2d7fgcRsUDZEK8pQf0wLguJJ0iJfu/uB12/oPNR4Jt8l1Be6eYdS1jl0S60KHfYe
         ON1A9kpolJ6lchYoseW0gw83dx7Sao1vkpubRKYMU2zrJbhKTfelbZxUf6noghQX7c7t
         m4eJIUIJd13axeAxs34YAn8bwlyR23bAaE6naPNINCiYEQpKUwD+t9TBJSu6PNdcO+q7
         VgHA==
X-Forwarded-Encrypted: i=1; AJvYcCWaaEJ5gIpSD6q6081Up5rE7LO0lU39vbfAY07mymYjexpUGrJfDxro6KdGSgm1jldhauRZz/Y2iBqb0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjBSDL/E1kVjU0E8EczWhb1hzlhstnWUAyUoet/T9J8jpeqM5Q
	EtXtXhyn/eFNruObcWsgHr/ZwksSUq5x0nrxy/+Lq+YUOVNvBkZeO2CcVvI7mOxd
X-Gm-Gg: AY/fxX6s0RQV032RNXfomXi+1MJ4Hf2iEdSjwfjn2aX5F8MLvEpsN6z7MT/niCVNErV
	X34TDStjkXKrMgAyQy/ds5sT0IS0LBW5BFYiFEL8tdNKmspZ9leYneCd3yM8NUoPw2zbZwEP0o6
	s4glJWVFopDYh1hpJLu7yqHfTfnamPo/glE+OHlVSkfoP7MMCdF15snEr+DPrYAOFerxG2lfmBf
	jsU/jt50DK9loWMXPE9g56oRXD/KqcWxHVw7J0hRb6228p2Je5a8bINAZ1sFULxzj5uvDsSJ5C/
	P3TFjalq93TDNLdDNPiuuKR3IQQXRG8EHMsCr78DhXb+RUa/02jSfyQjMrKiu/cVVYYb4B1GsJi
	egT/s3E/vJfT67uDdiBF3/MShtIPTlzuOee+P8LfI00Y5jU+C0j2hhXq8U43mpO7u59OytiQBKh
	gZ5XD6FfzDJkCiomaX/0pUnK1Zidvn6frMYCpNXldVjJH4DAjznRVsLkrFQy87TZWYsmci5KUbF
	tQS9Wi4rCWWussYtPAt0GUYuh4=
X-Google-Smtp-Source: AGHT+IHRW2qQ0SN2NxzIjxOAFlOFn2hT9OUGn5VFMQYofoyvx/h68UFN7Qpjf/pOxE/+TvQYWUd9ng==
X-Received: by 2002:a05:600d:41c9:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-47d8484a4e7mr18905025e9.8.1767779264334;
        Wed, 07 Jan 2026 01:47:44 -0800 (PST)
Received: from fedora.homenet.telecomitalia.it (host-95-244-124-236.retail.telecomitalia.it. [95.244.124.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d871a10f7sm7423715e9.18.2026.01.07.01.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:47:44 -0800 (PST)
From: Lorenzo Simonelli <lorenzosimonelli02@gmail.com>
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	Lorenzo Simonelli <lorenzosimonelli02@gmail.com>
Subject: [PATCH 0/3] staging: style cleanups for sm750fb and rtl8723bs
Date: Wed,  7 Jan 2026 10:47:11 +0100
Message-ID: <20260107094714.300380-1-lorenzosimonelli02@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series performs various style cleanups in the staging
directory to resolve warnings reported by checkpatch.pl.

The changes include:
- Fixing 'static const char * const' declarations in sm750fb.
- Removing trailing whitespace in rtw_mlme.c.
- Simplifying boolean expressions by removing unnecessary parentheses
  and explicit comparisons to 'true'.

All patches have been checked with checkpatch.pl and the modified 
files have been verified to compile correctly.

Lorenzo Simonelli (3):
  staging: sm750fb: fix static const char array warning
  staging: rtl8723bs: remove trailing whitespace
  staging: rtl8723bs: remove unnecessary parentheses and true comparisons

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 14 +++++++-------
 drivers/staging/sm750fb/sm750.c           |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.52.0
