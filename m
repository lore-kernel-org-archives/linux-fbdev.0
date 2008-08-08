From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 2/3] matroxfb: i2c structure
 templates clean-up
Date: Fri, 8 Aug 2008 18:36:25 +0200
Message-ID: <20080808183625.51f5622a.krzysztof.h1@poczta.fm>
References: <20080808164937.141a95e0@hyperion.delvare>
	<20080808170208.6c76ff46@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRUrf-0005Xx-CH for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 09:30:55 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KRUrd-0001xO-Sr
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 09:30:55 -0700
In-Reply-To: <20080808170208.6c76ff46@hyperion.delvare>
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
To: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, Antonino Daplas <adaplas@gmail.com>

On Fri, 8 Aug 2008 17:02:08 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Clean up the use of structure templates in i2c-matroxfb. In this case
> it's more efficient to initialize the few fields we need individually.
> This makes i2c-matroxfb.ko 16% smaller on my system.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

>  drivers/video/matrox/i2c-matroxfb.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> --- linux-2.6.26-rc6.orig/drivers/video/matrox/i2c-matroxfb.c	2008-06-17 20:23:41.000000000 +0200
> +++ linux-2.6.26-rc6/drivers/video/matrox/i2c-matroxfb.c	2008-06-17 20:27:36.000000000 +0200
> @@ -87,13 +87,7 @@ static int matroxfb_gpio_getscl(void* da
>  	return (matroxfb_read_gpio(b->minfo) & b->mask.clock) ? 1 : 0;
>  }
>  
> -static struct i2c_adapter matrox_i2c_adapter_template =
> -{
> -	.owner =	THIS_MODULE,
> -	.id =		I2C_HW_B_G400,
> -};
> -
> -static struct i2c_algo_bit_data matrox_i2c_algo_template =
> +static const struct i2c_algo_bit_data matrox_i2c_algo_template =
>  {
>  	.setsda		= matroxfb_gpio_setsda,
>  	.setscl		= matroxfb_gpio_setscl,
> @@ -112,7 +106,8 @@ static int i2c_bus_reg(struct i2c_bit_ad
>  	b->minfo = minfo;
>  	b->mask.data = data;
>  	b->mask.clock = clock;
> -	b->adapter = matrox_i2c_adapter_template;
> +	b->adapter.owner = THIS_MODULE;
> +	b->adapter.id = I2C_HW_B_G400;
>  	snprintf(b->adapter.name, sizeof(b->adapter.name), name,
>  		minfo->fbcon.node);
>  	i2c_set_adapdata(&b->adapter, b);
> 
> -- 
> Jean Delvare
> 
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 


----------------------------------------------------------------------
Tylko dla detektywow! Konkurs na Smaker.pl
Kliknij >>> http://link.interia.pl/f1eb1


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
