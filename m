From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Dual screen framebuffer development advice
Date: Sun, 20 Jun 2004 04:25:48 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406200425.48378.adaplas@hotpop.com>
References: <200406191455.56574.andrew@walrond.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbmOv-0002ym-N1
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 13:25:21 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BbmOv-0003bG-CL
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 13:25:21 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 487CF623946
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Jun 2004 19:46:23 +0000 (UTC)
In-Reply-To: <200406191455.56574.andrew@walrond.org>
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
To: Andrew Walrond <andrew@walrond.org>, linux-fbdev-devel@lists.sourceforge.net

On Saturday 19 June 2004 21:55, Andrew Walrond wrote:
> I need to setup a machine to develop a framebuffer based application. I'd
> like to use two graphics devices; The first an ati agp chipset on the
> motherboard which will run X11 with X11's ati driver, the second a PCI card
> running a fb driver and displaying my framebuffer application.
>
> Is this possible/sensible?

Sure, it's possible and actually not hard to do.  Just make sure that the 
driver of your primary card is fbdev, and the secondary X11.  X happens to do 
a fine job of initializing non-primary cards whereas fbdev is mostly 
restricted to cards initialized by the firmware.

Note: You wont' be able to see both displays simultaneously, switching from 
one blanks the other.   If you do want multi-seat, see the Ruby project of 
linuxconsole.

As for sensible, that's up to you :-)

Tony




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
