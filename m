From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fb_ddc: Fix DDC lines quirk
Date: Thu, 22 Nov 2007 06:58:49 +1100
Message-ID: <1195675129.6970.98.camel@pasglop>
References: <20071118142141.22a1e753@hyperion.delvare>
Reply-To: benh@kernel.crashing.org,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IuvjJ-00024F-NM for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Nov 2007 11:59:26 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX189vk0iZeq6Xw6vgc9w2jEj7CpchzBjZ2s=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IuvjH-00063o-5s
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Nov 2007 11:59:25 -0800
In-Reply-To: <20071118142141.22a1e753@hyperion.delvare>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@gmail.com>


On Sun, 2007-11-18 at 14:21 +0100, Jean Delvare wrote:
> The code in fb_ddc_read() is said to be based on the implementation
> of the radeon driver:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=fc5891c8a3ba284f13994d7bc1f1bfa8283982de
> 
> However, comparing the old radeon driver code with the new fb_ddc code
> reveals some differences. Most notably, the I2C bus lines are held at
> the end of the function, while the original code was releasing them
> (as the comment above correctly says.)

 .../...

> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  drivers/video/fb_ddc.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- linux-2.6.24-rc3.orig/drivers/video/fb_ddc.c	2007-11-17 20:23:03.000000000 +0100
> +++ linux-2.6.24-rc3/drivers/video/fb_ddc.c	2007-11-18 12:49:14.000000000 +0100
> @@ -56,13 +56,12 @@ unsigned char *fb_ddc_read(struct i2c_ad
>  	int i, j;
>  
>  	algo_data->setscl(algo_data->data, 1);
> -	algo_data->setscl(algo_data->data, 0);
>  
>  	for (i = 0; i < 3; i++) {
>  		/* For some old monitors we need the
>  		 * following process to initialize/stop DDC
>  		 */
> -		algo_data->setsda(algo_data->data, 0);
> +		algo_data->setsda(algo_data->data, 1);
>  		msleep(13);
>  
>  		algo_data->setscl(algo_data->data, 1);
> @@ -97,14 +96,15 @@ unsigned char *fb_ddc_read(struct i2c_ad
>  		algo_data->setsda(algo_data->data, 1);
>  		msleep(15);
>  		algo_data->setscl(algo_data->data, 0);
> +		algo_data->setsda(algo_data->data, 0);
>  		if (edid)
>  			break;
>  	}
>  	/* Release the DDC lines when done or the Apple Cinema HD display
>  	 * will switch off
>  	 */
> -	algo_data->setsda(algo_data->data, 0);
> -	algo_data->setscl(algo_data->data, 0);
> +	algo_data->setsda(algo_data->data, 1);
> +	algo_data->setscl(algo_data->data, 1);
>  
>  	return edid;
>  }
> 
> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
