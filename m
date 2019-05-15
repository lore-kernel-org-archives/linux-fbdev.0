From: Manuel Lauss <manuel.lauss@gmail.com>
Date: Wed, 15 May 2019 11:10:32 +0000
Subject: Re: [PATCH 2/3] au1200fb: fix DMA API abuse
Message-Id: <CAOLZvyG14NvbgX4PA5aafk=reLcHbqDswqS-8j4+7QJMx02d7A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190509173849.11825-1-hch@lst.de> <20190509173849.11825-3-hch@lst.de>
In-Reply-To: <20190509173849.11825-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux-MIPS <linux-mips@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Servus Christoph,

On Thu, May 9, 2019 at 7:39 PM Christoph Hellwig <hch@lst.de> wrote:
> Virtual addresses return from dma(m)_alloc_attrs are opaque in what
> backs then, and drivers must not poke into them.  Similarly caching
> modes are not supposed to be directly set by the driver.  Switch the
> driver to use the generic DMA API mmap helper to avoid these problems.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/video/fbdev/au1200fb.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)

Runs fine on my test system.

Tested-by: Manuel Lauss <manuel.lauss@gmail.com>
