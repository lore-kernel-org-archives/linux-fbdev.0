Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98EB3D9022
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844288; cv=pass; b=tD32+VVEBdbnWyTYJLHotuI8B4I6JqewAgUSSuasQyxrektkV2/nbqEt7u1a0TLcnayBLkL4ZKBUC0x3pnmFVANQjAZLKJ4vnLuYF8babSBG2BPogQNryKHpswiB38aKzyNfAl5H2xIM7+OqB/9O8kRN5nkYvuWHfdLH6HzPb3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844288; c=relaxed/simple;
	bh=yo/HzWSmo18kRP45/efRc37F39eN0N4aihI2I0DZzEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=of1MrzNM4oRwZ39oopUtdw32j8tQftIaIEjcA2VmPSWkoPEjE0HP2Mi1CSPJ5TfUsVY4Rk1ZRcgNGY7HK3IPxVAwMmaRZt7jASvwCkkpLW1ty+NNa87zfyDvFJDao5kO6LWMqCVYmArLaX721liXEr99C3XDmjRTSMtWfjjTIMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uvg6ZO4y; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uvg6ZO4y"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b7c2788dso4401006f8f.1
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 07:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773844285; cv=none;
        d=google.com; s=arc-20240605;
        b=YCeGEDj6C/HrvI3nVBDxTtpm8zwp3vGWQDdB07plGEaHuEne17nzDgS/poBwtv/TTw
         SoVvcjGYquoHA+apUtAPCpHAJXWs9LlGv/sb8Ncd6zPH+Rv9Md8IhGIQXAARo0fXsfwJ
         BaxifXNiMpL8VIilwb9OODDDtyqRrhZm0Ylegck1xZAQthjGo7gYf2Pz63YFSYikNmdT
         Hmp6et0gzuMA8I0Dkq7EE8a8Hnrm5eFwA6X/bfpkKj9x2F84z9Zy4sZZ49rnFOtPhntE
         WxLnNiXW8Nc6WkyIXkwRSwd4IWmWK/k1OHFkRXGM6INvR+Cv59caiBsLCzntXNyy0T8c
         LhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Oke8F3j0iNZ3cSK0OCeOVMy+GmzWDcEKfA0PeIuC3c=;
        fh=QMaXXedtq+WVIhMT49MCO908g6vYxsEW3WYbcVyc3AA=;
        b=b6aVPulp2Lmiqh4gGkzfa+iq9lNqEcYl/Lc9M9Dg+otOUuN7v52LDLnC+QZ6C6djGw
         m7iIzDzRSbH24OZH/8GvuksTKlh2FqLKPEcIGyBlRBo3vlbq851LclVMyHY/tRsPHX1M
         iDpuiiE45h5M8Oxnl0t9gaEfi8/whm8OJMekrwbVIp1rytKN6d4tmmH07kXkH+Q6lfGU
         w5gOXQAsk1J/cNbWou7JiSvSjEIrxYiwTrF/l7VGuCCa6jOpMcWIcvBH3R8Fyu0r21xh
         YtnGG7gwL40AV8cLkUGCRBlgwdomqCTlt6OUy0OoGZ5G4gxrIryAOO12unv3CTRx/K3M
         mv4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773844285; x=1774449085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Oke8F3j0iNZ3cSK0OCeOVMy+GmzWDcEKfA0PeIuC3c=;
        b=Uvg6ZO4yuFbCNzqx5IgkFjE5jT0+fReRtVmbA59JONr6Xm2hBLufDuAl+HwRA3MumJ
         uN812HoVq01bIipHv2xtXa3ZZHJublyGr73DFSuYVnGafGadt8oAaJIEyXKmeZicpw6F
         4x74RW1WCz65dZX/ujm1LnMPGWHnjCrihwE3HSRHT6XrrXCfrAxRnpYT8EmQsH9cMYyh
         H1+e88ZdZwC2RuAJCbrUmoqjlwbzbmt/4ZLu5r/Ym52d7SUuYfAAjkMIZwyC+Vcmwbdv
         7dbRLq1muvFqVMPphVbH+YS57ehpRFi60j78tAgyWXBiRz8oKCVK0wgDNLzolcyzVVjF
         A1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773844285; x=1774449085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Oke8F3j0iNZ3cSK0OCeOVMy+GmzWDcEKfA0PeIuC3c=;
        b=ZbBCfoUDvA1sWx9Z0u/DSalFZorIcuHBP01KOYXxgxjh/jZo7a279hirwmjugyCvpE
         fYcwLl2zGhYy5w3vSKChYcfiJIWHLdkVT1GzFURLfxZGKFJHe1JKyTDELNiAsefre0c/
         QMPZ3aRUVC9MhLCB5hwyRcjCGl/QCZmOppgk8SqXyGcUTzN/4E2Wjc2KQQA+JGDhYAZo
         dJjpu/cWEuL8za9VYXcayryjBae3APCtj4GQDvjME5pTytpxr499s2WT3q9ibchb6Hq4
         oZ3vsu+fnqfkRWjaVh4MYMIHVQ+55kM9gtdzDOqZM7WKOJpMkgNRgiufRPsYNYOkw9hr
         8CTA==
X-Forwarded-Encrypted: i=1; AJvYcCX4cxeZpCz1c4ONDNTBsijYuSZA/83jhBZN/hNu8KTAWqL+IT0HJKZY7pYeBqt/V/G7iLsCisXydCM6RQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1c4EZFTbaANZIPX7UGRN3+Za90FgjaI13cwGJnkb2/wt6DeI
	NkxvHR8owWR2yqDE4Dlt4YH0FiX8iPQY9tstYmiEXPe/lr0Hvr24S+zPFNm3XHy0Wk+kEeKGIVG
	6+1djAJQnN8y8Z0LHd7YsreKiJseccOjsUw3sWJ0f
X-Gm-Gg: ATEYQzwbXXFsqNCIUUPoYVYfjGXbN4TE7wGPHszqpCnlxhvNgamn+n5rbdMgZ9n7ieF
	6rE/B44tGML0FdzCSlKUP1R6hIXNdzN64ghIc1f3WL05en++4kzPhtD2EvtkfY4LbGsPrl+pP9v
	FPmO92pE4rgIboeCih8MhD/oip1HfYOrZ6ZhiYxkqjQxAHU93KE3F701PljhBNb2tblqVB5qpnQ
	PV6PNJrprOBkYEbji4JlwZEq9pvGeTj/dYyExs2AOdCAIdYGkEQ0HiD+AlByT5MnzJConxfPjf3
	/Acxq9aUXeqAMkSvozLlAC09MGqeZUhBGhAJz0WnFkrZ+zerAaDijj28IYVOLlfZHrQksw==
X-Received: by 2002:a5d:5f43:0:b0:439:ca85:8848 with SMTP id
 ffacd0b85a97d-43b527aa344mr6004289f8f.16.1773844284463; Wed, 18 Mar 2026
 07:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com> <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com> <CANiq72=bmJ_GWKowAgv+DWQ8FcWK_HePwjaVgeDmRH+gVD-z5g@mail.gmail.com>
In-Reply-To: <CANiq72=bmJ_GWKowAgv+DWQ8FcWK_HePwjaVgeDmRH+gVD-z5g@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 18 Mar 2026 15:31:12 +0100
X-Gm-Features: AaiRm51O3ZORqMPG2oSnP3bbIvsHXlypg7QXuPo86XIFyKOog2BgXzbGuVDuzJY
Message-ID: <CAH5fLgg-kgeBw3Py-EZmAEJhm357u5NJP6na4qJe8v3aeFW5Cg@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list interface
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

On Wed, Mar 18, 2026 at 3:21=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> [*] I would have preferred a middle ground like  modules being inside
> but repeating the folder name, e.g. `.../pci/pci.rs`, but I doubt that
> will ever be supported upstream since one probably wants to support
> the other ways at the same time.

In principle this is possible using

#[path =3D "pci/pci.rs"]
pub mod pci;

Alice
