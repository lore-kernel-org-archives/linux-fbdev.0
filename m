From: Christoph Hellwig <hch@lst.de>
Date: Tue, 25 Jun 2019 12:09:27 +0000
Subject: Re: [PATCH 3/3] jz4740_fb: fix DMA API abuse
Message-Id: <20190625120927.GA4205@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190509173849.11825-1-hch@lst.de> <CGME20190509173943epcas2p27a7106894d5a235a405a94e84340b416@epcas2p2.samsung.com> <20190509173849.11825-4-hch@lst.de> <8a149d05-047b-6df1-28fc-184dae9c32df@samsung.com> <16211aea-cd48-2d68-7ba9-d81b126d81cf@samsung.com>
In-Reply-To: <16211aea-cd48-2d68-7ba9-d81b126d81cf@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Manuel Lauss <manuel.lauss@gmail.com>, linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 01:32:16PM +0200, Bartlomiej Zolnierkiewicz wrote:
> I've just removed the "Switch the driver.." sentence myself from
> the patch description and applied the change, thanks!

Sorry for not getting back to you earlier and thanks for fixing this
up and applying the patch.
