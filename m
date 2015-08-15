From: Timur Tabi <timur@tabi.org>
Date: Sat, 15 Aug 2015 03:45:15 +0000
Subject: Re: [PATCH v2] video: fbdev: fsl: Fix the sleep function for FSL DIU module
Message-Id: <55CEB5CB.4060803@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1439531649-46827-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1439531649-46827-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Cc: scottwood@freescale.com, Jason.Jin@freescale.com, linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org

Dongsheng Wang wrote:
> For deep sleep, the diu module will power off, when wake up
> from the deep sleep, the registers need to be reinitialized.
>
> Signed-off-by: Jason Jin<Jason.Jin@freescale.com>
> Signed-off-by: Wang Dongsheng<dongsheng.wang@freescale.com>

Acked-by: Timur Tabi <timur@tabi.org>

