From: John Zielinski <grim@undead.cc>
Subject: Re: 2.6.7 still garbage upon start
Date: Sat, 19 Jun 2004 15:27:10 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40D4938E.6090406@undead.cc>
References: <40D21E31.5070904@winischhofer.net> <40D2E96A.9000605@undead.cc> <Pine.GSO.4.58.0406181516460.11779@waterleaf.sonytel.be> <200406190240.31144.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BblUm-0007Og-5k
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 12:27:20 -0700
Received: from mail.undead.cc ([216.126.84.18])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BblUl-0001ty-Kr
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 12:27:19 -0700
In-Reply-To: <200406190240.31144.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: adaplas@pol.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Winischhofer <thomas@winischhofer.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Antonino A. Daplas wrote:

>1. Solution: Move this set_par call to fbcon_init instead.
>  
>
One thing I just noticed about your patch, if we move the set_par 
shouldn't the vc_resize move with it?

John




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
