Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7831F2DA742;
	Fri,  6 Feb 2026 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393238; cv=none; b=bCG5LmHTRMuMSGNayI0+K/LQe+WI0hEmsHZXsoGeuTskzqPeuQQU8oLK2cREL2VJgKdZxk5qPq8Tf+ChrmNqLjZv1wVv/uriSRLpaRUJsIU2H4TsERlXXu7WI/mjwFgAdqfyYyDKHmYMUqEhADNOrM1QCZrHUzDAHPBKAby/8Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393238; c=relaxed/simple;
	bh=ze8RjpWv8yTJ+WjIu3XKMrMfT9jYoz3Ax+Xr197aMQM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ohhu4LpZjKq6lpYYisdxY7ppT83SElcqgfKc7aE+P8suRMByAetH6koqVatsGv0aIT0vVJx7D4XLUFwO6hJm0spVol6QBiKx/mXTtJ5/Dq5KkJOpUSjGW/OhHtzbchHC99eye5NY2SKRXCOuP6l4Glaaf+yy1ecfQ4GgQdoLzhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkZnrD/o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkZnrD/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA6BC116C6;
	Fri,  6 Feb 2026 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770393238;
	bh=ze8RjpWv8yTJ+WjIu3XKMrMfT9jYoz3Ax+Xr197aMQM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=FkZnrD/oa9GtTvMAdifPkms3Wa2QVBnFodZ7xitHhc1s9KkRwwcoYLF0ecmJSskB7
	 qeDNYKEQYz+l5Jcu3IxZBVpluiEeCGi5y6VjEYMLM3+KdVRzOnN7+/3BvItxTMM+Tz
	 JClwqsQv/MCqbahtuBihb6AijUCm3S7rIKYY3VIgb3140k6gtZsyyiUp7giy/FPqvQ
	 WxLb9xC9qzwJcB9LRPLhbkL3hYGTlu9jrv+9jwwpTFefk6U/jgDSGLvrlRyAaNCETU
	 erXhxJQ9whT6WQJUhkxpLOSCQygzOAyUC2J6h9/jl457b5Rcql9PmSSgT4ajwtk/oW
	 ZpzbSTyGfIvkw==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Feb 2026 16:53:48 +0100
Message-Id: <DG800TDA6OXQ.275PMMS19F1EX@kernel.org>
Subject: Re: [PATCH -next v7 1/2] rust: clist: Add support to interface with
 C linked lists
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
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
 "Boqun Feng" <boqun.feng@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer"
 <epeer@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>, "Philipp Stanner"
 <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <joel@joelfernandes.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260206004110.1914814-1-joelagnelf@nvidia.com>
 <20260206004110.1914814-2-joelagnelf@nvidia.com>
 <DG7ZF1UT98RQ.3F42J3ULGV2OC@garyguo.net>
In-Reply-To: <DG7ZF1UT98RQ.3F42J3ULGV2OC@garyguo.net>

On Fri Feb 6, 2026 at 4:25 PM CET, Gary Guo wrote:
> On Fri Feb 6, 2026 at 12:41 AM GMT, Joel Fernandes wrote:
>> diff --git a/drivers/gpu/Kconfig b/drivers/gpu/Kconfig
>> index 22dd29cd50b5..2c3dec070645 100644
>> --- a/drivers/gpu/Kconfig
>> +++ b/drivers/gpu/Kconfig
>> @@ -1,7 +1,14 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> =20
>> +config RUST_CLIST
>> +	bool
>> +	depends on RUST
>> +	help
>> +	  Rust abstraction for interfacing with C linked lists.
>
> I am not sure if we need extra config entry. This is fully generic so sho=
uldn't
> generate any code unless there is an user.

I also don't think we need a Kconfig for this.

In any case, it shouln't be in drivers/gpu/Kconfig.

>> +
>>  config GPU_BUDDY
>>  	bool
>> +	select RUST_CLIST if RUST

If we will have a Kconfig for this, this belongs in the GPU buddy patch.

>>  	help
>>  	  A page based buddy allocator for GPU memory.
