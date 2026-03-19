Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF393CCFAB;
	Thu, 19 Mar 2026 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921967; cv=none; b=otWgAwmhvRsdnojugFBjEnsn+2Aq8Eg3V8c6S7UIE4226n/iQ3jHxmSOJ4qioqlWi1Re0hv1zazjXC2I43GM8eshJysu4hWwld2VkbDTAEN6QZqLKUCy7/xKYvvKR/4LKidyp764sl1T5qbYabGRLczcBAaDZ79GUdbKw38wwyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921967; c=relaxed/simple;
	bh=w8tAFXa4fIuAqR0VU1Ba5fdAovqpAbKwCfet3tjmrgc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=WVUohS7StWPbcAor109g58PUF80ycpbU70KxTnodGTkAVhm24Q0OI/5/+yOINTrm7eBc0VD0GZQWC4EDeMxdS5pko2L6+u0RsuKv4mo/8q67+JRAH0fgO+X3b5t0blWr+ZinnkcQ5iReubZvcx9bxCcJVL/XOYfXbgQWcICYDTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcAmub1F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcAmub1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA65C19424;
	Thu, 19 Mar 2026 12:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773921966;
	bh=w8tAFXa4fIuAqR0VU1Ba5fdAovqpAbKwCfet3tjmrgc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=qcAmub1FUtgRFUZTVcUSU06EeQMSdbRK16OyR119849iTD4jv4DY8mR1zyoCNGZjl
	 IPGJxXg0fRPLjBdmOYwd9w2LLEdD5Jr27LU+TqGJVn0M1K1GF1ErKVZR+Nn4gaA4y8
	 3f3dnz2SncRA5uw7BJt2oKgW8kV9RTW/vM0LzjSpvprVB364nJPPqLwdeqKo2YxbkT
	 kjaSbDu9vsWFYAuntvNF+AlS6/MQCeY0OJ5e4R8/yWoRcnZ6U5Uzm44nutkYWin4/H
	 VlUHAG8w0xZGk0PNx/hXApvwti96nXcAzzVZVweQKmeTGLzE8AzRjRgWTXcRIoLhlK
	 0BlvahEfBe7Tg==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 13:05:55 +0100
Message-Id: <DH6QUO2T941E.2S1UP7EABOP42@kernel.org>
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
In-Reply-To: <DH6QAR1HHXRV.1Y7IZ22HC9FZ3@garyguo.net>

On Thu Mar 19, 2026 at 12:39 PM CET, Gary Guo wrote:
> On Tue Mar 17, 2026 at 8:17 PM GMT, Joel Fernandes wrote:
>> Add a new module `kernel::interop::list` for working with C's doubly
>> circular linked lists. Provide low-level iteration over list nodes.
>>
>> Typed iteration over actual items is provided with a `clist_create`
>> macro to assist in creation of the `CList` type.
>>
>> Cc: Nikola Djukic <ndjukic@nvidia.com>
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
>> Acked-by: Gary Guo <gary@garyguo.net>
>> Acked-by: Miguel Ojeda <ojeda@kernel.org>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>  MAINTAINERS                 |   8 +
>>  rust/helpers/helpers.c      |   1 +
>>  rust/helpers/list.c         |  17 ++
>>  rust/kernel/interop.rs      |   9 +
>>  rust/kernel/interop/list.rs | 342 ++++++++++++++++++++++++++++++++++++
>>  rust/kernel/lib.rs          |   2 +
>>  6 files changed, 379 insertions(+)
>>  create mode 100644 rust/helpers/list.c
>>  create mode 100644 rust/kernel/interop.rs
>>  create mode 100644 rust/kernel/interop/list.rs
>>
>> +/// Create a C doubly-circular linked list interface [`CList`] from a r=
aw `list_head` pointer.
>> +///
>> +/// This macro creates a `CList<T, OFFSET>` that can iterate over items=
 of type `$rust_type`
>> +/// linked via the `$field` field in the underlying C struct `$c_type`.
>> +///
>> +/// # Arguments
>> +///
>> +/// - `$head`: Raw pointer to the sentinel `list_head` object (`*mut bi=
ndings::list_head`).
>> +/// - `$rust_type`: Each item's rust wrapper type.
>> +/// - `$c_type`: Each item's C struct type that contains the embedded `=
list_head`.
>> +/// - `$field`: The name of the `list_head` field within the C struct.
>> +///
>> +/// # Safety
>> +///
>> +/// The caller must ensure:
>> +///
>> +/// - `$head` is a valid, initialized sentinel `list_head` (e.g. via `I=
NIT_LIST_HEAD()`)
>> +///   pointing to a list that is not concurrently modified for the life=
time of the [`CList`].
>> +/// - The list contains items of type `$c_type` linked via an embedded =
`$field`.
>> +/// - `$rust_type` is `#[repr(transparent)]` over `$c_type` or has comp=
atible layout.
>> +///
>> +/// # Examples
>> +///
>> +/// Refer to the examples in the [`crate::interop::list`] module docume=
ntation.
>> +#[macro_export]
>> +macro_rules! clist_create {
>> +    (unsafe { $head:ident, $rust_type:ty, $c_type:ty, $($field:tt).+ })=
 =3D> {{
>> +        // Compile-time check that field path is a `list_head`.
>> +        // SAFETY: `p` is a valid pointer to `$c_type`.
>> +        let _: fn(*const $c_type) -> *const $crate::bindings::list_head=
 =3D
>> +            |p| unsafe { &raw const (*p).$($field).+ };
>
> Actually, this check is insufficient, you should create a reference inste=
ad
> (just in case people put this inside `repr(packed)`.
>
> This could be something like
>
>     let _ =3D |p: &$c_type| { _ =3D &p.$($field).+ }
>
> ?
>
>> +
>> +        // Calculate offset and create `CList`.
>> +        const OFFSET: usize =3D ::core::mem::offset_of!($c_type, $($fie=
ld).+);
>> +        // SAFETY: The caller of this macro is responsible for ensuring=
 safety.
>> +        unsafe { $crate::interop::list::CList::<$rust_type, OFFSET>::fr=
om_raw($head) }
>
> Given that this is unsafe, I am not sure why the macro should have unsafe
> keyword in it, rather than just being `clist_create(a, b, c, d)` and just=
 have
> user write unsafe.

Either you are proposing to not wrap unsafe code within unsafe {} within th=
e
macro, such that the user is forced to write an unsafe {} around the macro,=
 but
then they calls within the macro are not justified individually, or you pro=
pose
to let the user write an unsafe {} around the macro regardless of the inner
unsafe {} blocks, but then then the compiler warns about an unnecessary uns=
afe
and nothing forces the user to actually wrap it in unsafe {}.

Is there a third option I'm not aware of? I.e. for the above reason
impl_device_context_deref!() was designed the same way.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/rust/kernel/device.rs#n650
