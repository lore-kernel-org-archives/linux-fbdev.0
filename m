Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680793816FA;
	Tue, 10 Feb 2026 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743783; cv=pass; b=aH/szPetY+A4GHF3Lrkd/XNl2uHS+hEYXIHOP3aXXFvIj4+7jPyVQaPM8UWfhsIapnITRb61XnopCZS3v9bU+j1ZsrNLDwz+Xb5q/FYY4HdBUPllfGZzTlpwmLz1ITHtVZq5XKoxIg1iGcbD2GkpZSjTteN9P1t5fwGZluKk964=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743783; c=relaxed/simple;
	bh=zSELdI3ZMpySApTCSKxcbm8f2Q19XBDVxgpRrF5SUPU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=O2icVGDe0YB5zqGEvFn3UOTheUdKpsun9cjslen8KGOwYVKIa+UF/GmB0IaWOOy3EIWGs5rkRAhuuCXnIC1AG6RMNg9SB+Fe2sqyaTQEP0FPkfDmwQDIkzIDW7HfZqvhittcnZGVVdxexZomI7XaW7S/VVcxm4qDSkvUlSHsXY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=DMMK2B2O; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="DMMK2B2O"
ARC-Seal: i=1; a=rsa-sha256; t=1770743748; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oB4nalvkcbhXErv16Lon26JqfcLOZ5ehE97TOB//5CRQ3KQtK0gQCoM42op5oq+gLlSjwDBUmkO8pgKldPM+KPUazv4ZAVR2TB5YZInJt8Rnxr2fwQlEgte1ahbPcycxtYkD4PR6d8H2HnqQRJvXlrurz3tFolD4jJmpgzSAwqo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770743748; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zSELdI3ZMpySApTCSKxcbm8f2Q19XBDVxgpRrF5SUPU=; 
	b=lDDpkILviLfO+RLG7wytd2BjFYFLeiuci2TEOH/2pk2pOyFTPMilgR1FS2MBbpKYfkbEyEEV890F6CTVbl/egUpxFA+rnMvERInW6TCtKqvsvZj4WvvGs7DFv/tfdnZQdjjo71L2AOZ1s+VEF+7t7wiM1a0D9EkHkwT+X6hpXJ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770743748;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=zSELdI3ZMpySApTCSKxcbm8f2Q19XBDVxgpRrF5SUPU=;
	b=DMMK2B2OWuhve9GdZRwnlRvNGEokHlylADfDk1zNEwhM+ss8D6Ge67KI9oVqOICN
	wiro7iMOSJBJT2R2jeDorMK/X0Z+qLvebFA+S3Sb1Ro/xlrL4MCLiynLXfm3tK5Nlxo
	3D3NLhWWc58CgZSSqIbuqZmPojmqV4B0Tca3b5UU=
Received: by mx.zohomail.com with SMTPS id 1770743746604450.9668358133772;
	Tue, 10 Feb 2026 09:15:46 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH -next v8 1/3] rust: clist: Add support to interface with C
 linked lists
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260209214246.2783990-2-joelagnelf@nvidia.com>
Date: Tue, 10 Feb 2026 14:15:23 -0300
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?utf-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Helge Deller <deller@gmx.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>,
 joel@joelfernandes.org,
 nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DC3EF8A-B660-44CC-90DD-1461B7C2DBF0@collabora.com>
References: <20260209214246.2783990-1-joelagnelf@nvidia.com>
 <20260209214246.2783990-2-joelagnelf@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Joel,

> On 9 Feb 2026, at 18:42, Joel Fernandes <joelagnelf@nvidia.com> wrote:
>=20
> Add a new module `clist` for working with C's doubly circular linked
> lists. Provide low-level iteration over list nodes.
>=20
> Typed iteration over actual items is provided with a `clist_create`
> macro to assist in creation of the `CList` type.
>=20
> Acked-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>=20


Sorry for not replying to your question on v7, I=E2=80=99ve been a bit =
sick recently.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

