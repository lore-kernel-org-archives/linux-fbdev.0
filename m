From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Resource management.
Date: Tue, 22 Feb 2005 06:53:01 +0800
Message-ID: <200502220653.01286.adaplas@hotpop.com>
References: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3MQW-0000ne-OS
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 14:53:16 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D3MQV-00020M-9q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 14:53:16 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 4590D14102BF
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Feb 2005 22:52:59 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@www.infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tuesday 22 February 2005 03:11, James Simmons wrote:
> Hi!
>
>    This is my first run at the resource management code. Comments are
> welcomed :-)
>

Hi James,

Where is this going to?  What I see are performance penalties.  For each
putcs and cursor, it has to call fb_find_resource() which walks the linked list
looking for a resource using strncmp().  

What's the goal here?

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
