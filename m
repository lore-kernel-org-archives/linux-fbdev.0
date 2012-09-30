From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 30 Sep 2012 12:17:26 +0000
Subject: Re: [PATCH] fb: only enable console lock in fb for VGA console
Message-Id: <20120930121725.GA21682@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAGA24M+PmObK3ZJWvtNhBzxO4WkGk_xyveQiZNtZe7xGdHrbFw@mail.gmail.com>
In-Reply-To: <CAGA24M+PmObK3ZJWvtNhBzxO4WkGk_xyveQiZNtZe7xGdHrbFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Sep 29, 2012 at 01:29:17PM +0800, Jun Nie wrote:
> diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
> index 1d00736..7759c82 100644
> --- a/drivers/video/s3fb.c
> +++ b/drivers/video/s3fb.c
> @@ -1445,12 +1444,12 @@ static int s3_pci_suspend(struct pci_dev* dev,
> pm_message_t state)
> 
>  	dev_info(info->device, "suspend\n");
> 
> -	console_lock();
> +	fb_fb_console_lock();
>  	mutex_lock(&(par->open_lock));
> 
Compiling is overrated anyways.

> diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
> index 8e4a446..e266b6b 100644
> --- a/drivers/video/tmiofb.c
> +++ b/drivers/video/tmiofb.c
> @@ -959,7 +958,7 @@ static int tmiofb_suspend(struct platform_device
> *dev, pm_message_t state)
>  	if (cell->suspend)
>  		retval = cell->suspend(dev);
> 
> -	console_unlock();
> +	fb_fb_console_unlock();
> 
>  	return retval;
>  }
> @@ -986,7 +985,7 @@ static int tmiofb_resume(struct platform_device *dev)
> 
>  	fb_set_suspend(info, 0);
>  out:
> -	console_unlock();
> +	fb_fb_console_unlock();
>  	return retval;
>  }
>  #else

Here too.

Turning locks in to no-ops without auditing every single driver's use of
said lock and converting to something to protect the work being done
under lock suggests that this conversion is more mechanical than thought
out beyond your specific use case.

While you've obviously identified a problem that's worth pursuing, it's
going to take a bit more work than mechanical conversion, and it's going
to have to be something that's moved towards incrementally. If you
haven't even compile tested the impacted drivers, it suggests you haven't
spent a great deal of time thinking about what they are doing under said
lock, either..
