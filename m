Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611546;
	b=1tWBh7y5VxIxHjt3Dk+SHpMspD4YKQ9nCheMnpjIr4rBgZVzuSiIcrRZ5mGNBT3dBVKt
	 LlMg5J90jDTVv9BACyXwAI0AEa6qZzOKeEk3qDvpMoNVMR/zqF468ftPR98N45i2cSgPt
	 vwh1t4tltl3IH6XnSW7Md0Sk40t7BPT+dqhc/GpOKhkmP94HUg8SryAG6WIMp/7q20+Wj
	 dCb78bOlKuDU9ch3s3gho1lEicSsy7ZobuflM/9jF35ULdbVAlry/E0IjgE04XyFMMaXD
	 Ra94WCUh1c7VCdX4nza80qyudh6N25PxXZDOEMV4oDXbEdKLcL7a7C1fbSUro+EjdVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611546;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=i0YJmDm8gA/DEKgkw5VE7O1KDlOMQNvIwmHotjeEm44=;
	b=UqPwonODLh+FMZIxWtvhIgPd8U3BoWM13CvTqNpCIsNfXTMOBbC1SAxMgTUfajSjKoqK
	 UW974MWuF9GiXGatoajvzHDS/B+jOwaAv4kAOi538mgn5oDeHydaW+WjlXn4oSLfbWZCU
	 uawZ16MPhcsU34C4MF8HC+NmqKkLhZEuavboEXQfLIBMvrjMOUzegpZnCG6g0tPpAjo7O
	 gRw9x27iRdoCUlBFblxTCW8uCd2uu6i2hH2U1LlRdwk06pjXxebRukRJ12Yz+iYIFwRQF
	 /rdoDWkXPXkGZJbg2lMayIsZ7Sh8EQH3gS+qcaCrEAYggknYO9/+2KMSWlaIHwrXuPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="M0/aHEUX";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hLzh5m4M;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40C60A2606
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Nov 2026 09:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C40C60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M0/aHEUX;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hLzh5m4M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793611545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0YJmDm8gA/DEKgkw5VE7O1KDlOMQNvIwmHotjeEm44=;
	b=M0/aHEUX0Ve/cbDQhqnZaQoYeJuI47eXE903Hqu58lUkA9oK29dFCxQ9WxZa8Ef3eWgyRW
	7Mo6DkUPa+ufNejSlwCNv3od3YbdXXILHIjqN2aDm28sNpurFGN/ExATgxmldYrgcrzpP/
	lnAencFsTF02tnbVnRq1u+rHmc48LPQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-OKBWFqVpM1-CAMJMyoX0RQ-1; Mon, 02 Nov 2026 04:25:43 -0500
X-MC-Unique: OKBWFqVpM1-CAMJMyoX0RQ-1
X-Mimecast-MFC-AGG-ID: OKBWFqVpM1-CAMJMyoX0RQ_1793611543
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a9d51dc486so23529555e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Nov 2026 01:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793611542; x=1794216342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i0YJmDm8gA/DEKgkw5VE7O1KDlOMQNvIwmHotjeEm44=;
        b=hLzh5m4Mwt3mjBFVEDDUI4YcAp0FgQ/fiznrIVyDzU7v5f4uH3vUGku+jA38C2nyW5
         ks68t1D7GQDP9OasgJWN/IqzAqSLFzQLC02oRn9uqEPHzMdi9zT2QlOi8f5tDaNEn5DR
         dKdQOEHRirVAewMWNe2r+9S7b7dXxSYLMyLI4pxHv8V1i66l1Ac5RJ0GDVR22KkO50iM
         5CiaDJ+PFYeYvpmwJtfzyYHZlGsOHycYatrhOOMM6yNmBLHCujWN9aSbHxtuhsxS73np
         DgRCzISBc1VyMf0qB4Ya9JmkHljaVfTEK25Lx3OLgWUFLj+bbLg4awx1GqTgMRaNyytP
         D3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793611542; x=1794216342;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i0YJmDm8gA/DEKgkw5VE7O1KDlOMQNvIwmHotjeEm44=;
        b=l0uCZQWpGU7789EJSfOlwRAUYLugm424WHAnZYkyFbgxWGuqDRg63Bs+4b+DMuU4So
         XD2Ld/CzJtyktj6rHScQluXey9dc6+8O3GfyiyG0KEjPmCqviWjta+Fwk4nJa1q1AcY+
         0UXSuMqhKWZ4KJAjpRJqY6PvcXGD80Q5gTpwPqlqBKC6JgfOUi5wEl+Y1iz8XlAejcc3
         8psZssHh46fmr1/msWWUJqH1HvTeiW25KTz0k6LU+jzFt4Vo2fsB9B1sttBdgmkMZ9UG
         vd3JpyU1wdz8Q2UwoaCGBxnKYe+K65FA3o3RqG194s+lEuyMbOuD9EMQrhYXiLdCSrVu
         rvnA==
X-Forwarded-Encrypted: i=1; AKwUvBzHyHD66Xsx6NJ1AmZXUOw12lT+eSDUEwVkuOAfrcl+2D0nTJpZk6VSpCFdR1nt8YlV0h6BPXCgLOSTow==@vger.kernel.org
X-Gm-Message-State: AFq9FYIA7m0i9gtIRbu0sMC7yzpR2NrG8TdGxlY7DAJGBDT0i1Qancta
	ltiK+8N+/XylX3yZknH9zxs0MsnP3jfWRIueXwKbpE9PTjqG2AGkY8OSwn55c9Hjb2+HNwj3wcL
	BMolhiqho1m/NvAaNB+OTtaPAhFBaCLI0aEpHg5E83oxwlPqVTD7a4pR4FcTEY/ct
X-Gm-Gg: AYBFou0pc5jYbjEB4jHdE/tM6+Lf8zZq204cX+tDyGKx/zg7kYpYJIbl65jQamonXf8
	VHrE/qctGR4ZMuYQ2ErJxpQ4YuFgfcDH3rzTc2XuKXRJRpEo6D4xsB38QLtesVGSGENz0gCxsdQ
	ziFotC1/9ngYk9k3AMMWeA123F1XltU1pbEgTjTjmYsgRe1oVuud7mCmPMXBOsvN9D2QLoz7oTV
	iKFSLhEwIOACLW9QKqbAxePYRj0oJBWPWqTc2dTW3DspYMRAGUlzkNH1d4hpCilmiezj6n0mo+v
	xOroA0nbbdz3HLssrfjj+3KYimP7QzGlQx7cDJD9J7oeLvdszuGRq5bLVsoxerC6Wdvk2Jj9nla
	TeDeQG3KRXnahYM1CmFDh34m9P2XOAHqodniWvzL4b67RZEn1NBE1v2urgaNuKVqhklXGnYnW90
	K4d/D2h6AowPEBgWEdckw=
X-Received: by 2002:a05:600c:c87:b0:4a1:efbe:529c with SMTP id 5b1f17b1804b1-4ac17567fe1mr225820335e9.12.1793611541873;
        Mon, 02 Nov 2026 01:25:41 -0800 (PST)
X-Received: by 2002:a05:600c:c87:b0:4a1:efbe:529c with SMTP id 5b1f17b1804b1-4ac17567fe1mr225819905e9.12.1793611541508;
        Mon, 02 Nov 2026 01:25:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9? ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09ad5ff8sm182618865e9.4.2026.11.02.01.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 01:25:41 -0800 (PST)
Message-ID: <5ee324c3-ddcc-4042-8708-01418225025a@redhat.com>
Date: Mon, 2 Nov 2026 10:25:38 +0100
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is drm_log the intended replacement for fbcon? It needs
 console=drm_log0 and loglevel=7 to show anything (7.3.0, amdgpu)
To: Guilherme Bember Duarte <guilhermebemberduarte@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: javierm@redhat.com, Thomas Zimmermann <tzimmermann@suse.de>,
 deller@gmx.de, simona@ffwll.ch, linux-fbdev@vger.kernel.org
References: <CALykNV4sPj4PPUfx3j9qbc2pPsriNgiUHk2cL1N3+1H_FMc4oQ@mail.gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CALykNV4sPj4PPUfx3j9qbc2pPsriNgiUHk2cL1N3+1H_FMc4oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/2/26 00:44, Guilherme Bember Duarte wrote:
> Hi,
> 
> I've been trying to run a kernel without fbcon, with drm_log for boot 
> output and kmscon as the userspace console. Before I go further, I'd 
> like to ask where this is heading:
> 
> 1. Is fbcon (and fbdev emulation) planned to be deprecated?

No, and probably not in the foreseeable future. Fedora 45 is switching 
to userspace terminal, so it will be able to disable fbcon in the next 
one or two release. But that's only one of the Linux desktop distribution.
The Linux kernel is also used in a lot of different hardware and setup 
than desktop, where fbcon might still be a better choice.
> 2. If so, is drm_log the intended in-kernel replacement for its boot 
> output, with the terminal left to userspace?

Desktop distributions that wants to replace fbcon with a userspace 
terminal and drm_log can do so. But they can also stay on fbcon, that's 
their choice.

> 3. If that's the plan, why does drm_log need so much setup to work? 
> Right now it doesn't behave like something meant to replace fbcon.
> 
> What I found (7.3.0, amdgpu RX 6600, one DP monitor, 
> CONFIG_FRAMEBUFFER_CONSOLE and DRM_FBDEV_EMULATION off, 
> CONFIG_DRM_CLIENT_LOG=y and DEFAULT="log"):
> 
> - console=tty0 loglevel=7                         -> no video
> - console=tty0 console=drm_log0 loglevel=3        -> no video
> - console=tty0 console=drm_log0 loglevel=7        -> video, and kmscon 
> takes over cleanly

Yes, that's the current way to make it work, I'm sorry it's not that 
clear in the documentation.
The first problem is that the console has an historical default to tty0, 
and it's difficult to change that to drm_log0 if fbcon is not present, 
and drm_log is the default.

Regarding loglevel, it is intentional to not modeset if there are no 
message. That way, if you have plymouth, or another boot splash screen, 
drm_log won't introduce another display flicker at boot.
Most Linux distributions use "quiet" and "rhgb"/"splash" to hide the 
kernel boot logs by default, so drm_log makes it a bit easier.

I really should update the Kconfig entry for DRM_CLIENT_LOG, as you're 
right it's missing those important command line parameters, and I 
understand your frustration.

Best regards,

-- 

Jocelyn
> 
> Why, as far as I can tell:
> 
> - Without console=drm_log0 the console is registered but never enabled 
> (flags 0x101, no CON_ENABLED; with the argument it is 0x107). tty0 is 
> already first in the console list and has a tty binding, so 
> register_console() doesn't enable drm_log by default. I saw this was 
> discussed in the v9 drm_log thread in Dec 2024. The Kconfig help for 
> DRM_CLIENT_LOG says nothing about console=, so a user gets a dark screen 
> and no message.
> - Even once enabled, drm_log_init_client() only runs when the first 
> record passes the console loglevel (it's called from 
> drm_log_write_thread()). With a normal loglevel the screen stays dark. 
> Needing loglevel=7 to get a display at all seems like a poor requirement 
> for a boot display, and it is not documented anywhere I could find.
> 
> If drm_log is meant to replace fbcon, at least for boot information 
> before userspace handoff, I think it should light the display at boot 
> without extra command line arguments and without depending on the 
> loglevel, for example by doing the first probe and commit when the 
> client registers, or on the first hotplug. If it is only meant as a 
> debugging aid, as its DOC comment says, then a kernel without fbcon has 
> no supported way to get a boot display, and I'd like to know that too.
> 
> Thanks,
> Guilherme B.

