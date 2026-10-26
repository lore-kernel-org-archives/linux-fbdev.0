Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792996320;
	b=JMLl+ZhDNJRd9uaQO33fZoYaxIr++/LyHYqS9ROQiok79btmRYPjTPKOu5Va6CB0jrKO
	 EHpAzVRkCNTKy7kf755G1m0ZY03h8aLZpbBfA4egYmpCBq40cb3vRMEzWg0GaDgDnUDBK
	 jIJ06IvzlRy3pCZbYjE0/nPMhJc93f58O0Gi0tX+eQieWfkl5h6BQOiWF3lJQ/NH21cTe
	 Ej1r6m7UAcSo5YtgEnKngME5W0TkGlgtXAYn3T2tjxnuxWyZUHyrw9vplrkSACSTB7B38
	 5nAxBKPKwbIZhbLQnEl5lxy88n/7398BkFGGxhDKxCUK8vJkL413uG08drORFVSNf5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792996320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GqcxNtiAZfNQOpaRDoKT3/3Dst2nVYU7A0CmkDZXaHQ=;
	b=cdIEEVDkxfQCOSGipCU7r9jyvyWPd0VwgfQoHXFFRokjycZcl+h5NXNCzZFh2Nwj2lUc
	 vakR7TXet8vIvOFhJLo3zYh84MhrhdqZfRwJqzc06xfnRPT6gxSNjcuCnncS7HPK1fW+b
	 OIv/A0MCIjIJ1ZfBBCd+HDpWwqzGlkEd2361FbyoDZL2xOmDZIpJeZ1rFpAl3jgx27HW0
	 kzaxPeti0dslub640MBJWCCr+86l7stN8GTxrJsMEvYdi5q0QBKSfia1GS7EQZKtYYjpx
	 pC1slstBT+4BBlpkn9dR4k3/CmIMXL5PLV1bqakr68E7DNAOtE7EfM+Kx7AwWvcS4jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M6hSArX6;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62665606A31A
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 06:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62665606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M6hSArX6
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so5361835e9.2
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792996319; x=1793601119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GqcxNtiAZfNQOpaRDoKT3/3Dst2nVYU7A0CmkDZXaHQ=;
        b=M6hSArX6JTjMluSmjYq/GJ9BD/s2nFPth0bRk6RiRLDEulLnGhekr3ymAjJj4S4Eg+
         1fIChaBCXkBKX/HIsDnMjJVeWIJouPP8kZqF/WtRHZ+aDk/Iu6rsAqKs9w1T7EPmf48e
         q22bq9/rbFr6UIR67MtYv2oad5mmlv8NF2kyrgEoLMFLJfCcImAhrkRLPStxXsjCoqv2
         aA8RDdpB+qkRR9rQcPT6cE39SamMygPkRCA0oS5bapvyXwgK0Hl5WH3M1brU4wCiIhyj
         sUdWThdie/Cwm80dTJQn1jh9ESiKc8DVyAImvnTmDCjFUW8ICV4KS8KPK/FxIGRxW+KQ
         PsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792996319; x=1793601119;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GqcxNtiAZfNQOpaRDoKT3/3Dst2nVYU7A0CmkDZXaHQ=;
        b=1pqZp2sWQXx7cOxdfJ0pMGAYGehju4Ivx5pXhWMG9G4uMLDzysKgPYVoRefiMYhuXB
         IC4DDdu0lacJP6FNKQVnO5mvdSjVVyKbZKRq049ZGPgtwjAVyerBBLONrQl1LwMF6QP0
         vv2vkQaCXu81pd+zImSeY2QlezSs7SUTsVfimEA9YfJYBS57zdXviAjSastcMOgnDl+W
         qEKbtUAdo8EzOnfaZlrL8Gf4qpjE0dde7Xz14KShCUrAQCELKzkGdBV9Lj+hlJpuvMNx
         QMK7JkdYHTXt5AiU7N0ccBeSL9azukxd8Xl6M/oHUoYTWnAWMvSfpJ+OEoXKz9Hm+nTY
         Vjpg==
X-Forwarded-Encrypted: i=1; AKwUvBzKkkiOiT70JrYZufslPObeofMUXckE7ERMNxv+ybQ+19ADWTq8vy/VEzu+kr9A1WrHo2yljBZdHS9s5g==@vger.kernel.org
X-Gm-Message-State: AFq9FYIxrfFlBsjpBCrtcA4xnDAqfzc5BFXGmx8LClhbnmdPPUnKWXu9
	FjQYoWOI5gJclOK2b3vc4/Bk+nHI0MPMVNoAG7CdY/gjMV04V9V7kV0U
X-Gm-Gg: AYBFou2Vq47pIGwCyH7m7lUFwup6MJ4IoB0lpSKQSL6HumZlBAoBl3b+I850SvUsZJd
	UV3heV9SeAW1N+O9AbM3AZIrF0jlyhNiFlfbFEHiGTCoqlkz6WbYrCgDhByH9D8gzrMdVwQ0zwx
	HzcIbaV/eUZY83RqECzz6/1nTXOwhQ4fQxHh+wXPNeQjF61iGIGNnBAd9GhiQ0joTbkEPpm/rgu
	r7X2DRwERszK+Q5tF3bycNkWPEANy98cZWQ+lyxk+EDoZvs4RDpFBlp5tud68J3riUb9j3Et+l/
	sT7hrnsBzEjI6dcg67el13V9BJRodfZJCq8sq9uQtBDVwgywLc1niOy+PU5KFh50G5mfHiCCuZp
	B18G+gboqN4NGqKyMxuK225Asv+jJiLZDDE38LzF7+RVCtzlqb7u5jY2oRGBJy7htDN2W0lUcu4
	NntJj1t3IkDwFbmb6TRBEbhM9TUOZsn8uTIMVI9OvZd44p3LWfofzpmyrNPOhc1EwNR1p+bjF8X
	gXlugrcdEhs2YpmhXAva4HiLK2Ek58OcS+QeQEnhyoO6MsXHPmvOA==
X-Received: by 2002:a05:600c:474a:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4a35acb9afamr106677375e9.33.1792996318690;
        Sun, 25 Oct 2026 23:31:58 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a58a293sm170484255e9.12.2026.10.25.23.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:31:58 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:31:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: Fix line length warning
Message-ID: <at7z2oubp02WQb1h@stanley.mountain>
References: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
 <at7pu4hldDTgZtXy@stanley.mountain>
 <CAGLmz9JaXM8s4BHQ2Cn5QQdBZpzDXmHyb-GQ_jXtj4Rz6SJOJQ@mail.gmail.com>
 <at7s7We7bxdmmmSM@stanley.mountain>
 <CAGLmz9+R5Wsd3i+7kLZXL-KP2bqdEmNUJTSKtZph_NSP92Jung@mail.gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGLmz9+R5Wsd3i+7kLZXL-KP2bqdEmNUJTSKtZph_NSP92Jung@mail.gmail.com>

On Mon, Oct 26, 2026 at 11:46:48AM +0530, Himanshu Bakshi wrote:
> Hi Dan and Andy,
> 
> I have not found any call site for fbtft_init_dbg and just assumed
> that it might be useful later on as the driver develops. If you are
> considering removal of the macro, please let me know, I can send
> over a separate removal patch of the same.

Yes.  Please do.

(also no top posting)

regards,
dan carpenter

