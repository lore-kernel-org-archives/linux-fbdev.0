From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 8/10] fbdev: Allow core fb to be built as a module
Date: Mon, 7 Mar 2005 00:36:20 -0800
Message-ID: <20050307003620.2d844158.akpm@osdl.org>
References: <200503060816.55890.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8DjT-0002E1-6B
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 00:36:55 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D8DjR-0002Wq-FM
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 00:36:55 -0800
In-Reply-To: <200503060816.55890.adaplas@hotpop.com>
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
Cc: adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net, jonsmirl@gmail.com

"Antonino A. Daplas" <adaplas@hotpop.com> wrote:
>
>    Allow the framebuffer core to be built as a module to
>    ease debugging.

It breaks `make allmodconfig':

/tmp/distcc_1108/drivers/video/console/tileblit.c:70: undefined reference to `fb_get_buffer_offset'


Seem somewhat nasty...


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
