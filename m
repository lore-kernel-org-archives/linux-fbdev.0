From: Mauro Carvalho Chehab <mchehab@kernel.org>
Date: Wed, 05 Dec 2018 10:31:29 +0000
Subject: Re: [PATCH 7/8] media: sti/bdisp: don't pass GFP_DMA32 to dma_alloc_attrs
Message-Id: <20181205083129.20b6b0be@coco.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181013151707.32210-1-hch@lst.de>
 <20181013151707.32210-8-hch@lst.de>
 <CA+M3ks5KO-Yr_PEczaENhTfirthFz2gW1uv4bwZe5mjy3-jZyg@mail.gmail.com>
 <20181017072020.GD23407@lst.de>
 <CA+M3ks5ebGDgFtMS5mSYz38AnyrTMQr8C_JkbFEzp=k+izJjUQ@mail.gmail.com>
In-Reply-To: <CA+M3ks5ebGDgFtMS5mSYz38AnyrTMQr8C_JkbFEzp=k+izJjUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, ML dri-devel <dri-devel@lists.freedesktop.org>, linux-spi@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>, linux-tegra@vger.kernel.org, Christoph Hellwig <hch@lst.de>, linux-media@vger.kernel.org

Em Thu, 18 Oct 2018 14:00:40 +0200
Benjamin Gaignard <benjamin.gaignard@linaro.org> escreveu:

> Le mer. 17 oct. 2018 à 09:20, Christoph Hellwig <hch@lst.de> a écrit :
> >
> > On Mon, Oct 15, 2018 at 11:12:55AM +0200, Benjamin Gaignard wrote:  
> > > Le sam. 13 oct. 2018 à 17:18, Christoph Hellwig <hch@lst.de> a écrit :  
> > > >
> > > > The DMA API does its own zone decisions based on the coherent_dma_mask.
> > > >
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>  
> > >
> > > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>  
> >
> > Can you pick it up through the media tree?  
> 
> No but Mauros or Hans (in CC) can add it.

I'm adding it. Sorry for the delay. All those trips for MS/KS made
harder to handle it earlier.

Thanks,
Mauro
