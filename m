From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Apr 2018 15:56:00 +0000
Subject: Re: [PATCH] video: fbdev: core: Change return type to vm_fault_t
Message-Id: <3519342.V5zGb1J1bc@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180414193506.GA31523@bombadil.infradead.org>
In-Reply-To: <20180414193506.GA31523@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sunday, April 15, 2018 01:19:30 AM Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler
> and page_mkwrite handler.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

