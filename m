Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0444E24EA90
	for <linux-fbdev@vger.kernel.org>; Fri,  6 Feb 2026 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342539; cv=pass; b=pqCuiw1DDeY40E2wDt9AxbRuoOIEGi1doKzr4bxUFysFQsIn2JqpL0o/OZB4+E+6GsBapyfpdP4dk5oJGse+rAAgajobBvgFjgCzqI7+KSMb9qfQGGTYDJErxDzwsvzpXmIg004zSyMb1ewKIyZqFomoj3SHMDzj38LTwWH/FNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342539; c=relaxed/simple;
	bh=qp2Y2OYYUKPukWWko+9fCBsOvav98ZHz2x3RlIJSAHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkIvvNHFyC8kFAQTvf7ULw1LuoUdL/W3NW2E/BxcBMjiCLhDLy5T3h0vGrWuKBIw60bviwOUyBfGOMFTu+GmtE+yMmBElGvEemT6c9yRqebj19jzNo4Pxt07JvbdvFxOIs1UajEn4CXqO9D3YXoNKGBiJJlMxpI8x9kkXPyTocQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSO+dHb8; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSO+dHb8"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c533228383so90115585a.3
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Feb 2026 17:48:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770342538; cv=none;
        d=google.com; s=arc-20240605;
        b=IvzT6nXqMrCNqwRXGXcqxEmvW/EHxuy+vCgrrMuPPbQWHV94k09w2/jNH0LqYPk4j1
         G+JCpR1xpzapu9vAso1M7JIn+pwleZC/7MljW8XqS7MTUGtoe57tRnUbfqjA1hz4imoS
         31btZY7vRPy8BOGXnEInDLzuHLkmfYaj1Rx13QTJ0La+TD8zcdh8W2GAB4fw4X5T6ypZ
         SQkApsb/QYmwQasOqc8mL0Rrg9Hy3EZQ1CEU/drs9wacMSRqbzmWX+iHOlbg0bQYm+Zx
         NSOW3m4akzc9JQRJX52Ekhck0Bal0hhaV/fsK1uwUfM8XCZW0LHAYyONd5qZhkksX0b6
         CYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qp2Y2OYYUKPukWWko+9fCBsOvav98ZHz2x3RlIJSAHU=;
        fh=BjVeNz3suOvce4l0n9Zad42ph7J0qSZ5AwJQj7/18UY=;
        b=FGnatuvL2K10qG63Ja9UAky9I1Q/LO/gLn3qra1djULVQEvEwbFZhPFezibU6P5quI
         dB7pwiNvBAtVnUQcUfZBfb1aD8xX0Zq5ZULil6hJQmZ2Qs/fbWQfy0g+cqBsA8VbJx9H
         CsBodzkmCnNe6HBYvORgrPVnVdXGZ9Pxm7H0H0NBBxIgzeumZDPHnEqpuog4X0r7t9jo
         QgFANFnqW5wyBrpip9QCQ1TfbQN/X/ez6Jg5NdwXvWGr63717HdkEq4j4aoGOJi0m8rX
         zz7fN2Y/hOnqm5G1PbugzpdSjU1ex/SpN8uCWdsODbms9GJdKYxkLm5b4wbeDzxM8FQp
         RzwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770342538; x=1770947338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qp2Y2OYYUKPukWWko+9fCBsOvav98ZHz2x3RlIJSAHU=;
        b=RSO+dHb8hCYS8eQGF6mFZ5GtOIutzXtL22MzW5vs+SkWw7e72WLP2HFwGWY5ftbyHo
         fHvxfrkmd9G+vmmgohs10bl9oxvYPwOmBlFJlBDSSWJGac24T/sfBEqlStR71XVuDgpD
         4S27igf8upM7T1TXzzQM39mlwg2FWLO7yfXDjQoJbaqnaGGSesYbvET32p5Dr/bhhFxx
         Z/FZhNn86RiWtq8HzwMySL/CSnhkI38m/01DoOpOT8ShMAxlYKk6rxYIDZKx95q0Qixw
         gdsW8qIvDZQkMga2c3+H5gqxwrieC1rS7lWWHd71hjTuzHmhaF7jbzxTJTRAu5FLN37K
         1ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770342538; x=1770947338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qp2Y2OYYUKPukWWko+9fCBsOvav98ZHz2x3RlIJSAHU=;
        b=ZdP/+1VmxkAcghiKGoRlBYVut8/UHvqyQcCenkyCw4LGZ98CSO9VqCRuEL81nec4xT
         ujWoM61VEAnMH+TGzzf78GzKDQo1x/PJvFf7JdkSATtOlIgIaCGbuIHrxBmkjh6qN+P+
         n1fFTbUEnjMkwVkddfrpZNanm21OIRNC35DfElylVmUbOdUrozLVusqTBHWEdM384iux
         y5GpcsvWA2W2sWHYUSdHgRIz8mJZSQ6A1y67saFwCMMto8egJq7lpme99UYSzjO+/plj
         Oyl+03GcSUnu1wzpnXEkCnkPIPva7Hkn31+aWZgmPB9/3YalOzE57uYulxHrSerhztX4
         TIUg==
X-Forwarded-Encrypted: i=1; AJvYcCXPuXArR8K+bigRfLPu2PV4Ff9cwJ40WiM2XpG5gFgIMZYizM7MPgXnZFd5XvGk9f/pIYUiHpp25sjetg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsEzJBddRnSHoTQt6UPC6CpvM/ROXcLxHHL710S7MTpX/X8+N2
	Lcu+EGsueMkomTlGi0b5GacumsYfBNitkWSuKu8HNeDZmKrSo5OO6o0B2O7z6Vow4+M6jSHJDro
	9Q4BDK5i7ag+ZoRwr2q1tK4E4pfA6MfM=
X-Gm-Gg: AZuq6aJoLFb77SkHV079M8QvNh21rlefm3WuCJA6P3D5YXtyYjUtUk5TVzntDvLLs3t
	s4F9XTjoRmGwjGZm8McShNW5wpxyQqHs6diqE9JTB6xyR8CZPJRvNR6/T7hM5l8vhUlUCDPhnM0
	TMmim5gIcv/6YoN12V+OdTm6D3z2VZqsj/F3u4/BTPmKJUdNBnW+Gxre6fmJsfKb4ZP15Dy17Aw
	nDPmKxQObz3V35T7YKU5A/tyMiargeDeCXtvZCnCr03rbOy9lUwDmVsHe7jdSFcMW1DXu4ZDago
	jZ1GIkkaSRYuMUVzZr1uGH7v4FoXIfGMglPDP0KwI7s8QieVvM4JkcY=
X-Received: by 2002:a05:620a:470d:b0:8ca:123e:8194 with SMTP id
 af79cd13be357-8caef409c65mr147454885a.33.1770342537850; Thu, 05 Feb 2026
 17:48:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206003451.1914130-1-joelagnelf@nvidia.com> <06ff773a-06bf-4d60-bd0a-75a0359ce41c@nvidia.com>
In-Reply-To: <06ff773a-06bf-4d60-bd0a-75a0359ce41c@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 6 Feb 2026 11:48:46 +1000
X-Gm-Features: AZwV_QiCn6zHej5_Mme9jV7jp01t4GcOY8De2NKm9jmAO6FZQzlBgU_JLG2YX-I
Message-ID: <CAPM=9tw=jzQxGvVrsUSv14RxQtnaw2rH6K2b3Gxh_UUHnOGTkA@mail.gmail.com>
Subject: Re: [PATCH -next] gpu: Move DRM buddy allocator one level up
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Helge Deller <deller@gmx.de>, Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, John Hubbard <jhubbard@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>, 
	Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Alexey Ivanov <alexeyi@nvidia.com>, 
	Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Daniel Almeida <daniel.almeida@collabora.com>, 
	joel@joelfernandes.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Feb 2026 at 11:06, Joel Fernandes <joelagnelf@nvidia.com> wrote:
>
>
>
> On 2/5/2026 7:34 PM, Joel Fernandes wrote:
> > Move the DRM buddy allocator one level up so that it can be used by GPU
> > drivers (example, nova-core) that have usecases other than DRM (such as
> > VFIO vGPU support). Modify the API, structures and Kconfigs to use
> > "gpu_buddy" terminology. Adapt the drivers and tests to use the new API.
> >
> > The commit cannot be split due to bisectability, however no functional
> > change is intended. Verified by running K-UNIT tests and build tested
> > various configurations.
> >
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>
> I forgot to add Dave Airlie's review tag here from his other email. When you
> apply, could you add it?
>
> Or, let me know if I should resend it. Thanks.
>

This one was a bit messy, so I've taken this into drm-misc-next now,
it doesn't quite end up in the same places as yours, but it looks the
same, and I updated MAINTAINERS at the end.

Now you can just care about the rust side of it.

Regards,
Dave.
