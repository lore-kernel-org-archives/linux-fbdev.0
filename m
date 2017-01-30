From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 30 Jan 2017 16:22:23 +0000
Subject: Re: [PATCH] video/mbx: use simple_open()
Message-Id: <13269025.Q9kkMo78lp@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <697f2692562e48afa03304a7e605e8adbee8437e.1484829069.git.geliangtang@gmail.com>
 <CGME20170120142721epcas3p32a9fc0e4fbfba5dc01dc62c44a2dc7b6@epcas3p3.samsung.com>
 <70f5253031d545642db17d64535f228752c12e6e.1484903730.git.geliangtang@gmail.com>
In-Reply-To: <70f5253031d545642db17d64535f228752c12e6e.1484903730.git.geliangtang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geliang Tang <geliangtang@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Friday, January 20, 2017 10:27:05 PM Geliang Tang wrote:
> Drop open_file_generic(), use simple_open() instead of it.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Thanks, patch queued for 4.11.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/mbx/mbxdebugfs.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/fbdev/mbx/mbxdebugfs.c b/drivers/video/fbdev/mbx/mbxdebugfs.c
> index e3bc00a..2528d3e 100644
> --- a/drivers/video/fbdev/mbx/mbxdebugfs.c
> +++ b/drivers/video/fbdev/mbx/mbxdebugfs.c
> @@ -15,12 +15,6 @@ struct mbxfb_debugfs_data {
>  	struct dentry *misc;
>  };
>  
> -static int open_file_generic(struct inode *inode, struct file *file)
> -{
> -	file->private_data = inode->i_private;
> -	return 0;
> -}
> -
>  static ssize_t write_file_dummy(struct file *file, const char __user *buf,
>  				size_t count, loff_t *ppos)
>  {
> @@ -174,42 +168,42 @@ static ssize_t misc_read_file(struct file *file, char __user *userbuf,
>  static const struct file_operations sysconf_fops = {
>  	.read = sysconf_read_file,
>  	.write = write_file_dummy,
> -	.open = open_file_generic,
> +	.open = simple_open,
>  	.llseek = default_llseek,
>  };
>  
>  static const struct file_operations clock_fops = {
>  	.read = clock_read_file,
>  	.write = write_file_dummy,
> -	.open = open_file_generic,
> +	.open = simple_open,
>  	.llseek = default_llseek,
>  };
>  
>  static const struct file_operations display_fops = {
>  	.read = display_read_file,
>  	.write = write_file_dummy,
> -	.open = open_file_generic,
> +	.open = simple_open,
>  	.llseek = default_llseek,
>  };
>  
>  static const struct file_operations gsctl_fops = {
>  	.read = gsctl_read_file,
>  	.write = write_file_dummy,
> -	.open = open_file_generic,
> +	.open = simple_open,
>  	.llseek = default_llseek,
>  };
>  
>  static const struct file_operations sdram_fops = {
>  	.read = sdram_read_file,
>  	.write = write_file_dummy,
> -	.open = open_file_generic,
> +	.open = simple_open,
>  	.llseek = default_llseek,
>  };
>  
>  static const struct file_operations misc_fops = {
>  	.read = misc_read_file,
>  	.write = write_file_dummy,
> -	.open = open_file_generic,
> +	.open = simple_open,
>  	.llseek = default_llseek,
>  };

