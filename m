From: John Zielinski <grim@undead.cc>
Subject: Re: 2.6.7 still garbage upon start
Date: Fri, 18 Jun 2004 22:09:14 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40D3A04A.60203@undead.cc>
References: <40D21E31.5070904@winischhofer.net> <40D2E96A.9000605@undead.cc> <Pine.GSO.4.58.0406181516460.11779@waterleaf.sonytel.be> <200406190240.31144.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbVIL-0002N9-Gc
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 19:09:25 -0700
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BbVIL-0002VA-2L
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 19:09:25 -0700
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

>If the boot logo is not enabled, then everything is okay.  With the boot logo
>enabled, you will see remnants of old text (not garbage) in the space 
>provided for the logo.  
>
>  
>
Actually, my problem _was_ with the boot logo not enabled but your patch 
fixed it.  That misplaced set_par was why it looked like vgacon was 
still being used and the cause of all my grief. 

>Please test, and if it works for you, I'll push it upstream.
>
>  
>
Yes, it does work so please push it.  It just took me a while to test it 
as I had to figure out what was clearing my video memory.  Once that was 
disabled I can now see my bootup sequence all the way back to the beginning.

John




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
