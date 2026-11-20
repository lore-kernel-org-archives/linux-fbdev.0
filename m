Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795137112;
	b=mkEbo7X62JwciBXKDYNlFNuy3pOVKs1f/d3bbDVu946ZjhM7+EPzP3hQ7SH1vgcmNCRj
	 uUIGw9cGK721ur8cWCCQYUGUsStBnuRva/8LTRVQRXzFF0ExdfcZ8UrOYiA7+EMgULdM9
	 hwGl5Qsi3rbui8+hQy8ns4gc4+VtCuXPr6R5l/xnwSyKxwTnAK+bi/xC0hpSgoQddTWB/
	 7pOO4Jr6SkU57bzcmF2qF20bqIDDOb5TWoxcwAF2t3zuCfeL4LNig0P6p4UhrY159siMg
	 cH6yc/u2Uv/kqM0dmQKZXh6KRJvBX1hBHoc53ut6L18QFIwio2jywqehq7mLEI0IJrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=+WauXmzgjTADvjBBTuDw9ddxWh3mS9R+yZFc6+jn+U4=;
	b=H14FfGUNAj+6UfinFnb4DL94/YEjUnZjxzaLuZXmBCVKlAB9Y/EIpv/JlWYqlDGbSEXv
	 xt+rJEidkIu31tDRmCLqfLaFFxth0pwEUPnrJiSyBPXlurtQkHe6G5SCaqKOaF8iWJCiF
	 hgY+OSWKMDY+zgS2uhdjpoW16JSdBrn2irvV53zuZyZejy+mYCRmHdUCaau6QdtF6Qkn2
	 kdgBX+NAjj50LAr1ox7QJD8uNDIiqkTnJ0um0WwpHKrP835Ec3tdl+v1x48wUhG3pExtE
	 i/2vpzDewEpizwzrmvoyNhYwhs8+oC/8Wlid4G8ei9HGquQGldsaEFKeLkzPs/ajd9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AsJxZNms;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70828606A32A
	for <linux-fbdev@vger.kernel.org>; Fri, 20 Nov 2026 01:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70828606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AsJxZNms
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3b40283c001so86560a91.0
        for <linux-fbdev@vger.kernel.org>; Thu, 19 Nov 2026 17:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795137111; x=1795741911; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+WauXmzgjTADvjBBTuDw9ddxWh3mS9R+yZFc6+jn+U4=;
        b=AsJxZNmszeOmf1P6FoD0ZvPkULx6VuhNHhNoP35uartk7q3/nSMkJlYOf6yueuMrlI
         5rUFjDiLJpw3jewnIekcwE8Fb/ABsrk3cWYcbWo/qMDSk/kCrTnzfmyJ4ZaeMr5v9fY8
         zpt8AVlZVCuJhBXKzglnK6saQp3dvp9lXhoAoPmapLCth8xICO+5rUPc+BER5EqBJapn
         CiHl7pFqBHYMnE7x+uDF+IOOddA3ragPxAk1EgAtVDKg6dpGW7BGex6yUqBFRRVVIXzE
         oAfIhFc0kAsegIkD1PfBMLJa9+3/W4AoUIH4ChL5qWACy8FxfpS+Nf1Zk+RPTNgMnvQs
         6vWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795137111; x=1795741911;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+WauXmzgjTADvjBBTuDw9ddxWh3mS9R+yZFc6+jn+U4=;
        b=F7uhkvGHkjIEwE3A0OlyqxgOELJ2w9ElAPelkVUKqK2i2Pwq0BM+K3+4euId3UrBti
         YiPnzzBIuEvPtGDDN6KGTSCCst/Y6I/EthZ93yCgA8jqYF1qmFOJ5ZAdDRfjp6ef7tJf
         lv4QEI+5Tf1MyQg4Gkmpnnw36PdJGa5VGmVqdWSADJ9tiFpTiYl8eBIcGRmCAyucN7QT
         xyMmQogKxO31DgvfSv25+l9eCDOKSLIixs7a2saxe5z9oIfrUcck91G/R7eCSR57MHbN
         bj8xaMJJA5GMzuz389BgJ8+48pT6dZdw/6hTBIwUg61Ann8XMxzmnfn7ik2qVCk6V3wZ
         SrWg==
X-Gm-Message-State: APuU4Z+P1X+J3dVWgRFq4StAAGTSxAqriaI95GHObMRen8qhND9xBy3C
	lD82/P1CEg+R61LF4n1D8MZyt/vKtBz14QaZI5XBdySYS+m20iqeUrIu
X-Gm-Gg: AZFdTZc34N67oX6COEPUkH/54FS1YVYliyz8nXsRj81qMaBLnDFGa0Zbrf9DhQ0hgna
	0WLX1qBxhnWv1vLf+0RnmXvIU/Ka7VzTF+wHusAB8DdeBA6oIzj7O+fxWQTmSJlKvH8Su5AoiFK
	5En6lFw4oxiJW1ihCLeqrrU7ev+F7QQeWes/RDQ2OvtGLoNxUo1lVi0TKNML4pHzI9YLd9Bw5tA
	KlhpeWazysmo66LgJdQIxxEi0Hio9Wct3jZkSYx5Gxqn5PcvbvB+WZ0zghb1OsLcog1EWL6Ml8+
	Eecci+x5TDCTr29ZD7BucDJUZC74ZENcT6mHHJf4VYZNS59rmz/LAMuE8jrNjYAgTQKq76+YHnc
	BZidOyWPbVWvPER+UIb9rryUl078SlnWtDZSBJDaR/Npugj5A79KoH9BmwdFw3RilSy0T/Vs1k5
	3k10sI91tTJtmfZj/bpJ/9n9+nlZ+77InVjrs4gc7gJoyKM0lGGMr5AqSSLop0Rq21Uz7KAUzUs
	CdCGFAHiSTzdBTPRZCRBm+ftMYooMtftUFVVojRVetif3MlkRpdfL3DnEaZ/n/eEVsQJkfx5uQ1
	jPjfYosCck7bxMZxrwF6ivyLwC2zELk9G01/xBZefXjX1j/wR0Wc+OaQvHe2T4NAU6SiEDQOcdr
	xZ40ltoxAYl7g
X-Received: by 2002:a17:90b:2f8f:b0:3b3:b0f4:1bf7 with SMTP id 98e67ed59e1d1-3b41c8d460emr1098385a91.23.1795137110648;
        Thu, 19 Nov 2026 17:11:50 -0800 (PST)
Received: from localhost ([50.7.253.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41d243eb1sm622215a91.3.2026.11.19.17.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 17:11:50 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH RESEND v2 0/2] HID: picolcd: Fix output-request and
 framebuffer locking
Date: Fri, 20 Nov 2026 12:05:46 +1100
Message-Id: <20261120-mail-picolcd-v2-resend-20261120-v2-0-d7531fa8061b@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNTQvCMBBE/0rZs4tJxCCe7dWDHsVDPla7UtOSa
 BFK/7tJRS8eZ+Yxb4REkSnBthoh0sCJu5CDWlTgGhOuhOxzBiWUllIJvBtusWfXtc7joDBSouD
 xtzvya7PReuWlgPzSR7rwazac4FAf6/0Ozp8+Pe2N3KPcF9KaRGijCa4pVREt/0Uz9bXBNL0Bd
 +SW7MIAAAA=
X-Change-ID: 20261120-mail-picolcd-v2-resend-20261120-ced5a8663d10
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, deller@gmx.de, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Clark Williams <clrkwllms@kernel.org>, bigeasy@linutronix.de, 
 linux-input@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Takashi Iwai <tiwai@suse.de>, 
 syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, 
 linux-rt-devel@lists.linux.dev, simona@ffwll.ch, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
X-Mailer: b4 0.16.0

Hi Jiri,

Thanks for catching that. Both patch emails were line-wrapped in
transit, so I'm resending the full v2 series. The commit messages and
diffs are unchanged. I checked that a copy of patch 1/2 sent to myself
applies cleanly with git am.

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

Helge acked patch 2/2 in the original thread.
https://lore.kernel.org/linux-input/CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=
=3DxkA9acsL9TSQ@mail.gmail.com/

Thanks,
Aveline Noir

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
--=20
2.55.0
