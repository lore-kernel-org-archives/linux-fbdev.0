From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Rivafb won't work with DVI connector
Date: Tue, 23 Nov 2004 19:00:26 +0000
Message-ID: <200411231900.26792.andrew@walrond.org>
References: <200411191137.14649.andrew@walrond.org> <200411231801.14328.andrew@walrond.org> <200411240226.03203.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWfu3-00046A-Ng
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 11:00:39 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CWftx-0003oz-7F
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 11:00:39 -0800
In-Reply-To: <200411240226.03203.adaplas@hotpop.com>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>

On Tuesday 23 Nov 2004 18:26, Antonino A. Daplas wrote:
> On Wednesday 24 November 2004 02:01, Andrew Walrond wrote:
>
> > With dvi connection and no params, I get a fully working console, but at
> > 1024x768 (128x48)
>
> Okay, this is what I wanted to fix.  Note that the preferred timing when
> dvi is attached is 1024x768. When dsub, it's 1600x1200.  You see this
> in your dmesg "First DETAILED Timing is preferred", and without options
> the first detailed timing block will be used.
>

Can you explain further...
This is =A31000 of TFT LCD panel with 1600x1200 _physical_ pixels. The pane=
l=20
size is 1600x1200, not 1024x768. So where is this erroneous value coming=20
from?

> Note, that you may not be able to force resolutions > panel size.  You can
> try, all you need to do is remove this code in
> drivers/video/nvidia/nvidia.c:nvidiafb_check_var:

I don't want to force illegal modes, I'd rather just have the real panel si=
ze=20
reported, then all modes would be legal :(

I wonder; does DVI have any recommended limits on bandwidth, resulting in a=
=20
max resolution with dvi of 1024x768? Something at the back of my mind is=20
triggering bells here. Anyone know? I guess google is my friend ;)

I'll try the other things you mention and report back later.

Thanks for your efforts this far!

Andrew


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
