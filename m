From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 09 Jun 2012 12:41:47 +0000
Subject: Re: [PATCH] video: bfin_adv7393fb: Convert to kstrtouint_from_user
Message-Id: <4FD3448B.2050806@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1338310620-6886-1-git-send-email-emilgoode@gmail.com>
In-Reply-To: <1338310620-6886-1-git-send-email-emilgoode@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Emil Goode <emilgoode@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On 05/29/2012 04:57 PM, Emil Goode wrote:
> This patch removes a call to the deprecated simple_strtoul function
> and simplifies the code by replacing two function calls with one
> call to kstrtouint_from_user.
> 
> -Simplify the adv7393_write_proc function by replacing the
>  simple_strtoul and copy_from_user calls with one call
>  to kstrtouint_from_user.
> 
> -Change the count parameter from unsigned long to size_t as
>  this is the type that the kstrtouint_from_user function expects.
>  (size_t is what will be passed to the adv7393_write_proc function
>  by the proc write handler function proc_file_write anyway)
> 
> Signed-off-by: Emil Goode <emilgoode@gmail.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/bfin_adv7393fb.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/bfin_adv7393fb.c b/drivers/video/bfin_adv7393fb.c
> index 1a268a2..8c6edfd 100644
> --- a/drivers/video/bfin_adv7393fb.c
> +++ b/drivers/video/bfin_adv7393fb.c
> @@ -353,18 +353,16 @@ adv7393_read_proc(char *page, char **start, off_t off,
>  
>  static int
>  adv7393_write_proc(struct file *file, const char __user * buffer,
> -		   unsigned long count, void *data)
> +		   size_t count, void *data)
>  {
>  	struct adv7393fb_device *fbdev = data;
> -	char line[8];
>  	unsigned int val;
>  	int ret;
>  
> -	ret = copy_from_user(line, buffer, count);
> +	ret = kstrtouint_from_user(buffer, count, 0, &val);
>  	if (ret)
>  		return -EFAULT;
>  
> -	val = simple_strtoul(line, NULL, 0);
>  	adv7393_write(fbdev->client, val >> 8, val & 0xff);
>  
>  	return count;

