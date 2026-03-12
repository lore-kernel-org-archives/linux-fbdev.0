Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9A7317170
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Mar 2026 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342975; cv=pass; b=UnPfyivZ/pC7RWGmjcFGphNy6Rz7A2EmWlrotck6ZJOkOv8JvA9iDLVGJL/Hh1Qi7AXs6G441vpXykxIt7EK7hCzElXKG7dWBKtBFBYhN6PiJwh3pIShqqcOsDUyNGQgnjzsOd5CJ0ZUHIWmAhsH2Ms4nsIkZ1G7vPr5UG1xlTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342975; c=relaxed/simple;
	bh=vJ49uuB8mdFiJb29JSb7GIkPU0l6yrugoKSfMVQPGJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NytW4aqqDf+jdKgdtPyqKbXb8g58PW7hIYQ4FIZq4i/m7OSoHYFUcAwEwYrBfrfk6FME4uN61MeTeHwsxuj+wAhAfpIv0vAnMRmoa3wG5udl30wXOjEvhNr0zjQtkChrKT1ZiL7ZOS9ilydhogWT6AiznSVniu9+/n8rgWaBhv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU7iwzPG; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU7iwzPG"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12734af2cdcso83838c88.0
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Mar 2026 12:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773342973; cv=none;
        d=google.com; s=arc-20240605;
        b=BQ8LG20nDuvEB3lnCeE3iQ9z+TYH0uFo+492pwA9ZcoEurkPeGvvCrlKY7It83K7Fw
         cNBsdXpCljLcST4WKcFmyyckMRRtJBsg5xY4s1Fg6VIWg1FZRR0x88vVoh5PvXqFv+10
         TJl77hbgCsaHwx8NykRoe84Ot17gdx6jfzC5AfwTZwOMD3oDUuADIdBYI+2gIBAbgYZI
         twppuARoR2h53Dx5abhafuCZi0qn947o0yh5m3AqVy6zq66QbX+Synq4LfoP1uYxBxxr
         +jFbGswwEZgpsFCVXQeZaNHsmD+Ywg2Ror9TRv3o34PAPI8BKBJtEZkOQAn/4FrQeWBa
         0Dbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2hzSysAOGotLHY/Gk0vtKsQ07bdjUjpPdIHGXWzs09g=;
        fh=KizpM86xUitjQGF81yillBm4vg5zdmNpxlxC+I6PT2U=;
        b=OE4XYdjd2brIJ6I3dixYskxPtzuhHWDCnW6jNVnOnc/pC0Z1dv8u+VE6oPI6/DZcr/
         dxbN5wYsoC5MOTtKGlV+zkdgZn9qzNKpLg/0BHtUid5xj+R7XZYPvWeUdp76cRQ6sCnD
         ouZW0X6vO5VB0YH5GrheqwXIvlEBXJYYcraVr4qLFXlWX5/Ir5nPak4grWOk80A4v0Zu
         brtZ6uo4Z5gMhKKajTEJl8xsVkPfjhnHhBVJjvOQdxsnoq28eQ7zH6Z9UV2QKclggVMq
         mQihAGw6yhaDcnT3qpAEM82P7eDq3I5Bu2PdP5V1NlNVSy4Mu3Qzw35IdIKoasUPXUAe
         actA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773342973; x=1773947773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hzSysAOGotLHY/Gk0vtKsQ07bdjUjpPdIHGXWzs09g=;
        b=FU7iwzPGYPyu9TatfgBruyqZEiZA017XxvOIi6d/Ic9lbcdIrWNMsivMRYl62Bk03M
         CqUvkZaS2Zp9net2lvIhL7d53139F5L4AduvPYr+LpGvXNaZOCTawLGFXBhy511Gktij
         o7Ptt0oQs2AV6oMTmUdCLylZkO4xDO5x3zCCbTktgY6882k+CCukgV+KyFiDvvePKIwR
         5yh+tVDvMYWQqahp1wCAwYIzdbyaic3U6N2du/uBBkfBGvwaF9mva/+zIgnHHeUz31op
         Snd1sPjT39dbkrf+6ucXc8JY/WuO3Ix3bH7ebjq9Kww17IVAuu3LWoxAbGg0a9r1VQsD
         Lr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773342973; x=1773947773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2hzSysAOGotLHY/Gk0vtKsQ07bdjUjpPdIHGXWzs09g=;
        b=iBWQYG1UFYCnXdxSM25C3icP72LZ2xZD/3hE9PmzE78mxssX5EZ9ru3Ufu8W6sA4ni
         HVW1MjxmblDYDt39SV8glkh72386zaAONocVtOmmdl0gdXEwaDu2pqfSzYzModZXzxuZ
         PWydF7XjCO4FBtOiOonFtZoCWUNbjDNghqJ2BP2JUG6FxPsu+xX3JWcUs3m2uQNeTDNY
         NipFw7BqnbEJb+h4OYa2QD7DF5mXGwAELQlAaXwZtSJcyh7WY+VgloIhIlvmgukD1wEA
         Pey8nbWjBjbo4dk7Sj4OSNbRNv4jCQacU1+B3w/P1C/5Nl0UpA4Yn3Pp62bmXsvNscVI
         sl4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmcxQbix0S3xWLm7VZxJrOPKkNo9N7HT/Tl5t1an6IC4fE4vz2qK8rpCLrAxiZxEimAulrpE53Ujt6sA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Y7vVyhZ7khDrakoQWPA1yGo/QNN03TgmAgJywS+WeHiNnpY4
	Bc2eoBmKwOOuhxSyW2+DRXlWD68Cb4cXf1Hd3bRkYrHsIlpcL9MvrRUEGQMq/Gpgyp4ua21UlF1
	whf0rt/loFCe+9XB3jz3FIyEHHv8S/Kk=
X-Gm-Gg: ATEYQzwVx13UXdZSiRL1w3ZWrf9zA4soC+07ZowcseRonSBaHljD9g9BvytIyK1pwqh
	XuQUXvdiuHNMLP4WWbC0uwc+LhDhzRrHuImnUR7EDW0nQTEaV1yxH6APenR1DZWl1hQw8VyJOq1
	2ZShFhvqkcApFCuXeT7uO7r3K5mPI9cT+SsMEolvWYunOtziu8Qyz7z6AK9laWzxHTpTpW/4Mhs
	FZVS6pUMXpdPJ+4x/5yl/uO9+IhdmIc7xzcDi34qyCN3mfsAH7fWf9G+GNg+7+f85n1OgMNUbSg
	mfHuKFZGQ4QlQxnLmMssaCujsnxH76YykWVuHpa6XSe7zDdFVv+EP69tKI163kJg/0a4eMgRCz5
	sj31tUW9snSIhHzsFOc+dZY4=
X-Received: by 2002:a05:7300:fd03:b0:2be:171c:2177 with SMTP id
 5a478bee46e88-2bea5744a60mr186533eec.7.1773342973060; Thu, 12 Mar 2026
 12:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306203648.1136554-1-joelagnelf@nvidia.com> <20260306203648.1136554-2-joelagnelf@nvidia.com>
In-Reply-To: <20260306203648.1136554-2-joelagnelf@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Mar 2026 20:16:00 +0100
X-Gm-Features: AaiRm537cVQtFBzSwOEaMgXdjzYeE0uMIzdX3f2cfwXX8kFS15LK67mGvYzfQo0
Message-ID: <CANiq72m2Eo1UAuwMC0LhiD4+yqKixRm=+oHtEnpwY-VbNdR+fw@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] rust: interop: Add list module for C linked list interface
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Dave Airlie <airlied@redhat.com>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Koen Koning <koen.koning@linux.intel.com>, 
	Nikola Djukic <ndjukic@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, 
	Philipp Stanner <phasta@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Helge Deller <deller@gmx.de>, John Hubbard <jhubbard@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>, 
	Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
	Balbir Singh <balbirs@nvidia.com>, alexeyi@nvidia.com, 
	Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 9:37=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.co=
m> wrote:
>
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

> +//! # // SAFETY: head and all the items are test objects allocated in th=
is scope.

`head`

> +//! // Rust wrapper for the C struct.

Empty newline comment between these:

  //! //

Actually, should this be `//! ///`?

> +//! // The list item struct in this example is defined in C code as:
> +//! //   struct SampleItemC {
> +//! //       int value;
> +//! //       struct list_head link;
> +//! //   };
> +//! //

Let's try to use the usual style, i.e. no empty newline at the end of
docs for an item.

And the example should be in a proper code block with a C tag, so all
together something like:

    //! /// Rust wrapper for the C struct.
    //! ///
    //! /// The list item struct in this example is defined in C code as:
    //! ///
    //! /// ```c
    //! /// struct SampleItemC {
    //! ///     int value;
    //! ///     struct list_head link;
    //! /// };
    //! /// ```

> +//!         // SAFETY: [`Item`] has same layout as [`SampleItemC`].

No need for intra-doc links in comments (for now at least).

> +//! // Create typed [`CList`] from sentinel head.

Empty newline comment.

> +//! // SAFETY: head is valid and initialized, items are `SampleItemC` wi=
th

`head`

However, this is giving me a Clippy issue (please see the other email).

> +///   `next`/`prev` pointers are valid and non-NULL.

We started using `NULL` recently as a convention for the null pointer.

> +        // - [`CListHead`] has same layout as `list_head`.

Intra-doc link not needed.

> +        // - `ptr` is valid and unmodified for 'a per caller guarantees.

`'a`

> +        // SAFETY: self.as_raw() is valid per type invariants.

`self.as_raw()`

> +/// perform conversion of returned [`CListHead`] to an item (using `cont=
ainer_of` macro or similar).

Intra-doc link to `container_of`?

> +        // - [`CList`] has same layout as [`CListHead`] due to repr(tran=
sparent).

Intra-doc link not needed.

> +        // Convert to item using OFFSET.

`OFFSET`

Newline comment after this one.

> +/// Create a C doubly-circular linked list interface `CList` from a raw =
`list_head` pointer.

[`CList`]

> +///   pointing to a list that is not concurrently modified for the lifet=
ime of the `CList`.

[`CList`]

> +/// Refer to the examples in this module's documentation.

Perhaps we could have an intra-doc link here to the module.

> +        // Compile-time check that field path is a list_head.

`list_head`

Cheers,
Miguel
