From: John Zielinski <grim@undead.cc>
Subject: Re: 2.6.7 still garbage upon start
Date: Fri, 18 Jun 2004 09:40:42 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40D2F0DA.8050706@undead.cc>
References: <40D21E31.5070904@winischhofer.net> <200406180945.06335.adaplas@hotpop.com> <40D29FCD.7020602@winischhofer.net> <Pine.GSO.4.58.0406181013340.11779@waterleaf.sonytel.be> <40D2E96A.9000605@undead.cc> <Pine.GSO.4.58.0406181516460.11779@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbJbt-0005H6-Mh
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 06:40:49 -0700
Received: from mail.undead.cc ([216.126.84.18])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BbJbt-0003bm-AI
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 06:40:49 -0700
In-Reply-To: <Pine.GSO.4.58.0406181516460.11779@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Antonino Daplas <adaplas@pol.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:

>Hence vgacon should be replaced by dummycon when it's deinitialized.
>
>  
>
I like that.  That way we're not depending on the old console driver to 
do the right thing when in KD_GRAPHICS.  Vgacon currently does but other 
console drivers might not.

I'll try that out tonight and see how it goes and then post the patch.

>(According to what I learned from the EFI talk at OLS last year) It's worse:
>you have to talk to the EFI bytecode to draw text on UGA, no direct access to
>the frame buffer ;-(
>  
>
Doh.  Let me guess, the interface was designed by a committee.....

John




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
