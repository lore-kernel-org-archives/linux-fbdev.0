Received: from mail-oi2-f7.google.com (mail-oi2-f7.google.com [74.125.231.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA54E3244
	for <linux-fbdev@vger.kernel.org>; Mon, 28 Sep 2026 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.199
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612157; cv=pass; b=DWbsh9j+3n64Vg2Bmj2bJE+3VUPlFWbUQ3rewPr/hoFnoF2ScacrNWef0UjQs5euLE+c3cVDExH/WyZkxhePnyMYKwSTb2xfpOLOp/TrfEAg0t0O8WKuG0Jk3mIhmUyYGuzdYvLp5T8uXaT8mI2uSpHpbX89Fg97cPWwwBOmwLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612157; c=relaxed/simple;
	bh=5zhxTTDmIVJyF7gRnQGI1x1uORVwq6Xhxto6tH0D/wQ=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=FICLwpWn2xnjT3MYOjatk3pk9vGQ6gTpd7WEbeqH5ybVXob1SszoGS6K1vSxZE5z6/bMEwNAnHxC8ir4VChG7BJMez0TlfeqhVvgQNpL/ob8U2iy3AC5t2JZm2voBrOi16yg20upjzHoIICR95iZyhn/6xMLW13M1hpPkrKuSTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlOhyslV; arc=pass smtp.client-ip=74.125.231.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlOhyslV"
Received: by mail-oi2-f7.google.com with SMTP id 5614622812f47-4b39374fab5so1125287b6e.1
        for <linux-fbdev@vger.kernel.org>; Mon, 28 Sep 2026 09:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612145; cv=none;
        d=google.com; s=arc-20260327;
        b=EVcdKGYP4/XgJKt+OGIK2odmpg84okZD4+vyeCkN33v5F+4xu0MSvTAvBnKhGyQYdR
         Q1Qsvci4qUY25SKxTt9SpoS2Hgrs8IJkOIpZUamfDQANm1RDxxsJaZPOGlmmZQAWD5eN
         MUCinkfpnog+9L0COAHjYq9vQeDCPDDKQk64P0gdrCc8sayxtGWU75W6xfoHabNXIKoc
         4m23ojquLBtD+gcicRE/M4s/AfXvKMpua2KtIWCHpHboIwbWiWG0nLeDOozZzYosNgFQ
         3GlFYS9bgv2rG5jJQ3f5v5Sckj+5rKpJjXLoksrw+QLxc8YQd1O5CT7ChJnpxSlxFPfL
         guJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=0A5INQy7dX8LBqGciPLMu7YdS8AMK7M47XwobBkMymc=;
        fh=8uW4tyIYMF+B+5XMFQZlui06QYcKE/BAZKDjGrLco0Y=;
        b=dTqce+UXNCAUfQ0mFyo0DgUoo2DmO5Pb80yD++IyjZohBQ+IgRUai/Ri9QpfwJl6NC
         UOsrIzqx0wY+oQR7RVcac8L9ucEFKE+SSKoDCMVTP+Jd8bEGxO66CkPDyYpSdyHU8Fyi
         nKClb0VTlsq/JkFwbjPUX2krZ3tqjq2Y9NLk36KQLiOv8f1/WK7ZrJ3gbbRbFasW4cmQ
         SLvMXZ24rFZv0vid9zEP44ssHlSISzkx68wmh42i8QE/UsK5DwXbEICM6TQ96AeZI7OL
         WDqFSyX+PbfNDJpXibHBU68JCiZqDBWVmUzNlBHD3nOKoAHj4/HZ5aEdWhZwWcGbjE1W
         rBQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612145; x=1791216945; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0A5INQy7dX8LBqGciPLMu7YdS8AMK7M47XwobBkMymc=;
        b=ZlOhyslVUrlWymcuC/MqPbxr4onRVzChOjkIPIgTGWjevHlLxpftjx9So4kGgay9TJ
         I1e0qyo36WrHA7CrVVzULjLmP41bpz1dbXrPO3oH3v3nCeEwlpJ7ctpgOKwNry3cP4lm
         EucllAX1KO++yYuDTC5kpHW/nv+i5kyZ3ssIavSSPgraGgJeo4XW8jWJULZv46eIRI2P
         c/lAhgZ+rQSD4Pr2aLFtxo+JiIQ5pxA5huBRQLGhn8L3iOOx+1fMpm8aDk7Xj6du4W4G
         c51aMVXxbAszP4ySV1HTYxr2bQhKi3c7KWKZ8oKF5ZPIcL4T9C8fbyWZPwKQKiIW4WBm
         qHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612145; x=1791216945;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0A5INQy7dX8LBqGciPLMu7YdS8AMK7M47XwobBkMymc=;
        b=KBtAfxpnF1fkz7MoW1zg7UE0DcYWiQ6AkwzC1wQ7ulknfzBpBmTA0YCq+KzoyHZZvS
         8XsMHrVBLpMyBBFFK0NqZheaxOD9tBEscK2aM6BYESvmeW25Cwn9zTMhkZXuraiG80gL
         aDVBns76oVDPXZl1TerugKTk2vq//zJCSakMZjXAw1Sn5uCJyqZNy89F9NjpgnEWViCW
         0EeZFxkat2QUz61E+lvmrwcfzblNoF1PCju0OGt5X3C60OlzYO+zaFyIpWDl3iEQmDFe
         dwDEOeMYdEzCArnvpEkuzvtcbx+KMbe6TK2uYvDID1jPhzYOTtJrgM52a8YYr90YQpLb
         hMWw==
X-Forwarded-Encrypted: i=1; AKwUvBxzkXn5rs90Z7Y6TQWOb4Ncmd72MtCQnr0IVWJ+OeOgqOm3Ffmav+ibVw/Lp0KLwSa8y6dPT2G+F4titw==@vger.kernel.org
X-Gm-Message-State: AFuF++mqguqwTbaXztCCRfDcm2cQ8qNbaNxlCMk38HqIqEplQ/c/Qhc0
	1OwIV8pAppC16QueTtQ5oSYrfhh5yTGC6bFAPNVckO19lt98rA0G87R1qR/7d5PTzwzMrSCNWFd
	lKVJRXfIEHqq1wzKHAQlIPLLHMP4mde8=
X-Gm-Gg: AYBFou3vKjBo7MVMyb0xkuAfRxH6LGNECVUe0JRZDAAVtyx9ZzHLsIjjwvmwHDroN8u
	TOi8VQFejn1oJhM+7U5DxYLCQIgtPkhSteFU6seP+A052iSWCuRIDjYGmJokzBsGB12coq9E9Zb
	54i7NTJkj2GCNd6r/NdaeoYp4Pp0q8tLSUCFblswAFlUUD6LbcystMbjbpXLAgFp6lx8CskXhxP
	Ho0vWlEhYbFF3kvfgvy9Xj50VNnvthDVVAzyx0Ao/Hf/21D2JnE8liwsK2HX6TsXBcPJONSCdoL
	0CDj6yH1CbZ+aQ5goEi+XV8V+94T8HLfVrgla1NnyRoyEWc1WcKh1ustzmnpO9/kMbmtfA/Gvc9
	704iEJ4RzRQ==
X-Received: by 2002:a05:6808:198e:b0:4d6:90f4:48ba with SMTP id
 5614622812f47-4d72ac45eacmr14395634b6e.44.1790612144676; Mon, 28 Sep 2026
 09:15:44 -0700 (PDT)
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 18:15:44 +0200
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 18:15:44 +0200
From: Aveline Noir <jm5905938@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 18:15:44 +0200
X-Gm-Features: AclHuK9iPdog26wVV94AzoDOB6Ecnbo54mNzfsBz7HWPWdsxEbSKehYuy5Lt6Js
Message-ID: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
Subject: [PATCH v2 0/2] HID: picolcd: Fix output-request and framebuffer locking
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, bigeasy@linutronix.de, 
	linux-rt-devel@lists.linux.dev, deller@gmx.de, simona@ffwll.ch, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

This series fixes two PicoLCD locking problems. The first moves output
requests into sleepable context and serializes LED state updates. The
second breaks the last-close/deferred-worker lock dependency using a
private framebuffer update mutex.

The first patch was tested separately with the original syzkaller C
reproducer and bounded concurrent sysfs/UHID-destroy workloads on
PREEMPT_RT. The complete series additionally passed repeated framebuffer
open/write/close and persistent-open framebuffer tests. Pre-fix modules
reproduced the respective failures. Physical hardware, prolonged stress
and suspend/resume have not been tested.

Patch 2's Fixes tag identifies the fbdev change that began draining
deferred work from fb_release() while holding info->lock. Patch 1's Fixes
tag was checked against the upstream transport-conversion diff.

Changes in v2:
- Address Sebastian Andrzej Siewior's feedback: clarify that the issue
  is not specific to PREEMPT_RT and identify picolcd_data::lock as a
  spinlock_t in patch 1. The code changes are identical to v1.

Aveline Noir (2):
  HID: picolcd: Move output requests out of spinlocked sections
  HID: picolcd: Avoid framebuffer last-close deadlock

 drivers/hid/hid-picolcd.h           |  4 +++
 drivers/hid/hid-picolcd_backlight.c |  7 ++--
 drivers/hid/hid-picolcd_core.c      | 46 +++++++++++++++---------
 drivers/hid/hid-picolcd_fb.c        | 56 ++++++++++++++++++-----------
 drivers/hid/hid-picolcd_lcd.c       |  7 ++--
 drivers/hid/hid-picolcd_leds.c      | 31 +++++++++-------
 6 files changed, 93 insertions(+), 58 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0
