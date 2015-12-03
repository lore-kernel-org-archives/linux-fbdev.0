From: Timur Tabi <timur@tabi.org>
Date: Thu, 03 Dec 2015 14:03:02 +0000
Subject: Re: [PATCH v3] video: fbdev: fsl: Fix kernel crash when diu_ops is not implemented
Message-Id: <56604B96.1030900@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449107652-5134-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1449107652-5134-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Dongsheng Wang wrote:
> From: Wang Dongsheng<dongsheng.wang@freescale.com>
>
> If diu_ops is not implemented on platform, kernel will access a NULL
> pointer. We need to check this pointer in DIU initialization.
>
> Signed-off-by: Wang Dongsheng<dongsheng.wang@freescale.com>

Acked-by: Timur Tabi <timur@tabi.org>
