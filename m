From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Wed, 20 Oct 2004 10:01:27 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <41763777.26324.1B3B684C@localhost>
References: <41740384.5783.12A07B14@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKJqI-0000Jb-Jt
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 20 Oct 2004 10:01:42 -0700
Received: from mail.scitechsoft.com ([63.195.13.67])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CKJqI-0008S1-3h
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 20 Oct 2004 10:01:42 -0700
In-reply-to: <20041019214818.GF1142@elf.ucw.cz>
Content-description: Mail message body
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Pavel Machek <pavel@ucw.cz> wrote:

> > Open Firmware may be a 'nicer' solution, but I guarantee that if the 
> > vendors started supporting that it would be just a bug ridden as any 16-
> > bit real mode BIOS code. For the Video BIOS the code always works for 
> > what it is tested for. Some vendors spend more time testing the VBE BIOS 
> > side of things fully (if they are smart they have licensed our VBETest 
> > tools for this purpose). Unfortunatley some vendors do not test this 
> > stuff thoroughly and it has problems. But the same testing issues would 
> > exist whether the firmware was written as a 16-bit x86 blob or as an Open 
> > Firmware blob.
> 
> Actually that 16-bit x86 blob can access any PC hardware, and that's
> where the stuff gets hard.

Yes, but there is only a very small set of PC hardware features you need 
to implement, and most BIOS'es only look at those things for timing 
purposes. Unfortunately there is no standard for how BIOS'es do internal 
timing and delay loops, so we emulate them all (8253 timers, speaker 
ports and CMOS time/date support ;-).

When we come across a new card that doesn't work we figure out why and 
make new additions to the video boot code. However at this point we think 
we have covered just about every card out there, as I don't think there 
are any cards in our labs that don't work at present. If there are, 
fixing them is just a matter of spending the time to debug it.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
