From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Cleanup of intelfb code
Date: Thu, 4 Nov 2004 00:57:47 -0800
Message-ID: <20041104005747.427811ee.akpm@osdl.org>
References: <200411041647.41604.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPdS1-0001tz-IN
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 00:58:37 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPdS0-0005ax-3w
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 00:58:37 -0800
In-Reply-To: <200411041647.41604.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net, sylvain.meyer@worldonline.fr

"Antonino A. Daplas" <adaplas@hotpop.com> wrote:
>
> +	if (ACCEL(dinfo, info)) {
>  +		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
>  +		FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT |
>  +		FBINFO_HWACCEL_IMAGEBLIT;
>  +	} else {
>  +		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
>  +	}5 files changed, 113 insertions(+), 474 deletions(-)
> 
>   	return 0;
>   }

erk, what happened there?

I have Sylvain's priginal patch - is this in any way different?


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
