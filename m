From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Rivafb won't work with DVI connector
Date: Tue, 23 Nov 2004 20:53:28 +0000
Message-ID: <200411232053.28741.andrew@walrond.org>
References: <200411191137.14649.andrew@walrond.org> <200411231923.40572.andrew@walrond.org> <Pine.GSO.4.61.0411232057280.6094@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWhfZ-0005fH-AV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 12:53:49 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CWhfW-0005dj-6H
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 12:53:49 -0800
In-Reply-To: <Pine.GSO.4.61.0411232057280.6094@waterleaf.sonytel.be>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, Chad Daelhousen <cd9@cse.buffalo.edu>

On Tuesday 23 Nov 2004 19:59, Geert Uytterhoeven wrote:
>
> No, this will use the BIOS to switch to a 1280x1024 mode before starting
> the kernel. Remember that Tony told you the panel size is set up by the
> BIOS. If that's really the case, it should help.
>

Hi Geert,

I got that. I guess I'm asking whether the problem is self imposed by our 
driver by rejecting modes > panel size. Ie could we just ignore the panel 
size and allow any EDID supported modes?
Or, is it the video card that in any case would not allow us to set modes > 
panel size?

Chad explains it well in his email.

I guess I need to start reading the code :)

Andrew


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
