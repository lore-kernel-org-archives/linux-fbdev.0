From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Patch to add mode setting to sysfs
Date: Mon, 21 Feb 2005 14:13:09 -0500
Message-ID: <9e473391050221111333c9fa62@mail.gmail.com>
References: <9e4733910502161430ff1dad1@mail.gmail.com>
	 <200502181542.50162.adaplas@hotpop.com>
	 <9e473391050218084629ad0935@mail.gmail.com>
	 <200502190559.07162.adaplas@hotpop.com>
	 <Pine.LNX.4.56.0502211853400.13423@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3IzY-00061r-Dd
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 11:13:12 -0800
Received: from rproxy.gmail.com ([64.233.170.202])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D3IzY-0006i6-0h
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 11:13:12 -0800
Received: by rproxy.gmail.com with SMTP id z35so594904rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Feb 2005 11:13:09 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0502211853400.13423@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@www.infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net, James Simmons <jsimmons@pentafluge.infradead.org>

On Mon, 21 Feb 2005 18:55:23 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> We are attempting to work that out. Right now also I'm working on resource
> management for fbdev. I have a patch coming but it needs work. I consider
> it more important that sysfs right now. I will be sending the first run at
> that resource management today.

The work on framebuffer is being driven by our goal of demoing
XGL/mesa-solo/DRM&fbdev at OLS this summer. The sysfs code is a key
part of being able to set modes without being root.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
