From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/8] trivial: fix typo s/complied-in/compiled-in/
Date: Fri, 16 Oct 2009 15:22:27 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0910161522180.8582@wotan.suse.de>
References: <1255635925-5738-1-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932240AbZJPNXG@vger.kernel.org>
In-Reply-To: <1255635925-5738-1-git-send-email-cascardo@holoscopio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: lethal@linux-sh.org, damm@igel.co.jp, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Thu, 15 Oct 2009, Thadeu Lima de Souza Cascardo wrote:

> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> ---
>  drivers/video/fb_defio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
> index c27ab1e..e59c083 100644
> --- a/drivers/video/fb_defio.c
> +++ b/drivers/video/fb_defio.c
> @@ -71,7 +71,7 @@ int fb_deferred_io_fsync(struct file *file, struct dentry *dentry, int datasync)
>  {
>  	struct fb_info *info = file->private_data;
>  
> -	/* Skip if deferred io is complied-in but disabled on this fbdev */
> +	/* Skip if deferred io is compiled-in but disabled on this fbdev */
>  	if (!info->fbdefio)
>  		return 0;

Hi,

as patches 2-8 from your series only fix typos/grammar in code comments, I 
have merged them together into one patch and applied to trivial queue. 
Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
