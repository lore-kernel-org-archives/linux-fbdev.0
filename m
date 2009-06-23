From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: Re: [PATCH 3/3] atyfb: Coding style cleanup
Date: Tue, 23 Jun 2009 12:52:58 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909019BDCF8@mi8nycmail19.Mi8.com>
References: <1245533384-28371-1-git-send-email-syrjala@sci.fi>
	<1245533384-28371-3-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hartleys@visionengravers.com>) id 1MJ9F8-00067x-4B
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Jun 2009 16:53:10 +0000
Received: from exprod6og112.obsmtp.com ([64.18.1.29])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MJ9F5-0003cc-PW for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Jun 2009 16:53:10 +0000
Content-class: urn:content-classes:message
In-Reply-To: <1245533384-28371-3-git-send-email-syrjala@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ville Syrjala <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>

On Saturday, June 20, 2009 2:30 PM, Ville Syrjala wrote:
> Fix a bunch of coding style problems in atyfb_base.c.
> 
> Signed-off-by: Ville Syrjala <syrjala@sci.fi>
> ---
> There are still some problems left, at least over 80 char lines, but
> fixing those in a decent manner would require some code restructuring
> to reduce the overly deep nesting. I decided to leave those bits mostly
> untouched for now.
> 
>  drivers/video/aty/atyfb_base.c |  829 ++++++++++++++++++++++------------------
>  1 files changed, 458 insertions(+), 371 deletions(-)
> 
> diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
> index 63d3739..913b4a4 100644
> --- a/drivers/video/aty/atyfb_base.c
> +++ b/drivers/video/aty/atyfb_base.c
> @@ -132,7 +132,7 @@
>  #endif
>  
>  #define PRINTKI(fmt, args...)	printk(KERN_INFO "atyfb: " fmt, ## args)
> -#define PRINTKE(fmt, args...)	 printk(KERN_ERR "atyfb: " fmt, ## args)
> +#define PRINTKE(fmt, args...)	printk(KERN_ERR "atyfb: " fmt, ## args)

Why not: 

#define pr_fmt(fmt)	"atyfb: " fmt

Then just use pr_info() and pr_err()?  Also, pr_devel() could be used instead
of the private DPRINTK() definition.

Regards,
Hartley

------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
