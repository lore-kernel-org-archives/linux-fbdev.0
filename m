From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 12 Apr 2011 22:00:09 +0000
Subject: Re: [PATCH] drivers, video: Add a check for strict_strtoul()
Message-Id: <20110412150009.243f6089.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1302167178-9216-1-git-send-email-namei.unix@gmail.com>
In-Reply-To: <1302167178-9216-1-git-send-email-namei.unix@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu,  7 Apr 2011 17:06:18 +0800
Liu Yuan <namei.unix@gmail.com> wrote:

> From: Liu Yuan <tailai.ly@taobao.com>
> 
> It should check if strict_strtoul() succeeds.This
> patch fixes it.
> 
> Signed-off-by: Liu Yuan <tailai.ly@taobao.com>
> ---
>  drivers/video/backlight/adp5520_bl.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
> index af31197..fdef632 100644
> --- a/drivers/video/backlight/adp5520_bl.c
> +++ b/drivers/video/backlight/adp5520_bl.c
> @@ -212,7 +212,9 @@ static ssize_t adp5520_bl_daylight_max_store(struct device *dev,
>  {
>  	struct adp5520_bl *data = dev_get_drvdata(dev);
>  
> -	strict_strtoul(buf, 10, &data->cached_daylight_max);
> +	if (strict_strtoul(buf, 10, &data->cached_daylight_max) < 0)
> +		return -EINVAL;
> +
>  	return adp5520_store(dev, buf, count, ADP5520_DAYLIGHT_MAX);
>  }

It is better to propagate strict_strtoul()'s errno, rather than
overriding it:

--- a/drivers/video/backlight/adp5520_bl.c~drivers-video-backlight-adp5520_blc-check-strict_strtoul-return-value-fix
+++ a/drivers/video/backlight/adp5520_bl.c
@@ -211,9 +211,11 @@ static ssize_t adp5520_bl_daylight_max_s
 			const char *buf, size_t count)
 {
 	struct adp5520_bl *data = dev_get_drvdata(dev);
+	int ret;
 
-	if (strict_strtoul(buf, 10, &data->cached_daylight_max) < 0)
-		return -EINVAL;
+	ret = strict_strtoul(buf, 10, &data->cached_daylight_max);
+	if (ret < 0)
+		return ret;
 
 	return adp5520_store(dev, buf, count, ADP5520_DAYLIGHT_MAX);
 }
_

