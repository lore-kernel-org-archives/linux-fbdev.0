From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: waitforVBlank, how does this even work?
Date: Wed, 2 Mar 2005 14:06:08 -0500
Message-ID: <9e473391050302110615272990@mail.gmail.com>
References: <9e473391050301215019081bce@mail.gmail.com>
	 <9e47339105030209302701e9b5@mail.gmail.com>
	 <Pine.LNX.4.62.0503021242370.15365@node2.an-vo.com>
	 <200503021308.23110.sellers-eric@rogers.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6ZAg-0005oW-3q
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 11:06:10 -0800
Received: from rproxy.gmail.com ([64.233.170.200])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D6ZAf-00029a-KL
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 11:06:10 -0800
Received: by rproxy.gmail.com with SMTP id z35so355864rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Mar 2005 11:06:09 -0800 (PST)
In-Reply-To: <200503021308.23110.sellers-eric@rogers.com>
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
To: Eric Sellers <sellers-eric@rogers.com>
Cc: Vladimir Dergachev <volodya@mindspring.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>

On Wed, 2 Mar 2005 13:08:23 -0500, Eric Sellers <sellers-eric@rogers.com> wrote:
> You can use my module with or without X
> (right now it only supports the older mach64 cards)
> 
> The only problem is there is no way of telling X where
> the capture buffers are. So you might get some corruption on screen when X
> uses that memory and it gets overwritten by a frame and then copied back.
> 
> The more memory you have the less you will notice this.
> (so if you have a 4 meg card, you might want to keep your resolution and bit
> depth down)
> 
> If there was a userspace program that could allocate the end of video memory
> there would be no problem.

I'm working on the radeon fbdev and DRM drivers currently. I can fix
the memory management for V4L if there is a radeon driver available.


> 
> Eric
> 


-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
