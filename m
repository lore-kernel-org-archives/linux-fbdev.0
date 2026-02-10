Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D133FE02;
	Tue, 10 Feb 2026 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718217; cv=none; b=M+NE0ePZk6ZlujnAYjocv8DI0KQ0EtVWgcpcHroFROmvw8Xtjv8r8IoYLKqlv5HmHHLOaHKwngV9jkJG2i2HRhBUDN5iE6JBt7f8VnKu8dwtszX955om10vSTzYoGWUDBzl1/xF9rw84Zeps0K5oMPWpNVvrMZpEybzZO7VKe3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718217; c=relaxed/simple;
	bh=Y1eJ+A7bQ+DjJKh+pu4y7cwRQw19sr4V6ovNvsHmjOE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=NgOREX5dOqTOJO8P2VyOY6GMv52q4xLfkxWHnrTl6vD5qejY1l8jNQUwOIFMkXTeRvMuZo1aPmbPLqUrXg/7GjAft0Z82+Ro0vpoeZ1JaYSQCWfWD5qgjN8d8SCVGmL0Tf9gw1oTptvNjbKEFBlqGF6bpqnz4mQxNsv02Py3Xgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjaZ5ktO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjaZ5ktO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304D5C116C6;
	Tue, 10 Feb 2026 10:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770718217;
	bh=Y1eJ+A7bQ+DjJKh+pu4y7cwRQw19sr4V6ovNvsHmjOE=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=KjaZ5ktO2RwcnVfgIKvTFccsUCApAJjPUj4D8e0ZO3b/KLUWqSj0RGU0HG8GMGMBY
	 /ca+RG3h60JHjlJnxuB/WE1vdfh2hG+sip0oKbsljKs7Y1kANUE/VXUNJ/j44c53gz
	 EQYNofR+tf0/melgx6bEoZ2lBVdRZbX0Tewo9DNVHrwitaRRpZO4yRMIbsHqPT0/Do
	 +Zh0a0G7FJfcZeN9ZeFCiYAzzuFKjPeSW2KDjstvQ06C13LjKiZomFwgWOb1lLjoTP
	 WF0IBAEwIqOKfYua4Pmmk3M+MBi2AmUfFW9dsSgYecM4uLFTuUxaDnyfmp6iru3MSI
	 +pQkxwj3FuECg==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Feb 2026 11:10:06 +0100
Message-Id: <DGB77U0C946C.3F9PUVN5XX912@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH -next v8 3/3] nova-core: mm: Select GPU_BUDDY for VRAM
 allocation
Cc: <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jonathan Corbet"
 <corbet@lwn.net>, "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Huang Rui" <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Lucas De Marchi" <lucas.demarchi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Helge Deller" <deller@gmx.de>, "Alice Ryhl" <aliceryhl@google.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer"
 <epeer@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>, "Philipp Stanner"
 <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <joel@joelfernandes.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
References: <20260209214246.2783990-1-joelagnelf@nvidia.com>
 <20260209214246.2783990-4-joelagnelf@nvidia.com>
In-Reply-To: <20260209214246.2783990-4-joelagnelf@nvidia.com>

On Mon Feb 9, 2026 at 10:42 PM CET, Joel Fernandes wrote:
> diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfi=
g
> index 527920f9c4d3..c129764daa23 100644
> --- a/drivers/gpu/nova-core/Kconfig
> +++ b/drivers/gpu/nova-core/Kconfig
> @@ -3,6 +3,7 @@ config NOVA_CORE
>  	depends on 64BIT
>  	depends on PCI
>  	depends on RUST
> +	select GPU_BUDDY
>  	select RUST_FW_LOADER_ABSTRACTIONS
>  	select AUXILIARY_BUS
>  	default n

NIT: Let's get the 'select' list ordered. :)
