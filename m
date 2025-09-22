Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9914D19C569
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Sep 2025 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550071; cv=none; b=g8W3uMwi2TSxTkgbw+1CCwkGyYnj6DA3A+WNECZ6mWjTcOFyrNMytRCbnLyEkqU2UOr7GbhXkPpcWmktn26HF1y/IUUsH3k0JCA6pEH0YHYtlPceXBJk7SQ0ZdU8yb2YUHxGCxogpNy3P3PePoxb5ggmkbXS3VzQdrkRlCRsk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550071; c=relaxed/simple;
	bh=2gKCZnS8Y0kw7LI52aPWPye+cd/qPIjBzxQKuWEn6pk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iR7H7otcyGRjv6qJv6HpjIvAheWoXBIEysz/YBkzQUgGNacZecsjX10U1WjLVFhfJt6aFu3DTihscLFXTCUZpg4PtnwTFNSW/NWewbs1N7yhkGCaJ6WzUtB73g0edNnpEEma61gtTlDb4zeZQP2LpRZUhEPxxQJXsSER9lciQiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=13oRaIfE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="13oRaIfE"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so5607322a12.1
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Sep 2025 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758550068; x=1759154868; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gKCZnS8Y0kw7LI52aPWPye+cd/qPIjBzxQKuWEn6pk=;
        b=13oRaIfEW+73jLfqkyekNErZbMJqXdnSYacGoyP2XAv6ZfSQf1RXPcha8atJOZl8As
         46vhi5spf6uugfF2HRkrCGnngBkhpSKwqsOkk5OYk85LfSrz7LbfLsPwhVRYToYTXkqz
         +1ZLJuSe2KBcwjuxVw6YY4LVO98aDuiisfokbLUcSNYz8kMw5HJx39snWC62fR7VVmIP
         7zM85Qj96lClyr/B8O5QVaul7SKe33eNJP5xRF1zUmd3u4ylwb/kRSmRTW86aOz2gvbF
         kXslc/8QQmixEmS3PCXkkdI8irlBHJ+OMliP64r1Viic8ND2F7FfAIGtHgJIMlOJM+3/
         URdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550068; x=1759154868;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2gKCZnS8Y0kw7LI52aPWPye+cd/qPIjBzxQKuWEn6pk=;
        b=WpY0Ffy3S7HMlQ1NsfdRILuj4i6HEzUbZPvi/Ync/s6DZNoOi5+0XDCOCljp3GGVhN
         a/YKs1ewfy5VJmci3tJ/am0leXoMDk0BjI/7BLZsTjVSEsyfmdiEmVMsCOSgX9UoOO6F
         NUhgvtQyS2s+aXF/r4zrDvNkAxbjDH72yTbe4qIDwqBa/+1DO/Mc7WifleqkogdrYTXR
         rGC/ZzLu3mJOnTZa/6LgMWXv6TZ2BS23RyXTuW+zazdDuERZC8Ldr2rCuWE/2KNCarM8
         lcurjJp/BHrDmAgxBUHTlse1GxQfQBmKG/cXqkX5g7/k2JrHifC4QHuhQrZsQ4jCZW2C
         tJWw==
X-Gm-Message-State: AOJu0YxEDnEGQaEBlhh9FLCvRHU7tRlup9LNxcBG7723KAbCoxULy5nH
	mIlHXncKdp6x4f1MPOZqDSM/uglTjUrCbL9zIab0DjFlB79QKotfbCbjF8Fo6UwF2QM=
X-Gm-Gg: ASbGncuqzR227+Me3HCwfxlFUoygL+LCOzAvHl/Lwe8kQ7QtwDP0WcRQ6IsSYm+JDh+
	hUIuHz1AkoAT4fWq6j6hO6T3OBb5MNWHMIoG47/9OB9e27BW8VKZu8KN9kFU5C48iWeKVmAAlc2
	dVF4pAYKqslP0FcP4I07YbLr68RDRLMcbjcYPLV5sEeZSaZj2t1mQrB6ticalLKuK5YX/1xGPED
	bmQKN36Itc7bDT0fWPtlK9jwGl0CG9x708tTXMpnrGZEbBQy+oKVpNC1YV3N1FhKX8w11q5hlHL
	JnznOttf2AyWTzUzx4LKVM0udcnifPyZGpSMecoVv6SMKldmNKIOlzs6a/ROQD/tW4PUpcoZfgg
	Qv9Ooek6tt3XtZV2q/MTlvEjTV3E0NkS9GWQOSmySjd+yEABInw3XU59z8jNLkFRZe7Wa
X-Google-Smtp-Source: AGHT+IG2LQi+1Jve61dJzJPf3p6C4wK2oRc2C6Ic3zD7ZHI0AKL2Y3hhz823ekZ6+r+8VVvfemU3qw==
X-Received: by 2002:a17:907:972a:b0:b04:4046:db6b with SMTP id a640c23a62f3a-b24f567c816mr1300784166b.45.1758550067866;
        Mon, 22 Sep 2025 07:07:47 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b29b80eaec6sm484442766b.87.2025.09.22.07.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 07:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Sep 2025 16:07:47 +0200
Message-Id: <DCZDZ037P56C.3MS3HI55IN41J@fairphone.com>
Cc: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] fbdev/simplefb: Sort headers correctly
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Javier Martinez Canillas" <javierm@redhat.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Hans de Goede" <hdegoede@redhat.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Helge Deller" <deller@gmx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-4-f69b86cd3d7d@fairphone.com>
 <87o6u9d3kg.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87o6u9d3kg.fsf@minerva.mail-host-address-is-not-set>

Hi all,

On Fri Jun 27, 2025 at 9:52 AM CEST, Javier Martinez Canillas wrote:
> Luca Weiss <luca.weiss@fairphone.com> writes:
>
>> Make sure the headers are sorted alphabetically to ensure consistent
>> code.
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

While there's still some open questions surrounding dt-bindings and how
exactly to do that, I think it would be good to pick up the two
"Sort headers correctly" patches so that they already get in. They're
good to have in any case in my opinion.

Regards
Luca
