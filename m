From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 8/10] fbdev: Allow core fb to be built as a module
Date: Mon, 7 Mar 2005 20:58:08 -0800
Message-ID: <20050307205808.60301d30.akpm@osdl.org>
References: <200503060816.55890.adaplas@hotpop.com>
	<20050307022828.54d52983.akpm@osdl.org>
	<9e47339105030711117f6ffdc9@mail.gmail.com>
	<20050307154355.2fd5094c.akpm@osdl.org>
	<9e473391050307163553dbd88e@mail.gmail.com>
	<20050307174736.6a363b39.akpm@osdl.org>
	<9e47339105030720507cc34a68@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Wnu-00034W-4M
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 20:58:46 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D8Wnr-000830-FE
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 20:58:46 -0800
In-Reply-To: <9e47339105030720507cc34a68@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: adaplas@pol.net, adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net

Jon Smirl <jonsmirl@gmail.com> wrote:
>
> Did you fix this or do I need to send another patch?

I fixed it.



We seem to have a few newish fbdev bugs btw:

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org, jim.hague@acm.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6.11 Permedia-2 Framebuffer] driver broken (?).


From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4295] New: Garbage all over the screen when using radeonfb


From: John covici <covici@ccs.covici.com>
To: linux-kernel@vger.kernel.org
Reply-To: covici@ccs.covici.com
Subject: X not working with Radeon 9200 under 2.6.11


From: Lobiuc Andrei <alobiuc@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Radeon card displays incorrectly under the 2.6.11 version unless compiled with SMP support


From: Henrik Persson <root@fulhack.info>
To: unlisted-recipients:;;@localhost.localdomain (no To-header on input)
Cc: dtor@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: Touchpad "tapping" changes in 2.6.11?

	("Well, -mm1 didn't quite agree with my savage gfx drivers")



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
