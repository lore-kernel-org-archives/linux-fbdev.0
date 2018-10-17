From: Christoph Hellwig <hch@lst.de>
Date: Wed, 17 Oct 2018 07:20:20 +0000
Subject: Re: [PATCH 7/8] media: sti/bdisp: don't pass GFP_DMA32 to dma_alloc_attrs
Message-Id: <20181017072020.GD23407@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181013151707.32210-1-hch@lst.de> <20181013151707.32210-8-hch@lst.de> <CA+M3ks5KO-Yr_PEczaENhTfirthFz2gW1uv4bwZe5mjy3-jZyg@mail.gmail.com>
In-Reply-To: <CA+M3ks5KO-Yr_PEczaENhTfirthFz2gW1uv4bwZe5mjy3-jZyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, ML dri-devel <dri-devel@lists.freedesktop.org>, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Oct 15, 2018 at 11:12:55AM +0200, Benjamin Gaignard wrote:
> Le sam. 13 oct. 2018 =E0 17:18, Christoph Hellwig <hch@lst.de> a =E9crit :
> >
> > The DMA API does its own zone decisions based on the coherent_dma_mask.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>=20
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Can you pick it up through the media tree?
