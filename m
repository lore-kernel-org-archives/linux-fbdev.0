Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550920;
	b=ilTLVKhU4GDgpAuBIH1KEVzJpLGNo+G4TatUBZ0nOY8qFNKEH/ZvBQ+i5QWVcImJ8IKH
	 RhUC74ikHsP1RUFKm0YMJwy4jc+5V1D9zrFsZOq1rXasr6I6l8PnM9UaJv1dRGoq3YF/Z
	 uJVjADTng53cZYVtx5V06tAoN/MpKA5+fGC2Hvz8mLV0dEv30xEkkf7apXlo3AFg8BOOn
	 p9EEbr0yt03dxpsF+IgzoKdNscqOnBCxR94gzIwstHaMthHBqKQJWNIVX0CqaClRPc/6r
	 RA127AluZFyrG6TplQREmXnGOYZzrwBuxMEIzk2lTt9nQQMIextEIVi5b104kqrgcQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550920;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=DKKBS1U0VE/3M/o2OGx1V8+PsdZJuoLSZ40UgSxaqYY=;
	b=iS0f8soYQLhTojc74+WuRZW6U/relx9DgudUeBl34EExD3z6VaiPv+JjVQ9kuzaXIC6x
	 Pthj1gSPhmk1fH6LXE5b2Wq/mGsVbF70rARhtaW1sVAuHoV4VXSsQ81cvuxSxhOMgLeFN
	 Fg0OZ9bxKnCilJViHa2ei3OyG71Jq/mSTLNXH8K1rywmhHatWrpsHxVHtyz8WwfcMKZl5
	 O6yD05NUQkCvZeS8gfZtAfDC2poGjLt4yjEQ9qkUonHL94qmO0lyVoLV+iu+hcgARqprB
	 YC0mZO3uBC7rfA3lxRNOmn7x3f3/azJ48xmn8IfHpcmKTE+j3tLcoBP9NMzFUtqwVvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=clJTmCYN;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D384606A31E;
	Tue, 24 Nov 2026 20:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D384606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=clJTmCYN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795550917;
	bh=kEMsWENHsct+hnOy/u/pQmeeCpFzxWi6tmYy7lkr2wM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=clJTmCYNwvUhqDOkMu4RA7chckDqhxt6fYb79HAYQV87DgCeTKdGRRp4ZIptr6uZd
	 R+L81WK0g8UEzFdizqqMZC5R7oreyfbN5PCdUC1toBs9uqgO9zRjD5m8OCMXz1+FS2
	 c0FuY4+EhDAezR/yNdahiteduhExHHbNGI/+Ug1tbC2lMwC7a+64uWCHuBAg/zlPxD
	 dLdR19c2WmrAHoQD3UyYp07OcgYDJfoiS1tiNnD1QAguq43BZiTPlzt3/cow2Ae6cy
	 1hP3jxq7GiX7KReuuni8DlsYuamVx4T3gAuPS2o2Tfuudtd0hN2qN7xncmx9fXxZCQ
	 22Sqwa6dALYbg==
Received: from [100.64.0.241] (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A17617E090C;
	Tue, 24 Nov 2026 21:08:37 +0100 (CET)
Message-ID: <6f58183d-1bde-4b6d-b09c-094c97732609@collabora.com>
Date: Tue, 24 Nov 2026 22:08:36 +0200
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
Subject: Re: [PATCH 13/25] drm/tests: edid: Fix conformity for 1080p+4K YUV420
 200MHz EDID
To: Maxime Ripard <mripard@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>,
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
 <20261114-drm-conn-hdmi-cleanup-v1-13-20e8a33a2286@collabora.com>
 <awRgyldN6JaiisFJ@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <awRgyldN6JaiisFJ@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/26 5:51 PM, Maxime Ripard wrote:
> On Sat, Nov 14, 2026 at 08:03:37PM +0200, Cristian Ciocaltea wrote:
>> The test EDID added by commit 58fe1d78605e ("drm/tests: hdmi: Provide
>> EDID supporting 4K@30Hz with YUV420 only") fails 'edid-decode --check'
>> (v1.33.0) with the following issues:
>>
>>   Warnings:
>>
>>   Block 1, CTA-861 Extension Block:
>>     IT Video Formats are overscanned by default, but normally this should be underscanned.
>>     YCbCr 4:2:0 Video Data Block: Some YCbCr 4:2:0 timings are invalid for HDMI 2.1
>>       (which requires an RGB timings pixel rate >= 590 MHz).
>>   EDID:
>>     Base EDID: Some timings are out of range of the Monitor Ranges:
>>       Maximum Clock: 297.000 MHz (Monitor: 170.000 MHz)
>>     CTA-861: Multiple native progressive timings are defined.
>>
>>   Failures:
>>
>>   Block 0, Base EDID:
>>     Vendor & Product Identification: EDID 1.3 does not support week 0xff.
>>   Block 1, CTA-861 Extension Block:
>>     Vendor-Specific Data Block (HDMI Forum), OUI C4-5D-D8: Max TMDS rate is > 0 and <= 340 or > 600.
>>     YCbCr 4:2:0 Capability Map Data Block: Empty Capability Map.
>>     YCbCr 4:2:0 Video Data Block: YCbCr 4:2:0-only VIC 95 is also a regular VIC.
>>     Missing VCDB, needed for Set Selectable RGB Quantization to avoid interop issues.
>>   EDID:
>>     CTA-861: The maximum HDMI TMDS clock is 200000 kHz, but one or more video timings go up to 297000 kHz.
>>

[...]

> Acked-by: Maxime Ripard <mripard@kernel.org>
> 
> I've been collecting descriptions of these EDIDs here:
> https://github.com/mripard/redid/tree/main/edid-generator/samples
> 
> If you ever have the chance or the motivation, it would be great to
> submit a sample for this one.

Oh, nice, you have a tool!  Just had a quick look at
https://github.com/mripard/redid/blob/main/redid/README.md - are YCbCr 4:2:0
Video and Capability Map Data blocks not yet supported?

Regardless, I will give it a try and share the sample.

FWIW, I initially used wxedid to generate basic EDIDs, then resorted to manual
hex editing for the more advanced stuff, which was always painful.  Having a
proper tool for that would help a lot.

Thanks,
Cristian
