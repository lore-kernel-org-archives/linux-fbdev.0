From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] Allow core fb to be built as a module
Date: Tue, 1 Mar 2005 20:31:48 +0800
Message-ID: <200503012031.50512.adaplas@hotpop.com>
References: <9e4733910502241239268ca595@mail.gmail.com> <Pine.LNX.4.56.0502282010070.16877@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D66ZH-0006D9-Ch
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 01 Mar 2005 04:33:39 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D66Yj-0003bS-Fx
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 01 Mar 2005 04:33:39 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 0913D712FD
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  1 Mar 2005 12:32:00 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.56.0502282010070.16877@pentafluge.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@www.infradead.org>

On Tuesday 01 March 2005 04:12, James Simmons wrote:
> Tony are you okay with this? I have no problem myself. I haven't tested
> with various driver with various conditions yet.
>

It does have a few problems.  Drivers that are bool, instead of tristate
such as vesafb, can still be selected even if fbcore is selected as module.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
