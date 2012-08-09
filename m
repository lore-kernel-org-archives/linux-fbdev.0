From: David Brown <davidb@codeaurora.org>
Date: Thu, 09 Aug 2012 17:57:12 +0000
Subject: Re: [PATCH 4/5] drivers/video/msm/mddi_client_dummy.c: use devm_ functions
Message-Id: <20120809175712.GA24215@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344008414-2894-1-git-send-email-damien.cassou@lifl.fr>
 <1344008414-2894-6-git-send-email-damien.cassou@lifl.fr>
In-Reply-To: <1344008414-2894-6-git-send-email-damien.cassou@lifl.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Damien Cassou <damien.cassou@lifl.fr>
Cc: kernel-janitors@vger.kernel.org, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 03, 2012 at 05:40:14PM +0200, Damien Cassou wrote:
> From: Damien Cassou <damien.cassou@lifl.fr>
> 
> The various devm_ functions allocate memory that is released when a driver
> detaches. This patch replaces the use of kzalloc by devm_kzalloc.
> 
> Signed-off-by: Damien Cassou <damien.cassou@lifl.fr>
> 
> ---
>  drivers/video/msm/mddi_client_dummy.c |   12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/msm/mddi_client_dummy.c b/drivers/video/msm/mddi_client_dummy.c
> index d2a091c..4c31325 100644
> --- a/drivers/video/msm/mddi_client_dummy.c
> +++ b/drivers/video/msm/mddi_client_dummy.c
> @@ -51,7 +51,7 @@ static int mddi_dummy_probe(struct platform_device *pdev)
>  {
>  	struct msm_mddi_client_data *client_data = pdev->dev.platform_data;
>  	struct panel_info *panel > -		kzalloc(sizeof(struct panel_info), GFP_KERNEL);
> +		devm_kzalloc(&pdev->dev, sizeof(struct panel_info), GFP_KERNEL);
>  	int ret;
>  	if (!panel)
>  		return -ENOMEM;
> @@ -67,18 +67,11 @@ static int mddi_dummy_probe(struct platform_device *pdev)
>  				      client_data->fb_resource, 1);
>  	panel->panel_data.fb_data = client_data->private_client_data;
>  	panel->pdev.dev.platform_data = &panel->panel_data;
> -	ret = platform_device_register(&panel->pdev);
> -	if (ret) {
> -		kfree(panel);
> -		return ret;
> -	}
> -	return 0;
> +	return platform_device_register(&panel->pdev);

Removing this block causes a warning:
kernel/drivers/video/msm/mddi_client_dummy.c: In function 'mddi_dummy_probe':
kernel/drivers/video/msm/mddi_client_dummy.c:55:6: warning: unused variable 'ret' [-Wunused-variable]

Please remove the 'int ret;' line above as well.

Thanks,
David Brown

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
