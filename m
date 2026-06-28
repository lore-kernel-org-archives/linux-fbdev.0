Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9091E2858
	for <linux-fbdev@vger.kernel.org>; Sun, 28 Jun 2026 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664232; cv=none; b=ce7TEajt3Owt9HQQO1L4XhcRpIXeCF0xn/JS6ir+f1yHihCKGJH0tPa1OJkc03z9tF9O9AWqL0UolvXkSUvDUS5HXihrGbjxQdN/Vw0CAEKF1CvWQGcKWI/1pSZS/WsnirxFGUrz8toqfyKQ/H6nkCn1+f12euVk7MFZ+2NIRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664232; c=relaxed/simple;
	bh=AwLmTjHbrcU+SOVQa01R8c+bODe7xXJZIanI/IfDJtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZukFiqSB9AC44kuP9ubfs5jcJvfh5+Tcaji+6WuobKpHUPk1oPITZQacoAj68ORQAWs29sbUH9yhPMmMY5/svWbA56M4aYnVSzzHAzcwGZUtEPh+SlZ4SS/RJK9qFRAwAKQnCBswh87J3/N9X/ngIh02e9Waxi630qlJl1AUK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qAslV0OY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAslV0OY"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4926ee9e8d9so10156855e9.0
        for <linux-fbdev@vger.kernel.org>; Sun, 28 Jun 2026 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782664229; x=1783269029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMnBtmnHmhK3jg0PxdbXqkHYJjM0gMd6xqD4YPFeDWU=;
        b=qAslV0OY1RR3QE+/3XPt75MHqz4pqPi8eBz4uS1tY1L/9Azg8W3mQpmKYOskpIYkgm
         2JYcfhArOkkD5+wB3fQ5wMGajEVb6lUjMkpD1UN1x4wh7dd88SCj0NkUB8e7Zf8AXp2M
         Jqv9gQtG9nDLNzKFOpTDS/BS1Y0THgyk45zNdkHWe75AVt3dlt43m1D7qjFfB3wpuji1
         YPXwuxeKHsEf5e3byYQiNS9psCJOwWLF7rrqVL+GGig1D0ElNSeA/yaDApTxCy222Zxg
         I+Ls3E/3QyFJsD8fIPAFBdiNgPqttJThO/Z/V9Lb4Rz63xDjR0qgZNQLeOKKKsVEG3/1
         +ENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782664229; x=1783269029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fMnBtmnHmhK3jg0PxdbXqkHYJjM0gMd6xqD4YPFeDWU=;
        b=NRJf6Mo7NGN9RVZOO5T84Y6zFLZOkhFxI6XPKJZVYx1a9nx+XvPDYYUUjlm1GLQdzN
         MuPFcohrbO9ebDdttCfPUbDjovNSNl3kidYMELneCgkbilzMhIhUQLfmiZbFzm81tydz
         DUeKKFOLKylM5z68PYpbP2m740MxuiCuAkhSVx/OtrQeICuKSZ7aizOEcWWaOaFxeYyB
         095lOOuI9/WeX1hV+E1DA1SrLkwjHnYNsn1FjX3rwGLPis6X+BFeGpfitqITgG/Y0OYD
         t1GUfn6ZUspRFNxJsYOTOC+uc9kkgedWUzWm09Hdd6Yx0IrnpAssNWTmZscbzzK/8IB6
         cXWg==
X-Forwarded-Encrypted: i=1; AFNElJ+nR2WEQe0d666jgd8EdyLA5JfmvzIQiRgs56IJZBZH804wK6ggU9wLuK6/nKUiGazvggO+eEBcFVmezQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9v8AbzQYIn8znPqlzBvzl2nQRT/qShqrK+1r9lqLVxnVtMk1V
	oz2L6cRn1yddvyjvA+AV6eyp0zCJ170yEr5VXH5Qpj8Qd+FsXqZqpxDT
X-Gm-Gg: AfdE7cnq3/ei96j92G/uRTkwvZI/EM50Za85kxvVH+JxvQiZ5+lZBJ6j26RnSPHzAIp
	BPBIULuzP6f2MtVs8PG1oN2pw9nKve74kHH8x+sZun6QKgl1gELQYA6RxZtC9J4k7OjE57p92Ms
	YE8iIntGTo9h/2vrSTADHHqWa1R0CWrf33zFNbaLGX+5X8jay+L5Xv0u/NKaF8i++pyCheos2j5
	IZLzLSwLmGno8GERrsIAU0+qXnvQFK3q+pr6ctOI89WuSxstDoRAkwREb7U/L1pvAL7+oLd5b39
	3Jjnsdxww0QfCOe7QqGB75WofULizdTxtrnhmkEIhiZ0aCtSqq9nPfED+eIfUC9WMoj5c1jYI/u
	7m9KlvTDpcSPFueEJPdgarCqfGM2W2zcQFEg+Dxyq7s9H9QaEkmua7C4Euh/aaagbUSirCrHVq0
	UqIOeN3vm+Vo1vDIIK6vSkIsq2qo4=
X-Received: by 2002:a05:600c:e54a:20b0:492:3fb5:3a17 with SMTP id 5b1f17b1804b1-492663f5bc7mr127559565e9.2.1782664228533;
        Sun, 28 Jun 2026 09:30:28 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fde98csm261474625e9.6.2026.06.28.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:30:26 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: andriy.shevchenko@intel.com
Cc: airlied@gmail.com,
	andy@kernel.org,
	azuddinadam@gmail.com,
	chintanlike@gmail.com,
	conor+dt@kernel.org,
	deller@gmx.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	gregkh@linuxfoundation.org,
	javierm@redhat.com,
	krzk+dt@kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	robh@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de
Subject: Re: [PATCH v2 2/4] drm/ssd130x: Add RGB565 support to SSD133X family
Date: Sun, 28 Jun 2026 19:30:02 +0300
Message-ID: <20260628163002.56829-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <ajpLyronl7a-yxh-@ashevche-desk.local>
References: <ajpLyronl7a-yxh-@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.

On Tue, 23 Jun 2026 12:03:06 +0300, Andy Shevchenko wrote:
>> + * Each Segment holds one pixel and each Common output has a row
>> + * of pixels. A pixel is 8 bits (one byte) in the 256 color
>> + * (RGB332) format or 16 bits (two bytes) in the 65k color
>> + * (RGB565) format. When using the (default) horizontal address
>> + * increment mode, the pixel data is sent Segment by Segment
>> + * (e.g: SEG0 first).
>>   *
>>   * When using the 256 color depth format, each pixel contains 3
>>   * sub-pixels for color A, B and C. These have 3 bit, 3 bit and
>>   * 2 bits respectively.
>
> Something wrong with the plural. There is a difference between "3-bit" and
> "3 bits", but "3 bit" is odd.

You're right. This is pre-existing context, but since I'm reworking the block
I'll fix it. In v3 it will read:

	 * These have 3, 3 and 2 bits respectively.

>> + *
>> + * When using the 65k color depth format, each pixel contains 3
>> + * sub-pixels for color A, B and C. These have 5 bit, 6 bit and
>> + * 5 bits respectively.
>
> Same mistake is repeated here.

Fixing it the same way in v3:

	 * These have 5, 6 and 5 bits respectively.

>> +/*
>> + * Per-variant output format selector for the SSD133X data path. The
>> + * hardware can drive the panel in RGB332 (1 byte/pixel) or RGB565
>> + * (2 bytes/pixel); this is a policy choice per variant, not a
>
> In other comments it was spelled fully, be consistent "1 byte per pixel",
> "2 bytes per pixel".

Good catch. Rather than spell it out, I'll switch to "bpp" (bits per pixel),
which is more concise and matches the wording already used in the commit
message. For consistency I'll update both this comment and the
ssd133x_format_info() one in ssd130x.c. In v3:

	 * hardware can drive the panel in RGB332 (8bpp) or RGB565 (16bpp);
	 * this is a policy choice per variant, not a



--
Thanks,
Amit
