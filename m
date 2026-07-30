Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE46437A821
	for <linux-fbdev@vger.kernel.org>; Thu, 30 Jul 2026 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436022; cv=none; b=k6h3YcQLJ40CuJaGOUoUKycq+eH/XckPBO36EunQ15bapDnF59aWvtd8jknkNih4O0CCHE1MYuYIJXDvKHX4ZdH3ovDRiSZuKeYYejrsHp60kWm7TcHH37hE2ubj7nzVYW7nSGL5vGXxOb02DE0+aVbeliRi9knVyVJszX9HDf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436022; c=relaxed/simple;
	bh=4uPIsF/07nQWiK7hORjMXqOAIOO9PCBxhA5CHSppplA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGslfHdDxsqf5ZrAz1VfZUckfxGGWB0YmHrq3rxKC4H+OyH8QzuqyvFU9Uoo9l167B1wMfk4xAJbuJlLj3O9LClfZ9KGo146iCbLJOMyhhh5L6+X4gNXugveHwePaZCf8Nm4yQh6zymPTd56nxd1iz9tMK5c7qqEE2l5nnSEkAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=e/jx8N3H; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="e/jx8N3H"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8423f236418so196215b3a.1
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jul 2026 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785436019; x=1786040819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wO9ENFeIo1i8UFssNPgLpbWODUeNcQJ8iH/TKOtI5vc=;
        b=e/jx8N3H95jNGXHuawqGLIv7mL5GiIkUFq/e6lsyZoAEvdxPbgMf9YMjku4E33Z6vh
         to4tE+I5m2gCEHoxQlc2KZ/C+HlfPZrtTwfKaaH3TDHKgqguLw3tncgGfodeYcFWQYv+
         xjl0mcuu4VwIbrErkAQdG8UVzpNytnzAC1mY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436019; x=1786040819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wO9ENFeIo1i8UFssNPgLpbWODUeNcQJ8iH/TKOtI5vc=;
        b=F2jsAuiySx/HCe7p7Z7e/h5ZBteljmx0Okgci4rO9VbplO4r5Mbzcq8SV9O950Wgi3
         GMAi6bCi3/UNHv68jMABRPVYIym+Key0NTGTXqw3adreKQAzDpV3YzjVj7MEnyEFACQN
         RZ3LyuA3e+eSid26wMJzWLOqAp2CIcsClb7bdrKwKRFEsNxj9Al+Y7DnkvSj4jEskCm0
         WewJTWPDjvpCTE/qKYhdyNF1exTlzMCzHQSFIWIPQJyOHnD7nIKDzOsc3YYPeEVjFbwi
         RPEaJVcxau3VuK8BP+D2etItPt05CUg0xCAZp2rxhPS/UyFWFxLcOOoh9VjkCYlyOODi
         iQ4g==
X-Gm-Message-State: AOJu0YzNKdVuh/WZ8k28Fgm0gA8mhV5ekNu4aUZvmkgsDRaBCUHWZOeo
	GJy7peA1L3eNMX5cDMpAnLIlqV8jeqiJhnpjo1pMDaKwgADeVMaPNASw1mU+JU1O6zeppbArREQ
	KLsKy
X-Gm-Gg: AR+sD11SR+/wmMuXklklmFK/OsmPQBxqd4n7wx9GPT4r78xnd/OeLB+B5EEE7ZQWhgZ
	vupRt8/ddJV3f6T/LZFDMmmWUvN7lDHuUS/xtuwP8sOEBszVIffwURrFEcnHO280R5TpRXl1KSj
	n5+hjZs3pUT1rk7lRqad4+Y02vHkrTcXHAxMKwPEpPEgriKVK6Kqvh7ujwWm7sTZMXcN5ua9Xia
	BzVQh38NTDQgbr3zdmA0zqcq61KYNndKyKMEAeuSOJKzYK0IIHFS5HjymbYeWOQqKmjnfewJV8I
	S15xwFUpkY15hV+sXDHeUc9UTxlONTX3himpYxT5aBMs0IFODw3gYWSwmyQ4v2+xxXcgHqgqGTO
	btQjzc6g1nDfm5zjF8M7lUP6ajfH3tVNp8MQX07arzkvwTxFaS3SkeWqi/VptRbaQMlkq3OCYWN
	P6OAaBC6EMZ4XtkAKv/0U8rc7D39nTtco4i+n2Y2VWZ1MZwH26GmQj
X-Received: by 2002:a05:6a00:13a1:b0:848:6ef9:f5ca with SMTP id d2e1a72fcca58-84ebc421141mr3212810b3a.63.1785436018914;
        Thu, 30 Jul 2026 11:26:58 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:f84d:1f36:28ac:c15e])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84ea0378b18sm3428806b3a.48.2026.07.30.11.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:26:58 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/5] fbdev: tdfxfb: Make "unbooted" cards work
Date: Fri, 31 Jul 2026 03:26:35 +0900
Message-ID: <20260730182640.2808572-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently using voodoo cards that weren't booted by the video
BIOS aren't usable.

This means if you happen to have a proper - non-x86 - computer,
another card is the primary or you have a new BIOS that cannot
run the video BIOS tdfxfb would probe but you be staring at
"no signal detected".

This series implements manually booting cards using the
values from the video BIOS' own table.

Debugging was partially assisted by Claude Fable 5. I could not
work out why this would not work for months so I told it to
create a voodoo 3 emulation for QEMU to compare the BIOS against
my code. That made it obvious my init sequence matched the BIOS
but the VGA core wasn't running.

This has been tested on a real voodoo 3 in an x86-64 board.
I have some patches to add an interface for doing 3D rendering
that are not included in this series and 3D rendering is also
working so as far as I can tell everything is good.

Daniel Palmer (5):
  fbdev: tdfxfb: Add helper to read config table from BIOS
  fbdev: tdfxfb: Attempt to detect if the card wasn't booted
  fbdev: tdfxfb: Manually boot unbooted cards
  fbdev: tdfxfb: Wake the VGA core before programming the CRTC
  fbdev: tdfxfb: Program the initial video mode

 drivers/video/fbdev/tdfxfb.c | 151 +++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

-- 
2.53.0

