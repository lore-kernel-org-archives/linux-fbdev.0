From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: Patch for review and testing
Date: Wed, 28 Jan 2004 11:18:00 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1075249079.5655.229.camel@gaston>
References: <Pine.LNX.4.44.0401272255180.19265-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AldSR-0000bg-RA
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Jan 2004 16:21:27 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AldSR-0006oO-DE
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Jan 2004 16:21:27 -0800
In-Reply-To: <Pine.LNX.4.44.0401272255180.19265-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>

On Wed, 2004-01-28 at 09:59, James Simmons wrote:

> P.S.
>    Have any idea to know which card is the primary one on intel. I have 
> been trying to figure that one out for quite some time.

AFAIK, we need the arch/i386 PCI probe code to "remember", when probing,
which VGA card had the IO enable bit set. There can be only one, the primary
one since BIOSes only POST one card.

BTW. What about my set of patches ? Did you have time to have a look ?

Ben.
 



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
