Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B62D6E64
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Sep 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021814; cv=none; b=OrZ7+Qv15VslWMP0ONFi/s10IHIR+D3EIr0wkj6j+yrNz4n5vFN0oQWVLsLQ+C44xAUrODHH8DRFp+cmgGJqUK1owqxbfzwvPYVeKUuo2SKae250NjYCDbIpidE3gFD+8LURtdyxjFYfl9iyoQOYrrt5ckE/szmz7IRXUlVgZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021814; c=relaxed/simple;
	bh=Gjb8euWhpxYPXfp/FaJb+FpWV2lF87I07NelregEU0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj3tmI/RT/2PcRmjeGtuzhcueY2Dy6zDLFcKupO4kkQ7Xhb9yc36kEbatR2trt7LfRuVRiHhtMjMH+c6pC4Ph/BubvTF2DGjVF5xNyysQ5dc50hWo1Z3j7L7B9I/bUJxQA6TeT0pAseI8tbeIqkSocaqLQ5jS0qtA5Nbtq+9qsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GU84kVvd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GU84kVvd"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0473327e70so274558666b.3
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Sep 2025 04:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758021811; x=1758626611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxtZUSssqP8QQ4xDjcwfBCGzgO78XtwgCRIXLf8n188=;
        b=GU84kVvdmi+t3YvgzOqWiakAstZsra7MM6IDccRx2ap8XaT+vCnYDlUyVTaKv2kq9P
         qR1Np0ODMticDk2YaRADHLhIvy3yz/axKDfRgGvzgML4DrkJYWrE4cs3BJ64+lSNSucT
         Yh6W+L3jFBlRKPibe9erSnKEQ48nJylcr6bRIMLkDXwUlPt9uFpssVatbBxSu6OOfKdf
         bG2M1xUX2SMBfjNESOMsOIYatFlHlH3XQhpe/56XBUVgqpaRQFvcz4HHYLit9zfv263A
         Z9+VAmPNtOJfHvVvdVr6Zn7S/yUU/hrID+sFO8hrkiPqGJ7t7909kJl4Oicri+BdHl25
         Xkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021811; x=1758626611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxtZUSssqP8QQ4xDjcwfBCGzgO78XtwgCRIXLf8n188=;
        b=nGmZNDuH5TtsfmBe5G0gw1TrFjxwamcx6IVwLu2e7Y9tQytCZXE+TRmzd+qwXE32Za
         7WIgXw7mwWwGku4zFp2Ejfz3O9zd2eWEbSPbkuY/ZHKhuzsbnOLzaVkMXpF7N+TU/IEZ
         uJ7VbJbkhG3H/1ev9p1Ir2/js5q5umcJ2B0yvJsriverbYypJ6hJU0AhYtoTo0PeB8Si
         9q3eAGv8SojuDTRVqPqIsmOCsVq9dgFyNirwK/z12eKor8g1StvCCIFx7znjXhtBC422
         rBF6nnFmg8UmVcNJDUoC6cRgJq8HBLjjUxhWw2MdmfDOJc2msbytJL4OhjOtQD0yzp9Z
         lDcw==
X-Forwarded-Encrypted: i=1; AJvYcCU1mM6Sllnog2GwceTRXjiJTIudBdc8P4gQBh0pzbkefYh96hIfTPxCbGtYzhVxtGX4MT3N5IuncIhGNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQITN0vttSZF9JKYHd5q1AnDXTi81aqNhobrz3FKmlnFewlgE3
	ORYM5a6tLVTHZxPd1x3hpjTkqwoL2wYc1epYtX1FLjexb67Mp96IpTg+gohWvutv+2I=
X-Gm-Gg: ASbGncsTEy1JC1oHImaR6ghJ+YJZxKreOCi/srOp0kCKCkoNlVqRNMCP3GJWXeObbKY
	rKGeQNFUbmQJ/1/E8Wi4yIOwyC5rf+fV9AK/MU+EgZhAIBUphNL4AYj5CwelXC4aIHGlRStWJQ+
	ubbsPKe1MXAX+Mv7OfTfBVhhDtkxxi2ddNd2Y/R7CVQTXbJ69l5m5zOHyYFJsrfXIuGiXmstK8L
	fqPwMRFLgsbi0+5JlnOFwkCBCZcPYx3+C/0MM3JPbklSRpmYyCreiRi766ZE2broU7pbd+ov030
	emrsCm41DpKZ3CYeD/Na/UhNLQcZRBNln+sPaweq82IiLvsxnh1Eoin/Nh/TWXhAeMTmJXSQ9m/
	oXEXSktcRFv1g62sgFnIkkd9Fnz7MFeSjW/lnifO8
X-Google-Smtp-Source: AGHT+IHpyTR/3eF3SMuNwTyjqfOeFBdU6maF0JBSLHjxTUYrHkZ3Z43YeF6fl1FdRdLJxJTI3BmjLQ==
X-Received: by 2002:a17:907:7e83:b0:ad5:d597:561e with SMTP id a640c23a62f3a-b07c3a7bd75mr1672253566b.56.1758021811303;
        Tue, 16 Sep 2025 04:23:31 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd5a9sm1125541966b.57.2025.09.16.04.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:23:30 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:23:28 +0200
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
Subject: Re: [PATCH v2 8/9] panic/printk: replace other_cpu_in_panic() with
 panic_on_other_cpu()
Message-ID: <aMlIsOH1dirXjrE1@pathway.suse.cz>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-9-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-9-wangjinchao600@gmail.com>

On Mon 2025-08-25 10:29:36, Jinchao Wang wrote:
> The helper other_cpu_in_panic() duplicated logic already provided by
> panic_on_other_cpu().
> 
> Remove other_cpu_in_panic() and update all users to call
> panic_on_other_cpu() instead.
> 
> This removes redundant code and makes panic handling consistent.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Looks good:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
