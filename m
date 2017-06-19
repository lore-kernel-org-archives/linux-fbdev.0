From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 19 Jun 2017 11:15:04 +0000
Subject: Re: [PATCH 03/11] au1100fb: remove a bogus dma_free_nonconsistent call
Message-Id: <8727942.IUH8e0tH8t@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170616071716.17321-1-hch@lst.de>
        <20170616071716.17321-4-hch@lst.de>
        <CGME20170619111507epcas5p47fd18b90a02d827da256ff4ebbda8089@epcas5p4.samsung.com>
In-Reply-To: <20170616071716.17321-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org, netdev@vger.kernel.org, linux-metag@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org

On Friday, June 16, 2017 09:17:08 AM Christoph Hellwig wrote:
> au1100fb is using managed dma allocations, so it doesn't need to
> explicitly free the dma memory in the error path (and if it did
> it would have to use the managed version).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

