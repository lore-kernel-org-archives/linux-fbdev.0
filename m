From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Patch to add mode setting to sysfs
Date: Fri, 18 Feb 2005 11:46:21 -0500
Message-ID: <9e473391050218084629ad0935@mail.gmail.com>
References: <9e4733910502161430ff1dad1@mail.gmail.com>
	 <200502180804.46005.adaplas@hotpop.com>
	 <9e47339105021723274951c76c@mail.gmail.com>
	 <200502181542.50162.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2BGs-0004MZ-CS
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 08:46:26 -0800
Received: from rproxy.gmail.com ([64.233.170.207])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D2BGq-000629-KU
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 08:46:26 -0800
Received: by rproxy.gmail.com with SMTP id z35so728211rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Feb 2005 08:46:22 -0800 (PST)
In-Reply-To: <200502181542.50162.adaplas@hotpop.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@www.infradead.org>

On Fri, 18 Feb 2005 15:42:50 +0800, Antonino A. Daplas
<adaplas@hotpop.com> wrote:
> On Friday 18 February 2005 15:27, Jon Smirl wrote:
> > Next version of sysfs patch. Fills out more attributes. Feel free to
> > add code for missing implementations. Modifies fbcon to copy mode
> > structure instead of taking a reference to it. Modular fbdev is
> > separate patch. Ultimately we should be able to eliminate the IOCTL
> > code from fb_core and move it to a compatibility module.
> 
> Okay, I think I can start coding starting from this patch.

Do you want to take over the sysfs support? If so, I will make some
changes to the radeonfb driver that I need. That will keep up from
conflicting.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
