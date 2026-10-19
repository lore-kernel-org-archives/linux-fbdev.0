Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB440BCBB
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400538; cv=none; b=eFSI1O8UhDhQGi2b1h92+RGivGyDOhj86GCy5UfYLi/eDdNibB4palj1Mi6JD46yamVpdCVeoWYdsqUoe4ovi5kdRCqRH2qNJJmAFsu2WB+Qwr9kk0RC2aPAn69Psu/S/2YuXc1cvpBFvr7yN52Fw6h9ucFhdEJx+8KBGWC75Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400538; c=relaxed/simple;
	bh=KEnNJh3rrhYtKOHUDjrU7apH2ucmijBgYQbutGWTkVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUVvfYeXX+IYkgcRqYBbStxBNR6V00vBF+2UcKpiugWBZOR7MDehZQY6wYqTgxKjd7QRrQOrAgNeSsF0UJHUU8pfB7YkXj5GRdUxfS+pBRYvo4kn1eokO6ujK5X3XCAYQ5QyTVDQWKEo0R2PI+ucIEkumx3e1O/cJ3P9PBYcKSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1ILgQUo; arc=none smtp.client-ip=74.125.229.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1ILgQUo"
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-14139405daeso93042c88.1
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 02:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792400536; x=1793005336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RAvRyHlIfiRgj3s2BsPRbneZn58NB0+Nwn0y6jlCCk8=;
        b=A1ILgQUo79fTyddEUPvBZ8P6M1Y17gl1pEEMDxoJiIJxj9/SISPtfbH4sp4RLN9YOL
         X3IdRj0v1ijtytxlhQ3/OyX0UoNH4VZWZfMj/Tl9IywUvUCI61vYl9Sh0E8XWVFWAfE0
         vA8lq1C3ZZeAeW6vQx2s0leqNVMSW+VpR+9ckYi35O69xIGDk4I/AOLt1sGS461Gysrr
         T15Js5axuk8jfRiqIiYSbvQlnGcZQzstHXvct9Tv7GFwpmEoiHfKulEV9lLSdV+XvVLB
         bwJXxc/eUW4OIprp/paH3ivlLayGSmRjHG7eQ84Ja35uSvzImEhwyNV8GFY1w6Ar42jF
         10KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792400536; x=1793005336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RAvRyHlIfiRgj3s2BsPRbneZn58NB0+Nwn0y6jlCCk8=;
        b=gIJSiwAXC9vrEgGmk8dV4J7ybbpuJSzzUs94AIBdFU5e7IgH9uHkvfNyDrlDOZHy2u
         vHRESy1biui0dyKaFA7VyPFpK8qakAixvSQn1Wf+skiEEfgelDJWqjwn7m8WVreAbiB7
         Mo+P50Psti0cVlr0e0jitoiBayQVK+4hJSXihYcAD0oZVUlOeHE1W7VxAbKqEuXUFoYW
         lYo5VXIZ+5HwreubIw6HnIVhtcPia+skNZmrI/bmlSAtXdH+GsznYpRar+6ZU2dwEt9g
         SlkdpCjaKwAYy9upxcBuv6Sz08bpGsdbR8m8TjtbHDFd8PWqYU6oAoAKGfZB90jQ/rap
         WAtQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4ygbMyrQtZz7/0TzI78HMmVtfLvLfm6cUT/eEurfCvPhNiR+NOQhjxAD/kPb/24laMbLB5obJj8z5AQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIAJdlAOFvW4ri5ZuJbHUhBj6Qlu67XEoUMP07nnwGs3+qOy0gi
	AgcP+wIK+8TMLzL8fBMPDj3cGC8hXSwFEIFpN6/ZeWOgCo7p9uT9mc/O
X-Gm-Gg: AYBFou1WTYvl6jljbX9yvIUIZbIq4laS0xFaj1CImSDABdpus39FHm8ZpnUVDgKNFtd
	V+Jf0xdYH8Csfn3jAwrdQC+klOBQGF1V+HbzTFd/xkcPiReeddwY8SWgT5VVa/9eyGZjX/Itflo
	QPbUEJpB3hRaBHIaPdO8PimnwvyiBrIaNg2vxUFLnUO/vQ7dsQoCbEH580okbXqdICFUsaibuO/
	kMGYDosJml2/XmfsUFCQwKnxgVNSts4AnzJc4zye8ex90Pb2NGg1OhcrRkKm0ap75tl7eB31QUF
	RQTjkJLsmOoBxDod4L45lapQXbfe4c/5ZdpWMHrklHyIwGTeipCHWD8ct1VfldQWrsuXGtd7HVd
	OSO9IR++pptwiAyvMf+3qti6gp2PGSfWj2SYOMKsIpJOV4PjFtSVGYeUssNON0soNOaxDSb4Fn/
	YtWFM8+Hm+DJKgIpQBYMcJXi7tfxGw7CodyD2H6ZQyhASLn2xuVPgdCzxqCzZvcffHJVdDYegCk
	4FlmCDxJ/pqVQWwV1/wx63UqR8QDu5z08c=
X-Received: by 2002:a05:701a:c951:b0:14c:637d:682d with SMTP id a92af1059eb24-18514b00b40mr12311278c88.43.1792400536345;
        Mon, 19 Oct 2026 02:02:16 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm27085064c88.17.2026.10.19.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:02:15 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	Yao Yiqi <yyaqia@gmail.com>
Subject: [PATCH v4 0/3] fbcon: fix rotated font buffer handling on font change
Date: Mon, 19 Oct 2026 17:02:03 +0800
Message-ID: <20261019090206.1094958-1-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix out-of-bounds reads of the rotated font buffer when the console
font changes on a rotated console (fbcon=rotate:N). KDFONTOP installs
the new geometry and vc_resize() redraws before par->rotated.buf is
updated, so the old buffer is indexed with the new cell size.

Patch 1 keys the rotated font cache on the font geometry. Patch 2
rebuilds it on font changes, restoring the old buffer if the change
fails. Patch 3 retries a failed allocation.

Changes since v3: roll back via the saved buffer instead of re-running
rotate_font(), abort the font change on rebuild failure, and guard the
rotated state with CONFIG_FRAMEBUFFER_CONSOLE_ROTATION.

v1: https://lore.kernel.org/all/20261014085102.497789-1-yaoyiqi3@huawei.com/

Yao Yiqi (3):
  fbcon: Include font geometry in the rotated font cache
  fbcon: Rebuild rotated font buffer on font change
  fbcon: Retry rotated font allocation after failure

 drivers/video/fbdev/core/fbcon.c        | 50 +++++++++++++++++++++++++++++++++
 drivers/video/fbdev/core/fbcon.h        |  9 ++++---
 drivers/video/fbdev/core/fbcon_rotate.c | 10 +++++++-
 3 files changed, 65 insertions(+), 4 deletions(-)

-- 
2.56.0


