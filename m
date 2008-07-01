From: <JosephChan@via.com.tw>
Subject: Re: [PATCH 11/13] viafb: viafbdev.c, viafbdev.h
Date: Tue, 1 Jul 2008 09:14:01 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E7CF1@exchtp03.taipei.via.com.tw>
References: <48693A5B.9040901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDURZ-000266-Oj for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 18:14:05 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KDURZ-0001QD-AW
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 18:14:05 -0700
Content-class: urn:content-classes:message
In-Reply-To: <48693A5B.9040901@gmail.com>
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
To: jirislaby@gmail.com
Cc: geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Jiri,

Thanks for your comments, I will let our engineers to check those items you mentioned. 

BRs,
Joseph Chan 


-----Original Message-----
From: Jiri Slaby [mailto:jirislaby@gmail.com] 
Sent: Tuesday, July 01, 2008 3:56 AM
To: Joseph Chan
Cc: linux-fbdev-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org; akpm@linux-foundation.org; geert@linux-m68k.org
Subject: Re: [PATCH 11/13] viafb: viafbdev.c, viafbdev.h

On 06/30/2008 09:46 AM, JosephChan@via.com.tw wrote:
> Initialization, remove and some other important functions of viafb.
> 
> Signed-off-by: Joseph Chan <josephchan@via.com.tw>
> 
> diff -Nur a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> --- a/drivers/video/via/viafbdev.c	1970-01-01 08:00:00.000000000 +0800
> +++ b/drivers/video/via/viafbdev.c	2008-06-30 08:53:33.000000000 +0800
> @@ -0,0 +1,2659 @@
[...]
> +static int timer_on;
> +struct timer_list timer_for3D;

Well the timer is neither inited nor used... ?

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
