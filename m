Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D0372661;
	Mon, 23 Mar 2026 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299735; cv=none; b=giUkEHGEpUGSolgvHoAtODv3k1/2a7+5y/Bqezhz1hfJe+bNeiY4mXvpMGJ/qFwVMe6QhuFq+ZozI3xZ0KFvaH61C2LQogkKcfj4fJ1zwSd0hkQNK+PSO9gDxUy0EJUvoIz1Db/EZYEvZAOOZ8ZNpmjcSg1jDHkNcBBmy0gYQWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299735; c=relaxed/simple;
	bh=dqk4kdg+Zk64HBd2FzGAkQH4A7+RJLy4QJjOPDS02h8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=CWpjtb35CqpJccaIYTxOsCdz9Z8VSozrwzW78Bd5EMCRTSd/ChzRu0US9wRNAXIaLL7ucBLA/1zrX9mDTY2NOj4gW6dMcjispDHskhODBoeAKMH46KjvlJLj2gRXNT8Y2ITU/pO+vC/yxfie4+4sXuSkbSgz2YeDvSDX3v44AEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtAcNpeH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtAcNpeH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF90AC4CEF7;
	Mon, 23 Mar 2026 21:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774299735;
	bh=dqk4kdg+Zk64HBd2FzGAkQH4A7+RJLy4QJjOPDS02h8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=OtAcNpeHdYCfcG95v0YNmWawpxLlpVnEsVs2xnwB8uQvp6VTriFb+5NTs2Fo6Is0o
	 rADJ3RsPnbhSao0F+yzAGFS1yx5YTPBk0Xe1J0fE3wsiyibb/yuo010okJz72Pci4R
	 JcnSmB27pqE5e+45S8y4g3bHwvwYyXcKFevoWpRyou/dLPxlGUUdRmghwyxIZcfsYv
	 Ji1SMtrC7dbuIRHyMMW9FjqcYEctIu1e1lNOmLBzISB9YaAo1ohTJGbzRINT5QRxC7
	 rsaNkrvxJfq+dRJeSA0qB+Cao+iCB/VPoIocFM6OTU9Wj5Cv943SQpRD9IthU18R3t
	 asD8FALwMSdow==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 22:02:03 +0100
Message-Id: <DHAGRCKUA4FQ.1HJ58DCKGH2ML@kernel.org>
Subject: Re: [PATCH v13.1] rust: interop: Add list module for C linked list
 interface
Cc: <linux-kernel@vger.kernel.org>, "Gary Guo" <gary@garyguo.net>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Dave Airlie" <airlied@redhat.com>, "David
 Airlie" <airlied@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Koen
 Koning" <koen.koning@linux.intel.com>, "Nikola Djukic"
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
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260319210722.1543776-1-joelagnelf@nvidia.com>
In-Reply-To: <20260319210722.1543776-1-joelagnelf@nvidia.com>

On Thu Mar 19, 2026 at 10:07 PM CET, Joel Fernandes wrote:
> Add a new module `kernel::interop::list` for working with C's doubly
> circular linked lists. Provide low-level iteration over list nodes.
>
> Typed iteration over actual items is provided with a `clist_create`
> macro to assist in creation of the `CList` type.
>
> Cc: Nikola Djukic <ndjukic@nvidia.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Gary Guo <gary@garyguo.net>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Applied to drm-rust-next, thanks!

    [ * Remove stray empty comment and double blank line in doctest,
      * Improve wording and fix a few typos,
      * Use markdown emphasis instead of caps,
      * Move interop/mod.rs to interop.rs.

        - Danilo ]

(I moved interop/mod.rs to interop.rs as it is the predominant variant in
throughout the tree, consistent with all other Rust core infrastructure and=
 we
concluded to follow up on this topic subsequently.)
