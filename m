Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A7E3DA5CE
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842640; cv=pass; b=iITm3c+B/vAXMtkGS34CVX4FCwrfLVxnJ7QZInvFf3u/iYaibCgNwDIRgCEX6J5ytT1giv4vct3IhjnzzLDnd/AtCn3OJ9uptj3cRqnnHhkwjMMmNP6wgYSGiN98TX9C1fAAI7+fQHtrHVOnr0v8+7hqHazozum3FSplwhuLjuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842640; c=relaxed/simple;
	bh=k/U8OvDUcJJhqeuFuNoQEHJ2yWsVYBLtuE+GiuKyXfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8u/JzdFHbefivWeO9cx35oVpxmlfLBUIz7TK4qZSoEkb4h4Ss9DJFJZ5w/DYkw7ebm1K9Sl2yPNToBejG24oevODeuWg/ejHpeLHbCPLL7BMv8NqCI1qX+gT19lzfPmZ7KNPKgQ3aw4FC5hbsAVLgNpNLMLHkMCrAXOOBLdnj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqQg1d1y; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqQg1d1y"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c0e532a408so18511eec.2
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 07:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773842639; cv=none;
        d=google.com; s=arc-20240605;
        b=YQ/AieAJDjDThxegfsZS9Ik4KgFRF9Xj81x1SJ91YU32dJINr4c+nneN/mT3RNz9nG
         CoP9MxGNaBsGG97XxOobldA1vGIcz1orVHHzjwTfg3n4EYxZDGFmsS0gqBrHSfIK+8UC
         Y1PJCgePIDvh7x55rU/dOOXSQjzcDgehAVh7Eza1hicdvAR1MPOEiAmrpqviaOMHBBiL
         bCf7uH6qaA6K3oKF6tbo5LVzGrmy0/rapF3szefW1w/z6sHxDEDdlKRsejwTB+NA4jLW
         suF0My/qhXS6btymb3KIDFFlYNPdHR04OI6nL+gFqiBANHK68xhDPT9Y7k+z82W9OlFH
         sy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k/U8OvDUcJJhqeuFuNoQEHJ2yWsVYBLtuE+GiuKyXfU=;
        fh=YHDumVAEhAgxeaSssPN9k3zacNAGrgazZzVwuf7lxmY=;
        b=B9xXM6gki1paM+XZIa6e9oBCHPuCMrpWLqs2DJU32kcPVEfMc1cJrz57FxkqmB76/5
         okLftxkEmCU2J5MuLWEvpKTT5dywkEA/GDQtVp+ApBLwB8KV6/S+U4KCo7WWSXNC/q4T
         fkk2RV4tVp43W/MVu9aVE5q7iNvt9fC/ATUSgcknm0GP7nCdBYSJDBwdxN4I0X1JtDrX
         ZJN6U01NZEyOGdPxomaoEtuOSiZwRjM603ww5NzqGOEGKoMAbVV0oGDaGfKKotO+bsiv
         8CI0dRjnjFKi5LLJYFoAAplOB/dsHpfvB8kUm/GoRZy7lB909LfbK9ZmosXjcTMCj/Xv
         IzJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773842639; x=1774447439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/U8OvDUcJJhqeuFuNoQEHJ2yWsVYBLtuE+GiuKyXfU=;
        b=mqQg1d1yHfCOS9q/wWHZZSnCggj6Lxz4m8Gu59eZHOtuH2zHauxuNYB+d2IG5/V4th
         TvYFpwJeU3+FS6w4JH6IIyxOPGwusKvRyCrKViUtzMFdcM70JnPxbXbOLkXQAync8Ix0
         jkEuOL/v5ohTVWOcVs4FbKQHMSkqnVqWxsRKNMnQu1U0ggTboAgBTBYFXG4kEtrCUQRp
         FgI2+07l+Ft25pknsMAPyO3AJHWOa5n9fRI4rBRaP5Iw6cUUZWpLLMxm5UB+Y3Yj+s7S
         THruLwCH/DYEIUmb1sWXz6u8uS8YUfXHH46caXqHvnRs3uji1XI9n8+aa38fZsWvi3pQ
         gzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773842639; x=1774447439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k/U8OvDUcJJhqeuFuNoQEHJ2yWsVYBLtuE+GiuKyXfU=;
        b=YHDxHIAHD0Ox8EEGewvMLYGPvc7GZ/kw1lWFlEAOR9vSZf+ooaseSWIGRyUxqbXgvC
         RPuKChxN0+elR6i6WNUzvitp0ilVIf2eoq9OmhMXubzieHqyVbBk2YTN+Wb5AEyfdhTr
         na+9of1liAnwXSNZ41DuZIzo3J+1/X2WzAWCiRLju2zw00Vr6YGPuP/qcOHh3ONLzPoy
         hzj02/jGQOsjZEAKtzyEifbNwo3gyftI8fPdNBpelcAfOd7Bp+W0MuKHCete2YhHUECX
         n4TvEacgHrCjl4NF6ljcCFBWRMKFImIG6sK227q2qyvpQnqDt5118lFvoj/JdZfGsu6E
         hTLA==
X-Forwarded-Encrypted: i=1; AJvYcCU/JPyQaCTlHVzo8+xymgptXpLy0tUiSUv7R4LwJTTgBmgGQL3KzSacql01H7Ablz1gmBt1t81Jkck+fg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4H8ULEPT17UQ/3HnsUcDBM/XQ2zcvORWyr8H8h+m82pQcyqBi
	xEm8w07ligzCjGQYono9DSBW6EK9/qVFFgvsyUsLmzz4LxWIi/kNS4bjviUZN7zSastYd1Fb5yl
	+ZHM/SC4mbbH19UCY8LA9Bn6PlwLq0wc=
X-Gm-Gg: ATEYQzyoCddp8IKo/nvIs+Qb1WQLKXUzu9In7+koSV0TKmfYPhl41pFMRH+j605yBmy
	Z7K/nUO/rmQ3f58c77Z24zT34/GQGJbCtOLMq71bYkvTM+ohwapUl508qEz+UjARtU3CVhcRuhk
	0zRmtuLE3LprkFEduIX0wBM/NultIsbbmpCJVIF1HIcgZ3cCOcJ2AzFUritoGeGtIMHNJts9kTZ
	hBbkvB+em/dj24/sOTT8EP0gODmumm0kQfpRda7JqiXe1XngZMnqgHNCN98d7nToKs8KpwYnY4i
	Rw20M5NtFgGKrpFzBIrjtrpRundIPoBWAltdVOTpd2BrzduKHLpaaK0N0JAETdXsFNoegowe/oD
	QL7eFMLLul+C+pAQLzMrYvV8=
X-Received: by 2002:a05:7301:1e92:b0:2bd:d8e6:90a0 with SMTP id
 5a478bee46e88-2c0e5071063mr859030eec.3.1773842638629; Wed, 18 Mar 2026
 07:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com> <abqdUBqchnVFo7Qk@google.com>
In-Reply-To: <abqdUBqchnVFo7Qk@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 15:03:46 +0100
X-Gm-Features: AaiRm52jPRFXXf03k9diVYR0ZGnNxGkoAlPwk0mwDAEpyLjxWwYifunzB4OTgFU
Message-ID: <CANiq72koBNCeXFh7uX5GHRJoAu7fyhttDHHN0WZzx9Q74F=mWg@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list interface
To: Alice Ryhl <aliceryhl@google.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Koen Koning <koen.koning@linux.intel.com>, 
	Nikola Djukic <ndjukic@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, 
	Philipp Stanner <phasta@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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

On Wed, Mar 18, 2026 at 1:40=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> My build triggers this warning:

I reported that in the previous version -- Joel, you said you used the
workaround I mentioned, but I don't see it here.

Did you decide otherwise and retested and you couldn't reproduce it?

It is fine either way -- I am asking because if we decide to keep and
use that "fake `unsafe` block" pattern, then I should create the issue
to ask Clippy to support it.

Thanks!

Cheers,
Miguel
