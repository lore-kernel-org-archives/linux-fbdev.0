From: Stephen Boyd <sboyd@codeaurora.org>
Date: Mon, 21 Mar 2011 20:31:54 +0000
Subject: Re: [PATCH 16/20] video: msm: Set the EBI1 clock to 128MHz when performing
Message-Id: <4D87B5BA.8030303@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
	<1300485562-27560-1-git-send-email-carlv@codeaurora.org>
In-Reply-To: <1300485562-27560-1-git-send-email-carlv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 03/18/2011 02:59 PM, Carl Vanderlip wrote:
> diff --git a/drivers/video/msm/mdp.c b/drivers/video/msm/mdp.c
> index b03204d..0bb19fa 100644
> --- a/drivers/video/msm/mdp.c
> +++ b/drivers/video/msm/mdp.c
> @@ -656,6 +657,13 @@ int mdp_probe(struct platform_device *pdev)
>  		goto error_get_mdp_clk;
>  	}
>  
> +	mdp->ebi1_clk = clk_get(NULL, "ebi1_clk");

Please pass a device pointer as the first argument so we can match up
the ebi1_clk to the right device. MSM supports clkdev now so it's fairly
simple to do this.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

