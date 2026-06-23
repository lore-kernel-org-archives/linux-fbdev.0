Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC0C8EB
	for <linux-fbdev@vger.kernel.org>; Tue, 23 Jun 2026 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782250518; cv=none; b=ftry0CBE1SuHCxvFExbT9B8qaNVBU/teUGwz22RWQKHJvhsfFM9U14xPnr2/eN8XlK4YJd9SVx2QN5mBhypn4W4jiaLSfS1f8CoynEVQEUnv6MLsg2KJdE4bi6RWatvG41XdaTX1kBHkCEBgHKbPeb6T2HXYIJ5CQW/eV9u7WZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782250518; c=relaxed/simple;
	bh=aUOlwUMmvUxeWUajWHyxa6VY5afRmReJOBvfaFefO1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvcePm8xjUXQlAGbq6VGIRkxu3HlH/nDFC8zS/ZCwbsAUJmWSfpBsj1Lz9yJV3PvazYcbCIVTOUNnl0zrwBVznLmc6PURzSh6x5cjcouqw8LncLQnJZZLgmwX4oCbI4j2X1dqUYxVhHtr/0do4lcca7lmUl9oREODDcsWNRGHBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxXQe4kh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxXQe4kh"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-464192ab2e1so267143f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Jun 2026 14:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782250515; x=1782855315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npX1zE3oC8B9i4AqwB/UnRyXW+2tBx9spPlY9cjsius=;
        b=kxXQe4khNHhsZuZYLfHoNMuyD8he9Pm5qCSWmoJ37d2BOJ32e71EOoxMNQuH47+LDC
         P4lRRdy3QI4G1GaR4tAB0D0nDqjEjbibO1byHCiVUKUeHTnESuoWwQMdjd5/TGfq90qn
         0AV85RuUi2n1S6BxmjzeKuFkaiXnOOBzos5QGY5NDhTxzQmC5pS943OvZCliAnbExjlF
         2fru3vIAsOIMKXeE1luxuISphiWOerwU0mkhZ+7e2Drcbow7eEN/I9BIxk5I7cunfBex
         lfDvESZ0ZX1NfPozqDPQLIfrkzK1pjPdE1rXiIVP74K4XKyAk6oyMBYUEdsmuwG3x4FV
         geOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782250515; x=1782855315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=npX1zE3oC8B9i4AqwB/UnRyXW+2tBx9spPlY9cjsius=;
        b=p3tm5h+NjOsvHFjxcyWesUiYvWrTe0aa85fZZ2ydyB96+8eTsj8wlYBELJAoDGm2ph
         gP6gFBUUDOYUAZ18IfwBgSK6u1Fy+YFQV5H2AJiNKWV9fE+cY2RDzLf+ZcWxazZilmUI
         0d2aRTQ00B37gI1S9toetXeXDovBNRnBTVzvuxjIhNYm7yFm1973na4iV2Ce7dfzYeHz
         yLN+omamwqcAeLHZyB4LNQ/gEdeh/LbF2NPJ4WK1s+yukzPidXrJehfepQz527Ucjeoq
         IuYOG7YFuV+hdDlIXSbvgrJzfKgIgy4ueF6S609NW6xXDfoLoZlfhOCTTCz/CfabL1kY
         qG9w==
X-Forwarded-Encrypted: i=1; AFNElJ8ANQKAkDE4g5ymwicfo2ZzYfZ8+MptBDii5mro9YQbsCGlRkT+88AUcNohRKiAPIXt9enCalvEsGMmLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFQEqaRbZ1ZknULzTWU5NWC3bEjSkVgFR8DYfy9y+sMomuQbU
	lLhSUhsHWjOBGJdOP2H8KBLk/u0Hme/pC3n0tpkCPzmUT7KyZxCxSV0Z
X-Gm-Gg: AfdE7cl2yWzjX0mPYHAyXLLdMHoaS2F5kFj1g5r67i4x/7ApVrW4BS5tJ7g/DlIjVRl
	qdUnFb942eycKKIn2DPXCyAddcY6q05U9imn//NzVDXwZkpSYSQAR1vyzlm4ndM1y5C6vLmBtzK
	SB6ZuzMNu8cEx1gn+AQo75UYo1HQii4WtGmGvIgRRDd5zUdeE3zXJ3CFIo8GATB6116KvEf/+nz
	rwJcFAUR9VUUyuIAeVxG75C0Td2TMtp5ezdCAjnJegSHFFstY0YV+V5ffaeJjINbismtMWV849K
	uYO9uat8aZoXR4LfFd5vWqMsx+BO7+ju8aUh03shr6sBlmrfI9Csb+fGLjPPelT9e5rpMJE68AQ
	CndgxfMWlzURanaJcOyQzvWGsMN6pkpJBXDpXa4T4V0MHMTQcJwiAZgq+euI5/gzlKzEa/M4s8I
	zmMJx8o37ionhlQk0c1obexKLs+3LzYD4MNm2AoQ==
X-Received: by 2002:a05:600d:10b:b0:490:b642:ce31 with SMTP id 5b1f17b1804b1-49260840c5amr3352535e9.2.1782250514831;
        Tue, 23 Jun 2026 14:35:14 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d93d8sm1059435f8f.23.2026.06.23.14.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 14:35:13 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: markus.elfring@web.de
Cc: airlied@gmail.com,
	amit.barzilai22@gmail.com,
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
Subject: Re: [PATCH v2 3/4] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
Date: Wed, 24 Jun 2026 00:34:47 +0300
Message-ID: <20260623213447.30196-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <16a86f3d-caf0-46d0-97a4-c9585bdaa06c@web.de>
References: <16a86f3d-caf0-46d0-97a4-c9585bdaa06c@web.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Markus Elfring <Markus.Elfring@web.de> writes:

>> +++ b/drivers/gpu/drm/solomon/ssd130x.c
>> @@ -146,6 +146,33 @@
>>  #define SSD133X_COLOR_DEPTH_256			0x0
>>  #define SSD133X_COLOR_DEPTH_65K			0x1
>>  
>> +/* ssd135x commands */
>> +#define SSD135X_SET_COL_RANGE			0x15
>> +#define SSD135X_WRITE_RAM			0x5c
>> +#define SSD135X_SET_ROW_RANGE			0x75
> [...]
>
> How do you think about to use an enumeration for such data?
> https://en.wikipedia.org/wiki/Enumerated_type#C_and_syntactically_similar_languages

Thank you for the suggestion.

I used #define to stay consistent with the rest of ssd130x.c, where the
command constants for the other families are all defined the same way.
In my opinion an enum could be a readable solution for these values, but I
don't think the switch should be included in this series.

-- 
Thanks,

Amit

