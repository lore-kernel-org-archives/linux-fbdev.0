From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Thu, 21 Oct 2004 12:36:59 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4177AD6B.8391.20F028B0@localhost>
References: <41763777.26324.1B3B684C@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKikJ-0008D2-HI
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Oct 2004 12:37:11 -0700
Received: from mail.scitechsoft.com ([63.195.13.67])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CKikJ-00007j-3m
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Oct 2004 12:37:11 -0700
In-reply-to: <20041020190846.GA21315@elf.ucw.cz>
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

> > Yes, but there is only a very small set of PC hardware features you need 
> > to implement, and most BIOS'es only look at those things for timing 
> > purposes. Unfortunately there is no standard for how BIOS'es do internal 
> > timing and delay loops, so we emulate them all (8253 timers, speaker 
> > ports and CMOS time/date support ;-).
> 
> Hmm, that does not seem that bad. Did you need to emulate interrupt
> controller, too? That one seemed most scary to me.

No. Only software interrupts. The BIOS never deals with hardware 
interrupts since there is no standard, reliable way to hook them from 
real mode so it never uses them ;-)

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
