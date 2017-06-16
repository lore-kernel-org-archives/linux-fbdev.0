From: Christoph Hellwig <hch@lst.de>
Date: Fri, 16 Jun 2017 08:51:47 +0000
Subject: Re: [alsa-devel] [PATCH 04/11] sound/hal2: switch to dma_alloc_attrs
Message-Id: <20170616085147.GA11211@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170616071716.17321-1-hch@lst.de> <20170616071716.17321-5-hch@lst.de> <s5h1sqkb9l7.wl-tiwai@suse.de>
In-Reply-To: <s5h1sqkb9l7.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Jun 16, 2017 at 10:49:56AM +0200, Takashi Iwai wrote:
> On Fri, 16 Jun 2017 09:17:09 +0200,
> Christoph Hellwig wrote:
> > 
> > Use dma_alloc_attrs directly instead of the dma_alloc_noncoherent wrapper.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Should I take this one through sound git tree, or would you prefer
> taking all through another?

Feel free to take it through the sound tree.
