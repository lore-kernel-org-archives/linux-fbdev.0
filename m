From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Patch to add mode setting to sysfs
Date: Fri, 18 Feb 2005 15:42:50 +0800
Message-ID: <200502181542.50162.adaplas@hotpop.com>
References: <9e4733910502161430ff1dad1@mail.gmail.com> <200502180804.46005.adaplas@hotpop.com> <9e47339105021723274951c76c@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D22n3-0008HT-VF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 23:43:05 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D22n3-0002vF-D6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 23:43:05 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 8135CE64A52
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Feb 2005 07:42:54 +0000 (UTC)
In-Reply-To: <9e47339105021723274951c76c@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>, adaplas@pol.net, James Simmons <jsimmons@www.infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Friday 18 February 2005 15:27, Jon Smirl wrote:
> Next version of sysfs patch. Fills out more attributes. Feel free to
> add code for missing implementations. Modifies fbcon to copy mode
> structure instead of taking a reference to it. Modular fbdev is
> separate patch. Ultimately we should be able to eliminate the IOCTL
> code from fb_core and move it to a compatibility module.

Okay, I think I can start coding starting from this patch.

Thanks for the work Jon.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
