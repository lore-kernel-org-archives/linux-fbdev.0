From: Ingo Molnar <mingo@kernel.org>
Date: Fri, 29 May 2015 06:41:44 +0000
Subject: Re: [PATCH v4 3/17] video: fbdev: gbefb: use arch_phys_wc_add() and devm_ioremap_wc()
Message-Id: <20150529064144.GA22749@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432859434-17821-1-git-send-email-mcgrof@do-not-panic.com>
 <1432859434-17821-3-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1432859434-17821-3-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Masanari Iida <standby24x7@gmail.com>, Suresh Siddha <sbsiddha@gmail.com>, Ingo Molnar <mingo@elte.hu>, Andy Lutomirski <luto@amacapital.net>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>


* Luis R. Rodriguez <mcgrof@do-not-panic.com> wrote:

> +		gbe_mem = devm_ioremap_wc(&p_dev->dev, gbe_mem_phys,
> +					  gbe_mem_size);

> +		gbe_mem = dma_alloc_writecombine(NULL, gbe_mem_size,
> +						 &gbe_dma_addr, GFP_KERNEL);

> +	par->wc_cookie = arch_phys_wc_add(gbe_mem_phys, gbe_mem_size);

> +	arch_phys_wc_del(par->wc_cookie);

> +	arch_phys_wc_del(par->wc_cookie);

Could we _please_ rename dma_*_writecombine() to dma_*_wc(), so that the naming is 
coherent across the various APIs?

Thanks,

	Ingo
