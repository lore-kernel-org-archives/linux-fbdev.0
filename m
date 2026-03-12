Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309492FE066;
	Thu, 12 Mar 2026 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337361; cv=none; b=shlM153OWk5DhwyJVM2Q1yh+j3IpmcvZGinZq+/CyF5Q/powdd+NER7Wv4flDV9FPy7g1EFNanBxEC2iRrF2jpLUslWSOmcAcjRpm2XyEHZK64k0YnGnkWfKtOpc4kq0SD8sAd1TgolE2+re5TbHA1UeiGEYJRHFdQXJKLcZqjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337361; c=relaxed/simple;
	bh=fzWGAK9KTqaNGRFT54YPdh5xx8RwDks5Dg0v4o6wWYk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=D+tTZDsx7f3OI9LVbTu9Kbv3K3u9rccY2ZnH3J1OONEVQNEMzTt2IqeCCoG3P7prlJAFs4Wmldm+HwLbDQCt1Lg2HvaLCF3ihQDx9omnoDDRIsmFnty0FTWZUGNL5VDPxp+lD8ZEe8Ym2YiaQlkrGm4LOC37A8G76OUNcPZhyCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI8NbSKK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI8NbSKK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B799EC4CEF7;
	Thu, 12 Mar 2026 17:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773337360;
	bh=fzWGAK9KTqaNGRFT54YPdh5xx8RwDks5Dg0v4o6wWYk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=iI8NbSKKaOcIFGvIn2I9PF0S4Qw3RnlKLcXDXC0+xFllUHAHInmePQSGfQs1Gp1jl
	 DJJax35FugGxPGplpzgZodu5b9excH8SYhM7tnBqQ53CE6dNLeq4iMJorLVpUJDNOW
	 a38abgMWt6HtgEF64DVK06YQY1+v+zgrm3wAd6BY+M4lWdYeJQgYtQVfvEmTumS/jL
	 uqsz0gAA62BkEUOGcfS4IO169P9bgBGS9yPoFWWDhkwKY8Jm9CPnaFPaJkjT+d08Yx
	 3I2xjSRSbRTusYJeJDf6cPcGRLR/2Yvy+ZPwGX1/YzvB9a3rPeFIS9nCslzgDO4wqg
	 1gGcNC9hSEqhg==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Mar 2026 18:42:28 +0100
Message-Id: <DH0ZMJKN6OE6.243UPT928HIIX@kernel.org>
Subject: Re: [PATCH v12 1/1] rust: interop: Add list module for C linked
 list interface
Cc: <linux-kernel@vger.kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Dave Airlie" <airlied@redhat.com>, "David Airlie" <airlied@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Simona
 Vetter" <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Koen Koning" <koen.koning@linux.intel.com>, "Nikola Djukic"
 <ndjukic@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Philipp
 Stanner" <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 "Jonathan Corbet" <corbet@lwn.net>, "Alex Deucher"
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Jani Nikula" <jani.nikula@linux.intel.com>,
 "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi"
 <rodrigo.vivi@intel.com>, "Tvrtko Ursulin" <tursulin@ursulin.net>, "Huang
 Rui" <ray.huang@amd.com>, "Matthew Auld" <matthew.auld@intel.com>, "Matthew
 Brost" <matthew.brost@intel.com>, "Lucas De Marchi"
 <lucas.demarchi@intel.com>, =?utf-8?q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, "Helge Deller" <deller@gmx.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer" <epeer@nvidia.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>, "Miguel
 Ojeda" <miguel.ojeda.sandonis@gmail.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Miguel Ojeda"
 <ojeda@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260306203648.1136554-1-joelagnelf@nvidia.com>
 <20260306203648.1136554-2-joelagnelf@nvidia.com>
In-Reply-To: <20260306203648.1136554-2-joelagnelf@nvidia.com>

On Fri Mar 6, 2026 at 9:36 PM CET, Joel Fernandes wrote:
> Add a new module `kernel::interop::list` for working with C's doubly
> circular linked lists. Provide low-level iteration over list nodes.
>
> Typed iteration over actual items is provided with a `clist_create`
> macro to assist in creation of the `CList` type.
>
> Cc: Nikola Djukic <ndjukic@nvidia.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Gary Guo <gary@garyguo.net>
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Was this given off-list? I can't find a corresponding reply from Miguel.

> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

I'm asking since I'm looking forward to pick this up as a dependency for
GPU buddy.

Thanks,
Danilo
