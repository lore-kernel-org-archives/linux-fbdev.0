From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 09 Mar 2015 12:42:22 +0000
Subject: Re: [PATCH v2 4/4] staging: sm750fb: fix undeclared function
Message-Id: <20150309124222.GE10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425886506-8643-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1425886506-8643-4-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425886506-8643-4-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 09, 2015 at 01:05:06PM +0530, Sudip Mukherjee wrote:
> kbuild test robot reported that for microblaze-allyesconfig
> chan_to_field() and lynxfb_ops_set_par() were not defined. These two
> functions were defined under CONFIG_PM, so for any archtecture if
> CONFIG_PM is not defined we will have this error.
> 
> while moving the lynxfb_suspend() function some very obvious
> checkpatch errors, like space after comma, space after if, space
> before opening brace, were taken care of.

I have a script to review patches moving functions around but these
white space changes break my script so I have to review it by hand.
Sucks.

>  static int lynxfb_ops_set_par(struct fb_info * info)
>  {
>  	struct lynxfb_par * par;
> @@ -369,7 +313,6 @@ static int lynxfb_ops_set_par(struct fb_info * info)
>  	struct fb_fix_screeninfo * fix;
>  	int ret;
>  	unsigned int line_length;
> -	
>  
>  	if(!info)
>  		return -EINVAL;
> @@ -441,6 +384,7 @@ static int lynxfb_ops_set_par(struct fb_info * info)
>  		ret = output->proc_setMode(output,var,fix);
>  	return ret;
>  }
> +
>  static inline unsigned int chan_to_field(unsigned int chan,struct fb_bitfield * bf)
>  {
>  	chan &= 0xffff;

These white space changes are not related.

regards,
dan carpenter

