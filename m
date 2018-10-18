From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Thu, 18 Oct 2018 12:00:40 +0000
Subject: Re: [PATCH 7/8] media: sti/bdisp: don't pass GFP_DMA32 to dma_alloc_attrs
Message-Id: <CA+M3ks5ebGDgFtMS5mSYz38AnyrTMQr8C_JkbFEzp=k+izJjUQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181013151707.32210-1-hch@lst.de> <20181013151707.32210-8-hch@lst.de>
 <CA+M3ks5KO-Yr_PEczaENhTfirthFz2gW1uv4bwZe5mjy3-jZyg@mail.gmail.com> <20181017072020.GD23407@lst.de>
In-Reply-To: <20181017072020.GD23407@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, ML dri-devel <dri-devel@lists.freedesktop.org>, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@kernel.org>

Le mer. 17 oct. 2018 à 09:20, Christoph Hellwig <hch@lst.de> a écrit :
>
> On Mon, Oct 15, 2018 at 11:12:55AM +0200, Benjamin Gaignard wrote:
> > Le sam. 13 oct. 2018 à 17:18, Christoph Hellwig <hch@lst.de> a écrit :
> > >
> > > The DMA API does its own zone decisions based on the coherent_dma_mask.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>
> Can you pick it up through the media tree?

No but Mauros or Hans (in CC) can add it.
