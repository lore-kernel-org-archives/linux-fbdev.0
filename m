From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Mon, 10 Jun 2013 13:43:02 +0000
Subject: Re: [V2 5/7] video: mmp: add pitch info in mmp_win structure
Message-Id: <20130610134302.GZ19468@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CACDDiy-Ri=iYNLWg6dd3BwayZx=4+Lb5WC=ZEgtNHpxiSca=nA@mail.gmail.com>
 <1370780950-21746-1-git-send-email-jtzhou@marvell.com>
In-Reply-To: <1370780950-21746-1-git-send-email-jtzhou@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 20:29 Sun 09 Jun     , Jett.Zhou wrote:
> From: Jing Xiang <jxiang@marvell.com>
> 

this is impossible to follow

resend the patch series fully with a PATCH 0

as I just go back from vacation I'll not read this series until then

Best Regards,
J.

> Add pitch length info of graphics/video layer for mmp_win, if it is
> YUV format of video layer, u/v pitch will non-zero.
> 
> Signed-off-by: Jing Xiang <jxiang@marvell.com>
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> ---
>  include/video/mmp_disp.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/include/video/mmp_disp.h b/include/video/mmp_disp.h
> index b9dd1fb..462e3bd 100644
> --- a/include/video/mmp_disp.h
> +++ b/include/video/mmp_disp.h
> @@ -91,6 +91,11 @@ struct mmp_win {
>  	u16	up_crop;
>  	u16	bottom_crop;
>  	int	pix_fmt;
> +	/*
> +	 * pitch[0]: graphics/video layer line length or y pitch
> +	 * pitch[1]/pitch[2]: video u/v pitch if non-zero
> +	 */
> +	u32	pitch[3];
>  };
>  
>  struct mmp_addr {
> -- 
> 1.7.0.4
> 
