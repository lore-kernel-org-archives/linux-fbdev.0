From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Issues with radeonfb (new) in widescreen displays
Date: Wed, 23 Jun 2004 09:04:20 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406230904.20399.adaplas@hotpop.com>
References: <1087949171.40d8c97373b9e@webmail.portugalmail.pt>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bcw9X-0003TR-0a
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Jun 2004 18:02:15 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bcw9W-00022W-Mc
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Jun 2004 18:02:14 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id 20D557470B
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 23 Jun 2004 00:00:07 +0000 (UTC)
In-Reply-To: <1087949171.40d8c97373b9e@webmail.portugalmail.pt>
Content-Disposition: inline
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
To: biatx@portugalmail.com, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

On Wednesday 23 June 2004 08:06, biatx@portugalmail.com wrote:
> Hi!
> I'm having a problem on a HP NX7000 laptop (the same as Compaq X1000)
> which has a mobility radeon 9000 (identified and marketed by HP as Radeon
> 9200 because of its clock rates) and a Samsung LCD with 1680x1050 (WSXGA+)
> as its native resolution.
>
> After booting up the system with a 1680x1050 radeonfb (only possible by
> editing
>
> drivers/video/aty/radeon_base.c
>
> and commenting out the
>
> radeon_map_ROM(rinfo, pdev);
>
> everything appears fine, except when Xorg launches using the 'radeon'
> driver and loads the GNOME environment. After that, if I switch back to a
> vt with eg. Ctrl+Alt+F1 my console will show up some garbled lines with
> green pixels mostly, in the bottom, in the area never used because of the

<snip>

> I'd really appreciate if someone could come up with a solution or patch,
> otherwise i'll have to fallback to the more limited and buggy old radeonfb
> driver that doesn't exhibit this behaviour when interacting with X.
>

A workaround which may or may not work is to set the tty where X is located
to a different size as compared to the tty's where your console is mapped.

So if X is in /dev/tty7, you can do something like this:

stty -F /dev/tty7 cols 80 rows 30

(Use the latest BK or mm release.  stty will fail in 2.6.7)

The above will set tty7 to 640x480.  This way, when you switch to any of 
your consoles (assuming they are not in 640x480), the framebuffer console
will "reinitialize" the hardware. 

A more definitive fix is in the works.

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
