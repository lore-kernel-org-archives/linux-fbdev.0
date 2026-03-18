Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98DD3CA49C
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843708; cv=pass; b=ETP6evx14Phqv+hIcHePoD7U895sGvcn5t0daYNme5jqD1dmRFEg/xBS1lOeD1UK/SM0EvfZg6bwxAgNfN4Ub6MzEwbFZXRZbyHKUsPUtXsj+o4LkUYtlXYV44Ld014zFdnl99JjuIPayvVNpc7WS9bak0ye2ED6/6SXXuY1dIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843708; c=relaxed/simple;
	bh=KTRA21nAfVjporOLqz1nEfqleKbtz+pYNCQThiLu4Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxGw51IvzcnWLnLbzbQ+VkbyHA+tftOYQo9Wvw3XhPMGWBQOgsOvqMM08nf1WlBHPgSOAGiB2NqmwMo4+v46MIZYX1MKgnUZyla3LZ7CNM7M7398wKd5RobZcF0+j02OwOz1KQ6HCX44QWzu+ZSwq+ljMvkjAPHH17DeAnSi+kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncXnZeZI; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncXnZeZI"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bd5658b901so379415eec.3
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 07:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773843706; cv=none;
        d=google.com; s=arc-20240605;
        b=B6fvOiT6CEzY4erV98ypHkFPspvKNCLmlgqubAAy9fKvjsYJiiO0pA+pnSHYAyXXni
         4B8x/Ox98bK3QbHDWthLHWP0faza+YTsYCZ5wmSGT9UmZljuTm8OljsK8TFTrsMGunEG
         nN5eQcUG7a1LTEw7yQ+aomjgTnFmZA5iCasivkDyuol6N39c5JPQVC3BsLvXnXHTI7VT
         rvplrKhCiusb/szIQkiYZegfLXkw16zKWvlQeG3cZtKEI3JFOn5mNZ6rzxJsB7DTFTSA
         avxfwLN3nzYmXsubNni58PW0nT+vpH2RWdg3f5N/3EcgMl9rCGewxOhmqIvRIzvf2qA8
         QktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N50RuEjVo0iFefZqItqTOtUCCVZJT3+xKOol5E25ZQw=;
        fh=+7rgvEULQY4hbrRm5mrkypZnJbacQMbKDjDOdvQANqI=;
        b=em4gA6/LSDqlIXZeUR2Z5X/XWJfyWYMT9yR84OIMv6V1pUef+JcN1N3wAVJGeTDWMT
         REPnwqZ+yWlo86pdXeHg85SVz9kustSaVxVS8lJApPDI9eWjdOQZ0h3D1FyNTlb5bqPy
         grgHoLc3nzxmp2a4NGGCvM8p+npNfPKnhZFX2yI5CCtOMrvODjvw/bj+IKHBSx8pt0Ot
         e3fL4hBvzCUKWMmjO7p4RKzVM7gj5SdHlWVTEvmCWvJDNwBl7hZu2NBy+BsAl5SezQUH
         WKuxZCB3W0594Y3wOMon4p/M5lI8+V46YxpTBfW7qLDg2lcC06y50coxiCgHlOsLAemy
         h5mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773843706; x=1774448506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N50RuEjVo0iFefZqItqTOtUCCVZJT3+xKOol5E25ZQw=;
        b=ncXnZeZIuOjGeXZuihtqHQjQvOfKIZP6avWEj+G04ST+7/5OoAM+9W4HrAWp2tpeCg
         qV3oZ6vSIUONar/YjrHxliQhsxbKSf++6gTYV2KDYAwQZzOMCUGbOtGkQ/M6lnz8Si35
         8cajHQ6rXnuUoFE7lWJ8eh1IQ1/C/m/4KUEtvM30T6T49ccOSw3rhnYbt7WWtvJztqGg
         xn7Jr0z1OgIglV1lijREgwEUFbNUaZmqaxtkOe9YCHFQ/TStonivbob3Xi4EZ7I40dRu
         mVfTvnoUa3XQQ/Jr1rI6LfuZlzc4c2+s5rVU8DOEKSJk0D2JdP+oTLNkFO/SoM9RK0oz
         +L+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773843706; x=1774448506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N50RuEjVo0iFefZqItqTOtUCCVZJT3+xKOol5E25ZQw=;
        b=VNQ5d12E7XMdpP0XxntWq9nSs2cke5FhKiaDfiDaO9qlNkcd65yTSWK6cIIl3KBLPR
         I0MGxLIdT8jzuDzzUV6tgFb93hi6iFw+xPR0jrKewIwIFVDU3by4OvGjH162lVGf8gxd
         JG28gEpWQcEUhApVRpEKXMWN3x9codGCnITerpUWggEz0vzn6YEzq5QwG1UG+tJrm6o8
         pWghFYHPu3uWa6h2iN/4dbXIBjIdyVLIrB6D5HJAgr/tZRZWzAlfQjOZZ4mKjDTuZnwX
         StNdfnVoP9q+ZpeTVoDl4LDSsp4MrbYSbsz0Y1vXxymgKVRqfRZ4vLF9bBrTYg1MtITE
         vCRw==
X-Forwarded-Encrypted: i=1; AJvYcCXKY78I7MaPhX3+NADD86skAeDpIU2q/XDNhcopQ/7vID3wSPQCAVMNAMHtgqnXwngVN/YlC5Sirrltvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9/7bVkC8dxiSjJoXmrhQ78S0NutN71/AEcZN/OZuQZz0WnpBM
	7Gvj6o85vii0Mm7jCeh6AM5GwOv5dSp0qNJOWdUZt44YweKg+WSDbA6kgF7vX3sZ2XSj8wkBwgk
	sTpUpxzyYLwHE7PjP8fejCYQyzVIm4D8=
X-Gm-Gg: ATEYQzzOjircsFRQ6T19D3UVCj4EIBEzJrOBecGSWKc5PMN+h7si+ixMjXxI3aZA4gp
	Wb4O9JVh/OQIA3VbY1cvmdWSi4Y5Nt13MhN6T07G05++Pr8oEOakFqOjhGhiLTHF096cJfQy/wY
	PoNb0k82COmOfXFMiYlf0EWmBvHEX4425rQpe/53QCsIEz4lqn0oaF9rC6dQwIlq54/hJqgdOz7
	5IOdNymgc9FmeXFsrvHn6xrL1jn6GHEi1270xr/SDX1eeNz/mj4qIh1Ql3hueE7dJ8KBSRCI/FK
	e4J9XqxYY5CagcbHllW1rpkkQW8ZoBnskAYO8Tw18kEyRBosBogt7L2au2oi8AtE5fSHAzs6ShU
	Pp/jerwzxBTtOilMuqGMrIBU=
X-Received: by 2002:a05:7300:3724:b0:2be:1f56:ed32 with SMTP id
 5a478bee46e88-2c0e4f79e7amr862302eec.1.1773843705849; Wed, 18 Mar 2026
 07:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com> <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
In-Reply-To: <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 15:21:33 +0100
X-Gm-Features: AaiRm52hYvm4SlfuaD_e2Ur_BKHJMunoPzi20wYq7repEoz5nN2Go3Dpr2oWwgo
Message-ID: <CANiq72=bmJ_GWKowAgv+DWQ8FcWK_HePwjaVgeDmRH+gVD-z5g@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list interface
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Koen Koning <koen.koning@linux.intel.com>, 
	Nikola Djukic <ndjukic@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 11:54=E2=80=AFAM Alexandre Courbot <acourbot@nvidia=
.com> wrote:
>
> Ah, so there is a rationale for using a `mod.rs` file after all. What
> are the project-wide guidelines re: `foo.rs` vs `foo/mod.rs`?

Quoting myself from a few years ago:

  I don't have a strong opinion either way -- this was originally done
  to improve fuzzy searching, see commit 829c2df153d7 ("rust: move `net`
  and `sync` modules to uniquely-named files") upstream:

    This is so that each file in the module has a unique name instead of th=
e
    generic `mod.rs` name. It makes it easier to open files when using fuzz=
y
    finders like `fzf` once names are unique.

Another reason was that it is what upstream Rust recommends:

  "Prior to rustc 1.30, using `mod.rs` files was the way to load a
module with nested children. It is encouraged to use the new naming
convention as it is more consistent, and avoids having many files
named mod.rs within a project."

  https://doc.rust-lang.org/reference/items/modules.html#r-items.mod.outlin=
ed.search-mod
  https://doc.rust-lang.org/edition-guide/rust-2018/path-changes.html#no-mo=
re-modrs

Now, several other people have argued for the other way over the years.

For instance, one reason is that tab completion can be smoother with
`mod.rs`, e.g. every time you complete something like
`rust/kernel/sync`, you have to decide whether you want `sync.rs` or
`sync/`, and then if you wanted the folder, you have to tab-complete
again.

So I guess it depends if you use more the shell TAB (like Linus really
values on the C folders) or the fuzzy finder (like Wedson argued for
in the commit referenced above).

I personally don't want to bias it one way or the other [*], but
please let's avoid having both mixed if possible (unless there is a
reason not to). I can put the result in the new guidelines rules list
file.

I hope that gives some context!

[*] I would have preferred a middle ground like  modules being inside
but repeating the folder name, e.g. `.../pci/pci.rs`, but I doubt that
will ever be supported upstream since one probably wants to support
the other ways at the same time.

Cheers,
Miguel
