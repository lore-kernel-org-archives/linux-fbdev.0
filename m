From: John Zielinski <grim@undead.cc>
Subject: Re: Sane behavior of fbset
Date: Sat, 19 Jun 2004 11:50:26 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40D460C2.6090901@undead.cc>
References: <200406180945.12444.adaplas@hotpop.com> <20040618173840.GA3989@havoc.gtf.org> <200406190240.26228.adaplas@hotpop.com> <20040619031650.GC14319@havoc.gtf.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bbi76-0007Sj-UJ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 08:50:40 -0700
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Bbi76-0006q3-GL
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 08:50:40 -0700
In-Reply-To: <20040619031650.GC14319@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>
Cc: adaplas@pol.net, jsimmons@infradead.org, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

David Eger wrote:

>So *this* is what's going on with my port of the cirrusfb driver--why fbset 
>wasn't working... for radeonfb fbset still works in 2.6, so i didn't realize 
>there was this problem... What's so wonky with the fbset code path that 
>screws things up? and why does stty work?
>  
>
The radeonfb fbset doesn't work right out of the box.  The fbset path 
doesn't resize the vc rows and columns.  I use a patch to get things to 
work.  You have to be careful as there is potential for an infinite loop 
if the calculation between xres-yres and cols-rows is off.  I can't post 
the patch just yet as things have changed in fbcon.c in 2.6.7 so I need 
to update and test it.

John




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
