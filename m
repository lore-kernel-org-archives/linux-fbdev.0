From: Andrew Morton <akpm@osdl.org>
Subject: Fw: 2.6.11, framebuffer
Date: Mon, 14 Feb 2005 10:03:48 -0800
Message-ID: <20050214100348.3542b897.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0kaC-00085x-4d
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 10:04:28 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D0ka0-0004Xg-Fw
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 10:04:28 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: stegall@bayou.uni-linz.ac.at



Begin forwarded message:

Date: Mon, 14 Feb 2005 12:56:08 +0100 (CET)
From: stegall@bayou.uni-linz.ac.at
To: akpm@osdl.org
Subject: 2.6.11, framebuffer


framebuffer, intel, 915g 

Greetings,
complaints were requested, but I am not sure this is the correct
place to make them:

I cannot start a frame buffer on 2.6,11x using
hardware with the
    intel 915g 
chip. Either it crashes or nothing happens, depending on modules,
kernel compilation etc. Nothing works.

One thing I did see was

   allocation failed: out of vmalloc space - use 
vmalloc=<size> to increase size.

I realize that this chip is ``new'', but
it works quite satisfactorily  on 2.4.10* !
I can even run xwindows with the xorg stuff.

If more information is required I'll do what I can.
Thank you,
 Charles Stegall


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
