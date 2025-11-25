Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5927C275AFB
	for <linux-fbdev@vger.kernel.org>; Tue, 25 Nov 2025 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056970; cv=none; b=WndXVu5IQixPA7HeP7mL78shtVK+rrXcKR46+9jE7VCINIUfe/2SpCPR7P4Lq1iefHwdZUml/1gw5inuc42bs3QcaeCETpEnCfpUZNs5h+7cz6rSLUZo9fFdGFeMOb9fmOgq9NcOYQyTkXmJYV1Nq86I6rXCTuey+Kqn4hGAmpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056970; c=relaxed/simple;
	bh=dYXQ1uyTYiQp5l0EOSTj3X1iUi+LYOARqqBvPXETpmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ee3w2qlfrD8vozMZXdIciQiNShz8f5OniluJnQHgUknzjxmt86J23peNw6oQsMcLBRoka8Ep0AH6yOcUEOzphssj/Z6rtdgCQ3kLywpVN4EqoLhKDTjmMDu26U0XL93Q43SpacAM1ODn/B1d0jmLZGU8efIr4v3/Rsbx+CH6SUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFxEq6mF; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFxEq6mF"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b25dd7ab33so353240885a.1
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Nov 2025 23:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764056968; x=1764661768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYXQ1uyTYiQp5l0EOSTj3X1iUi+LYOARqqBvPXETpmQ=;
        b=XFxEq6mF+ReEMyfAdIoLDgqQ/y7LR9X6wnP5orAxuJvpI8jx82tdB0uYGbCtYSUNrB
         yr1Bh/0G4pi1hDzrtL6yZpbw0ajwzjJM0DnE6Oi9lHJ5HizKQ8216ITWyVJm0Lsve7DK
         9gwhjEsIhbYzGiUXarNDQ0HMzWitIy/2C8MdwLpp43EKFcLB9IslisCE5+CvPnWApFo7
         chjznelgNCrhbpu7E8lfeH0LYZTNh+qmEnD5VlLGDPaHhjTjgnt/pIaEU5D1D+KmJ/AJ
         QIn5nOZGvVgmbzCcgLgiQEQ7WX3fCrSqbZKUQPoGw5t+pjIE/2Z6yu1fqwEMD+cJ8TAj
         6omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764056968; x=1764661768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dYXQ1uyTYiQp5l0EOSTj3X1iUi+LYOARqqBvPXETpmQ=;
        b=MYmFr31tW6elzBzj1fCxNRYhPcZeM5CBPctI/87R2WSXLsQRON7ri5vtANbcC4gjK2
         QBqooDN428ZN4rgVbRyjq9XpI6LHS9onLd1WodAoeJ5O2Bb7v8vIVS7p3nuRs9cz3vB8
         az1zGQMDvCKplnxJBsRBKGqKPFVrkoCcMxSwzGE9qEDYk7ERKkMHqodhqiYxC/qI63Zk
         7Bl95qosaoMNWVp6r41ZnTRmtwW1Tmmo67rKJQaw4fSVTsWbcJEhjtagHPpcv1z/kYPz
         t/r+n3wfDTHo/xRY3YTJ56H8+S2reZJgJl4x47OBd9WJC/qx7bFNulte48pPr9oyGxNc
         2rCw==
X-Forwarded-Encrypted: i=1; AJvYcCWPDrGXwDxMY/I/uqzGAT/pTiq0v7ZjdmGypc9h/UWaGsyijKZ1SFsKWIpiy7XVbVI/dKV3nMNy8O/1Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAWlydyq7fAoXNkFrK63Hzcyt7U4qXIezGH16FHduxyeeFgq8D
	YLhvX5HHiFXjTC301WcmBUlHkNMJNgv3hCn69D/vrXEekFISjskYAHMQTGjzGZoEq1xItZl5EMf
	kj+Bxk4E+GrN4FigMS5USPd3EJBsjlzI=
X-Gm-Gg: ASbGncsFSziQTXUnzU2RS8lXb6p/Ed8LS8rk8h1wkx9tGK4IQV0HS+iqyoWV8UetSAi
	thBMkkcCfyNX2HFVS5ZfTspDx5PlPMmddhvrKBXuAUyQuACKKQhbdr+q8Mh34yuUkLyftwjxoCG
	f+3sXjmrzGud7V3C8hSyD1zhFepf/jf1vgOC3GBw+mfj5Ezs5HZdGldiSYLXZOXpGkAe0i7/Fdw
	bzlrd/DHjMU2fDWR/Owi4KjTuh3UsVfgUFDi+M1zzI1vkIPu7LaPC2gu59F4HMOYg6nlQ==
X-Google-Smtp-Source: AGHT+IEtXPDouByPiT/qxibkQ8ULLGq/MTP3sJn0d1xkeYQ9cq7USFxzR7YMrVKLhlsOLhXx4WZEKVrsh8lyXL+gyvM=
X-Received: by 2002:a05:620a:708a:b0:8b2:6ac5:bce1 with SMTP id
 af79cd13be357-8b4ebd9ec27mr242566785a.52.1764056968048; Mon, 24 Nov 2025
 23:49:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124234432.1988476-1-joelagnelf@nvidia.com> <f73e4536-ec89-4625-96d4-6fa42018e4e4@amd.com>
In-Reply-To: <f73e4536-ec89-4625-96d4-6fa42018e4e4@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 25 Nov 2025 17:49:16 +1000
X-Gm-Features: AWmQ_bnwzbjWb8lRQT1DDgpaZ85N7NFNJhUwspjg107_d0wU8nUTSe73G0Ayj_8
Message-ID: <CAPM=9twe3xcVBgrNCT+1_pGECPL-ry_aA2dxBwbKVeai4+S7AQ@mail.gmail.com>
Subject: Re: [PATCH] gpu: Move DRM buddy allocator one level up
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Alex Deucher <alexander.deucher@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
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
	Alexandre Courbot <acourbot@nvidia.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Nov 2025 at 17:45, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 11/25/25 00:44, Joel Fernandes wrote:
> > Move the DRM buddy allocator one level up so that it can be used by GPU
> > drivers (example, nova-core) that have usecases other than DRM (such as
> > VFIO vGPU support). Modify the API, structures and Kconfigs to use
> > "gpu_buddy" terminology. Adapt the drivers and tests to use the new API=
.
> >
> > The commit cannot be split due to bissectability, however no functional
> > change is intended. Verified by running K-UNIT tests and build tested
> > various configurations.
>
> Well such a change needs to be part of the patch set which actually start=
s to use it outside of drivers/gpu/drm.

I'm not sure it really makes sense yet to force that for this, since
the next patch would be just adding rust bindings to it, then a patch
to nova-core would be needed to use it, I'd rather not merge something
like this via the rust or nova trees as it breaks the principle of
least surprise.

Maybe this + rust bindings might be enough to justify it, but it
should be reviewable as a standalone idea.

Dave.
