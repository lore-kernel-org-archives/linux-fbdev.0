From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH 1/8] fbcon: Do not touch hardware if vc_mode != KD_TEXT
Date: Thu, 4 Nov 2004 08:57:34 +0800
Message-ID: <200411040857.34809.adaplas@hotpop.com>
References: <200411021946.06302.adaplas@hotpop.com> <20041103155204.7eb2daa3.akpm@osdl.org> <1099527408.31629.102.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPW00-0002mk-KV
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 17:01:12 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPVzz-0003AU-RY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 17:01:12 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id A6F0298B1F3
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  4 Nov 2004 01:01:04 +0000 (UTC)
In-Reply-To: <1099527408.31629.102.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thursday 04 November 2004 08:16, Benjamin Herrenschmidt wrote:
> On Wed, 2004-11-03 at 15:52 -0800, Andrew Morton wrote:
> > This patch conflicts with Ben's "fbdev: workaround for broken X servers"
> > patch, which is in Linus's tree now.
>
> Sorry, Antonio, forgot to CC you ...
>

No harm done. My fault too, I already saw your patch but I was too slow to
respond.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
