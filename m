From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH][resend] drivers/video/kyro/fbdev.c ignoring return value of copy_*_user
Date: Sat, 5 Mar 2005 01:32:06 +0800
Message-ID: <200503050132.10895.adaplas@hotpop.com>
References: <Pine.LNX.4.62.0503041514110.2794@dragon.hygekrogen.localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7Gf6-0005kj-Hh
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 09:32:28 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D7Gf3-00037W-MG
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 09:32:28 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 64E00F56D13
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  4 Mar 2005 17:32:16 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.62.0503041514110.2794@dragon.hygekrogen.localhost>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Jesper Juhl <juhl-lkml@dif.dk>, Paul Mundt <lethal@chaoticdreams.org>
Cc: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>

On Friday 04 March 2005 22:26, Jesper Juhl wrote:
> Hi,
>
> 2.6.11 still contain these warnings :
>
> drivers/video/kyro/fbdev.c:597: warning: ignoring return value of
> `copy_from_user', declared with attribute warn_unused_result
> drivers/video/kyro/fbdev.c:607: warning: ignoring return value of
> `copy_from_user', declared with attribute warn_unused_result
> drivers/video/kyro/fbdev.c:628: warning: ignoring return value of
> `copy_to_user', declared with attribute warn_unused_result
> drivers/video/kyro/fbdev.c:631: warning: ignoring return value of
> `copy_to_user', declared with attribute warn_unused_result
> drivers/video/kyro/fbdev.c:634: warning: ignoring return value of
> `copy_to_user', declared with attribute warn_unused_result
>
> Here's a patch that has been send before but obviously didn't make it in.
> re-diff'ed against 2.6.11

Your patch is already in the mm tree along with the other fbdev patches.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
