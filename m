From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Rivafb won't work with DVI connector
Date: Wed, 24 Nov 2004 22:38:11 +0000
Message-ID: <200411242238.11299.andrew@walrond.org>
References: <200411191137.14649.andrew@walrond.org> <200411232053.28741.andrew@walrond.org> <200411240638.51261.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CX5mv-0006mj-P2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Nov 2004 14:39:01 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CX5mu-00080m-RB
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Nov 2004 14:39:01 -0800
In-Reply-To: <200411240638.51261.adaplas@hotpop.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>

On Tuesday 23 Nov 2004 22:44, Antonino A. Daplas wrote:
>
> BTW: How does X behave if the input is digital.  Does it accept modes
> greater than panel size?  If it does, then the documentation is actually
> there.  I'll look at the X code again.  And I'll probably do some googling
> on this.  If you happen to encounter any kind of programming info about
> this, let me know also.
>

Just tried this; No joy. The screen just goes blank. I think we need to find 
out about those undocumented registers.

I'll try the vesafb trick next.

Andrew


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
