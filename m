From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Sat, 30 May 2015 00:32:56 +0000
Subject: Re: [PATCH v4 3/17] video: fbdev: gbefb: use arch_phys_wc_add() and devm_ioremap_wc()
Message-Id: <20150530003256.GG23057@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432859434-17821-1-git-send-email-mcgrof@do-not-panic.com>
 <1432859434-17821-3-git-send-email-mcgrof@do-not-panic.com>
 <20150529064144.GA22749@gmail.com>
In-Reply-To: <20150529064144.GA22749@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@kernel.org>, tomi.valkeinen@ti.com, Dave Airlie <airlied@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Masanari Iida <standby24x7@gmail.com>, Suresh Siddha <sbsiddha@gmail.com>, Ingo Molnar <mingo@elte.hu>, Andy Lutomirski <luto@amacapital.net>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Fri, May 29, 2015 at 08:41:44AM +0200, Ingo Molnar wrote:
> 
> * Luis R. Rodriguez <mcgrof@do-not-panic.com> wrote:
> 
> > +		gbe_mem = devm_ioremap_wc(&p_dev->dev, gbe_mem_phys,
> > +					  gbe_mem_size);
> 
> > +		gbe_mem = dma_alloc_writecombine(NULL, gbe_mem_size,
> > +						 &gbe_dma_addr, GFP_KERNEL);
> 
> > +	par->wc_cookie = arch_phys_wc_add(gbe_mem_phys, gbe_mem_size);
> 
> > +	arch_phys_wc_del(par->wc_cookie);
> 
> > +	arch_phys_wc_del(par->wc_cookie);
> 
> Could we _please_ rename dma_*_writecombine() to dma_*_wc(), so that the naming is 
> coherent across the various APIs?

Sure, OK done. Will send once this series is merged and visible on linux-next.
But who's tree should this go through? Since it depends on this series which
goes through Tomi's tree should it go through there?

 Luis
