From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH 1/8] fbcon: Do not touch
	hardware if vc_mode != KD_TEXT
Date: Thu, 04 Nov 2004 11:16:47 +1100
Message-ID: <1099527408.31629.102.camel@gaston>
References: <200411021946.06302.adaplas@hotpop.com>
	 <1099434421.20294.19.camel@gaston> <200411031030.11430.adaplas@hotpop.com>
	 <20041103155204.7eb2daa3.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPVT6-0003Pz-TP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 16:27:12 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CPVT5-0004CF-UQ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 16:27:12 -0800
In-Reply-To: <20041103155204.7eb2daa3.akpm@osdl.org>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: adaplas@pol.net, "Antonino A. Daplas" <adaplas@hotpop.com>

On Wed, 2004-11-03 at 15:52 -0800, Andrew Morton wrote:

> This patch conflicts with Ben's "fbdev: workaround for broken X servers"
> patch, which is in Linus's tree now.

Sorry, Antonio, forgot to CC you ...

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
