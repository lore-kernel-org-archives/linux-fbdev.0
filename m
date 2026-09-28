Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB64B0E44
	for <linux-fbdev@vger.kernel.org>; Mon, 28 Sep 2026 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.203
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596011; cv=pass; b=r4AaAOXJpDnX4jFJBo53YZrKu7Ibr9P8ldxykgE9Jq+l5h7b8UwH1/vNGt1fg8Cksz36Fbl6Gnns7oNIcQqlnki3+HEIrFURUlFzkuxjAxhNO9Xo54spmmzpmodccjnxBybZ0fDEf1Fk+6rAvdg8nT2OHd3ezJCQ0QD46nqKjVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596011; c=relaxed/simple;
	bh=lBv8IBD6IJb/z9r6xNQnFgugXVsOeX1D0j5YFBOsNP8=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=orhQlUTsM2jymqTIMhffPCM1pa0QcrQbO+mjCb40PDrIV2UUVLCwsVOTDXPs/eOwrKIubiwjevHir6dH8AnNSDFuES1tdaGkbg/PevP9htzVBMaY3AO3pUjtIncQDvWokPCvKaEO9ikALYMbQMJr6/g3OUPedY/qjuWCFJ+YLGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEmd1BhH; arc=pass smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEmd1BhH"
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4c112aaaee4so199669b6e.0
        for <linux-fbdev@vger.kernel.org>; Mon, 28 Sep 2026 04:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790596008; cv=none;
        d=google.com; s=arc-20260327;
        b=HpnzZvnHtvhvbeHSSYE6rKOofj/Pc1otSHW3MUQWtxkTbulxzAY1dhvhzLEin2h06R
         U7n5rht75+sV9KQ2yD7Bv0e+1PY27PIgfTgIujALnj2TLQ/kFnP7ZCbyp26DIsNr0+Jc
         k0Rl5AD+XjyH8P1heWqYW0jwQzDU7PqBWRxMnaAFAzjmrfjED9USv3h2i4oEyyngquGK
         XQrITNv99FS5c4pPXJ4PndkuqUBMRu9caCt7O+lRJLDiJxrzR6CHYpEJZIO/w/M3RrUa
         /EVAZ7o2T2wL9O8I+oounb9CwsiPmrpDYahzZbSbQUuPDg5LVNDFUx5mlKn//POdXhpm
         9BPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=8y/14vF+O1HeqA5emJg88NL5DefW60ELONqq7Ew71Mg=;
        fh=kbwOSuo4wX22Vv0hOnrl1r2kjH80bQvooUvUmulj5V8=;
        b=Cn+aodsOldwD53lp/t8EmInSqTptEepbqiCN4jGiaHgfuBv98jbCvwFs5m06Xte9wM
         H4sJvT31GJquaecnLjUsBscC+yL4fxSZ5luUa4G7I1z8UTSkoJBudpGmoxx8LZ5xhgGB
         0JjlfCrXjiRnHI8qSb+ZafUSB4WAk830h2GweQnsp1YuItUT4nmLMVj+VtPYR+7eTrcA
         fB/bQTyWMOM9qAWNcllw06igEBX68V1TtEDDBUHqEZHd0TzrvWz1I7Wi7NBGn4JIQjfU
         Gfev6mpkF35U6c4n50Og/wLxpqlhaZbMblyKp7i0iEURCi7fdv+jsSnD4jpfDS2iRsR9
         Q3oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790596008; x=1791200808; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8y/14vF+O1HeqA5emJg88NL5DefW60ELONqq7Ew71Mg=;
        b=fEmd1BhHfrHKOPJbcsNae+s3Qjv8xY7/kJNU/qJzo1aycD20k8tDOovLZxcZliA2B3
         1UR6ZsqPZFlNdsH9jf5ZOhVNoTWI2SUDCrF3pjjnbkAuE4NPinNzZKKbWHgb0PTfe7k1
         x0h/3oFwolKtCk/DbFHsHDdMDJag6rR6R43OWTV0+N+2f51mNjp1+h6FgsE2CJg5nIfE
         v5r7RjUdEywqXlDlRGf0jRqlrtX8qt0XwxgfopIsE4xPQQkPsmTIA8DOsSk3DVwEy9en
         Rzjaq96OGEl2HZytM9jKx4JEj6IO1kPI9Igdc4GY1dY48uILGGJIN/ipV5CgSxp/3TSW
         TbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790596008; x=1791200808;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8y/14vF+O1HeqA5emJg88NL5DefW60ELONqq7Ew71Mg=;
        b=MRu8z5KHv94uvcRa9CHyfog8aDcZHKnSJroydVDiDZeo5trNnywUp/TgkYf7XDb2/p
         RTHw9tMm4JtyVeTv8mRUpFVuDTC4cCfqbLDj5vZXItMcclSWA7ytrS7uCq6075OIDPKs
         xJpRLWAMQiF3OzWsuL1uWHmyICj3I8UiX/1FKmWoVuklzFv+obC9gclru6TF67WeorqN
         RbiojkgtUDzu8RHsWEJnazUjVL48dx/k/Z95xh2X2hmxznlR+RhSXJ2MMSa1M3+lVmq4
         6PQbmfbYq+2FocNO1VAGeEEQbocuFxY2cRgrndk2+7n272LbR8QsmAIPIROhJEbfrXwB
         1sGA==
X-Forwarded-Encrypted: i=1; AKwUvBzMGMKquFrgSeKAIb6lq4qSgCFdooEWE2rCWH10dBdI5syswh+tReT7KO0UZmB4XfwDnLckxSbwcPG3sw==@vger.kernel.org
X-Gm-Message-State: AFuF++mkBF8imRyahz7+3OOIr0ZxDpKkLx6MVfcDIjXTrFv9FxUHo5RZ
	7KE+qFby6PltVOEYDgSPnXsJsfZ9Hi4gpwsoll+MG7w6byQ//a9/MjUQIIyiDURz4YovzbOIWAR
	rdiupUaK2MKFql28FkF+Kgp3qWjq9plE=
X-Gm-Gg: AYBFou3vRrq4vdjztVL588iyRBrZeCUBCeG5ftqgVFpL6SX3CIpEhh9vuBE0IMQzIYm
	OGWTzZB26Qc5Dzh91mA+Hxiqjkt2xOTwVxusMLrNqTrfoy++xTMWeBr19tVO+amLu6Z9yfMjOBK
	cCZ3QQfn/eotAXP+l/iHb8kaBhE2UyfvlxdNs8S2jYRDfTj8cJcQMJ/6AvKgLQjqAOsk7nuPvqS
	JTE19f6gmDuvpX3hjqkhLJoNJrEwLnM7w6gLN5IIq1xtLy2/TLRzTxz/+CL4dZOSuTJ72GgJJGu
	MGmKzfpjiPkG5p41hZRbN946v4YYtBeQUbdo3FhdLqsk25+AWc/9VxFAoBGbvSwg7DN7VtE3J4K
	Wi4lOgYPiSA==
X-Received: by 2002:a05:6808:bcc:b0:4b3:7da2:f393 with SMTP id
 5614622812f47-4d72c636b6cmr12794285b6e.15.1790596008135; Mon, 28 Sep 2026
 04:46:48 -0700 (PDT)
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 13:46:47 +0200
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 13:46:47 +0200
From: Aveline Noir <jm5905938@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 13:46:47 +0200
X-Gm-Features: AclHuK8vvWWUjI-1FK5rP_VlhGDEQ4c_Oaxo0Aq7l7qcc2S08USGBF3bm-pvFn0
Message-ID: <CANOyQmEg5abcMc-Xk6=2hQQWu9vq9wevGR3spe352QLyxsZNEw@mail.gmail.com>
Subject: [PATCH 0/2] HID: picolcd: Fix output-request and framebuffer locking
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
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
