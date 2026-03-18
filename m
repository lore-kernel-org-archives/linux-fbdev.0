Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D01261B9B;
	Wed, 18 Mar 2026 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845361; cv=none; b=R+JpDwjsTGkcrC64h8Ub31HvVxpWX6r/apqQq2ovt1NhfNXU1sdZoJaxsuXCTnUsDgqeLJSbcYSqn9tXtijQXps1fb9ztm5C181hufp+mdglO7vOS052NGunqDZHti9dmvspuoYfjsfOai4IL6+r2KTrWrwLN9P8YlChZvp4GeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845361; c=relaxed/simple;
	bh=aW5bvrmFz8ackGklJ4CM2BaQvUtm6FdrgZ0HSt1ERN8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=oUylWt4jvhnkQTVc6kVC3jydTWVWQiokjNJvkD/3btbpcHjeu8qeB19h6jM4qNdWbgszOcgSs2MC0UbMhvhhVf+hA4kFdbk4vj8COf41416jFxpxtDOStT+1xyKyp21eLp41sHVh32BOX8QmOmasYzjOZrEHhqlc2lAsPK8+f7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6pcsti3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6pcsti3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F4BC19421;
	Wed, 18 Mar 2026 14:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773845360;
	bh=aW5bvrmFz8ackGklJ4CM2BaQvUtm6FdrgZ0HSt1ERN8=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=I6pcsti3DOkZesWqbbB3khzQEteyRi+wVmUNphXAjJHu1ODx62i2Q+YR2c5pAayQ8
	 8XNWCGplmSzR0A0APJdcVKApXnN5wGWr1q6AI8dUxKzQbiAh0dnkxSD75eLFdyJkMn
	 +62QBlD5kbQToTYE6D41hF39MCPPMeQeBhHRk0FUNqtE86B9Mkkzl7PgMvxbY+qkIM
	 5O3pVDfY0R/jQZrY6UcCvRjDC7Qd0kyhHQ7P/fr0LZg1ojoowq3nr/HKraQNQrdYoc
	 ykFINyhjEDAQ+BbYscs2vs/zFeO2NEsvuaUr3AYed2kDBowOcRl2Y20Hz6jfpGZNwe
	 KtHvQE3OBIzUQ==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 15:49:08 +0100
Message-Id: <DH5ZP3IUEWMD.TOOZSEUTLV85@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked
 list interface
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Dave
 Airlie" <airlied@redhat.com>, "David Airlie" <airlied@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Simona
 Vetter" <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Koen Koning" <koen.koning@linux.intel.com>, "Nikola Djukic"
 <ndjukic@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>, "Elle Rhumsaa"
 <elle@weathered-steel.dev>, "Jonathan Corbet" <corbet@lwn.net>, "Alex
 Deucher" <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
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
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com>
 <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
 <CANiq72=bmJ_GWKowAgv+DWQ8FcWK_HePwjaVgeDmRH+gVD-z5g@mail.gmail.com>
 <CAH5fLgg-kgeBw3Py-EZmAEJhm357u5NJP6na4qJe8v3aeFW5Cg@mail.gmail.com>
 <CANiq72nad-60tOJeAfkvHTFrWXQS_wbG4JUGQNnkjm_NvhhaYw@mail.gmail.com>
In-Reply-To: <CANiq72nad-60tOJeAfkvHTFrWXQS_wbG4JUGQNnkjm_NvhhaYw@mail.gmail.com>

On Wed Mar 18, 2026 at 3:41 PM CET, Miguel Ojeda wrote:
> On Wed, Mar 18, 2026 at 3:31=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
>>
>> In principle this is possible using
>>
>> #[path =3D "pci/pci.rs"]
>> pub mod pci;
>
> No, I meant supported natively, i.e. without having to write an extra
> file everywhere (which could perhaps be simpler as just a symlink
> instead).

What do you mean with extra file?

renamed:    rust/kernel/pci.rs -> rust/kernel/pci/pci.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 34b924819288..4b6396aec030 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -131,6 +131,7 @@
 pub mod opp;
 pub mod page;
 #[cfg(CONFIG_PCI)]
+#[path =3D "pci/pci.rs"]
 pub mod pci;
 pub mod pid_namespace;
 pub mod platform;
