From: John Zielinski <grim@undead.cc>
Subject: Re: Sane behavior of fbset
Date: Sat, 19 Jun 2004 11:59:03 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40D462C7.30908@undead.cc>
References: <200406180945.12444.adaplas@hotpop.com> <200406190240.26228.adaplas@hotpop.com> <20040619031650.GC14319@havoc.gtf.org> <200406191413.28339.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbiFJ-0008CR-VV
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 08:59:09 -0700
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BbiFJ-0005B6-Im
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 08:59:09 -0700
In-Reply-To: <200406191413.28339.adaplas@hotpop.com>
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
Cc: David Eger <eger@havoc.gtf.org>, jsimmons@infradead.org, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino A. Daplas wrote:

>The flow of fbset is upstream:  fbset->fbdev->fbcon->vc (2.4 code)
>The flow of stty is downstream: stty->vc->fbcon->fbdev (2.6 code)
>  
>
The flow of fbset in 2.6: fbset->fbdev->fbcon
The flow of fbset after my patch: fbset->fbdev->fbcon->vc
The flow of fbset if calc error: 
fbset->fbdev->fbcon->vc->fbcon->fbdev->fbcon->vc-> etc.

As long as  graphics_res / font_size = text_res then fbcon will not try 
to resize the vc.  If there are any errors introduced into the 
calculations then you end up with an infinite loop.

John






-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
