Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0627CCEE
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Sep 2025 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021607; cv=none; b=aiGjnIgolqG5UvqLIU94akpARIQWo582GqojM5QwjReC7Y2TtFpVVoMlDBM89uTjcyedoLUp0FNpnMiL5GxZdTeI5WdSDIqDfSWqj/eqHM0Sjgp2oySCs0v+jgW6F+uNuVNXUtUDoGl2zxowONyzAB0RUKVyhUJfxDxR+x/kONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021607; c=relaxed/simple;
	bh=6Z9HRjTpL6Nieh/l8DUnXky6k1yn+f7s/1vHrl9qB4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kD1ryZqx2NK5lsxMZc9n2Y71Sfd+K5MTpLxH6N7UkMMeEl9G4IXaXVm2TT3ha6W69MobITgMT5jbRXrI47yac/ViP+r9dDEVO3IragUAWLcSAi65f9m+Er17/alEq77mtUvdalYZOHYdYbgUXXy5gviEWhDM6lKZZkjttUQUHF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dyx8krGl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dyx8krGl"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b04ba3de760so672945666b.0
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Sep 2025 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758021603; x=1758626403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZkAhMwtG05Nwx51W4BF/MbpYhaSp+19IYTVLsAUUIs=;
        b=dyx8krGlkJ+bN6N/1EC2gdPehKi6Wv+V9WBXYWTQeGMozo1NA0WsqPDwfRESHZlwCL
         BYph7tYGEJXF8GCj0gchAlOxgbzjOWlzKg5p2klpZ0mugRQKMlzmHWmfXQpqaJxJ0Cm7
         9gNR9ljMCcj+OXFiMxiE7C0aRrZCHZTjTDFWY9DPN6BNlBp9k982I3GE8/L4YVUu1sl2
         1O89EwJe92An9EsGkORsSeJ+nod7KKY8cA/mW0BThidUzldTpRZsMZw1RP4nDXli+MeJ
         ens76EITeYSKVmqb8rXvjDjD+fZqdIh0m8lJPgKFjE+5G93TApLLNH4tVOp/8H4ui3ea
         t54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021603; x=1758626403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZkAhMwtG05Nwx51W4BF/MbpYhaSp+19IYTVLsAUUIs=;
        b=FQUVXKWkjJnjNj6bajHtnHpyW9YOafKoOM6fm4kPBspDtfo77ejAHFHYsTTeB1SfVH
         NGXSO+JYawGEI/MBgQqc0AN6IjFxspSDL2FOOJi6Uk0oJSB4RadhJLNrlyERYhFCJydL
         dXXQzhXuqKj2YE+NXXBevvYlH/9+Cz0z8jU22oY9aa7UtxV3BMVGZ/53QxOmt1pTY1mL
         aIg+Seatq+5ieSfYLxFH8jvowqRlCkYWCDB2ypzFD0H/HVAgqrqWGmXsUcpTjvNBfLOE
         5sevRYf/HNW7Hj8lrbp6rkjNw/dpa8/NDLdbf3KPAMetlV0qXa1rZRMZ1yOaNbS4JDT6
         ZWuA==
X-Forwarded-Encrypted: i=1; AJvYcCUOPIptUH1nODzOrW7v964ESrExUGc/TwMxdCWVx+ohtknU3ambkF9v7f6nrQBxciLUl9VMBR+bIkv+rA==@vger.kernel.org
X-Gm-Message-State: AOJu0YysaJ9J6XX0MlHklaLVt42KVvzfRevMHqrbTx+W/aVymi+26Mhm
	UhsEY/HCdnDNcMeKoU4kWekPVWEfDZRKJqINtOd8ip/vFtZ5v3OXprctS6tn94hcOO0=
X-Gm-Gg: ASbGnctlZVb31YfZgHcqq44GdpuXfR9c7Hxhk0705ivW36dYG1sjNj7gDC6HdG0o3ak
	pwo2ZtwN+4CVvMvlRUZMaCv1v3Z6eKwbEtl97GRleUUT9S8xClBDBRjpUZeJlziD1bUfFkLlJhB
	Y1mWrqsd8ARA4LTDiOOEZEjy+sJIXBuTmuqIS0Mt0wCPN6AU7avt5pJQC5ZlMg9Bk7+Yn30Fqff
	e+/0yzcQk+Y2Fn3ASMrB/D82klruQBpYUq7vSFkfpRsMeFHvO7pYlM7PFyvTRn6WqtZQb0H+aSp
	gzrnlm+Q+gcoRAhjSeSShA6Lbq8DVDdMGPu9b6v71N/VCs9GHO4fY6WN1FvJ9e/A5hJB+R1NaZE
	hq3+yZe7uB/nU+ldAzQSZqzcF2FVTfAQInmFJQudQ
X-Google-Smtp-Source: AGHT+IGYOku1dWOd7XgyZFqiTBP3WC2b/azuNq9E2ePki1CNpOxLiy1c6JRukGNdqA80ZoAb+KYahA==
X-Received: by 2002:a17:906:c153:b0:b04:8c45:4bdb with SMTP id a640c23a62f3a-b07c37fb543mr1468835066b.34.1758021602813;
        Tue, 16 Sep 2025 04:20:02 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f3919e168sm4212344a12.34.2025.09.16.04.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:20:02 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:20:00 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Qianqiang Liu <qianqiang.liu@163.com>,
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Zsolt Kajtar <soci@c64.rulez.org>, Ingo Molnar <mingo@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Sohil Mehta <sohil.mehta@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>, Tejun Heo <tj@kernel.org>,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] panic: use panic_try_start() in vpanic()
Message-ID: <aMlH4CcK_n1I1gY2@pathway.suse.cz>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-6-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-6-wangjinchao600@gmail.com>

On Mon 2025-08-25 10:29:33, Jinchao Wang wrote:
> vpanic() had open-coded logic to claim panic_cpu with atomic_try_cmpxchg.
> This is already handled by panic_try_start().
> 
> Switch to panic_try_start() and use panic_on_other_cpu() for the fallback
> path.
> 
> This removes duplicate code and makes panic handling consistent across
> functions.
> 
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -415,7 +415,6 @@ void vpanic(const char *fmt, va_list args)
>  	static char buf[1024];
>  	long i, i_next = 0, len;
>  	int state = 0;
> -	int old_cpu, this_cpu;
>  	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
>  
>  	if (panic_on_warn) {
> @@ -452,13 +451,10 @@ void vpanic(const char *fmt, va_list args)
>  	 * `old_cpu == this_cpu' means we came from nmi_panic() which sets
>  	 * panic_cpu to this CPU.  In this case, this is also the 1st CPU.
>  	 */

The above comment does not fit any longer. I think that it can
be removed, maybe except for the 1st paragraph.

> -	old_cpu = PANIC_CPU_INVALID;
> -	this_cpu = raw_smp_processor_id();
> -
>  	/* atomic_try_cmpxchg updates old_cpu on failure */

Also this comment should be removed.

> -	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
> +	if (panic_try_start()) {
>  		/* go ahead */
> -	} else if (old_cpu != this_cpu)
> +	} else if (panic_on_other_cpu())
>  		panic_smp_self_stop();
>  
>  	console_verbose();

Otherwise, it looks good. And the comments might be removed
by a followup patch.

Best Regards,
Petr
