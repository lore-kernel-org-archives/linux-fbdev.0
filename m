Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792532922;
	b=4qZDz31zOQiBQb++1Bcz0lyOU95HLpWvY7REltHPgcqYLINEprf971EiVaPB0Vy/IcXN
	 4tV+4duF/IEOVO7YBnqq6MUgToK3fELvJRyYtK5qxJYkpRZJMm4XOBj8SINc0+iCDULqC
	 ehUA8KnWu/SUthIn5aVyzxrJUMIseI8lZC6s2JiV8H+C30cTIPjuhW/V0c0du6G/ZHvYV
	 KIVozcC/W9rnW6qg1NC64Abc2SQecMmimSkUOICxGafx1OIWW5jDhyYeTmGKvDhoXOw1z
	 Wqoglf14WbjWBCDGcTTT4HZDnzN5rhEtTqxmYfflHzyhgJ1SU0Jn7H7pF16X20Qfasw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=lwH5lbGW7Jp7v2pgahH/8u5d5Q1US/ZAJYtMLpAtA4s=;
	b=dzR1WZWua2GNJlSW6W3l+nhr+GzqKno7F4nBPFCxNOz+S86g+HagK5PdbEm2JlyS9/fw
	 TGl2Yqiyg5/kdrbs36Go9k1aEFQMNgpGo0kM/amOvqxixq78RCJBuNtE+HBYSa6yrDJk8
	 1XSdYslS6ScoYApihWVPEH6hQoYZ6ZStxGUEoUc5m2HtFGt/qbYEbx97F8dtjvIfZuFG3
	 2wpEhxQXjeOlquYTZkpo/ZE/oMMVBmPaOF3t3Bdh1rraaWbt/WQU8B85RswLh6Mp/e5s/
	 BcpSnpfNt5qce6qM93njosqC7rOq4ykTqEOYUgTWXxzyv7EYyfgNrizzsnK/pUDYb5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Vnm419Qa;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A956D606A325
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Oct 2026 21:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A956D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Vnm419Qa
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91b89c6caffso1149216d6.2
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Oct 2026 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792532920; x=1793137720; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lwH5lbGW7Jp7v2pgahH/8u5d5Q1US/ZAJYtMLpAtA4s=;
        b=Vnm419Qa/kjE27NqFknpFQG1AEpyq49ddgDDuGG4m4PuK8jB4BIucxesyWwSf4SEa0
         uSz2H8eWQ3QAQVj6mvZloHz1ezWLtzmCORiSuo4nvX/Y89/2PHrTr2TW0P6Tm5o1c13y
         kFggrh0Im+PIpGTSB7fqkFQNt8NQtpgWN8Og3tQl5MkWnwnj8MF/yt/hQt64q5Q4ESGC
         hfbLwpJB1hqraCnMet5mFnXiToBilJJr7Z42YzL3pjg2EM6cMOlxUZWGIUnaMwpSxLeW
         e0X1EurcmLyvexnjMFYKgO/omwKsQow1isD1OoopS7BI9x0SWOD2yG9zXJviPhqLpw95
         dF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792532920; x=1793137720;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lwH5lbGW7Jp7v2pgahH/8u5d5Q1US/ZAJYtMLpAtA4s=;
        b=vABTQV/CyDUpDp2AGki/vNFvyjfY18Xc6MXVVB4Dyxc/6bzi9fVcCslPGocijmXU4O
         SOfzwY12VQ6PQUQJ8xJFn41hGM1O+atwK+9yYfCoHy2U6XBzStAzklgfmRt7HnKGr/gM
         uOwCxewfPIqgly1p3olRjkMM0zWJPLsxqJGO+aULPAdhURbTlV9n70ONuIJg6U9+uPPy
         nFWwbcsx9t4uFygQOa4uRihs+YyY8sQRh4sTHVzPfIAZ17dWMTgkCiGqqFrsSgMyKeuW
         thIMSaA44MWe1/7XoDvkPDL48ph33i0pEdBBjyvVRPUnIuPs2FllOIbEu9i4EGI78QPy
         f9bw==
X-Forwarded-Encrypted: i=1; AKwUvBwqHgMjTn++weLXV6550WyPmi5EadXX4KlWaXliHlTSEllXtKM9t7ELtRIDuavz6Ow16yNOp1n7BTksdw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJx0ZyTXhM1WoI3xYZx1LZ4mkg6uapNUK0EOzFR4k6LOAaZ9ELZ
	fL4ao1PdVDGKc6CZJ6jMEZDvxg3LmXuejvbEJK8fAp4Kfz11q4e5GNe/9IcT2KybcAm/gpWkELD
	GRUX+
X-Gm-Gg: AYBFou26tRMgQAE92PC6Ok9Ueh3zQ6JbMQYnslcXl07mctBKWcsHiJkjHf5u0HQ2RA1
	3jNpfXBMO339U3V0KM6+ksEe9OaKLOeY1H06A4Wyo56ImUfoBLC3kJIrVdrGnusPzkiACmACmTk
	nJ2HM7dyDw5jLmDML2RZ3IZRgT1Gu1ZECjX/y7IMMEqAH+4xzr2ydHU6BKmT+UuZRLqpzhYai9f
	Elu1OKeEFMPr1m8RM/JwaOGWX7IsjNm3eMtrRxQ2lVtupq/QKJOkbQ9NZIuwE8CcdkYS4NZ2Xcq
	eSZ0stErvHZle05GK92JrkEvVe2a19+9Muhys2uHHVKeGNl9xyIDYhQQLjYFUt2AtU7WySWalJV
	QIyC8MPFkTAPrnlO6jnHrHHNJi1Yka2SH3A1sp37wsbCkD0/uIwHRykGov51R8l8o9LiecZrYwZ
	JgcdAJj0zk74gZnRgFAjo2CnhCk+K9UVnP+2M8hciWB91JQ5HxsqvlS2Yd3XFAJgO7WQ4Rx6HCw
	appcP7Hzuq8Wup+VcisHhD3Jk9Okt/vzxvETmnTMRrpLw==
X-Received: by 2002:a05:6214:3c86:b0:91b:5d3a:5105 with SMTP id 6a1803df08f44-91c12f580cemr1790346d6.51.1792532920531;
        Tue, 20 Oct 2026 14:48:40 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10bc99a7sm8625276d6.22.2026.10.20.14.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 14:48:37 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 07/39] mm: assert mmap lock held, use new flags API
 in vm_insert_page[s]
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Youngjun Park <youngjun.park@lge.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Michal Hocko <mhocko@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-rdma@vger.kernel.org, selinux@vger.kernel.org, 
 linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
 fuse-devel@lists.linux.dev, Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Bert Karwatzki <spasswolf@web.de>
In-Reply-To: <20261013-b4-mmap-prepare-vma-flag-sanify-v6-7-1aa3c9b139f9@kernel.org>
References: <20261013-b4-mmap-prepare-vma-flag-sanify-v6-0-1aa3c9b139f9@kernel.org>
 <20261013-b4-mmap-prepare-vma-flag-sanify-v6-7-1aa3c9b139f9@kernel.org>
Date: Tue, 20 Oct 2026 17:48:32 -0400
Message-Id: <179253291264.1207257.80392040365771672.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-13 16:04 +0100, Lorenzo Stoakes (ARM) wrote:
> The existing logic asserts that an mmap write lock is held, bizarrely, by
> asserting that an mmap_read_trylock() fails (which is not the same thing).
> 
> Assert the mmap write lock here and switch to using the new VMA flags API
> while here.
> 
> Note that the vma_start_write() is explicitly broken out from
> vm_flags_set() here in order to use vma_set_flags() safely.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
