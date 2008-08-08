From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 1/3] matrox maven: Fix a broken
 error path
Date: Fri, 8 Aug 2008 18:35:31 +0200
Message-ID: <20080808183531.08a8509e.krzysztof.h1@poczta.fm>
References: <20080808164937.141a95e0@hyperion.delvare>
	<20080808165823.71d9bea3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRUqs-0005WY-NH for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 09:30:06 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KRUqs-0001fF-5U
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 09:30:06 -0700
In-Reply-To: <20080808165823.71d9bea3@hyperion.delvare>
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

On Fri, 8 Aug 2008 16:58:23 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> I broke an error path with d03c21ec0be7787ff6b75dcf56c0e96209ccbfbd,
> sorry about that.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>


>  drivers/video/matrox/matroxfb_maven.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.26-rc6.orig/drivers/video/matrox/matroxfb_maven.c	2008-06-17 17:22:42.000000000 +0200
> +++ linux-2.6.26-rc6/drivers/video/matrox/matroxfb_maven.c	2008-06-17 17:23:18.000000000 +0200
> @@ -1266,7 +1266,7 @@ static int maven_detect_client(struct i2
>  ERROR4:;
>  	i2c_detach_client(new_client);
>  ERROR3:;
> -	kfree(new_client);
> +	kfree(data);
>  ERROR0:;
>  	return err;
>  }
> 
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
