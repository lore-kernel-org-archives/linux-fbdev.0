From: David Eger <eger@havoc.gtf.org>
Subject: Re: 2.6.7 still garbage upon start
Date: Fri, 18 Jun 2004 23:08:54 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040619030854.GB14319@havoc.gtf.org>
References: <40D21E31.5070904@winischhofer.net> <40D2E96A.9000605@undead.cc> <Pine.GSO.4.58.0406181516460.11779@waterleaf.sonytel.be> <200406190240.31144.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbWEB-0007Tw-SM
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 20:09:11 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BbWEB-0002wI-JT
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 20:09:11 -0700
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, John Zielinski <grim@undead.cc>, Thomas Winischhofer <thomas@winischhofer.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, Jun 19, 2004 at 02:40:31AM +0800, Antonino A. Daplas wrote:
> 
> Actually, to eliminate the white rectangle, we just need to initialize fbdev 
> _after_ vgacon.  Currently, there is a set_par call in fbcon_startup()) which is
>  called prior to vgacon_deinit.  
> 
>  [snip]
>
> I've include a patch that incorporates all of the above.  (It also has some fixes
> for problems with creation of logo space -- the code does not consider that the
> new VC window size is different or even smaller than the old VC window size).
> Please test, and if it works for you, I'll push it upstream.

with my cirrusfb driver and your patch, the area to the right of the
penguins is cleared, but the area where the text is drawn still has
white rectangle crud that scrolls off the screen.

-dte



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
