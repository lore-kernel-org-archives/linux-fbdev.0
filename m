Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D634E29D287;
	Thu,  9 Apr 2026 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775732426; cv=none; b=Lfykx+uH8VuM0r0HfGbbobbE4GdJ6FTrmnYpS47BdHSHAsm6mqGzC9QXbGeOXeOqtXFpDhyMDSx7IaTaY8im4gNXWK+M1Wo/PgCKphgDdq0txvlu2Hho+Tr/IgaRYX/n/chfUprDEJqncbUC5LX5kDMFVJ/ScW0Z28EcIdgENy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775732426; c=relaxed/simple;
	bh=S27S6h9mUKM1s14YWbjTJbACYA6Nxxtr5I5xly+lAhg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=GfzZdifvygwt6CHweaRFegH5pweIMSHTNytzNDCyuu/QBaucX9+t/wKBog46gsR6eg2pCQs0eBhRpNmUtSz9x5NnDnZ6BVIpxgtZod6zQL2RaduYEcwcN9zfCS6Vsd/TPfAzLWGy1Sk1D9QWgqFNhGIgTRTGg920038skaDKxXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1dt1w0Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1dt1w0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903F0C4CEF7;
	Thu,  9 Apr 2026 11:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775732426;
	bh=S27S6h9mUKM1s14YWbjTJbACYA6Nxxtr5I5xly+lAhg=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=I1dt1w0YhmrPkInFOfuRXDoZ9ixaATj78Qv5fyzm6FWc51SnZJDMLAdBKgV5uso4/
	 Yz3nJ1ynniMI5ZvWkunExqSqHeFZlXlp1GXUjF7oi08MvBAOAb40jXPKM6qW5pEKSs
	 34Hq5mibMCHghbGtVgWbNnqtLRnrgpkY7mW9KXnH4UBNO96MA04DY4apOlPhmLeADP
	 RvlredU/NIokGAPx2+Xe1KEzNrrBBgXRNJLqCPy4P39owcZlh4AD/fpyKI0Gz2N/6B
	 VrF9WPfO+F3qlGoAkBycROiIuyiS4jO0SIAvHnQPBtAjwaiBvUz+evx1UmOO58//tD
	 UR7or4b82RKOg==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Apr 2026 13:00:15 +0200
Message-Id: <DHOKLTRRIX2Z.1YA9X0D0X21K@kernel.org>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <linux-kernel@vger.kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Bjorn Roy Baron" <bjorn3_gh@protonmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Dave Airlie" <airlied@redhat.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Koen Koning"
 <koen.koning@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, "Nikola Djukic" <ndjukic@nvidia.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jonathan
 Corbet" <corbet@lwn.net>, "Alex Deucher" <alexander.deucher@amd.com>,
 "Christian Koenig" <christian.koenig@amd.com>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Vivi Rodrigo" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Rui Huang" <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Lucas De Marchi" <lucas.demarchi@intel.com>,
 "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>, "Helge Deller"
 <deller@gmx.de>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Edwin Peer" <epeer@nvidia.com>, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Andy
 Ritger" <aritger@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>, "Elle Rhumsaa"
 <elle@weathered-steel.dev>, "Alexey Ivanov" <alexeyi@nvidia.com>,
 <linux-doc@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-fbdev@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v10 12/21] gpu: nova-core: mm: Add unified page table
 entry wrapper enums
References: <42dd707f-e23a-4725-8b6f-08ca346b0143@nvidia.com>
 <1775730646.3752.4760@nvidia.com>
In-Reply-To: <1775730646.3752.4760@nvidia.com>

On Thu Apr 9, 2026 at 12:33 PM CEST, Joel Fernandes wrote:
> Since it is 3 against 1 here, I rest my case :-).

That's not how I'd view it. :)

Anyways, in case I'm included in "3", that's not my position. My point was =
to
ensure we keep discussing advantages and disadvantages on their merits, as =
I
think you both have good points.

> I am still in disagreement since I do not see much benefit (that is why I=
 said
> pointless above).

That is fair -- in this case please explain why the advantages pointed out =
by
others are not worth it, propose something that picks up the best of both
worlds, etc.

You can also turn it around and ask people whether they can tweak their cou=
nter
proposal to get rid of specific parts you dislike for a reason.

IOW, keep the ball rolling, so we can come up with the best possible soluti=
on.
