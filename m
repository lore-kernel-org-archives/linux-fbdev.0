From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: waitforVBlank, how does this even work?
Date: Wed, 2 Mar 2005 12:30:59 -0500
Message-ID: <9e47339105030209302701e9b5@mail.gmail.com>
References: <9e473391050301215019081bce@mail.gmail.com>
	 <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com>
	 <9e473391050302090926854d95@mail.gmail.com>
	 <Pine.LNX.4.62.0503021212550.14716@node2.an-vo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6Xgf-0007Ff-WB
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 09:31:05 -0800
Received: from rproxy.gmail.com ([64.233.170.198])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D6Xgb-0003rU-HS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 09:31:05 -0800
Received: by rproxy.gmail.com with SMTP id z35so318539rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Mar 2005 09:31:00 -0800 (PST)
In-Reply-To: <Pine.LNX.4.62.0503021212550.14716@node2.an-vo.com>
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
To: Vladimir Dergachev <volodya@mindspring.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>

On Wed, 2 Mar 2005 12:15:18 -0500 (EST), Vladimir Dergachev
<volodya@mindspring.com> wrote:
> > I would find it useful if someone came up with a standard kernel space
> > V4L radeon driver instead of the Gatos stuff.
> 
> By "standard" you mean "self-contained", right ?

One that doesn't depend on X being there.

Can one be build now that just ignores the memory management hooks?

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
