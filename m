From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 8/10] fbdev: Allow core fb to be built as a module
Date: Mon, 7 Mar 2005 16:48:24 -0800
Message-ID: <20050307164824.56224123.akpm@osdl.org>
References: <200503060816.55890.adaplas@hotpop.com>
	<20050307022828.54d52983.akpm@osdl.org>
	<9e47339105030711117f6ffdc9@mail.gmail.com>
	<20050307154355.2fd5094c.akpm@osdl.org>
	<9e473391050307163553dbd88e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Stg-0005c8-E2
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 16:48:28 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D8Ste-0006Zz-Uh
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 16:48:28 -0800
In-Reply-To: <9e473391050307163553dbd88e@mail.gmail.com>
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
> Here is the delta you need against 2.6.11 + x.bz2

That one worked, thanks.

> Not sure if ppc will build since I don't have a machine to check it on.

I use the cross-compilers from
http://developer.osdl.org/dev/plm/cross_compile/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
