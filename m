From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: 2.6.7 fbcon: set_con2fb on current console = crash
Date: Sat, 19 Jun 2004 18:03:10 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406191803.10736.adaplas@hotpop.com>
References: <20040618215047.GA4723@satan.blackhosts> <200406191413.44439.adaplas@hotpop.com> <Pine.GSO.4.58.0406191127250.23356@waterleaf.sonytel.be>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bbcgg-00064u-EW
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 03:03:02 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Bbcgg-00029E-3M
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 03:03:02 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id AA3F472AE5
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Jun 2004 09:01:49 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.58.0406191127250.23356@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jakub Bogusz <qboosh@pld-linux.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, pld-kernel@pld-linux.org

On Saturday 19 June 2004 17:28, Geert Uytterhoeven wrote:
> On Sat, 19 Jun 2004, Antonino A. Daplas wrote:
> > Thanks.  Actually there's still a critical flaw in the set_con2fbmap
> > code. For one, con2fb_map is never initialized.  It's just fortunate that
> > this array happens to be  filled with zeroes so con2fb_map[n] will always
> > return zero and registered_fb[0] happens to contain a valid info.  So it
> > works, by accident.
>
> According to the C standard, global variables are initialized to zero,
> unless specified otherwise.
>

I know, but what I meant was con2fb_map[] is never initialized by fbcon.  So 
if the first valid fbdev is in registered_fb[1], then con2fbmap must be 
initialized to 1's by fbcon.  It doesn't.  Note, fbdev-2.4 does the 
initialization correctly.

So 2 critical flaws in the code:

1. con2fb_map[] is always zero-set
2. fbcon assumes that registered_fb[0] is always valid

Both flaws will manifest by doing this:

modprobe fbdev1 - in registered_fb[0]
modprobe fbdev2 - in registered_fb[1]
rmmod fbdev1      - registered_fb[0] becomes invalid
modprobe fbcon  
	 - con2fb_map[] with zeroes instead of 1's and fbcon_startup looks for 
fb_info in registered_fb[0] instead of registered_fb[1]

Tony




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
