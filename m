From: "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Mon, 26 Jun 2017 18:21:05 +0000
Subject: Re: [PATCH 07/11] 53c700: switch to dma_alloc_attrs
Message-Id: <yq1efu6390u.fsf@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170616071716.17321-1-hch@lst.de>
        <20170616071716.17321-8-hch@lst.de>
In-Reply-To: <20170616071716.17321-8-hch@lst.de> (Christoph Hellwig's message
        of "Fri, 16 Jun 2017 09:17:12 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org, netdev@vger.kernel.org, linux-metag@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org


Christoph,

> Use dma_alloc_attrs directly instead of the dma_alloc_noncoherent
> wrapper.

Applied to 4.13/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
