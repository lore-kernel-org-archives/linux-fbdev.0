From: Zhou Zhu <zzhu3@marvell.com>
Date: Thu, 28 Mar 2013 01:38:09 +0000
Subject: Re: [PATCH] video: mmp: removed reference preceded by free
Message-Id: <51539F01.2020401@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364417318-26650-1-git-send-email-epure.andrei@gmail.com>
In-Reply-To: <1364417318-26650-1-git-send-email-epure.andrei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrei Epure <epure.andrei@gmail.com>
Cc: "FlorianSchandinat@gmx.de" <FlorianSchandinat@gmx.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>, Lisa Du <cldu@marvell.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 03/28/2013 04:48 AM, Andrei Epure wrote:
> Patch found with coccinelle.
>
> Signed-off-by: Andrei Epure <epure.andrei@gmail.com>
> ---
>   drivers/video/mmp/core.c |    2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/video/mmp/core.c b/drivers/video/mmp/core.c
> index 9ed8341..84de263 100644
> --- a/drivers/video/mmp/core.c
> +++ b/drivers/video/mmp/core.c
> @@ -252,7 +252,5 @@ void mmp_unregister_path(struct mmp_path *path)
>
>   	kfree(path);
>   	mutex_unlock(&disp_lock);
> -
> -	dev_info(path->dev, "de-register %s\n", path->name);
>   }
>   EXPORT_SYMBOL_GPL(mmp_unregister_path);
>
Acked-by: Zhou Zhu <zzhu3@marvell.com>
