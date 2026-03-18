Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E733D75DB
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844247; cv=pass; b=I5ncswPW7YvTrkkhzsY+e6D3d3l4dqaELg4ZAHsSNY7D5/eiCCkVFLLpwEeuK3z1AigRNsflXlPC+ethzSz4UD5qaB9N8LuUOBtx0XdQiODtF1yisO9mVToYW2qAo26+dJX8lZDgsjz4tPqSA4KNb908D7A1of5PSOoLg0hkTLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844247; c=relaxed/simple;
	bh=Lz2XCxRPQhc2ZncmeIQiQRFj2Y2HhTtKvhZaZiMtVkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/C4+/vkHZM0/a/ivI3VUUGjRDRsdav/siTWWV90a/Qya4XLLyz8fmAKplG55O8CFmSsvgwS836oZaZ05aojW1PakKl+HjQz5OQnt1BL2Cmy0VM66IebdERW5an303CSfvyv2V5fVdVJ8hR0L8hlPO4iGPKvtaAWRbMjNn0uXQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI7t/II6; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI7t/II6"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-128d428ba0cso453440c88.1
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 07:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773844246; cv=none;
        d=google.com; s=arc-20240605;
        b=DCL9tlFL095rE6GjU6PSjN4Ynb1r+MQxOHx5aSFrJu6VnniIcmDsv1Bg37+znTS4OD
         M8TqJBoj7y7qpY2OwDiUBXP+494G0frFJTr8J/YzNSBmlftjrGgaW7vPD5DyQB2q43XT
         nk6XVgEXxg+8FRpzcvxC919+PHuzDyInnGf0Ynkufc+tG5cxBHH4CE3FnNuxxlLu/5s3
         UevA4I+Ty2N8Dg38MibOoczJhXy+MoTdn83g845F1b8dhamXqX3N9qYzWRZC81EzxJZi
         ydIQ92zSmeeHGAZioZUwdH/mVOk92TspE0o/vruNXW85928TSGPUaXDxLCARxAM/rciY
         HqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lz2XCxRPQhc2ZncmeIQiQRFj2Y2HhTtKvhZaZiMtVkM=;
        fh=roTtCEoP1Xae/OGUlciI3hzqsM4+gnlt8lVBi+llyzY=;
        b=FBZHDgkUZmZHCZwpYWsBsUOUR+Vjx9zfI/Kz0cG4cE52f+EwUzQOyzosw79YJZ80zz
         bTVrjMLfEU0wFDbdwReqP2JdmQ2mHLG2c5EShbJYzbGo8DnZAHwO8XwNXWCCoYEoTJDn
         Rkea6xc9jTAXXeP+1Cyip1pWTjYoP1lyrbhuHUrxtAVTfyCQ0ZJlHoje/0j/VjzIYaeH
         ODvHTI+jxd1HtdWrDlRmJxvapHLtgjtYD46iw/IDtkma/PV5A7fLFG3JTBAPGw2ChVDE
         94V7TR8b+9SXliIr/M7yGpt27PFL7YchGlhEEdWMjB1S3gklM+o7R2Qio8EDvszVN5pN
         of4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773844246; x=1774449046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lz2XCxRPQhc2ZncmeIQiQRFj2Y2HhTtKvhZaZiMtVkM=;
        b=EI7t/II6A6g9XQSBrVFfwSxtA0WCIPfioPEctcfeXnVUICQsj03WPLKVZiy0dbqlgY
         2OTiFma1eZBJ46+8rf9r5YgCNRuNqyhD0YtMvjRvhi/L7O3j6ZfERAYQRWdbbrC/eaxD
         lkT3OZj1m9yARQknpQxgOFRLtpgcDOTTD91dkKBDJx/Uoi2ZhBRokgBcEosMr9Pu9aMR
         7Mrp0BGqqfmb14zXkvHQnzxx/z3J0JiIsPZLjcWbzFAjXU/cy0wguusg4FUntJrWMMkg
         uFwUXFkDiP8+462pm4XuH5E+vaLhhh6qv84pG3Bf3VRk/gk0kHg88CcXhcP5vwXukRq7
         c5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773844246; x=1774449046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lz2XCxRPQhc2ZncmeIQiQRFj2Y2HhTtKvhZaZiMtVkM=;
        b=Zo+pkKRthQaVM4KKqkPCtRTzh8vygAoAmUXrsrJSEBZQB3s5oGyf730olXtKIzdH/u
         4INi2j4CS944q3zU9Ah8bvkDQFvMj7a3WUeKC8M0HVJecBYwRtyTNNkSbFH6tSs+kbhp
         Sc4DWoKMzh/fVewRyLIagwF5eLfvHCOq5xbtQnyuPJwZ0sIsb9RWEADcagXXBT7f6ZeZ
         AfAfUnzXhz7B06xedba8Dca7ZmU2GWySZTjTNkBog3oT1jiVoXcasN0ySbJIiGau67xo
         ZAAV2QFH4w8QbMgMyCRqWoqp2NNp5cWfHtE+uvFRnN1ahaV5jCyTmDs5VHKeGhqOn8md
         kPAA==
X-Forwarded-Encrypted: i=1; AJvYcCVlVjDlK56nPjoXmVMj8yj7Vpxw7jnP86QOFw1in2t/6BWjGRI/PegXaiA0e0X8VsO+zTfVVegWfA/Khw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0WzoLo/2R3ango50Q9sAWVteuiCjWW92O8Cv1MnsnKHk4FZvK
	gxAO1zL8dGiioLCdDNSUFCPApKEMewCo8nmlrJzmOiiXC2nd3gVJCjhmQIUUrDDwtDFpWGr/7aY
	YgwHqS9shCJ8kzn+06/ge+M6NCh/k85k=
X-Gm-Gg: ATEYQzw+xdzOBm3JYJEXvyTUXaAazfxwsX++sjATjvPlo+Hy353UV3cqdJdoPqAGGwu
	9JMbWwtu57wKyZm6oACrY72bhOxR5CRlACRyjMdKTrf3e8MaFabsqToifz9Yz7hc0aOhQ/F4m4u
	WoQ9Ud3WGGcuEB5FV1Gy6U3eEl5BUBfLYWsN+TfHO6jGwJDHJnUc1wrFtXX1Fb0rJpQ9awEsq5X
	jhSzRqOD6NBxvkM5fryvjYzQoaTALRSnDb9DGVIU4ZcvsOMgBgMQzHzcl62wT/o5gdpIdQRs4Xt
	2bE1jmM0k80Nr1NTTxjg3j0009rWSzv1kEi/fSdugwqrmWWjmxcAnbP2YSXg46AqOOEbLWu5kKT
	YUvK6S5Gq
X-Received: by 2002:a05:7301:1e96:b0:2bd:fa8f:77f4 with SMTP id
 5a478bee46e88-2c0e518610dmr846274eec.4.1773844245396; Wed, 18 Mar 2026
 07:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com> <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com> <CAH5fLgjUMaC5v3SERZLosdD1ajU-fvKSgNq6OgbBBcoTS21-Sg@mail.gmail.com>
In-Reply-To: <CAH5fLgjUMaC5v3SERZLosdD1ajU-fvKSgNq6OgbBBcoTS21-Sg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 15:30:32 +0100
X-Gm-Features: AaiRm50bVmwgAQrBl1Sd2LWxaRmG-ZY7uRxgxq5LrbNAlb0we3rijRktUCTLM4o
Message-ID: <CANiq72=GGicUCODkY3C8U53wQfsuRYeu9GiwrM5eFhkP99kiHw@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list interface
To: Alice Ryhl <aliceryhl@google.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Koen Koning <koen.koning@linux.intel.com>, 
	Nikola Djukic <ndjukic@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Helge Deller <deller@gmx.de>, John Hubbard <jhubbard@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>, 
	Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
	Balbir Singh <balbirs@nvidia.com>, alexeyi@nvidia.com, 
	Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 11:59=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> I'm not sure we have discussed it in detail yet. Both are used in-tree.

Yeah, we have discussed this several times in the list and in meetings
-- please see by other reply.

The handful existing ones I think were all created by Lina (so perhaps
some were kept as-is to avoid extra modifications of the patch -- not
sure) or by you (so those don't count ;)

Cheers,
Miguel
