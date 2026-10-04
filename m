Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2FE3BE623
	for <linux-fbdev@vger.kernel.org>; Sun,  4 Oct 2026 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791137395; cv=pass; b=EL7H3H+Bkqsei4UMCRChDblBmg79NYJ4lOvB2tbFypJIVrznpF+yof+M/U/F2AUBmrLl/lL1KsvfpqwWfCtQnfN1hVr5pQsMW2j6w+7kbmWasa8kL228Qwsn4g8Nz7s3ELe2gBD1nTRCmmfPFNp1ex3qN9qRjGN7h3ks3iG30yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791137395; c=relaxed/simple;
	bh=p8mpZNJ/Ji/VmSUc1fEHKip1nG8b1aj7rE3YFXNPflA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbmeP2tSL49AzhBvN4M8cI7x6q5upTmY3p5PMjfPF85id7mPAdx59sq1gDFIJcXH9Nwanc9V+WWSLOY4U1KrEvrp7lCr4wGLnwy43FLIKVRgEgqmPmmX77w2hdGYu3jqh9+K4LfFQ2Oc7hDQPoL2vVDcfIhtCwYE/zwOKMH1I/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQoHbZhO; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQoHbZhO"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5337fa12431so185301cf.1
        for <linux-fbdev@vger.kernel.org>; Sun, 04 Oct 2026 11:09:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791137388; cv=none;
        d=google.com; s=arc-20260327;
        b=Uoz2mV+I0ZIJWhAOmKTCg1dYjZzSQUkx187j7Oh8L2wJMrA3pfan8EqXC17nEL2J3R
         l/JxehqCMB285CgH/neyfr5UEfgbAuJJvKj51b5Ws+CMKujawx0PO3k0pcHcLe89TC1y
         uAxLQJhwionyeIIT2kVPn5h1fOM+iTxuxMVRgGsWqPEyHPYfBqgLmFd7tRfk2DiCeMuC
         C/Tzuxxwg87owvSrv4cFU+0VXlUyErf4f9jdKpWxm/nRUd+xtwCxs1MQQyO40TLpGaj7
         D0OMndywt35klFnye9KK/iSZEsVzwPVMvwHCHQPIjgkM6MFdlHR1sByeWZ8qAlPUQReY
         PNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XLyJnDD7le8j0fwG4PV8CX7G4WYRHL5RcOgxsV2u/6k=;
        fh=klhANhY6iPa18AEvgcRbZ8jd4ESWIhVuPlW01vo7ooo=;
        b=QUSdcnk8Rlts8097z8WGg459qFS7UV8DN22yUP6Wcn9kf/PCgqHAyGsYxWg00Ewpcs
         0qzHnE0E40LLiECqudTIWMvckYyKB2DWtB+3599tiKXTYOeF8JSL8EKFuS+1bGE7up2O
         dTj2Si9GYF8xNtusj1Y6o04hJBdWt6MP14uQAih8qFvEyy8NBn5YiTqVXQsgK2BHdZHP
         FODUNGSv179EfXgBdZFZnn/kQ3RAsgFPUTTvPwKQzROaC9dN8Lh79FEPFYNFqxzmpahE
         /fByJOrAlTE+CtjAtnxgrQJ0Am52zs68dcdnnaWUsAXT+24MBamGWgCpe+smF9HLfiJ+
         kqow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791137388; x=1791742188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XLyJnDD7le8j0fwG4PV8CX7G4WYRHL5RcOgxsV2u/6k=;
        b=AQoHbZhODLn2mfCrdgDwCEMvBeVlC8jwsdW9CFBBzksHdi8cJisqSDBV1Biz441g6t
         RKsMdunXPyZWUeKao/KKYd/4zHxkA2dUpaeXXnB2Ip0AHcvsOMFPsRNyzHt/Wr3ioOR6
         6ZY5MuGmw7FbCkHw0/CZZ84fUSlVxejj1L25qkU/Ghd3azp5WSdMknuiN/8Z3+C9+WwC
         EziiKHwyleRn1QhVYIzXkTWeGKKh8pXsIo34qE6gsJavYLVZ4yT2oqIR3/TYEWShb+Ws
         upnHFV9P0w2F0BQ+XY6AIk6ckEd86kOBrvPWP5ELT8iHJ4xJUKi7jaae96pWPriP0w3p
         1F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791137388; x=1791742188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLyJnDD7le8j0fwG4PV8CX7G4WYRHL5RcOgxsV2u/6k=;
        b=c+7lXoXTUS+v2YAettKK4lAErAIwsCo1C8ek3Znw7FgomIwCvI4aZACHERwFt7hyBH
         RElbIQlRlDQzDboLmOAkxW4YPflvnchRlfRlD4dbS/rQZn1AD1URYjwsD1H3kSojFX7w
         Op5X+CoH5/qnQlqEp6briueGVbnL+LkTO7fWqkCpSKLOBKKssa0hCfncMfDGjpAtCJma
         pra7G/qv548ghfpeVl2Klxl3L/vlgDX2z6TnSLCZhupieVhmNApAEFJdeGw2QwSmhT8F
         6jcjmUvSkqHb5/V9j3fHFRwsssXhKj/Q0edAB3LsVAXUKJfHa/hwdFZ1i4/7t8vvyi4m
         U41g==
X-Forwarded-Encrypted: i=1; AKwUvByqlEpfRfEZAcdqjqrYd89khAMZ4gw1UQjUDuO+kBZ1FASaDNJeLy6CS+SflQv6Gn64C8ixvI02NgqEuA==@vger.kernel.org
X-Gm-Message-State: AFuF++nF7XdcOf+gy1xxrHiiRgD2PFHmr2k+eH8ZSHuV4BUBImfD2v1I
	bsnI8tb3YterK8EsUn+uwiYCg0565gA5AEvurXCabMdH7tZJUzHeBEuxZPlYubvWgfXf50aED7k
	DxR1PLj9YJS6zmTX5BnLSG1jzFnuSYnjLf2WoQAL1
X-Gm-Gg: AYBFou2VVJ83pW0Zo7TqZlIRBvt1M0On+Sy1b96He7HO2F/bf0NNF4AKnKsY7Y4Mg9d
	KcwJVfcti0+pzv4KrTLw8Mn2lc4yADCYvdXBWehS2JGUI4Lei8OQGhThSazdbxir60x8wZPcM8s
	W3eZ4MVF4so8SdENkquctAF/zwOS+6HJHVR1dfIgiATBfZSMWs0/n+TocIltxEN1kXJKU4SN0th
	yTJBB7xQOY8Rw7UlciqllRTXDhjAtDtFV3r2ASQqs/W9InbH/wJeyePRySedbA9ghMvuVUGrayU
	CXyHYWbjUDXe5rscuNZ/AO569hNlH5lXHLzjZx0jID1IckwGuQqyvApo
X-Received: by 2002:a05:622a:e159:10b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-535146449camr14146121cf.14.1791137386702; Sun, 04 Oct 2026
 11:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-19-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-19-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 11:09:35 -0700
X-Gm-Features: AclHuK-kwJ_Uo7kW-aV-ulJRzQPF_vjK2tdCaS-4gRgk6ACv9UztvH0OKE8MWEw
Message-ID: <CAJuCfpFKJ+31TZOWhwoTQTseOEy0AgAjz5eK9fdXmL40D0OY6Q@mail.gmail.com>
Subject: Re: [PATCH v4 19/38] HSI: cmt_speech: convert mmap hook to
 mmap_prepare, refactor
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
> Use the mmap_prepare in favour of the deprecated mmap hook as part of the
> work to convert one to another.
>
> Since this is simply a refcounted kernel page that has been allocated, it
> should not be marked VM_IO and should be inserted using the kernel page
> insertion mechanism, so convert it to do this instead.
>
> Use the VMA descriptor's private data field as a scratch buffer to store
> the page in - this stays valid throughout the kernel page mapping
> operation.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  drivers/hsi/clients/cmt_speech.c | 33 +++++++++------------------------
>  1 file changed, 9 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/hsi/clients/cmt_speech.c b/drivers/hsi/clients/cmt_s=
peech.c
> index 7226677ebde7..801697b74d4f 100644
> --- a/drivers/hsi/clients/cmt_speech.c
> +++ b/drivers/hsi/clients/cmt_speech.c
> @@ -1084,22 +1084,6 @@ static void cs_hsi_stop(struct cs_hsi_iface *hi)
>         kfree(hi);
>  }
>
> -static vm_fault_t cs_char_vma_fault(struct vm_fault *vmf)
> -{
> -       struct cs_char *csdata =3D vmf->vma->vm_private_data;
> -       struct page *page;
> -
> -       page =3D virt_to_page((void *)csdata->mmap_base);
> -       get_page(page);
> -       vmf->page =3D page;
> -
> -       return 0;
> -}
> -
> -static const struct vm_operations_struct cs_char_vm_ops =3D {
> -       .fault  =3D cs_char_vma_fault,
> -};
> -
>  static int cs_char_fasync(int fd, struct file *file, int on)
>  {
>         struct cs_char *csdata =3D file->private_data;
> @@ -1256,18 +1240,19 @@ static long cs_char_ioctl(struct file *file, unsi=
gned int cmd,
>         return r;
>  }
>
> -static int cs_char_mmap(struct file *file, struct vm_area_struct *vma)
> +static int cs_char_mmap_prepare(struct vm_area_desc *desc)
>  {
> -       if (vma->vm_end < vma->vm_start)
> -               return -EINVAL;
> +       struct file *file =3D desc->file;
> +       struct cs_char *csdata =3D file->private_data;
> +       struct page **pages =3D (struct page **)&desc->private_data;
>
> -       if (vma_pages(vma) !=3D 1)
> +       if (vma_desc_pages(desc) !=3D 1)
>                 return -EINVAL;
>
> -       vm_flags_set(vma, VM_IO | VM_DONTDUMP | VM_DONTEXPAND);
> -       vma->vm_ops =3D &cs_char_vm_ops;
> -       vma->vm_private_data =3D file->private_data;
> +       vma_desc_set_flags(desc, VMA_DONTDUMP_BIT, VMA_DONTEXPAND_BIT);
>
> +       *pages =3D virt_to_page((void *)csdata->mmap_base);
> +       mmap_action_map_kernel_pages_full(desc, pages);
>         return 0;
>  }
>
> @@ -1353,7 +1338,7 @@ static const struct file_operations cs_char_fops =
=3D {
>         .write          =3D cs_char_write,
>         .poll           =3D cs_char_poll,
>         .unlocked_ioctl =3D cs_char_ioctl,
> -       .mmap           =3D cs_char_mmap,
> +       .mmap_prepare   =3D cs_char_mmap_prepare,
>         .open           =3D cs_char_open,
>         .release        =3D cs_char_release,
>         .fasync         =3D cs_char_fasync,
>
> --
> 2.55.0
>
