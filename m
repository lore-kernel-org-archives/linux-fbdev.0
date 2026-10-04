Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A81BC2A
	for <linux-fbdev@vger.kernel.org>; Sun,  4 Oct 2026 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136941; cv=pass; b=hq+jXHpp7oe0oDecMJAVEI19LtZub/9fEmm7//YiFkWV84G6kd/b3AYwoR+SgtIpGmjZfxZdKvyIujIXBFyd0g8GaKnjmxi9W7Yof55YYD86uNMDpESSR2RbmzbNqGyeOFrP5ARU07EuxvaG5aaqEl97jAhdEegXiCRT1Q05zCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136941; c=relaxed/simple;
	bh=xOBOM0qU79KZiyR638ux2NLueBV95WtehhE5D+Z2EOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+Aa0mXYSNbmVEHRqdvZPMGTTX3KsvWq15inm42b9hM4+dJcebvfEEXjdCgQUCc66i1vYApBHqlVpIktzgSqvUwken/vjoT3vIMOrBIKNNBoty8yOfCu2825SBJ4mC6yTM/YeAi+0IeuNQZpsxXFT5AoE3ytvG7hIs1a8Tvz/fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EzRNGhII; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzRNGhII"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5337c7b9937so262951cf.0
        for <linux-fbdev@vger.kernel.org>; Sun, 04 Oct 2026 11:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791136935; cv=none;
        d=google.com; s=arc-20260327;
        b=A9bMrGXGBmY5Jl030AOIngVac5R1D0u9B7iBrcTomULJcFIu6Za43Ut/71sDsDAtc3
         EwWRxjkrs1syKdxuX+JNrKa1IVs3tsdrg1jhHFtPSwUn30K1/lyBcJxF+0OBU7VqF0WY
         9GZDKL3q3hv/cmkma2Rj282xAVYVlKj170N1WbnQmak3B/WyhXOiaBU9YkCm1Jh5WiWn
         hrBEEN3bx3RR6GT2doBai/O/eK9yBHIovnqr+R6/Qx6uhCXBeelDBmPt2I/pMLyvcetL
         gs0n5x3abCF4VgtFouvURlyCqcmikY+oiWKwHZJSIxKkZwIrstcX0aict2CXDurKcqSj
         V4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fxl6gThguTjmryCDwAa1VxSTqh72eFueCyhgsTktke8=;
        fh=B96FNZpgJNzzanNVQYKFiWyBNmBNFmr/jWVDDU1OlhM=;
        b=KcoEZFtcF8bu5vY5ejFKWFN3IbBM5s3YbxpJm+zYlcwgIUg5GdSmqpjJG4f6U1rK4F
         RDh2gdZUU65lB8WqOoK9zkIv5zrk3toNaQ3iIX9VhabEbbJVG2jnfuiyb8XT5g3YwkOy
         x00LYzA2MZsH0N4KNHYQr8ecee9DOEP5fyj1ZtR0+adcJadKCte9ORTkdPqyW2hm/Fq6
         +f6sAdu7JAXRTeHuQJ6g0LW3uoHbxLlrAvepulm+1omjpHa29A9eX3XEgJqCFTvFXXM/
         EkJjgF6qOB2QH7g3y9UgCrLi9OnLEHkddWlwZJzG1aEK8VTMvEXpD/ETACUL3qbO8kdv
         JU8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791136935; x=1791741735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fxl6gThguTjmryCDwAa1VxSTqh72eFueCyhgsTktke8=;
        b=EzRNGhII5r+95roQZlVBkmYNQdaiRDoLFBLNEVDHO+/MdO62rSW77h0jsY0RRI7TOE
         OGizXIl23WARyeveEsg9A4VKDlhQ107vzXvgKB0/kumOZE0OxLvvTNILxBDSV3YzzO8k
         qiO7RseqnigoM4JWPrCD0Bqwst28hHQj3ynkIBcst8yxNsMOZSo71JGcgRt/gQfuJBmy
         aRm3rm9+wZlzJp9JgpetPss9VyFcXkLcrG4rtH3CiCS5OBjpz8pjPDk2RzfpGkkOJU/6
         LOTv8VmGgUBpxyWljxRzHPYcvYUZO7aEnLg0bU+UMvBTc+Kud1K9PjZyHy1VScuLbj8s
         CCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791136935; x=1791741735;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fxl6gThguTjmryCDwAa1VxSTqh72eFueCyhgsTktke8=;
        b=0UprzxSdCqh8/Tq0WZmDf/wD2kF+TzPB5ZstT3q/LdhBKFJzdpiLrVs2Uf06HV+QBB
         7ZrOgn4rfK8yna0ArDe3qtOYJ46L3pliYT6Sihzsbzt6a2CMbPBkqZ44NMZ13yOfVSTc
         LXZVYc3ZZ3A0rRufQ2VYtNcbThgIMKV/WubnXUDeHyaukVPALM+Zb2egbqCaFx4/+i87
         1E5KYSft7khmUM9etsRZfdQsoenECBwEJPz0irxiNji4h/G8zoWYeeGgcuo24LK1ruAi
         EG2l11/vn2qMds0qZGxPzcNvuTAwWJ9QQbGXr5jkMzspnYGGWdr4wvjFy3AGU/hM0Wig
         xG4w==
X-Forwarded-Encrypted: i=1; AKwUvBx8sKgY1aQvgs66vp98b6TTEzVP4iMahCLSMSleT2yhR0JlGfir55jvJSbxHaFbTjzdy67kQXXaizQKoA==@vger.kernel.org
X-Gm-Message-State: AFuF++kmT7YADRDfluUCqaNKdKCLDF+YSMa3N1LkYTu6e4im/CWl62TJ
	VX3311NedOMEzasQdak/APM6ZCJT5nQBPFP50iR7wVRfDi2Hxkflg3R3IjjDCsVIs7ACCDiQiw3
	UandreVKKNCihF5XqQb5KLctDeqnupwMD9WETi5BH
X-Gm-Gg: AYBFou1gpUB0XivFQfjaWlwoGsvAS9zcu3yKDctima6olkaktAc980QwsCJSKVT5Wvu
	PMK+aRYNFvliaEdJ1Wu+cYyZ101WVvMLQ+lsYMmcRcNAhCLCZERtUGu1lbHHmhKXiIzyisz7s2p
	tmK6ep/W2uIje2io8dC8yRqu9Av7f/bt51SVRhnIrgH7NiyJIeGMgPMgG27nKweystRYM3bxwZ/
	4BuLhSFRDeU7wvIxdKu8+iB3cq6T9HXX700hIZunr6phjkAuYhss2pAfvxy+OKsy8XuXVV5dARG
	eW8S3UdQpw9iqKX/Gg4HvhmTUZvQfa/yNJ33aqkgvIx/MCVHo7IwNlJZ
X-Received: by 2002:a05:622a:1b20:b0:530:e335:4ef with SMTP id
 d75a77b69052e-535113c3cb6mr18023261cf.2.1791136934142; Sun, 04 Oct 2026
 11:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-18-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-18-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 11:02:02 -0700
X-Gm-Features: AclHuK_nOqMX3djeZOdNLjNPymjaWdesvnL51eoG4SJjNhtYox1cB5x1yziRAMs
Message-ID: <CAJuCfpHiaV6uDCfOMmHJ4tPosUBPRMUF9zjrB0fkCWZG1umG5w@mail.gmail.com>
Subject: Re: [PATCH v4 18/38] fbdev: defio: assert FBINFO_VIRTFB, drop VM_IO,
 add VM_MIXEDMAP
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
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
	"Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
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
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 6:39=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Currently all drivers which use defio allocate system memory. All of them
> also set FBINFO_VIRTFB, other than ssd1307fb, however this driver allocat=
es
> system RAM, so simply failed to set this flag when it ought to.
>
> This patch sets FBINFO_VIRTFB on ssd1307fb probe, then drops setting VM_I=
O
> in fb_deferred_io_mmap() and instead requires FBINFO_VIRTFB to be set,
> erroring out with a kernel warning if not.
>
> The logic requires a page from the driver and since commit 1ecbc7dd2902
> ("fbdev/deferred-io: Always call get_page() for framebuffer pages") has
> always required it to be refcounted, so this was implicitly already the
> case.
>
> Finally this patch sets VM_MIXEDMAP, as the logic is mapping
> kernel-allocated memory so this is appropriate.
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

With the same disclaimer as in previous patch,

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  drivers/video/fbdev/core/fb_defio.c | 6 +++---
>  drivers/video/fbdev/ssd1307fb.c     | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/co=
re/fb_defio.c
> index fd00b86e1ae6..fb359ecc3966 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -366,13 +366,13 @@ int fb_deferred_io_mmap(struct fb_info *info, struc=
t vm_area_struct *vma)
>  {
>         vma->vm_page_prot =3D pgprot_decrypted(vma->vm_page_prot);
>
> +       if (WARN_ON_ONCE(!(info->flags & FBINFO_VIRTFB)))
> +               return -EINVAL;
>         if (!try_module_get(THIS_MODULE))
>                 return -EINVAL;
>
>         vma->vm_ops =3D &fb_deferred_io_vm_ops;
> -       vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
> -       if (!(info->flags & FBINFO_VIRTFB))
> -               vm_flags_set(vma, VM_IO);
> +       vm_flags_set(vma, VM_MIXEDMAP | VM_DONTEXPAND | VM_DONTDUMP);
>         vma->vm_private_data =3D info->fbdefio_state;
>
>         fb_deferred_io_state_get(info->fbdefio_state); /* released in vma=
->vm_ops->close() */
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index c4fdecafd856..958514a35433 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -763,6 +763,8 @@ static int ssd1307fb_probe(struct i2c_client *client)
>         info->fix.smem_start =3D __pa(vmem);
>         info->fix.smem_len =3D vmem_size;
>
> +       info->flags =3D FBINFO_VIRTFB;
> +
>         fb_deferred_io_init(info);
>
>         i2c_set_clientdata(client, info);
>
> --
> 2.55.0
>
