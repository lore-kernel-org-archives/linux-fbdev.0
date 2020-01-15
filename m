From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 14:36:10 +0000
Subject: Re: [PATCH][next] video: hyperv: hyperv_fb: fix indentation issue
Message-Id: <060a65e9-1880-0356-f8f3-447cb391b4e7@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20191114172730eucas1p1206011eed67d59f39fbbcf0b9ad1bbca@eucas1p1.samsung.com>
 <20191114172720.322023-1-colin.king@canonical.com>
In-Reply-To: <20191114172720.322023-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "K . Y . Srinivasan" <kys@microsoft.com>


On 11/14/19 6:27 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a block of statements that are indented
> too deeply, remove the extraneous tabs.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for v5.6, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/hyperv_fb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index 4cd27e5172a1..5fcf4bdf85ab 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -582,8 +582,8 @@ static int synthvid_get_supported_resolution(struct hv_device *hdev)
>  	t = wait_for_completion_timeout(&par->wait, VSP_TIMEOUT);
>  	if (!t) {
>  		pr_err("Time out on waiting resolution response\n");
> -			ret = -ETIMEDOUT;
> -			goto out;
> +		ret = -ETIMEDOUT;
> +		goto out;
>  	}
>  
>  	if (msg->resolution_resp.resolution_count = 0) {
> 
