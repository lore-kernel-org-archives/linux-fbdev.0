From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Rivafb won't work with DVI connector
Date: Sun, 28 Nov 2004 06:43:06 +0800
Message-ID: <200411280643.09524.adaplas@hotpop.com>
References: <200411250807.32040.adaplas@hotpop.com> <200411262209.17558.adaplas@hotpop.com> <200411271240.13475.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CYDPZ-0001ip-8Y
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Nov 2004 16:59:33 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CYBHp-0003CF-PM
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Nov 2004 14:44:01 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 76A0DA9471A
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 Nov 2004 22:43:10 +0000 (UTC)
In-Reply-To: <200411271240.13475.andrew@walrond.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Walrond <andrew@walrond.org>

On Saturday 27 November 2004 20:40, Andrew Walrond wrote:
> On Friday 26 Nov 2004 14:09, Antonino A. Daplas wrote:
> > On Thursday 25 November 2004 23:27, Andrew Walrond wrote:
> > > On Thursday 25 Nov 2004 00:07, Antonino A. Daplas wrote:
>
> none which are useful. Trying some of the modes from the DSUB log (ie 145 =
> vga=0x345 etc ) results always in (from memory) "Unsupported mode supplied;
> hit enter for list for wait 30s to continue" during boot. As I said, scan
> only finds text modes.
>
> So, not only is this not going to work, but the vesa driver also seems
> broken when used with dvi.

It's the BIOS that's broken.

If we can't even rely on the BIOS to set up an acceptable mode, I guess this
problem is for nVidia (if they're going to release the info).

Tony 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
