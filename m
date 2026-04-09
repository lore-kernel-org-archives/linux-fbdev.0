Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843803242A4
	for <linux-fbdev@vger.kernel.org>; Thu,  9 Apr 2026 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750328; cv=none; b=QtjEzFQw9atcn9wJRO0mS7x96bi5/aVMjEcMj9KLqlAVnK9N8HubZuKE3s/BrbEMPteGKNjiIc6Xzy/evL0ZXUPtjJlHjIaLVIJXL+uHXx6RcIBr6pZIF1X4mF0iZaU5mI/ZP241dRBbdC9DV+6Bp1O5OEL5jUepEzyfB1mvN/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750328; c=relaxed/simple;
	bh=1SK+KtZvEbEpqHVA73v9ax7ST3arkHcNNUhN7WXLBco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aaouKZzpTC00opDggxzbGmtt43iJsUE2bQtWRp8p1Uchzx6A+ZhDxOxxkUn9MR+CwO7wzR9o6lR6SCpCM/DbxpMxJw2tTTEkzRBlGuOSjuh0bwy2IjFXwaP6NSc4ytM2iiyKtqcivqyOiGyym3Sh+u0pRL3lvIwcgaa07OJ1XPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7lTvL3z; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7lTvL3z"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so2046049eec.1
        for <linux-fbdev@vger.kernel.org>; Thu, 09 Apr 2026 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775750327; x=1776355127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D2izecO73IvypyZQMsOkvk4r8Hx4/34uvh+o5G4CY8M=;
        b=e7lTvL3zRlbLvwyuFMVGMMLbFg3JXX9MgyKNCGyVz8o7h9QRs2yA6WBkS85Y4wrGJW
         rs8zf1Wr2sqhNhNatDiPO+eHfYXbv6+PIBDZj+/Fh80nZS2YoYjwK1OSKV7rm35Azs3h
         4XAYjgAheeVYJQdyKUVVLZlgslC1Sfu/caqEXOxV9vtlmziD5NjuJ6YTJ7oECdz0IY7P
         F3wZY7Onm6GKeS+mMU6earKejqlHqwBZ4AaD0eP6vt4P3ArV9PU7olCmbSjDyQuTa+O/
         KIF5SBBXTDYN0SYCVeOfBLIQL9ZSdm3/smQYHzIujuxYdQ4NihfMdhlHbpnkLZI9y+zP
         nYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775750327; x=1776355127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2izecO73IvypyZQMsOkvk4r8Hx4/34uvh+o5G4CY8M=;
        b=BCkg/LrAW4J7AmM3hj8Ucr2pdIKDkI7eUCoqTqBxdBo1EDZbU+eTE1VFhoe4sfZN8/
         uXOk0N0DAWjl426FSyaP3FLkCqdtLinBeEO76a40jzfwI5CP+LFyNc2YkFtAgRZNT9G8
         5QSss4lKQAw8GyWaoMyMRSBjR2sPnS2c5qKCA3gM+5v8ZUaFq788u5yVk8KWYbE3hdQ7
         3rzbD/cznsS52XAWPusQhC2IAb0YwsxBwbIC93A1nPnQXUkS9t9mJrFBxEu510SEORoU
         ZIjioCF9UggscCTxCdqEZPYb8tOwjLT3nb6g9E8QgHk9VIp4IthDj2L1rCJG64NEggC3
         tN4g==
X-Gm-Message-State: AOJu0YzPwNcGJ8ClAvdmNt62eIHXXiiW37xSGF6ZGnVYj7kxutsEZsQ/
	aOobOm0FpIMQsST5dyWghLiJo4HGj8OWGA1JUYnDcYo7e9AwWHQT92BH
X-Gm-Gg: AeBDies0oEbVA2QZ5Now8qCLB9Rvb4w2pvEzvoMKxMp0BVHUXIly5cDPwTCWlZTaNBS
	KKZGjCoJxiCSXLPWHTuG1PN1AssImAoIQiw7bTvRq7sPUK3o89r2G/PkeMMkz9UVEuPD/ni9EeG
	p8AveQUa3VVfVZRasNApjvMptwamsmDG4S881BJ3KalFyPuLJXg6XmN1qIDhNxaBwucttRvkraa
	ykSyjEIHJhfxgYPsVRZJJxhWkOubJuEBl4zteDuV4e07axyNP2fT+U9N6QitCOBsNxZjTkWF0Pg
	H9yx07HNhSTvDPfBa48N49jstbklh0jeO7kXR5v7a4+THCMG4uyG0ZbT83I5kxYYRD1U+pBXDXY
	ydkC+3d0dBqFwVai+9y9h7xSzwAo65AoIBbAt2GbpkN21I9pvxODg+KrAPMuN1pXwrn6AGyF3LI
	wFWXtmOp7rl0de6DuvZ3d0EIHeBJOhAoODVBG5W6FoHWI6IbVhnayBADw=
X-Received: by 2002:a05:7300:4350:b0:2d5:30fc:399a with SMTP id 5a478bee46e88-2d530fc3b41mr693229eec.7.1775750326403;
        Thu, 09 Apr 2026 08:58:46 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5621d5e43sm153746eec.21.2026.04.09.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:58:45 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2 0/2] staging: sm750fb: improve error handling in de_wait path
Date: Thu,  9 Apr 2026 15:58:19 +0000
Message-Id: <20260409155821.23375-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves error handling in the sm750fb driver.

The de_wait() helpers previously returned -1 on timeout, and
callers discarded the error code by always returning -1. This
series replaces -1 with -ETIMEDOUT and propagates the error code
to improve error reporting.

Patch 1 replaces -1 with -ETIMEDOUT in de_wait() helpers.
Patch 2 propagates error codes from de_wait().

v2:
- Restore the removed comment in sm750_accel.c as requested

Hungyu Lin (2):
  staging: sm750fb: return -ETIMEDOUT on timeout in de_wait functions
  staging: sm750fb: propagate error codes from de_wait()

 drivers/staging/sm750fb/sm750_accel.c | 20 +++++++++++++-------
 drivers/staging/sm750fb/sm750_hw.c    |  4 ++--
 2 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.34.1

