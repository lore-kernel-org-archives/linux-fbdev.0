From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] - fix video/fbmem.c warning.
Date: Fri, 30 Apr 2004 21:37:56 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040430213756.188bbfe6.akpm@osdl.org>
References: <20040430181015.GB3119@lorien.prodam>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJmGZ-0007Vp-9N
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 21:38:19 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJmGY-0004GC-Ss
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 21:38:18 -0700
In-Reply-To: <20040430181015.GB3119@lorien.prodam>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Cc: jsimmons@infraded.org, linux-fbdev-devel@lists.sourceforge.net

"Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br> wrote:
>
> 
>  Hi,
> 
>  The patch bellow fix this warning:
> 
>  drivers/video/fbmem.c: In function `fb_cursor':
>  drivers/video/fbmem.c:922: warning: passing arg 1 of `copy_from_user' discards qualifiers from pointer target type
> 
>  It is only a cast (several other calls for copy_from_user() need that).
> 
>  drivers/video/fbmem.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff -X dontdiff -Nparu a/drivers/video/fbmem.c a~/drivers/video/fbmem.c
> --- a/drivers/video/fbmem.c	2004-04-26 15:25:52.000000000 -0300
> +++ a~/drivers/video/fbmem.c	2004-04-27 16:48:15.000000000 -0300
> @@ -914,7 +914,7 @@ fb_cursor(struct fb_info *info, struct f
>  			return -ENOMEM;
>  		}
>  		
> -		if (copy_from_user(cursor.image.data, sprite->image.data, size) ||
> +		if (copy_from_user((void *) cursor.image.data, sprite->image.data, size) ||
>  		    copy_from_user(cursor.mask, sprite->mask, size)) { 
>  			kfree(cursor.image.data);
>  			kfree(cursor.mask);
> 

Why is fb_image.data declared to be a pointer to `const' data?  This
function proves that this assertion is false.

Would it not be better to remove the `const' qualifier?


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
