Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389C2C181
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Mar 2026 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774224501; cv=pass; b=Qj3vPTVNUVfibVytslGUnf8F0vcBbRvPV1ETf3Cd5zI4PjQ160mSDLAReBOXNwSQC1XZrBFzbZEbPbXVr7/MvruDXg+WJzOompKrFSRx8dW1HCWrH+2kvdUmlTpwcNWWHodF0wsCJrxNSi4XYbh1e1G4IZ3iy+cc55DnwQFkeUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774224501; c=relaxed/simple;
	bh=+To22M9XrloAsp8zyktj8aS2Z2Pum4SQehyzZWues4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kytRTRKMvnk/V+ae6C1sPpdZLWP+oWpvdikcIYc7YpMeAspK3a6uZOyumtbTuAdSlFn56fT9gnZcG8tBGt9UXsSP83p564x7mIm6ttLDNxqGP+bbCVwoE+Ixs36UjZ7RwF9rVu3d+rXN6iArE2d5N+kbJBFp6SX/i6t71eoS/8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHMkk+0D; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHMkk+0D"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79628fb5c05so26853547b3.2
        for <linux-fbdev@vger.kernel.org>; Sun, 22 Mar 2026 17:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774224499; cv=none;
        d=google.com; s=arc-20240605;
        b=Ws7Q9M7h8ePXhswCY8QKkjt5bGjBIQ1zQdjd2nSnXRW/r7hFu9YrQixgf9yJ2f8sfi
         MKlvaNyFNC6EMjzCmRmNtpIuhZTrMrF+qfORTVah0j92F1OoMGZk3eAGqhTgI9fiimwa
         h8IsSZOA9paoGWjxQLMVDuD8jiS+Tp2lnfRTD4g/15Ln56fkZCr4IAPt6St/b4Rc5S9B
         dNdyQSR3asQCOoK/OrPwFnF5BmV//Xkq1zhQj4ObAES4V+SRP0tcE55P9PEME24nMNbf
         LE4cqxoC5wxvNO3I986ZuvAVs5oK1XsdX8FFH5rS0oaPNmJROnaBrGDlM19TRAMQCjQx
         iz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+To22M9XrloAsp8zyktj8aS2Z2Pum4SQehyzZWues4c=;
        fh=pNnnNi6JYc+6Ci3yx31KP4UFnpGoLkgoEECeb4ipUi8=;
        b=fUFM69MGiOLHPJeCpxD8cSRFqbCiLDrEYSyH9kAcek/5/ir/51xS/LwUCcDisgYEZo
         t4+6AnaUsMmRIhsNRct9ExlsvOhvcUeVJcH5kXTABzNS1hppe6jiy4V1bc67UUuNujz3
         6buWUNDftfjQIfmWGMTRo1t0qigyOI/ClWWeaGcQF6CILQcFF3Dfd8MpQgvwa9stP2nS
         VqfEehMDjB2C3mUwv2UAEvhNpprbk6Ugaam+JfJ2VeuVJjH3ZhRyt/SV8UsszFAjO50K
         K28shhDnZ2RFB+y2fQOIy8UycwvvA76QM2JhFWlyyu19OoWAKOcCBgLI63+lpMCEUrZO
         bWAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774224499; x=1774829299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+To22M9XrloAsp8zyktj8aS2Z2Pum4SQehyzZWues4c=;
        b=QHMkk+0DtvEFkBJdEo8/vhY7E+upRvKFtFZjNpYcESVymU+JS4fnyuLXhTUibIaG2f
         Yy8eHiWBKV8KEhhDsBBfXpZsSjjpOmFTP6wLfmrMfSGgLXGQtzWOd9ksbEKGExFj7TAw
         yHVUrA+aJ7/TsuG3KMfZ4kDdGmhqhyrR0FDF6L+7CD2ySJgKmcckK7OaT4+hFDuZFKL4
         VlSLRA94IC7becUdDRn944mW5fA7DucyWuqxrgilxlZg7M9YpBAbJ+moJuiizJnZgu91
         S8y+Ly9yMuTPlK5VBKsaQzY0efYcDJ+44UVwIFIwU2vV4UqtFfZ33+kpzg0maAkPaauG
         rDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774224499; x=1774829299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+To22M9XrloAsp8zyktj8aS2Z2Pum4SQehyzZWues4c=;
        b=A6ka4wJ0q8vuT5itIz2M+cwW6IlobHWSiEmfgwcGlrIDhcC6jlOQjBrBE+VIVVPtiN
         hQrpg6RnSaOwGtOafgC68yP0hYyOCLH30BvvFQ0DI2Wr2WvwIro20KtNXPU+hD4gO38n
         0QwZuXb6dDT2l6+aDzrrruidiLe028aR6/IK2upbj0RcIyMeSHFkYLKUBwWFdL5ILrlC
         m1bJvHr729bROcWC0nYgwFQ3Do1igPTFOJfCPUPHC2t4cb3P6JnVOu3IRNn5os29jG91
         DXoX5acqIvkmB4OzTwP9LYCXkjHWzruWlegKa3APuHqdLHTzDlm8BK7o850icucIwHR3
         /1+g==
X-Forwarded-Encrypted: i=1; AJvYcCWFNVAkZi74ScYTpsI0trKvuztSPmca7aQSb5ehvLRruu45uuWxZPKMiUWf6eThTx4F8GsuCehHLePI2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrDJt5FhFR3Y41xdsnEH2etHPx0PbQ4ncNDdhkiIQqYHN7Bibj
	g/iHdOmaV+r209Gzrm8K2+Ak4AF2crLjtg+uBdZ6rn1ACT9P3++ZNycnqqX5doDMDU18i1dWG2V
	GLZ0kCQmCboSIJ9uwGlSRqMdUlaBB2oM=
X-Gm-Gg: ATEYQzw5bR7iwUmZ06eMwgZYcu6PtCuOvnd8I262fkwerJGAaEPGBpMJtSeptSxnfSY
	/xYIq7p4u+Z7Dz6Fr/BH0VdV/LWBuoi5heLs4TZfUZY4q8tH/pArjbr4ZcVuxeMS/lzLOBSDDwA
	US96DtBvUcN1jG355785dlYm0Bc9dSL/7cbYdxWZ4HiX3R1av5lK6xYyYHA+0jXqbVFZGlrPDpn
	UxdfsAgjSnk8s9vEAV2hl9B98B2NyG635u0pzETQ0E4D0XL5Dlt2TxreTDwGejPLAXfTfoEjJU1
	Gp+KG75NP1Xg950sYn4luRbug6Jpn6JZzqEU235kLeOkyYx9
X-Received: by 2002:a05:690c:4424:b0:798:6f13:2419 with SMTP id
 00721157ae682-79a90bce798mr96296727b3.37.1774224499042; Sun, 22 Mar 2026
 17:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com> <abqdUBqchnVFo7Qk@google.com>
 <71b6a115-98f1-4b09-9c04-a99349f51e49@nvidia.com> <CANiq72nZKx7pw_rZK2mHHvR=TaeGvMRvg5GTHOd58X17oyxieg@mail.gmail.com>
In-Reply-To: <CANiq72nZKx7pw_rZK2mHHvR=TaeGvMRvg5GTHOd58X17oyxieg@mail.gmail.com>
From: =?UTF-8?Q?Alejandra_Gonz=C3=A1lez?= <blyxyas@gmail.com>
Date: Mon, 23 Mar 2026 01:07:43 +0100
X-Gm-Features: AQROBzBsI6copsViR8GCb5s4kn_1rinKOMbl-9Inr9UPp4mS88b9cJGUv5vqwNA
Message-ID: <CAGeanHfNwP6Zs3LSfc9eEO7_LG0kK-jO24oUd7BjxrQbndEmNw@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list interface
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@gmail.com>, 
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
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 7:57=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Mar 18, 2026 at 7:31=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia=
.com> wrote:
> >
> > Anyway, the fix is simple, just need to do // SAFETY*: as Miguel sugges=
ts
> > here, instead of // SAFETY:
> > https://lore.kernel.org/all/CANiq72kEnDyUpnWMZmheJytjioeiJUK_C-yQJk77dP=
id89LExw@mail.gmail.com/
>
> So, to clarify, I suggested it as a temporary thing we could do if we
> want to use that "fake `unsafe` block in macro matcher" pattern more
> and more.
>
> i.e. if we plan to use the pattern more, then I am happy to ask
> upstream if it would make sense for Clippy to recognize it (or perhaps
> it is just a false negative instead of a false positive, given
> `impl_device_context_deref`), so that we don't need a hacked safety
> tag (Cc'ing Alejandra).

The team is a bit hesitant on adding comment-specific syntax apart
from the widely used (and already on clippy) `// SAFETY` comments.

I'm pushing for some more comments specific to the Rust4Linux project,
because we already tailor some lints for specific projects (such as the
Safety Critical Rust Consortium), but adding more than new types of
comments is a bit much.

On this specific lint emission, I'll see if I can get it fixed,
because it's a false
positive.

Cheers,
Alejandra.
