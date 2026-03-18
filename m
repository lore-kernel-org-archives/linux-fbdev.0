Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E83ED10A
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860249; cv=pass; b=LEVNvdzQOVHx/TYe9xgXjr6k3WigI/icWMGWBHcH7T6jF3ZrdscXp00ZE0/VgrWbF+qM33dAksVNJPTGsQKJO2BjSBssxvLL2tiUMMd7jM5V/KkUqCg7TytJUzGh8HFC+uJmloUyD6dY7IMqh9GW3XSCbJcYjyuz1iDlxwECZGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860249; c=relaxed/simple;
	bh=d3bcHjPGT0Fov9B4KoCksRHw66Y8wxvQ5LjIruDyWqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R13n2OUASuMFaVHMKPCtmM38JZkVwZ50Ex65l1cZsjlZv1pkPdh0UoEaaUfvM/bI7odyBBXtJZddGEZTxvAgTi+NT3aIzRSvzqyDQGFt48lClrciP87kSsqZIurMXJkakIB3XVyJXumg5cmGnwc+qu5XxFqDiaobfaCEVkQBVgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYiFswS+; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYiFswS+"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c0c7267500so5386eec.0
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 11:57:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773860247; cv=none;
        d=google.com; s=arc-20240605;
        b=IZAdLUIj3VkXW7L+u0KlmiFwGzo/fI3T22dcnA1BYP71oUD6ak6vo6gpi6/rvp+Ck0
         AvdkHcdhnjrqgHnqlnVhphWPn2wOh0vj98QnPx7ROr355Rra+srmivwJRzrOzVcSVe16
         Qpmm/AEYvzTQxW+9malj6g4d3UmdB/Mmb+U7X0taQThnQoRwAaRdqQ51Zn36qe47jJjv
         qTRhHKsGECjvTnuIGPWAudcUUkmMeZ9WsqxOMRQ/+PnlsttH/qQVMqEy0Xs3rHQJAP6r
         s7NNtvsNvWI3BPrrIsZeO/7hy2q45u86K9ETNmlEOFPXDYap2LUHH4VYuTkEnr4ER52F
         PRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d3bcHjPGT0Fov9B4KoCksRHw66Y8wxvQ5LjIruDyWqI=;
        fh=hIZY7/PtMphVtc2Uqt9dm59dtsmIKbL7lbM4h2upjZY=;
        b=FAMTlW2palDsv6AwcMfU3QlZDM6qQjdM7qhrsaDv8YMe5L02SisFq8hOhXrSN90wl3
         ktnxgpxMiDkFBKH9wW1JTr/HKl1/5jIULh4hTCp+yhebAqSEcGp4z6Vj+McrzTlZ6/8L
         VMN97yAvaVj7uB6MVIzd5XrznvEiiT9lJh4AJFlj/O6oGWAEukbT+XnuqXNKVOUrii2E
         g9lGQyClv1DiMqT5OG+gc49YE3qFk3pbf/gDKZMVU2SKnUEB8k5CMxOz23L3yt6RXCXu
         LPSEJAjXsCoyP5ybuy3CQEvBYpOUc1NiFFIYxhi6lAJUAnRs50ffq0Y3k2A10YX2RMnt
         wlNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773860247; x=1774465047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3bcHjPGT0Fov9B4KoCksRHw66Y8wxvQ5LjIruDyWqI=;
        b=bYiFswS+IF473HnaBsgMKvJRSNlZN/lfwu86MtxxErFc7DcLsZHIxIQ8VwiGoz2igY
         LMN9LeIGAw02c01Ds9nr9kZrbrmMr7sm7FwmZctAlzxG19G1L2XNm76WU4GIro/1DiUc
         DCZlr+tolR9/hW3MpT3u9TluRJMPMgLgKtlXcsMNi73+V5gKzLC4ZkDjkvz6BQehoGxc
         T1K8Ja9T7lg8kQCI3VbTQb8TXxPEX0xZH/6zkapxMaNAFtrwNHsFP4OMNrDpqavYa8JA
         tAJsWnbmAEril4JoMORwlcPrj7GkzZmqGiUka9ymMiJr8EV+npcabUuUCUMYKN4donni
         JACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773860247; x=1774465047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d3bcHjPGT0Fov9B4KoCksRHw66Y8wxvQ5LjIruDyWqI=;
        b=ZmAbWk5C/3KZFO5asD5Rr4Ypws74tCI14H/8JpeXo9wLOdl6AQz1/Ezx2fWp7YEWFW
         9+JFqiKCYD0o20+sGyl5mvjTXhW5zNPuMWz24rEv+myd26cL7ecRXgJFGppYx0GaFJqZ
         YMe6gisl/BlraVkF9+zK8HrLijv5lkfI9a6QHFy4ZezGccLkHlMxMofLSWTXQTKtybbC
         rRSwr9IHsXxHPt6kXJDzOO6E9dzE7CQjUWvT35+rgfONbBm6qGtYfGJvgAuBK2FJplqG
         NgcFhlGrimKcF4QrXVRScyFx8pKKXhhLbigOr6zRCbCEj5X8O+SgqGRNnf3Qnu0EB7sO
         hEfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5hhqYiisAoZxaix/iDXuwTI3GknInHRPeH9/N26i0BmXuWNNZi9aMOLZGXFT1TqOYmQWSiUlniZWNsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzygcUJ4vE1TQR0LHJc14Ha+vXWfHz9imVlwgH8zD3Alj2E1BM0
	C1yo+jVbo+Gm+vH7jFJpp1WgQI9suxlxHbz/cFDJjluZPimAkm95lKoKbjvU3uwHiNxtzDDoaBX
	ovc2MGOb4LNVyx134XKdRiuRuNfWSN8c=
X-Gm-Gg: ATEYQzyoH5wm7vSJdUcYwZZF1nNxjwL3988pfgqicc4mvqxZnca6i9aoeGUrUlmMMF5
	nTSr6gRNyQ9YDVFPmTtz/8ZEzPukRkWq0N02CA5FWL+QuP6aWgE89dTLVOJaNyuov74Z91gXdYq
	bhBlYAh4FhgC4Oqp52wOgKu42m3LwrAUAtXn6I2KmqmbxZXLeo3mkL+A4mZU5aZZsyOcyDxtDB4
	MkR9ghFuTfvqpD7xH0XqIDmPm7697vKIVW30WNt/460udH9UFfYGaEx9SlNjvZCW/lTlsC9HtSq
	HUwabTTQHfUCwtiTtcjLjq0lWAHcTmYVuolcwxArxE1M0GwJazGFAra0WtA/aju4D2uRquDTkRo
	CgFLaEGxOFVPXKpjKvCFEBF4=
X-Received: by 2002:a05:7300:f191:b0:2be:9886:d4ff with SMTP id
 5a478bee46e88-2c0e50fefe8mr982481eec.2.1773860246896; Wed, 18 Mar 2026
 11:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com> <abqdUBqchnVFo7Qk@google.com> <71b6a115-98f1-4b09-9c04-a99349f51e49@nvidia.com>
In-Reply-To: <71b6a115-98f1-4b09-9c04-a99349f51e49@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 19:57:14 +0100
X-Gm-Features: AaiRm52hIUr0vzgoavDmbzyJmg3hgU_AUfgRxMfUiR8zNc5S5daML4wMbNTdaCA
Message-ID: <CANiq72nZKx7pw_rZK2mHHvR=TaeGvMRvg5GTHOd58X17oyxieg@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list interface
To: Joel Fernandes <joelagnelf@nvidia.com>, =?UTF-8?Q?Alejandra_Gonz=C3=A1lez?= <blyxyas@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
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

On Wed, Mar 18, 2026 at 7:31=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> Anyway, the fix is simple, just need to do // SAFETY*: as Miguel suggests
> here, instead of // SAFETY:
> https://lore.kernel.org/all/CANiq72kEnDyUpnWMZmheJytjioeiJUK_C-yQJk77dPid=
89LExw@mail.gmail.com/

So, to clarify, I suggested it as a temporary thing we could do if we
want to use that "fake `unsafe` block in macro matcher" pattern more
and more.

i.e. if we plan to use the pattern more, then I am happy to ask
upstream if it would make sense for Clippy to recognize it (or perhaps
it is just a false negative instead of a false positive, given
`impl_device_context_deref`), so that we don't need a hacked safety
tag (Cc'ing Alejandra).

But if we could put it outside, then we wouldn't need any of that.
Unsafe macros support could help perhaps here, which I have had it in
our wishlist too (https://github.com/Rust-for-Linux/linux/issues/354),
but I guess the fake block could still be useful to make only certain
macro arms unsafe? (Perhaps Rust could allow `unsafe` just at the
start of each arm for that...).

Cheers,
Miguel
