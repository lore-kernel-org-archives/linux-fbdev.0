From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] Fix leak in aty fb code. (fwd)
Date: Fri, 3 Sep 2004 04:56:42 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409030456.42443.adaplas@hotpop.com>
References: <Pine.GSO.4.58.0409021144390.5627@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C2ydb-00008n-Cy
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Sep 2004 13:56:55 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C2yda-0004pw-Se
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Sep 2004 13:56:55 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 5C818109DF6E
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  2 Sep 2004 20:56:40 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.58.0409021144390.5627@waterleaf.sonytel.be>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: davej@redhat.com

On Thursday 02 September 2004 17:44, Geert Uytterhoeven wrote:
> ---------- Forwarded message ----------
> Date: Wed, 1 Sep 2004 16:51:21 +0100
> From: Dave Jones <davej@redhat.com>
> To: linux-kernel@vger.kernel.org
> Subject: [PATCH] Fix leak in aty fb code.
>
> Spotted with the source checker from Coverity.com.
>
> Signed-off-by: Dave Jones <davej@redhat.com>
>
>
> diff -urpN --exclude-from=/home/davej/.exclude
> bk-linus/drivers/video/aty/atyfb_base.c
> linux-2.6/drivers/video/aty/atyfb_base.c ---
> bk-linus/drivers/video/aty/atyfb_base.c	2004-08-01 00:00:35.000000000 +0100
> +++ linux-2.6/drivers/video/aty/atyfb_base.c	2004-08-23 14:08:20.000000000
> +0100 @@ -2374,6 +2374,7 @@ int __init atyfb_init(void)
>  		}
>  	}
>  #endif				/* CONFIG_ATARI */
> +	kfree(info);
>  	return 0;
>  }
>

This is also incorrect, and will actually cause a crash. This is part of
init code, and info should not be freed.  It will be freed in
cleanup_module().

Tony




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
