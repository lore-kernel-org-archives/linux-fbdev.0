From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Wed, 21 Aug 2013 14:27:24 +0000
Subject: Re: [PATCH 1/2] [RFC PATCH v6] dmabuf-sync: Add a buffer synchronization framework
Message-Id: <20130821142724.GF2593@phenom.dumpdata.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1376385576-9039-1-git-send-email-inki.dae@samsung.com>
 <1376385576-9039-2-git-send-email-inki.dae@samsung.com>
 <20130820192228.GE12037@phenom.dumpdata.com>
 <008201ce9e4a$08d1d1a0$1a7574e0$%dae@samsung.com>
In-Reply-To: <008201ce9e4a$08d1d1a0$1a7574e0$%dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Inki Dae <inki.dae@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linaro-kernel@lists.linaro.org, dri-devel@lists.freedesktop.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org

> > > +EXPORT_SYMBOL(is_dmabuf_sync_supported);
> > 
> > _GPL ?
> > 
> > I would also prefix it with 'dmabuf_is_sync_supported' just to make
> > all of the libraries call start with 'dmabuf'
> > 
> 
> Seems better. Will change it to dmabuf_is_sync_supported, and use
> EXPORT_SYMBOL_GPL.

One thing thought - while I suggest that you use GPL variant
I think you should check who the consumers are. As in, if nvidia
wants to use it it might make their lawyers unhappy - and in turn
means that their engineers won't be able to use these symbols.

So - if there is a strong argument to not have it GPL - then please
say so. 
