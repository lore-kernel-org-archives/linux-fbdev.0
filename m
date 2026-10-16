Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51B53B440F
	for <linux-fbdev@vger.kernel.org>; Fri, 16 Oct 2026 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122345; cv=none; b=Rvys1tbTejYc9VtYVDHmo7Kq1Hzfuc/yd1MNqr71z0mE7lUEWbVWo3Mu2wrZ3WcW4KNHcgBnrNI/nK4Y4Erv4z11jwDUKzJHbSjrZ8MNKdoB04jmsUVkkYEoaRTMLkKbZ+B23q1hrIzcbR+/uIRoNIeKdJI7pq1aNMUke3+KjwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122345; c=relaxed/simple;
	bh=wmd4iCJP259B08tTxV+CJqvRxEMm0VuE3Nq9x76e9Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CtpwmVN8Zttba7u/Aua8XH0L69wcGFrrAlT2wFqId5zDQN1RkrJ+ZG53CGoSTsPTrzAzkL/LqaYR0Jg8JrPbpC12NAD0yNDi0lua52GEnO6YxW1e/SEWL9p5tRDurVqI15VpIQA6U9yLhiHY+w7sL6aWZ5bj4+6EZ/tbqLj8Pr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcodzQeS; arc=none smtp.client-ip=74.125.229.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcodzQeS"
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso2618917eec.0
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 20:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792122343; x=1792727143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L9utFG+7l3jNDaHXc+0ut/Bf6ZmDHhf+7z5lxoYvvn4=;
        b=UcodzQeSImvrsSCYKYjTNoOFYNmTPC5Lw4w5mbk+UMELpeNV3drRUvucBpm4vFZxKp
         ZY0q90Fc4Hl2vmANzyr/SVq26jbNNYztpmx4yTe2VsX50jO1T8+nY+JkxxtsN+8a+E3h
         anMUyTPq+P4zqcJhAjE70HBs3YrGiw13IqZtTrxpGW850zVhGgr8TDrYH/BgMDmPCwuG
         wegP6u9nnRHpp/fqfOCykf3sx1Tx5UvMdUAM92y0BBJOernVL7Lqd3pzi2vl1fM0zORI
         FHVmidzQm93CME46E8cPGpcfSQG0sqd4H3OjoynlKx5GvhoBUPe7sfQzbm8sQQ2MLcsV
         o9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122343; x=1792727143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L9utFG+7l3jNDaHXc+0ut/Bf6ZmDHhf+7z5lxoYvvn4=;
        b=vHcdZsyslHi6egbsdDyTDX58RjSIk3wCu8iLimSGag1rEIiHoVi5bCW82Maisqf7gz
         if+hnP4d2LIVXDpEiHzqh84SzoECO21I4NBNoVwNwazhue3BlOJhOS7g7EPs36QMTYTP
         aHJo1ctFlLFTZIhuvFCRuFfNDWq3NMBSVOk0hPWX6uJH9HVOly8P27IKSQ8fcIud2aSY
         CLz0VHZIUfjgcHpipQqh+U4+ouxwaLlMIvRMM6UbaV5M9pJuDvBbE4w3yoP3iPoUCJFu
         b4posTowch65d/w1NTbeXN3gePoaE3LByZai96daiBfHLSisJw7I2Dr7DJj5N34dfDj0
         kOMA==
X-Forwarded-Encrypted: i=1; AKwUvBwdTLr5Ub7gu/CbZ7YfKDNvlmHJYTZrhY7z28CT9lsjYB7w2O8Vgru8OP1vy23CQgqNIrPTwYzKlljmdw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJblEeb+9NOIUbzr8f+vC5FqBg/NqOktTdnUUQL0CQbREhEDyat
	4tMA85N2f8EMv0cZCdXgNZCZfRHoXlqnYQ156uzd6FshTBHc6nd9sC3N
X-Gm-Gg: AYBFou24MMCIoDiKLSsq/y9jppvKuTB1/NnU+1dIuJbOckBKENgqC5b3dtLCKDreUMY
	Eg5jCuDPder5uuI4ZDSqO40qlZkXww/Y3QICLUG1UqyHRQhg60b/3qwrRso+uJAKIVH9IeJwWtP
	+kaBd4t40XKdDRDyXU6UVyrEG13r5LtcwT9vL9RwFLHlYJilmLpBiUlqP1F3S7spsqosKIWpjJ7
	H/qDeddDRZ0TEF5OrbsOJmuv79z/tXfx3EE3iMbqdMRmOVdkQiY6cZz50eYu9fHFChlBYeSOTIr
	quujDqCPgMri93UN9NprqebqmP8d5OwRz1DnxAy3a8L8e6krAJpchq3wkXnM+FhqbWseWjQVS+r
	4SU304i0OmnrX+GPu2wF+kGryXR98Fu6s8xxqMBX9OBNab38zsKlSi70+thwRCdvGznTBRoTSOO
	86v3vK9hXOsn2RTMJGtlRcZpRvhXOOhc+X0qumawH/JaTGRcoA8SowFbFcNRACyfc2waqZLNwEz
	b20N8+D2ChsUDLWMf1xN8dQZNsGoRJGK9jNco4=
X-Received: by 2002:a05:7300:1ca3:b0:351:7416:5f28 with SMTP id 5a478bee46e88-3537e016fe8mr30314288eec.27.1792122341773;
        Thu, 15 Oct 2026 20:45:41 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608297f4f7sm2434229eec.23.2026.10.15.20.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:45:41 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
X-Google-Original-From: Yao Yiqi <yaoyiqi3@huawei.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	Yao Yiqi <yyaqia@gmail.com>
Subject: [PATCH v2 0/3] fbcon: fix rotated font buffer handling on font change
Date: Fri, 16 Oct 2026 11:45:30 +0800
Message-ID: <20261016034533.445862-1-yaoyiqi3@huawei.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Yiqi <yyaqia@gmail.com>

Sorry for the late update. I was overwhelmed by the AI reviews. This is
not the driver that I am very familiar with, so it spends me a *lot* of
time.

This series fixes out-of-bounds reads of the rotated font buffer on
consoles that use fbcon's software rotation (fbcon=rotate:N).

Changing the console font through KDFONTOP installs the new font
geometry and then calls vc_resize(), whose redraw indexes
par->rotated.buf with the new cell size while the buffer is still
sized and laid out for the old font. KASAN reports, for example:

  BUG: KASAN: slab-out-of-bounds in soft_cursor
  Read of size 64 at addr ...
   memcpy
   soft_cursor
   cw_cursor
   fbcon_cursor
   hide_cursor
   redraw_screen
   vc_do_resize
   fbcon_do_set_font
   fbcon_set_font
   con_font_op
   vt_ioctl

Patch 2 adds the missing rebuild for the font-change path, and
compensates in the error path of fbcon_do_set_font(): if vc_resize()
fails, the font state is rolled back, and the rotated cache has to be
rebuilt for the restored font as well. The rebuild itself cannot be
undone, because font_data_rotate() has already reused or freed the
old buffer.

The cache key in fbcon_rotate_font() compared only the fontdata
pointer and the rotation. Raw font data does not store geometry, and
fbcon_set_font() deduplicates uploads by byte equality, so re-uploading
the same bytes with different dimensions keeps the pointer unchanged
while the geometry changes; the early-out then skips the rebuild and
the stale buffer is overrun during the resize redraw. Patch 1 adds the
font geometry to the cache key. Patch 3 makes a failed buffer
allocation retried on the next call, instead of blanking the console
until a font or rotation with a different key is installed.

The unrotated-rendering fallback that fbcon_init(), fbcon_switch() and
fbcon_modechanged() attempt when rotate_font() fails is ineffective:
set_blitting_type() immediately re-derives par->rotate from
par->p->con_rotate and reinstalls the rotated bitops. This is a
pre-existing issue that is independent of the font-change path, so it
is deliberately not addressed here and will be sent separately.

Changes since v1 [1]:

- new patch 1 ("Include font geometry in the rotated font cache") in
  response to the review, which noted that the early-out relies on the
  fontdata pointer alone
- patch 2 (was patch 1): also rebuild in the error path of
  fbcon_do_set_font(), so a failed vc_resize() no longer leaves the
  cache describing the rejected font while the console renders with
  the restored one; and select the console's blitting state with
  set_blitting_type() before rebuilding, like the other rotate_font()
  callers, instead of writing par->p directly
- patch 3 (was patch 2): unchanged in essence; the retry now covers
  the geometry-aware key of patch 1

[1] https://lore.kernel.org/all/20261014085102.497789-1-yaoyiqi3@huawei.com/

Yao Yiqi (3):
  fbcon: Include font geometry in the rotated font cache
  fbcon: Rebuild rotated font buffer on font change
  fbcon: Retry rotated font allocation after failure

 drivers/video/fbdev/core/fbcon.c        | 19 +++++++++++++++++++
 drivers/video/fbdev/core/fbcon.h        |  9 ++++++---
 drivers/video/fbdev/core/fbcon_rotate.c | 10 +++++++++-
 3 files changed, 34 insertions(+), 4 deletions(-)

-- 
2.56.0

