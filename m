From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: patch - bitblt 2D acceleration for
	s1d13xxxfb
Date: Fri, 5 Jun 2009 13:59:16 -0700
Message-ID: <20090605135916.34dc2c71.akpm@linux-foundation.org>
References: <20090605193853.d235e679.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1MCgX4-0004CA-T0
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Jun 2009 21:00:58 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MCgVX-0000kM-Cf
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Jun 2009 21:00:58 +0000
In-Reply-To: <20090605193853.d235e679.kristoffer.ericson@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 5 Jun 2009 19:38:53 +0200
Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:

> Greetings,
> 
> Just wanted some feedback since this patch is quite large. Any comments are
> appreciated. It patches, compiles and runs like a fox on fire.

we like firey foxes.

> This patch:
> enables 2D rectfill and copyarea acceleration for 13506, need to look
> at hardware sheets before I can say it works on other version but at minimal
> 13806.
> 
> Also some cleans up the code.
> 
>
> ...
>
> +/**
> + * we make sure only one bitblt operation is running
> + */
> +static DEFINE_SPINLOCK(s1d13xxxfb_bitblt_lock);
> +
> +/**
> + * list of card production ids
>   */
>  static const int s1d13xxxfb_prod_ids[] = {
>  	S1D13505_PROD_ID,
> @@ -59,7 +71,7 @@ static const int s1d13xxxfb_prod_ids[] = {
>  	S1D13806_PROD_ID,
>  };
>  
> -/*
> +/**
>   * List of card strings
>   */
>  static const char *s1d13xxxfb_prod_names[] = {
> @@ -68,8 +80,8 @@ static const char *s1d13xxxfb_prod_names[] = {
>  	"S1D13806",
>  };
>  
> -/*
> - * Here we define the default struct fb_fix_screeninfo
> +/**
> + * here we define the default struct fb_fix_screeninfo
>   */

The /** token is reserved for introducing a kerneldoc-formatted
comment, but none of the above three comments are kerneldoc comments.

> +/**
> + *	bltbit_wait_bitset - waits for change in register value
> + *	@info : framebuffer structure
> + *	@bit  : value expected in register
> + *	@timeout : ...
> + *
> + *	waits until value changes INTO bit
> + */

That one is kerneldoc.

> +u8 bltbit_wait_bitset(struct fb_info *info, u8 bit, int timeout)

The patch adds lots of global functions.  Please make symbols static
where possible.

> +{
> +	while (!(s1d13xxxfb_readreg(info->par, S1DREG_BBLT_CTL0) & bit)) {
> +		udelay(10);
> +		if (!--timeout) {
> +			dbg_blit("wait_bitset timeout\n");
> +			break;
> +		}
> +	}
> +
> +	return timeout;
> +}
> +
>
> ...
>

It otherwise looks OK to my inexpert eye.

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
