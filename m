From: Andrew Morton <akpm@osdl.org>
Subject: Re: USB mouse hiccups (was RFD: Kernel release numbering)
Date: Mon, 21 Mar 2005 12:44:26 -0800
Message-ID: <20050321124426.53d75b3e.akpm@osdl.org>
References: <pan.2005.03.20.21.53.36.929746@brick.flying-brick.caverock.net.nz>
	<20050320164129.44d3a065.akpm@osdl.org>
	<20050321072601.GA31826@flying-brick.caverock.net.nz>
	<20050320233227.2c7b8013.akpm@osdl.org>
	<20050321202546.GA7281@flying-brick.caverock.net.nz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDTlX-0005p9-MR
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Mar 2005 12:44:47 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DDTlW-0004YK-5F
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Mar 2005 12:44:47 -0800
In-Reply-To: <20050321202546.GA7281@flying-brick.caverock.net.nz>
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
To: viking <viking@flying-brick.caverock.net.nz>
Cc: linux-fbdev-devel@lists.sourceforge.net


Guys, we seem to have a tridentfb regression in 2.6.12-rc1.

viking <viking@flying-brick.caverock.net.nz> wrote:
>
> Also (and this is something I've noticed since I tried tridentfb) the video
>  buffer never seems to get cleared, except when I change virtual terminals,
>  then change back to the terminal concerned. THEN it's cleared. So for the
>  moment, I've gone back to using VESAfb.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
