Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793579154;
	b=TSebTf0FG5uv9wXWlW1iR1yqmupEObGx8zAosJjJWK+qWJ5EMrgnCJ6WSDk8perNLXgH
	 bJT7+SbyYs8YNjG2SA+EVdHm+mfb3mDjTDXyQKNLdsCa4NPuP+/WOdMDUzxEBKKHNa0CB
	 Z56xTWETW9SuswH2MIjXnhXO19K6kaWr0O5dvsSrPCKkkj0A6Et4c9rJ2Z68avFsubWZ8
	 hVDLofCrpu8wKcwLESPYs1kCZ4IpsNWp4N//WTt+MGtjKNUS522X/gJgxAcNocSeuD1TO
	 7UCbQle/Gpfh5QxFcQjvoaS7w4l3Qb0SvF1DNE5AaDlE/93snVUgrXzTteoW4L0XAZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793579154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=IxaHOBhBHJELnjR7p3C67+RByc+CNdq09G2SjlGIq8w=;
	b=soAh1+NkSEnuqeHA75OPzUvbGttbmfMurJc/E16utFeR4bockoO+IgTqHXwtF1kkFSmg
	 fnhLlKOX289MD2MZUYYR0oTT8KHFlXaC/EnClBS38KrMh8M5RuV65HOItHf4x1dDzc+2M
	 yp8rxTMl2XcAKyfqER0o08+GNcxmMKogzH5BiSh7kSV+7//LkPnn+XVksLCmG4wfGm0tv
	 r+GsgVA7mc+MJrWLIacfdVRDud+UDNhswHPObf1H1Vi69q54Dm4BxHFgbrnLKg9f0996a
	 C/ojhc6jt89OntIbBHFaW03AZ2mE4cnH2MjeL9T1filkdUNfz36P+D/ORG/+BtSOMmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XCVwmTLZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FCA606A324
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Nov 2026 00:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43FCA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XCVwmTLZ
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so4595195eec.1
        for <linux-fbdev@vger.kernel.org>; Sun, 01 Nov 2026 16:25:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793579153; cv=none;
        d=google.com; s=arc-20260327;
        b=Va7xr94XTQSePsRFWGehFeRAcKzrcZAROMJDAYY7xiy23I4hv0BjC+/3QkY4+k7Zan
         1IxWdctjJ4OmW46APGjmjfgu8NeFrVjWuQEcs5CklyDOBKbXQmC1wF/82FRvD3iLJJFP
         zQshK7zSM0AAW+ENQn5SUi8p0zz4W8hdOREnMEDuyFjDoG2Erj0GCRoBRERI+z6JEmzV
         wH1MTK4B9EQRdJ1yb6G8E/5+uA2SvUYH6NAzeZ3hdzVeUCDGpDx+jTcQDGtrhzIndmJc
         Ysn2uhV0V7fGtyJvYHMJYSeZEjTEn3uLrNiJCh6j+6vAG6ZSI+6eHV9gTRGn59PMWMyP
         MIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IxaHOBhBHJELnjR7p3C67+RByc+CNdq09G2SjlGIq8w=;
        fh=0OzTX1D2dfYLDzfEsDld+awI73JgilcIc0DS19gjlyg=;
        b=dylqod0jVHK84Dh4TQygr27At9WP95jycQC8WZkStuXdJr3CH0JWpwfBEFrZtoz3L8
         U3rZkiWRGSCm0h89yRgq5iIB9d0d9r+WAMZNn76/jxa9jLzQfkfwK1gFS4Y9wh8W4jNS
         5sGrDKvw2Ye/ScrbivVCV5HXeWvP6P1YwT93T3Ni2KiJNfHllf45rB4oC3bE6/TTZ140
         aElSms7nHiVWS+PHe1bHDyWatLL3UQDgIW2mQjaV8uJC/nPkyVPTAu+MX0t+yHoCda8u
         sHeqcgpoff2wHnZKxZR4G2m8jgeP4X6XFznOXo7GF/5o1GTS/ARrCFPMUUCGIjKW/2VD
         /fgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793579153; x=1794183953; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IxaHOBhBHJELnjR7p3C67+RByc+CNdq09G2SjlGIq8w=;
        b=XCVwmTLZ350/60xK9/X/yBqfj9P8rTJau7RijEFDK4bT44aCS2ncX6iuM/LvlhNwND
         QpaEzggKZ3pWXkQijQpwjwWxSWh/4CSL5TviBBax8I4bjpPeYAvT884+pr6/AkYTXqV7
         WGbo7k4fRYdk69fdAPgkZ4aLFhM43tTyAU3gPE17bY9SX5emeVS9WJQF4AwhQSMRfIi4
         T4AkydpIuHtq3zP461ENG9t9QhT0v9e166zOzvK3uetmuTqwpCZ66hZ8fXPEZuvl7hUk
         c1jsEB+q1dl7knQS23VIQfmeoRyJO6SnYlNCWayC7h7RY63PtSF/j7/0MpI6Hq5C9IiF
         XQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793579153; x=1794183953;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxaHOBhBHJELnjR7p3C67+RByc+CNdq09G2SjlGIq8w=;
        b=jx/qxrSR82EWda5ZHQq/z/1uUZ/sjryU98W2cKuGt0rD7iYBmhbYDkFKwu//PIV2qN
         SVVBIqI5GWUAaT3qJ4GJAQapixlqOWdfR0XjQqEHiX9Uv26cAlmCELbhu8auurLtIvDy
         scCA7wcvdtJDWDoh0kxc5m4NDqMbVW5fBrblQ53IFZz+8lrXXP1/2w0AoWGf7F8GNgnm
         4qiAjTS7io8VmQL52b03R0lyS5pTD8PfhJzY0SiqNSKL/sriTS/NMp3gIJmPqyYHGwXf
         iVC1hLEJ0+NwAzNV9LZxrYF4QYM8w82SrED8yPEi/jRj86R6eng9Td1O409RJFC1/lYt
         8gKQ==
X-Gm-Message-State: APuU4Z+MbTBWUdiysa7GC26aunsY7bmOqfuacb/w2TSd2CtRv3lwCZYN
	CsG7HYnpZsUR0kTdjQRpctoDWTz4S2HxwmF1folcAr6nCUdkLXQeyioWQb23rVC0Xz9pFohWFTX
	B/8L84HwVXqhYt9BsyTqm7s4B8+JNAueulv6dzb7R5g==
X-Gm-Gg: AYBFou1x/qEZj6mK/YBj/5sjJSd7XZL3MMJsUsy/1s43XxdVe+fHNfEWeKywtWZYmeF
	RR5pxQhWrBvLwFhJl6tIeOAfwnfHvKCXdbAMWh+Xah5La6zCd90yGx3TS8Bkry8Ob6SskRbM2D6
	bYuNHCAps2oIkmoPJkiN3g1SsIkPdgtU/74AuSaoZNuzJFn6JZmLqCymXnjs0ihVV/nWBoN7ZZ5
	Tn0hoorZejshWzSheAo3iubTigz6WMj/X0sNptpHKSBAdyDlt41bzVPZzEt5H5S7i8IouSzSjtc
	y90ZcKUNBTHrSLekgXBaLqicz0/toaAJrdzk22+keonFAg4dw5T5X6eQLmTNTW9mPJavWyIBh2a
	GA68UF+YTCo3QX02So8NYOexxx1JXDcm71+qqFeKJ36aE/9+gzCY4UTcH2GO6w1plfYmTPQ==
X-Received: by 2002:a05:7300:f793:b0:35d:2633:ff79 with SMTP id
 5a478bee46e88-36a4245944cmr12788322eec.40.1793579153046; Sun, 01 Nov 2026
 16:25:53 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Guilherme Bember Duarte <guilhermebemberduarte@gmail.com>
Date: Mon, 2 Nov 2026 00:25:41 +0000
X-Gm-Features: AclHuK9yBlVXACtI0Q-ECo6CdIAwEfXFppBZZF_EM0LOwAT2YMseTCuKC_x1ZQ4
Message-ID: <CALykNV4SPeXMgGv+F77Gpd35QcaQCBv+Z8LMn24v_+j7sXrc_A@mail.gmail.com>
Subject: Is drm_log the intended replacement for fbcon? It needs
 console=drm_log0 and loglevel=7 to show anything (7.3.0, amdgpu)
To: linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I've been trying to run a kernel without fbcon, with drm_log for boot
output and kmscon as the userspace console. Before I go further, I'd
like to ask where this is heading:

1. Is fbcon (and fbdev emulation) planned to be deprecated?
2. If so, is drm_log the intended in-kernel replacement for its boot
output, with the terminal left to userspace?
3. If that's the plan, why does drm_log need so much setup to work?
Right now it doesn't behave like something meant to replace fbcon.

What I found (7.3.0, amdgpu RX 6600, one DP monitor,
CONFIG_FRAMEBUFFER_CONSOLE and DRM_FBDEV_EMULATION off,
CONFIG_DRM_CLIENT_LOG=y and DEFAULT="log"):

- console=tty0 loglevel=7                         -> no video
- console=tty0 console=drm_log0 loglevel=3        -> no video
- console=tty0 console=drm_log0 loglevel=7        -> video, and kmscon
takes over cleanly

Why, as far as I can tell:

- Without console=drm_log0 the console is registered but never enabled
(flags 0x101, no CON_ENABLED; with the argument it is 0x107). tty0 is
already first in the console list and has a tty binding, so
register_console() doesn't enable drm_log by default. I saw this was
discussed in the v9 drm_log thread in Dec 2024. The Kconfig help for
DRM_CLIENT_LOG says nothing about console=, so a user gets a dark
screen and no message.
- Even once enabled, drm_log_init_client() only runs when the first
record passes the console loglevel (it's called from
drm_log_write_thread()). With a normal loglevel the screen stays dark.
Needing loglevel=7 to get a display at all seems like a poor
requirement for a boot display, and it is not documented anywhere I
could find.

If drm_log is meant to replace fbcon, at least for boot information
before userspace handoff, I think it should light the display at boot
without extra command line arguments and without depending on the
loglevel, for example by doing the first probe and commit when the
client registers, or on the first hotplug. If it is only meant as a
debugging aid, as its DOC comment says, then a kernel without fbcon
has no supported way to get a boot display, and I'd like to know that
too.

Thanks,
Guilherme B.
