Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4049B415B82
	for <linux-fbdev@vger.kernel.org>; Wed, 23 Sep 2026 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173879; cv=pass; b=JZNJBOoV2jT1zBwEeyvyTjee28qnBAmW9xwqtJGGpYfebDrhIIZv0jiUHRUAZxwIC7XzYq6JScg/yqly1G3pkCKmRk9WCauBfEc6Xyq5iZnokysZO8vm6NdVkI+xuGEkTVfk4aIxVkOsIJdd/rynHja4y+rQuyYoywK1yyzOzO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173879; c=relaxed/simple;
	bh=3IRQTfCkVu29EAhzhIq8HL8xV9bhN+vmwTvfaTzW1hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joOMuYgqO8yQkYljmF7ZtwyGi/TDFLkUy6vbsrM76KX3iG/zLoJlLogaMiF21iZN3INycNFv0kH4+vJ+dBQK3YrVpT4bvd7KjooC67oSEa0DYilYSrY6wpRa2i5oEvbXaZbeWS3WmwVgl5jtG1ZLzHlFXMfb0Zv3/wonBVEVi4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+1Ohl3z; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+1Ohl3z"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53113d72966so260491cf.1
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Sep 2026 07:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790173876; cv=none;
        d=google.com; s=arc-20260327;
        b=EOvG6CnEFavyZD6DYSua3pCdBqojw/jy6OcXDXZe0FvSe1rWPLxqU8Du2nfXTILhOg
         9VCbM6+hRYSfWJ4ALiXzknoFdjCO4b5v5DzStfltcXVYVHFgq/GZnkX/P1SMLouH/IfK
         OP5yZ0YWNtF8vtMhoa/Pp7c4DnsjOIc4xD6zvJO1MVrcNpdkTPvAtnJAj0W9V9cb0ggc
         PK7XqPJnq9ntGvAkqIfY8/UYnqqwyDnl4xch5gdCziaDK+up6oWHrRL5hS7llfC5jwX4
         FgQMXtyHahzTTsg5Hb857AI6PqQN4Y6eOxqOxamgkiHa5wFRFlaP5Wp61zhNSfmiWWUC
         ziGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3IRQTfCkVu29EAhzhIq8HL8xV9bhN+vmwTvfaTzW1hg=;
        fh=o81NCVYW3s1IhAHC7BzG8oczuoz6EPnuxwX4IiRS5wQ=;
        b=f9xe5m8NV/tW1YE2Aqe0wL0MYs9eMlbqMEo5NCuoD/JHKL/cmIiq8fCpg+FWkHw0S1
         gfEfXLN+JeUPTjyt2nOn5UKVYFv9WcI4QImJMIzLUo/4wzsqbscHuMasEDh8iewo4Xb0
         obmiVWq2QnWthcrLwM29nGiU2DjiAxWJ6vydgWhxg1uPttRZuQlynTbdhxf3npFHH77J
         q10g8SoGguqtqqFlhO/Ly2qGuqfxEWekr3m2xMvtYEj2KnSUgl8nM0rV9uDePYLcleSV
         1IE1ST7f14y1PYMpY9a0PRx/7g1WD9cheH37o7YWygSa8JXicocDfYwiECu+WlpV+Hh+
         MlYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790173876; x=1790778676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3IRQTfCkVu29EAhzhIq8HL8xV9bhN+vmwTvfaTzW1hg=;
        b=C+1Ohl3zbsMrjh1dB/zOjZD8WctelSpuD7HSjz83HtCzxAu2uQCdrvdk6mQA/qDmED
         XPmCruc/0qesoh5ZaUY/8kYU55YuQDkrL+NWB4/GzBktzO6vR8i1QACk+3pme9wnGQCn
         VZQmjl8KrY0HTHromA139b+tgbWQilZ3lTmZ8bgk7A7cwz+FVWfgOIYzhOmTDxAQ89K+
         VZ5tGKKWdn2SxsyXoo0ZRNPy/7aL5Z2Tdfk7aj0pDU/c4b+4zxQCe6XqJRfIBBmHEG8r
         fY+QEIfNks1XUT2d6WUeW6MkoHO+EYXflKlYvUF0fbOWU0DbvpsKlrTvHc30tBgH/z4n
         u9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790173876; x=1790778676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3IRQTfCkVu29EAhzhIq8HL8xV9bhN+vmwTvfaTzW1hg=;
        b=Je+YsxemOzH3PGcXLIAoUgDA7WX8FYjptFNw3hkknp5iCZ0rkHgQTyDDXYnCOr4xLJ
         1HDXgkHSziNRNcobnjihwLR8ThOCLzSNwvo0JqPnw85IBjntxdo/Ya/hci22bPXARiQv
         v0ugZVYjfWR92BxSGeQ+hHbz5BvyF9ajLS3oPJKyCI5PR9W7Lt6wjgiAqhbGRHTrCOtg
         Aj3v0p0faoj+kuJlWcSTcyiqoKrzz0HJUrQ0PyyVPUDdAptfX+dKCLTQDfEn6l6uEBkH
         lqo/yoqFV3sHdfYKLBDIWKUJY7PHYObCGJtM5yVy8rXKL4vYrsYk79hSbTkzzHf8bSVf
         5OPA==
X-Forwarded-Encrypted: i=1; AKwUvBxVb64johR+A7oXbeJY+ffn9bjxw7Z1/CjvscFgAjGBtt8UpBThVGiZVAjuLxZquJBqm/sMIpLy+YZliQ==@vger.kernel.org
X-Gm-Message-State: AFuF++leaRmIbEsgVsjKszz6p9S026et3MOJ/8bycA2JtNgy9rW9oBVn
	1KkUHN8HIt+w2uF8d03IAglEoyven4CI/7KwN82xqGstpsgnDDm7mqXStyxNS+9kKsbjzBRNeeK
	bEDK6iVku4xPJVReOhtKnvzTbBX9TzG3YMz8bOweS
X-Gm-Gg: AYBFou1P36uF/RxGY+cMPrQbLkhuloEM0dX49cQPVWEbH20fOrhXTluYMLMqEBc3Xz0
	Gdpb6yaX/zGteEsjwnE8/PnNd6U1dvebv9Tm69h5JwbeRIsnFFHEqzCz6LK4iSyA/c3GbQ6gh3N
	LKibNq/1EYYDDsAyi8n7T/FIQMJD0S+/fWMtS5zJKQDrDAijhArv8CTUuN0QDy2fnRDRN0eH25o
	wLKaCIn58Uz0K5Cg9JKPInOgo9cMPngglR//eEyq1WO+p5GRLE2TtO5VhI8o5TroVqndnZjbJqC
	AIbM+IVjVqhO7EExIsPHx/piqTqREX6pVPLygmjiXViIVHtZ27lg7DY/IPxVXQE1hqugkqIcbEr
	P2c6wlZUXPw==
X-Received: by 2002:a05:622a:260e:b0:532:9d15:2e5a with SMTP id
 d75a77b69052e-532ede89b29mr14598791cf.1.1790173874906; Wed, 23 Sep 2026
 07:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914180811.057cba8fcc48d6e0b53a2683@linux-foundation.org>
 <0b064fe6-ddb3-4f26-a1f2-2e9dd88d590f@kernel.org> <CAJuCfpFBichJH4OcmSHTb1rOuQBT6k5pXeua9_KgpWjDBKvsYw@mail.gmail.com>
 <aq6kzpK7wPl3iFGe@gremlin> <aq6lW9FvL69QeA9H@gremlin> <arOCPN02xB7mykju@gremlin>
 <b007cd0f-29ef-457a-8e44-63ab26f3bcd0@kernel.org>
In-Reply-To: <b007cd0f-29ef-457a-8e44-63ab26f3bcd0@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Sep 2026 07:31:02 -0700
X-Gm-Features: AclHuK_ZGTwaB8ygIyiOyIIeQNRzbEtns-G_Cds8CuZ4q61CHw7YMjTifucik0o
Message-ID: <CAJuCfpHL=dHjT=O4S88ZBvT1DyodAtCL9QTryepzs3EMwoECDQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/40] mm: make VMA flag semantics explicit, eliminate VM_SPECIAL
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 1:40=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/23/26 10:13, Lorenzo Stoakes (ARM) wrote:
> > On Sat, Sep 19, 2026 at 04:09:13PM +0100, Lorenzo Stoakes (ARM) wrote:
> >> On Sat, Sep 19, 2026 at 04:05:57PM +0100, Lorenzo Stoakes (ARM) wrote:
> >>>
> >>> Thanks guys!
> >>
> >> Note v3 has been posted to fix a stupid bug in 1/40 + attack some very=
 trivial
> >> sashiko stuff
> >>
> >> https://lore.kernel.org/linux-mm/20260917-b4-mmap-prepare-vma-flag-san=
ify-v3-0-4583d8a23bca@kernel.org/
> >
> > Just a gentle nudge on this :)
> >
> > If you guys or anybody else has some time it'd be appreciated! (obv. th=
e v3 as
> > linked above not this v2!)
> >
> > I know the series seems intimidating but most of the commits are very s=
mall and
> > it's been in -next for a while.
>
> Busy with too many other things sorry. Its time will come.

Had to take care of the pile of bugs but I'm on it now.

>
> --
> Cheers,
>
> David
