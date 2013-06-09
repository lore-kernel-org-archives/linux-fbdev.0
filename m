From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 09 Jun 2013 12:03:11 +0000
Subject: Re: [V1 5/7] video: mmp: add pitch info in mmp_win structure
Message-Id: <51B46EFF.7020001@cogentembedded.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370767486-11729-1-git-send-email-jtzhou@marvell.com>
In-Reply-To: <1370767486-11729-1-git-send-email-jtzhou@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 09-06-2013 12:44, Jett.Zhou wrote:

> From: Jing Xiang <jxiang@marvell.com>

> Add pitch length info of graphics/video layer for mmp_win, if it is
> YUV format of video layer, u/v pitch will non-zero.

> Signed-off-by: Jing Xiang <jxiang@marvell.com>
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> ---
>   include/video/mmp_disp.h |    3 +++
>   1 files changed, 3 insertions(+), 0 deletions(-)

> diff --git a/include/video/mmp_disp.h b/include/video/mmp_disp.h
> index b9dd1fb..5708d26 100644
> --- a/include/video/mmp_disp.h
> +++ b/include/video/mmp_disp.h
> @@ -91,6 +91,9 @@ struct mmp_win {
>   	u16	up_crop;
>   	u16	bottom_crop;
>   	int	pix_fmt;
> +	/* pitch[0]: graphics/video layer line length or y pitch
> +	 * pitch[1]/pitch[2]: video u/v pitch if non-zero */

    The preferred format for multi-line comments is this:

/*
  * bla
  * bla
  */

> +	u32	pitch[3];
>   };

WBR, Sergei


