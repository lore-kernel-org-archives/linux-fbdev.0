Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806BC2D5C92
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Sep 2025 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021779; cv=none; b=EhxTaSILosVPuMmpL+3ciftai9PdiAVjzLFxhM+6soqqrmX/RoRsMcVnT+cSQiTmT8wi9qCa6R+ad5iRyTongtBCw+alHOQT5mTXAyYRyudMsz08wVNFbuikxkW424ad7uLgtPGnmiZVvL7zWSTO8JrBS+2BdCd1yxMebRrrMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021779; c=relaxed/simple;
	bh=8kc0CeLZLfeiMXrcTaHIH/R4jGNR3faf9TtHlR/N16I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3MLbae1QWOONiWVunTzB7Ru1Zu3AFiCr2HYqDeYSCreXePI6lK7GrCZA9ZGEb/gsJt7WN54wxMjp0q6AtMjKKGrqH6n9Hpy2JUvyEcuUq3vU8fG0MwLfC4IHKFLWqu8oeauPngVwMOP60ucSV6W10JZwPvZH04dfu+pwcSGiog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MX5mipFP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MX5mipFP"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb78ead12so753081666b.1
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Sep 2025 04:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758021774; x=1758626574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0oabvOv3LnHYmSMEDkeEgkYTZEtABtHwxuQ+4V9AEw=;
        b=MX5mipFPNTEeqUz+RN5Bk3CNl2bgoRjnfeBCCnTpnZwFdVp2AUHOiZB5H0MhEXFS0p
         Dvt4wNOou4O/mbc4KNwTzf725/3AzR+10Z/Qcf1YHf3+GoDXPsZAA24cPXIGn1BIYv6Z
         t5/mSgVHEEDywFY1wbDcY3Hb1953rwYazW+fsPy0nB1lOL6BezBABOug+G5K9ac9xq7j
         /fThtfbNmg5zXKaDBBNNen2pvJpT40RlTjRPTnRG6O8o7Ff8JZIBYug8kwGktm9+/wR2
         Rx199khf/PS2JCs1L38dFm1F/xyMrobmsqVS3sk7iFpjrENvMRV/2jQcrd6aJ41jYpaM
         15jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021774; x=1758626574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0oabvOv3LnHYmSMEDkeEgkYTZEtABtHwxuQ+4V9AEw=;
        b=Up82nr4UHOgbd/dA7EIocODTcUgy0Rf4rcyq93wo5wHDIwAEcJWVY5PelC3KAhSW0n
         oBztWScdwhggdlbr2VrwIivBP5cujuXvFXJhO/1GxbF+b88X5zirMrSwU4GJXsbDio+b
         uMmN1GN1/o/OLLxuEQ6bAp8Boeh9qVXQKRi76JreCg+53wkuzzqeigYi7rKtseX+u1R9
         NnNaYobnmeX22VKKiq6KdB7HK3UPgNxkOBy8TH0PGvFEyCbkmoU+ePnCoNRrX+GXJfE7
         CAJJcXQul4NaEer8k61KenHUwliMPm+GQJB2b9avGRq6Ogm+ujisOq9p+XbNFf6R0Z3C
         s+Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUrd/uLK6MixlZjvMFAF+GBlBrL15k7mMcx3xosYprfETsuO8MjHMo1GaB3SGbFujlA0eARgWVIh/7bTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6xS4QtySkFzlyQFBN0UAsouhE32HZ9GJsUapUSnw/FmLiJ/kK
	NDm0CiZytY6ngXwmb7P6ZtaGnycus2uAogj+tBWNwrjWqJ2oTef7wkKFi7f89nfvdjM=
X-Gm-Gg: ASbGnctEwkLHXqm73cHtVagvUyBBBq9pAvnVw2lg7HGcXlNQ9+CrBqo2AjmnVUnTvww
	KF1BBbiQbO3a9C5Nnl3dNS6T07oPKEqwqbm+6n//BMKb0ew/kAKO/HaRAULaOFaLl3EcJhlJXv1
	gmf3QMt6EnIm2toFzHazb2sTeYafCO5RF5EbDe83w1+u3qd1SAeuXuIAhHQRk2gQ7iAveFCYrTF
	bVWevl80EqIXe392N2cc+g49YlzRlgoJ4ZyPaLdDMyOtz+/kC4tDE91lV5hi1B2X5GpoM2Zurts
	DDtHc38b5+87XlLOYgm5D9UbO0gxMpNyfiDqS69LIAhz1QaYZswQ4LpmljWDVvOrB9Z6NakCF6L
	nw7UDRyOIgsQ88q+RPjH8tdUl2Lkw4xCWQp6W+8OzXSCqcIVx2hs=
X-Google-Smtp-Source: AGHT+IHgksZmCXWo+aWrU2puhznGEL5CDcY5xl+DcR6ldtoPz+TwMIqHuYXw60VG60pLkMPaI+rleg==
X-Received: by 2002:a17:907:daa:b0:afe:7027:56f9 with SMTP id a640c23a62f3a-b07c3574efemr1811450966b.17.1758021773565;
        Tue, 16 Sep 2025 04:22:53 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f2098sm1157083666b.74.2025.09.16.04.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:22:53 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:22:51 +0200
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
Subject: Re: [PATCH v2 7/9] panic/printk: replace this_cpu_in_panic() with
 panic_on_this_cpu()
Message-ID: <aMlIi9cT7xiYWo29@pathway.suse.cz>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-8-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-8-wangjinchao600@gmail.com>

On Mon 2025-08-25 10:29:35, Jinchao Wang wrote:
> The helper this_cpu_in_panic() duplicated logic already provided by
> panic_on_this_cpu().
> 
> Remove this_cpu_in_panic() and switch all users to panic_on_this_cpu().
> 
> This simplifies the code and avoids having two helpers for the same check.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

It is great that the helper functions were consolidated and moved
from printk to panic code.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
