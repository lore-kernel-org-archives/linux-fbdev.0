Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EBF3DCD84
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844922; cv=pass; b=aOkZVxGsojQB6mTnzsG99cahzYKmC9DAXxBuC2XQBLDw5pH1abnz7l2qJiqQqz5D8hZWkH4blZaup9fv+nU7svWHNO684eDYtW+72DmeUSVpYS8ACrFlR6w60y+Df3hruGeKFABgnw7mELBe3XjxVL3lS+MJLbp/r+BWCjzKqRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844922; c=relaxed/simple;
	bh=RTOE29KKEh2RCMQf09/Yf7/7d6oQT0Su+sy1NG6/ao4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c772cVEzENz2OPGS40/gqpafQLtQdPwgpExx/sTzPtUh10liuJgNRcz61Mmrnf/nnFquLf0XtrGV4G80/jgucwgNA914GtJvRYG1O0XMO6QrcRx1823Bk+OKogIU/x+HtMvRYsU8Sa7zbdJMaG2mlW3UHxal2zn+MArs5clsL7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHhatJNJ; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHhatJNJ"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bd5658b901so380877eec.3
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 07:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773844920; cv=none;
        d=google.com; s=arc-20240605;
        b=JuTniQq5UcHYjHTAZRQYiqmaeg3f0mCDSTk5o1T9bglVB4AaUYEblmg3IXzHl8x7UW
         6jFxwXoYKeVBiFWsR3Mjs/DvV3IW7C3qGc5n+N783JVcSSFumW0WisGx9WkpKNLq6awb
         9k7kZozgFfzz9UPCRe//bxxZ48ai4Q7VMnwna3n7kXAsLxRMpLe6gJeWB0718REDPAfl
         ojtD80K++eTWtpOqHlfK+ehsua5CINsukLFFimBLMJS69e01ZTAYT3VNnQsTNMyz6b3z
         Si8nxHirN7Z1qHnzqMSE1E4GfAokYdWGkcEWIg8ACU71JcRs77VUCuky/8oN8ZXReVEO
         gXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RTOE29KKEh2RCMQf09/Yf7/7d6oQT0Su+sy1NG6/ao4=;
        fh=qOi8qVUBjtAuUic7lPQ1+xPV3faVprfBYksFbku3dyM=;
        b=DlNkmHEphnkUHfVV3f+B+qa5HqwgY5ESoZp09WeYirgcZ9+/eTR4S4sa/TqQtyyWif
         5BS+oUhVLBY5w0hNwoC7Xd+isrC+vErpR6h0cistSgApQNN12GyIRdx4wVht50fJgs2+
         NqiJJLNijzX63dPL4EqO7hbczGaoaMSGPR3u51SNBLFPQe0iMVxjoSYoRLonyoIommsz
         6yhuwVXQ9G+Ml8yHRz0hkM7YZhL8UwiKtVLYwHLtSM2OJ3LxV8bTsETrZPkMhoBwq5fz
         pjTolOGdQER+VIp4xMUALkWrVNcVahV3kLO7XxMzs06ysdl+qau9EPKz0bx7pEuXLVXu
         kqRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773844920; x=1774449720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTOE29KKEh2RCMQf09/Yf7/7d6oQT0Su+sy1NG6/ao4=;
        b=CHhatJNJyvt21ikHjuZPr6+qHwBpJA4tTy0E6e/NlXO4QN/irSUV2UPrRjNdg570P4
         4W4wEsFDisbsvfQ8kUgqLFQKL202dFrUPS218bvfOPzm1IL+YEVD+XuvpaDbzpwEsJ3Q
         DuNUwHjvAr75ST5ptv0+jN/YZqVZ4m9ZT/7jisicTx2ZTQeP+ZmYEucYjHV+DUilrgOg
         j6ZoYOIxYwTAbOfhC4CyHLXGglQmrYdoA0Bwq57Tt+f7dhSzZSGFzUsmrxWi7ZQGx5Jj
         t+uXI+jWUTWy7a15bIOXNCM+0fIhuCvE2UOJfvRQkH0GESU1QFZt69FxpS8e0eUlJROc
         M2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773844920; x=1774449720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RTOE29KKEh2RCMQf09/Yf7/7d6oQT0Su+sy1NG6/ao4=;
        b=kjMqtLBgOGG1FHFqpOB0LOTDs+v0VdJzIEdrzdYlJ9DI7uu0YhGIRPSOxKad/6Uvlo
         odfDJf3Djlqt4lwdVoKaXSBTej9ycXw5BfgQl6XFUm1S5ScOYy+RLmvpL2B6egkkNpqa
         7YpX33eiB+81CLr8SkcsvePsxAizikhykKmpXfHNjpe3p0gSObANCcB84CyePIQtGD0Y
         z1ko+7i6Ijx/+oDpbSFjUcNDdOAVbUm5mS8d5V5pfSeVNyECOViDoHgAN/EDPX1+RTFZ
         cLTI4DkET9aNR5Rzm37egCtjXX4l0D5pucx89wEyV1dN+GVYTSszcUUFwqJad7v5XA4U
         VoWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhOGNwyohiF5nBAk1vn49Zj5D9AfWX8nmhuhbXkuIFchoMvx1fCXvgEjC+BnyNGGkfA1rFOFYI7n1EXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjVCZiK4ohvU4iGzZgTvji1KlJhokM1/g459uJBdWst3oqcTNV
	zHb/0ehcISbBbkmKs6m6Dvq/Z15uJK3sHL2Uvg7LLQDlgUZJHlcRuANJCbS57YJ1ZRo7zWNgR5w
	GnvfJZJV5Y5HEzG0hpOmBnVEWdx+M6j8=
X-Gm-Gg: ATEYQzzRojWPir0VxoU0ZNX10q8o4brn9ZZveeoxT4aIJttQ1LhhBxJ1dhKT/NDjJ93
	DTdo1zxf/QsEtcyx7NB2rpKKrL0GlCJ4hgvkyjtvCTle+/ZzfVsIgBih+CyYdBVsla8qreNFN9a
	jYogA2sgv8iW/8hUtpQwyjG90BMcM5x0cpuxrmkXy2RHXrz5VCJujaaFvZQeJuxautklVJYBUxB
	zmZVghJAUdjsIdJGu1r497UZ0NrTOALDpAExP3xIWTPuTf2i0wLuebznIgCxZ4/9VfpmNuk7pxN
	HXcC3C4t/zZ3eetx9LNQoHt8tFFDB90TAiaLnIJA0jUvOjGD27Vl3tYKPE2DdnbOc9jAYwizWv+
	ZJQ2c13nqYqk6mEJTIO4yEJs=
X-Received: by 2002:a05:7300:3724:b0:2be:1f56:ed32 with SMTP id
 5a478bee46e88-2c0e4f79e7amr877942eec.1.1773844919477; Wed, 18 Mar 2026
 07:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com> <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
 <CANiq72=bmJ_GWKowAgv+DWQ8FcWK_HePwjaVgeDmRH+gVD-z5g@mail.gmail.com> <CAH5fLgg-kgeBw3Py-EZmAEJhm357u5NJP6na4qJe8v3aeFW5Cg@mail.gmail.com>
In-Reply-To: <CAH5fLgg-kgeBw3Py-EZmAEJhm357u5NJP6na4qJe8v3aeFW5Cg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 15:41:44 +0100
X-Gm-Features: AaiRm52glbQ5k03i38HLvFJrknMe1XNNnKvvWBogM8moiNwsNZDgYGGN20TDKPc
Message-ID: <CANiq72nad-60tOJeAfkvHTFrWXQS_wbG4JUGQNnkjm_NvhhaYw@mail.gmail.com>
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

On Wed, Mar 18, 2026 at 3:31=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> In principle this is possible using
>
> #[path =3D "pci/pci.rs"]
> pub mod pci;

No, I meant supported natively, i.e. without having to write an extra
file everywhere (which could perhaps be simpler as just a symlink
instead).

We could also generate the `mod.rs` on the fly, but that means a clean
tree isn't great for tooling etc.

Cheers,
Miguel
