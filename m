From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Mon, 18 Oct 2004 12:34:45 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4173B865.26539.117B09BD@localhost>
References: <200410160946.32644.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJdHX-00045Q-Qf
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 12:34:59 -0700
Received: from mail.scitechsoft.com ([63.195.13.67])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CJdHX-0008GP-7m
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 12:34:59 -0700
In-reply-to: <9e47339104101519034137c795@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Jon Smirl <jonsmirl@gmail.com> wrote:

> > There's a log of initialization that goes on between console_init() and
> > populate_rootfs().  However, console_init() will only initialize built-in
> > consoles (as pointed to by conswitchp) such as vgacon or dummycon.
> > However, the framebuffer system initialization does happen after
> > populate_rootfs().
> 
> We already have vgacon, promcon, sticon, mgacon, newportcon. What
> platforms (other than embedded) are not covered by these? 

Many embedded platforms do not map VGA resources in, so it is not 
possible to get VGACon to work on those machines unless the kernel/boot 
loader is modified to properly map VGA resources (which should be 
possible).

Then there are Macintosh machines that also do not map VGA resources. I 
am not sure if it is possible to map them on Macintosh machines or not.

I would assume however a serial port console would be fine for embedded 
machines until the framebuffer driver could come up anyway.

> The idea is to use one of these as a temporary console and not
> print anything on it except KERN_ERR level messages. Of course if
> you are a kernel developer you can change this. A working system
> would non have KERN_ERR messages during this phase and the screen
> would remain blank. 
> 
> Messages at levels other than KERN_ERR would be queued until
> populate_rootfs()/early user space time where they would then get
> displayed on the fbcon. fbcon will be a full console with mode
> setting capability and other fancy features. It would immediately
> go into graphics mode. 

As long as this process happens quickly and the machine boots into 
graphics mode within 1-2 seconds from poweron, that would probably be OK. 
If it starts taking too long for the system to get into graphics mode to 
display something the user can easily think something is wrong and the 
machine is not working.

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
