From: David Eger <eger@havoc.gtf.org>
Subject: Re: State of pm3fb driver
Date: Tue, 12 Oct 2004 15:15:14 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041012191514.GB4636@havoc.gtf.org>
References: <1gl6uux.9w928rity4liM%dolbeaur@club-internet.fr> <20041005190604.GA11481@mercury.jahnsnet.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHSE8-00039r-7u
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 12 Oct 2004 12:22:28 -0700
Received: from havoc.gtf.org ([69.28.190.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CHSE7-0006vJ-DX
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 12 Oct 2004 12:22:28 -0700
Received: from havoc.gtf.org (havoc.gtf.org [127.0.0.1])
	by havoc.gtf.org (Postfix) with ESMTP id AC50E754E
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 12 Oct 2004 15:15:14 -0400 (EDT)
Received: (from eger@localhost)
	by havoc.gtf.org (8.12.10/8.12.10/Submit) id i9CJFEdn023974
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 12 Oct 2004 15:15:14 -0400
Content-Disposition: inline
In-Reply-To: <20041005190604.GA11481@mercury.jahnsnet.de>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Tue, Oct 05, 2004 at 09:06:04PM +0200, Thomas Jahns wrote:
> On 10/05/04 15:01:23, Romain Dolbeau wrote:
> >Noone ever updated pm3fb to works with 2.6.x, so as you noticed,
> >it doesn't work. There was a lot of changes for FB driver in 2.6.x,
> >so the driver is in need of a complete rewrite.
> 
> Is there a sufficiently complete description of these changes to  
> "mechanically" port them to the existing driver? I'd certainly try that  
> because it seems to me the changes to atyfb are just as hard to port to  
> the Macintosh. I think Benjamin Herrenschmidt is working on the latter  
> already but I'm unaware as to how much progress he has made.

Upgrading a driver from 2.4 to 2.6 is a tedious task that takes about
two weeks if you know FB sorta well.  I and Francois Romieu did this for
cirrusfb between 2.6.7 and 2.6.9;  Geert fixed the amiga bits then too, but 
there's been no testing of that code ;-)

A Pseudo-human readable description of the non-Amiga bits is at:

http://www.ussg.iu.edu/hypermail/linux/kernel/0406.2/1936.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0406.3/1040.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0406.3/1083.html

-dte



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
