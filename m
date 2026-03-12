Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7D1F2B88
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Mar 2026 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342947; cv=pass; b=Si7XAx9G5za0O/KieY/uiInbRPikiyvlW+zWhwgEwg2Jq25br9K+Pitlv9766qoayXtKsRU9utd/UldZaiRxqPDRR2IOpqVAwMlV/KZ9XfnyHgoifHkV/YuAzOSKh03GFAPxRDBxkc7so1Q2HfgWFqAXEblieaXVY0qR55dFIJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342947; c=relaxed/simple;
	bh=4VzEC4HlHoK4vh0lvr6EYPz1Eqp/YdbOqaCW1vewwOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US8W4TTNegzdz6hUdrDM3JCAT+9LN1kwSZVVcOMtlofFVfZWf4lW7wEcHF052DRT8La/XweGunYTKyIWpXYVJv8kBq5owSdDCkHcVDlaVFeRuaoIK+XMfdFi0JaQOcCFw/+lland+M2kX2Je9dNd0PJ15MbTIDo9CqjCmexu2ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mds+JwZA; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mds+JwZA"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-128bae6a35aso94016c88.1
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Mar 2026 12:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773342946; cv=none;
        d=google.com; s=arc-20240605;
        b=CU0Y8JrhP5H6u5r0lg5GyBwtXD32MtGg3IdWsm0RllKfYrwUcLZibgwYuF/naRRu7V
         knb24ZSxw4eXy6AAoSmqpHdMQ5/Qi2WGwcBaZiIsWYrRXjR7DUPSVG5yDDOxfu+LGou1
         2HnGcyXgbpfto5Z5mAE5oTujzQEgMRnmaTu/RQyVUjMS3gi+BtKyzm3mmSYPsMlXwj0+
         Idt38mZjYoh9vcMfpsdcsoVMyRxyp62BluhjALwatE7P2skOd8CihuOMT+C/k3QU0Qyr
         obzGDKJkdBqFyyzoB7gQ/8x44Piv4gvM2MWLzZNAFyhrdyOZIF/Mn3tqjeg0uOM6v6U0
         6CMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4VzEC4HlHoK4vh0lvr6EYPz1Eqp/YdbOqaCW1vewwOg=;
        fh=G3up195OJ9eeI2IEmgGpkBdjBlBDHXmDYNff/XOJpSc=;
        b=PQGoANNv9zK/jL7/wkhZoBt+TWFCQsVcIyf8HMrgT6xlfLgrrVdrTVXC0K7upboiZa
         xhML/eEX4RAzF1P5AVkv2q5h6cGbQZoh/jFrnZY1R6yzN2YPD/oWjKfiOCGDrQgTS3iV
         hZMnYtOA8LeSnJsC4iQNlxfKMMwCP30epxZE5qqkpcN/EGS3Ie+FI3Je+0rCu0pI2JKo
         Mrg8L3XXbPg1TrIyeX3Z/vngz8iWKr+zFwNwW8r5sfk7PjKld7mJpaDSzk9ZBoY9+AjG
         k/EkZAKmvY9coQmgVc52MNIfy+1Cw4duVqGTY1Zslpo6O1WeL/4TYBMo19ifCVuBAm2A
         PBjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773342946; x=1773947746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VzEC4HlHoK4vh0lvr6EYPz1Eqp/YdbOqaCW1vewwOg=;
        b=Mds+JwZA8Oc7NjhpeV4FSN1/iP+X+fhRT2pASsS+li3LA7tJEBaJbx9omaoF04jfJm
         0KaEhyKFhvvR6bA5Ul1RkUZjawanfmKwgnLrlG9wPkrMLlSZlV4P3wl667VdlnyYnDyj
         +ePEpIlxvj99eJCBS48+J+ArRMvkjaPX+PGwYfUcGObXIwHwaTy0ldJv0aS29SaYMC6P
         811f+SRV34+/ZJ1Sk0Qd62dCTVbEKWbwGWxpyKs7emTPYFuRVrr1og7nwpfO+gSm7lPU
         /eevbC5don8pk4HE8D8ZAkHH4F7OLq/IOaIMjPzrV6/ybLDLIuHcImYx02KR2AqUNGXB
         5nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773342946; x=1773947746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4VzEC4HlHoK4vh0lvr6EYPz1Eqp/YdbOqaCW1vewwOg=;
        b=M9CzjhqMJi2iIa+fgxaQpTC/6DtkSqqGBYjrPCG0GHkViX7ZKmRWHhqO5HmRr+nHK0
         BzEtK8VGD8R2mLeuXqZRP8dVqfMuLCBJY+9jdIYKnl31gjXz4VXNtlooFGe0NmRqaqUl
         cLymCbfBRv19w1cFnkgN+8+ANjYTdb1kIHSlVFlr8DbcsD1PztZ/W+3AyVGa8FTCQWdf
         nAYo5AvjEyIWITmq+V0NI9PsAqLFuTycChrp8wEPm0lkB0FGCOJoVWfYDIdpeEVsu3sZ
         wqJad6rzwrPaV2FrsRhA34yqVswwrzHbqw5o4D6m5xIdPzFRwNx9/KPqspfWv4L9elQ/
         tRwA==
X-Forwarded-Encrypted: i=1; AJvYcCXjIX6PzBp84Of9tJ9o5zFvEp4QelvcKH9N0EkjM6oEOWImkGuvsUwk3Ak1TPPdtJ3DgvwCSXihJ3dR6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx4Pghlx6sv9zpYw9gW0e6lC1dOIrr4/xFRJj+W7QjsGNS0HNx
	m6zIWq6nYPkHx75ZmUiZa5YcrvjYfATjK+AIfWt8955Lk5RYrIWeG/6Izqn640QR960vjEEaedt
	Jl5iheCqS1+ut2kfRMOHCmXW6HxXj3Fs=
X-Gm-Gg: ATEYQzy2m+mBpzutppTz3ZLK2HHWtmjoVgsXJmPbg/ATRk5Py+Czh5VhIPq1u7+sJAE
	Tz3GGGogUkV6+MPzxj+rslCmgbwC7lFtteRt7T5AvApSozzYxla/SHXxQCjawnZaDC57gGx4Zqv
	Mv1F8C+gBPAdjce52DJIhuNcIa87irWBVUVspzrDWmQGpUcqRDCGyAxafDytQo5rspgxrkWhvj8
	/0qU1pXyQgXHj6EKb2INFJ5FwEZMWDQTZsACmKyU9l+iM/n5kAfk54ojz0/OhH8Y1kb87GqFIoP
	1jVpw4Km8nMe/hqU/p4WQZ/Xz0TEqsquOMltpuQfIZlfz/eWDv9QZB/zV3U6q4PIEZuCqs9Ybhh
	Hzi8SZRkEG87olSfdkUVg3F0=
X-Received: by 2002:a05:7301:1924:b0:2bd:d8e6:90a0 with SMTP id
 5a478bee46e88-2bea555c8d0mr231898eec.3.1773342945899; Thu, 12 Mar 2026
 12:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306203648.1136554-1-joelagnelf@nvidia.com>
 <20260306203648.1136554-2-joelagnelf@nvidia.com> <DH0ZMJKN6OE6.243UPT928HIIX@kernel.org>
In-Reply-To: <DH0ZMJKN6OE6.243UPT928HIIX@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Mar 2026 20:15:33 +0100
X-Gm-Features: AaiRm53560zXAmoL0EVQHDBxYh33LaVByeeBz-QChPDevjdBJ65drv5v7FGkL1c
Message-ID: <CANiq72n6ccEz71V3nkJxtY_BNbTw3F_eekt+Dyhvfb1FNP-srw@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] rust: interop: Add list module for C linked list interface
To: Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Dave Airlie <airlied@redhat.com>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Koen Koning <koen.koning@linux.intel.com>, Nikola Djukic <ndjukic@nvidia.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
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
	nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 6:42=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Was this given off-list? I can't find a corresponding reply from Miguel.

Thanks for double-checking that -- it is fine.

I am sending some nits and Clippy issues independently though.

Cheers,
Miguel
