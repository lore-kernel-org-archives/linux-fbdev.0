From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Running fb core as a module
Date: Thu, 17 Feb 2005 22:16:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502172214350.10099@pentafluge.infradead.org>
References: <9e473391050216173115f37838@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1twu-000236-JT
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 14:16:40 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D1twu-0006XE-0l
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 14:16:40 -0800
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.43 #1 (Red Hat Linux))
	id 1D1twq-0002jo-VB
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 22:16:38 +0000
In-Reply-To: <9e473391050216173115f37838@mail.gmail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>


> Is there a patch floating around for turning the core of fbdev into a
> module? Why isn't running fbdev as a module an option? It would make
> debugging fbdev core much simpler.

I agree. Of course you would need either a graphics card boot from a non 
primary slot or work with serial console :-) Of course that opens alot of 
other issues with races. We have to look into it in depth.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
