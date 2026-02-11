Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418B311597;
	Wed, 11 Feb 2026 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770801561; cv=none; b=sbidF6NaTEy4G0bzsEs7taF4uWjPB5r5OGfnCfulbWqqAWAxgVPjYYYnPkSKCceVSXAhg9dVewJRcAtIFWSBDgrJZVVEqhKvZNitVhYmtQAiG4p9P6jcqcxciJAXRGEP6CbkZnOENYqnkNMkIJpzy1uMaQ8/ngpC/fQ3jryTiY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770801561; c=relaxed/simple;
	bh=78vTmn6thDBzfMtB97lbGjUwbhyWjHfpO01rDAwelEE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=KZISYO2d1UTcXUWMn3Nm1PApW4bldVTF4j5j+4rfZw0XBzt2uU2GGVbwgasIOyhg/iignWKATra9bSqypPAFlTC6zYwtphWsjCD6hqeLX4ebU3ROnAJA3cT3gELGIPOS/NkBetG4RqYslH8BV3R5K7/HRVt3B0e9xg6Je76dqkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVn6Hz7e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVn6Hz7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC37CC4CEF7;
	Wed, 11 Feb 2026 09:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770801560;
	bh=78vTmn6thDBzfMtB97lbGjUwbhyWjHfpO01rDAwelEE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=aVn6Hz7exp0YJcrbUnRdD+gd17f1RCAA1sl62249pmqhZS29AgnCdsbpjMH8vQ6gs
	 cSQv5HLMWxo2QDS1hKjJFEG/YQ3uBYw43zlB4S1skWSy39hiqhsDcP+QPulot0nfxO
	 N8j7Uh02sfUFF5Jhx0zgR69nlFtP2B/SzwZCUn2oP0aJmSZAl8Ua0YFXABPQFIKkDM
	 A5yL2AFL3lts4OTxoYgANVJoQuhUr1/6YkJ2GPgK/rEbSvM6fi6j8ESdROE7LSLGad
	 OUlqfK9D+aK85lrsm9/ouuaH1cbTAOZNYb2LkVWX8e2xjyzD6r3ZBk4ldQggiNdhql
	 8+jd/QPt2oy9w==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Feb 2026 10:19:09 +0100
Message-Id: <DGC0RDIBDEYB.195QJ6S6GF9WL@kernel.org>
Subject: Re: [PATCH -next v9 0/3] rust: Add CList and GPU buddy allocator
 bindings
Cc: <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Simona Vetter" <simona@ffwll.ch>, "Jonathan Corbet" <corbet@lwn.net>,
 "Alex Deucher" <alexander.deucher@amd.com>,
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
 Gross" <tmgross@umich.edu>, "Alistair Popple" <apopple@nvidia.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Philipp Stanner"
 <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "David Airlie"
 <airlied@gmail.com>, "Edwin Peer" <epeer@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <joel@joelfernandes.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-fbdev@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260210233204.790524-1-joelagnelf@nvidia.com>
In-Reply-To: <20260210233204.790524-1-joelagnelf@nvidia.com>

On Wed Feb 11, 2026 at 12:32 AM CET, Joel Fernandes wrote:
> Link to v8: https://lore.kernel.org/all/20260209214246.2783990-1-joelagne=
lf@nvidia.com/
> Link to v7: https://lore.kernel.org/all/20260206004110.1914814-1-joelagne=
lf@nvidia.com/

I already asked about this in [1], can you please add a changlog to your se=
ries?

[1] https://lore.kernel.org/all/DG0MRL6T7ACW.25G3GLJMP7PN1@kernel.org/
