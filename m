Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934937C92F
	for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139175; cv=pass; b=pfHBmuEZzA2VgpA4PyQ9mOqGpREe+146wHRnpe6QNmba9OtbAkUbr7DREh64F+JMx7yldy838wXfDRxwzwEqjPUSKQ/5GU9NrJDq8D2tzMHarYD4ZXVpL1xifpr7F5Y9IJS5sK6Hl5ARWygJ7ng5pZ3YF86CnMWn4nf/KJH4CWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139175; c=relaxed/simple;
	bh=31WGPI9CsS8AEb1QmZigfY8oBbhGb6+EPuGPGJKusUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFuEnyf9/ckt6pM9lqExg1HeKuGSI86oz0gQvIdNjFTrj916OepZINHpmvdeievaeGT+PucIIfEuKy5ZwtC6N+gcNtmGQMnYcGa6UrCRAxts2sM4Dn0mVD7plvQ9QHa1AObgWNPz2hNZliVs88OAlI8gmD5BLRFiWZP9ymlrmbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0OqVLPf; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0OqVLPf"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccde2a99so673838fac.3
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 08:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789139173; cv=none;
        d=google.com; s=arc-20260327;
        b=G/tdJpqn2o+C7kHkk9VuUAGbZSBkL2RJgTAaT7jkHcNZn35DsKX49Bpk6/Kl2gGiYS
         CwvRbWpnCi6FI9ER/wC60YbPzvQrkO5GwYRBNPVxpKEXys7xa+PK6q2K8yG8koc6mX8G
         OsbmrAl4oLZfP79xOrGAf9paCv0DpgY98VpkxvnbABEE7Xhas3+HA69/3o5aNMzIYsVk
         gmpoS0nY2rf9iGXu4AAP31FtpfC2sBUKdPCZ14r77tVsEeWWX0iCc+Zgj9g23u4szjkh
         L+lw32Lgn7Ny2Iq8nXLtJrz7RZ65nAkzHdJSXYkY0Wm8qP45N0T5GrTRqPHOD/UVKAL7
         vsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=31WGPI9CsS8AEb1QmZigfY8oBbhGb6+EPuGPGJKusUg=;
        fh=m26NUZWg3ZCQQLPbdWsi+UnsQjq38pSTinn9DyeFrkw=;
        b=sEc/a5YO6Y7JztOqt/+Y9GzgWvY9h4Beb33lAkEIgVJHgapZklYn3ktt3kcYYdb6IZ
         hPI6moLuiyUfBZxUY1VTUkAK7yMyDY4ZzX9Yy7/BJzaZNhaI0hukW+tIxVkAaIR6lDbg
         qObD5vZIewwKgyPKJF7hTfda408/unLKeo41dQ2aK2/IHZRtWNPksUsyQ+qoQ3VSIBZ2
         +ELoKevGILJjkiaFdbGLvOIN7SHqogOUrNi+bOSqfeB3eMxQnGbVlqWgcTZ0urUXetcO
         gxL5nU7jTKHkV87Y6/n8Yskw/z1Sq8xIjjdnNjf9wcXbb8Qfl+kxnoNep15lf5GxRVme
         Lk9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789139173; x=1789743973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=31WGPI9CsS8AEb1QmZigfY8oBbhGb6+EPuGPGJKusUg=;
        b=R0OqVLPfM0gl0LpwKD+N3WkIoR5rdyBDVZktibqvsikfgbZnroFf1Lxa1yGtL+b6wA
         HCF/Lh4bWsaKG7cEFOTL+552c/2/B0PnWMKWW4fzWWt1OX1apuz3RDOslCZ9b/azOa/V
         CYjfuH6tVnKqEAzQWZtVYGX482dRWfS6tt76r+tPUg2KXcWmni3U2VPDbkTz3EobjI/o
         hX2nNamUcXKKn5QowYiu4Gna+/8F3cpqaN+xzv8ex3q/L7dZBsUIVQuDgE0e3Gd0B72G
         N/CGh67yXoqpDnFs7kFC8TrgIsE/bYr+tYEuAk6Odri+RXfKiEJw0c0PPGyDsDn2u7Hb
         Z9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139173; x=1789743973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=31WGPI9CsS8AEb1QmZigfY8oBbhGb6+EPuGPGJKusUg=;
        b=eY5AqqLNl8nH2NHJuztQNB9xIMAFkh8aqBbbBvCneord357T0N2nLPbv+fnbkXn+So
         AgFvvngvLwh9XIjeGd2MkpSCrlyb6x9Cz3Y6PUhezgsfgcIBGBJGd29grzLsGefDt8IZ
         HyUv2rheUwb0KIt1CCuD9oCT21hum+Bdzo7HUduvJKpCQCYHnCQqcdQu1rjkrC/CIicn
         vPlSaodZsX93EJfOyFCNRult4cwt946g3xf4EfiTzAXiFq/jgVn71gfw0MRrPaWBdBZX
         KDxs/Bx5utKNNwuZfZkTKRA6z/EbNjIxL9eCl86x4Ep17M3lvTm5o8xCWsTsaWQCDBOE
         Wyyg==
X-Forwarded-Encrypted: i=1; AKwUvByScDWfi0j4u6b7NDxwTH++HztQS9uIyYJzN2mo6OSal/ojYjKnmHuu9C85A021rikg3+ID6s+F1eHC9w==@vger.kernel.org
X-Gm-Message-State: AFuF++kr/W81C3M2pmnsI3hvFzDTJfluvhuHUGw+K33qoa+PL1AAa57r
	gSdHz/nAlFspsiro3GRFC70Ws1BAosJDYiEijxdadXOC3dPc1AshBOVxBPoLu09iHgQZ8i6xeXf
	DTYSAEnMh1mbnvdTRBOPuCNps0OLq/jo=
X-Gm-Gg: AYBFou0VtmV6EeYssIswQWHFC+TKf0u29CcfJklGl9KFGiW3nz6Ya1YfBTiY+5u7Vnm
	T0xtbzb9AgcLXCFaYgGDyvNwOMCJzmk4iO6tx+3/ClgIrR/VYkXiotXeOpTdcJaXbhnC/U9yIL5
	1EDDGVXusjM6uyQvaFtO4B444qYtNv9BbsGnB1t+8IZoEC0joAPjlMhGduO7uXKRnoQvZdSbEKt
	QFyYbv5e0KywX/0z4+fCwiVWCYur96sULvzfM0pUpPe13fdy7npenVTzOYSgxFauR13VwMTnjbb
	fxd+9Hj53QcOyhWkDL3IX6Js1MbJ0V76lQGa7TYN/unBH0qpd/6+Dd0=
X-Received: by 2002:a05:6820:8585:20b0:6b1:be9f:ce6c with SMTP id
 006d021491bc7-6c0b9d4e35dmr4967721eaf.4.1789139168581; Fri, 11 Sep 2026
 08:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-11-dacf19cce22b@kernel.org>
 <CAEjxPJ7hXSi=oLtQPV+7GEvN+txfYwZ-u-v_EysNHM0gSGNrCw@mail.gmail.com> <aqPUqU3eZeFrykj3@gremlin>
In-Reply-To: <aqPUqU3eZeFrykj3@gremlin>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 11 Sep 2026 11:05:57 -0400
X-Gm-Features: AcwNN1UL9TCHStClpz4OqpdpVCOHFGRlTtL1ELl-GfcxGBMtPjfBSuHNlaSY27Y
Message-ID: <CAEjxPJ6P19eKF-c+mm2BSr5_WpmhMTZjjUfSamv3SfOPO4SGVw@mail.gmail.com>
Subject: Re: [PATCH 11/39] selinux: reject writable opens of policy file, drop
 mmap shared/write check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Jaroslav Kysela <perex@perex.cz>, 
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
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, 
	linux-sound@vger.kernel.org, bpf@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 6:16=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Thu, Sep 10, 2026 at 02:11:18PM -0400, Stephen Smalley wrote:
> > On Tue, Sep 8, 2026 at 4:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kerne=
l.org> wrote:
> > >
> > > The policy file has no write method and is exposed read-only (S_IRUGO=
 in
> > > selinux_files[]), yet sel_open_policy() performs no open mode check, =
so a
> > > CAP_DAC_OVERRIDE caller can open it O_RDWR. Reject FMODE_WRITE at ope=
n, as
> > > kernfs does.
> > >
> > > The file can then never be mapped with FMODE_WRITE, so do_mmap() alwa=
ys
> > > clears VM_MAYWRITE and VM_SHARED for MAP_SHARED mappings and the VM_S=
HARED
> > > check in sel_mmap_policy() cannot be reached. Remove it.
> > >
> > > This also stops sel_mmap_policy() clearing VM_MAYWRITE on a mapping t=
hat is
> > > neither a PFN map nor a mixed map, ahead of the core enforcing that o=
nly
> > > such mappings may do so.
> > >
> > > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> > We should likely do something similar for the other sel_open_*() and
> > sel_mmap_*() functions too.
> > In particular, truncation of the status file can bring down systemd
> > since it is mapped by libselinux.
>
> Yeah I think there's definitely more that can be done there.
>
> Though I think obviously that kind of stuff is better as a follow up as t=
his
> patch is focused on eliminating a case where VMA_MAYWRITE_BIT is cleared
> incorrectly.

Agreed, posted one for the status handlers at:
https://lore.kernel.org/selinux/20260911145840.19039-2-stephen.smalley.work=
@gmail.com/
