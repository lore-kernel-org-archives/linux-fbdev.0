From: Scott Wood <scottwood@freescale.com>
Date: Mon, 07 Dec 2015 17:07:22 +0000
Subject: Re: [PATCH v3] video: fbdev: fsl: Fix kernel crash when diu_ops is not implemented
Message-Id: <1449508042.15946.56.camel@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449107652-5134-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1449107652-5134-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 2015-12-03 at 09:54 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> If diu_ops is not implemented on platform, kernel will access a NULL
> pointer. We need to check this pointer in DIU initialization.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> v3:
> - Fix capitalization in patch description.
> - Add comments for verify diu_ops.set_pixel_clock.
> 
> v2:
> - Move set_pixel_clock judgement to fsl_diu_init.
> 
>  drivers/video/fbdev/fsl-diu-fb.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Why did you not CC stable as I previously requested?

-Scott

