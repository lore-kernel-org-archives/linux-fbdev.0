Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034B3D47D5;
	Thu, 19 Mar 2026 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773924717; cv=none; b=b1HlaRSivUXfpSTqKeZV9LEW5VeZYETxbge3Xca2m+/BZWMjEQ3bEqzNNzW3j8CKVibVCDlF47s0wjVBBABmO6ztStMBapXlahr17ZFZ0eKdxWKcFiJRmBFFWlO8K5P25JJ4ahsbiiNaHje6QJLNq0qjH3FAsFWW4HqGkhT/oXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773924717; c=relaxed/simple;
	bh=3JCTw3yQAwzCC0Z3TnAOJaa/wbUuhF+28P/bEaMtvTE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=tltt6mrlRvsjQ4XMJbpD4Wm7yuuKhscJME6wkZTVsdnPgJ5yxHE+rVc96atmK7iqhgb91lNRdoIywi936SMdQtYKY1rLDlcXZQ5oPbHWSO6+4by+tJMq754zCrx0DvXblWKGttUZ6uscZ3J2fsfSc/q9Dm/gssQnRZs1uaERkJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf//2PEA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf//2PEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5658FC19424;
	Thu, 19 Mar 2026 12:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773924716;
	bh=3JCTw3yQAwzCC0Z3TnAOJaa/wbUuhF+28P/bEaMtvTE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Hf//2PEAF/nTtwZm3T755K9b8oQH3665Q3VRMD0anzbF5f/txUtpJpFzzhUkQMfOt
	 FQWI52Rbq3mC7VdKFHs7fMygfOLftFbHThZWxpprlHYTb7nZ6FhYkz/r4PZ1OycQcb
	 tGiztUO5ANyUu1kXN8Nk3Kj/PHNaVdoPFrEfiEBsN6i2m2I5GJLFMvGpWnw+DRPEpJ
	 WAhMljp9unXDJzqcqcpnkk2nxiSEJyYw/n/oTEUgDwu6RdQdJAw5/9QniNKvKBLVv/
	 A8L+7NPsxPo5L0gFrt1+tZyQ7vaGw0H0i8S1Ip0HYppZ6O5xbm2Orbl1CqmW95r87/
	 YOsyLjMmc/VtQ==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 13:51:44 +0100
Message-Id: <DH6RTR2FV614.116P56ME4RPT7@kernel.org>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked
 list interface
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
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
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-fbdev@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com>
 <DH6QAR1HHXRV.1Y7IZ22HC9FZ3@garyguo.net>
 <DH6QUO2T941E.2S1UP7EABOP42@kernel.org>
 <DH6R6GB10S07.AG2EY39F0P85@garyguo.net>
In-Reply-To: <DH6R6GB10S07.AG2EY39F0P85@garyguo.net>

On Thu Mar 19, 2026 at 1:21 PM CET, Gary Guo wrote:
> If there're cases where we do want to justify unsafe code that's not imme=
diately
> deferring to the user inside the macro, we could use the SAFETY* trick pr=
oposed
> in the thread, without writing an actual `unsafe {}` block.

Works for me -- if this is what we want to do in such cases, we should prob=
ably
document it somewhere in the coding guidelines.
