From: Otto Solares <solca@guug.org>
Subject: Re: Merge of Luca and Ben's sysfs work for Radeon
Date: Thu, 25 Sep 2003 20:36:17 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030926023617.GD9615@guug.org>
References: <20030925234817.GB9615@guug.org> <20030926001053.80602.qmail@web14904.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2iTZ-0007zH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 19:36:57 -0700
Received: from guug.galileo.edu ([168.234.203.30])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A2iTY-0006Ly-QB
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Sep 2003 19:36:57 -0700
Content-Disposition: inline
In-Reply-To: <20030926001053.80602.qmail@web14904.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Sep 25, 2003 at 05:10:53PM -0700, Jon Smirl wrote:
> --- Otto Solares <solca@guug.org> wrote:
> > Good! is somewhere a plain diff as i don't know how to use bk?
> > 
> > -solca
> 
> If you are going to track this you need to use bitkeeper.
> Go here and download it: http://www.bitkeeper.com/Products.Downloads.html
> Don't worry about registering an email, they haven't sent out any email in two
> years.
> 
> To get luca's code
> bk clone bk://mesa3d.bkbits.net/fbdev-2.5 local_name
> To get updates:
> cd in to local_name, bk pull
> 
> benh's code is at:
> bk://ppc.bkbits.net/linuxppc-2.5-benh
> 
> I just put a merged driver (luca+benh) up at:
> bk://mesa3d.bkbits.net/radeon-2.5
> 
> You can browse these repositories via
> http://www.bkbits.net/
> http://mesa3d.bkbits.net/
> 
> If you want to work on an updated Rage128 driver I can make you a repository at
> mesa3d.bkbits.net.
> 
> To edit a file:
> bk edit file_name
> To commit locally:
> bk citool
> To publish changes:
> bk push

Ok, i have your merged tree now.  How can i generate a normal
patch so i can patch the latest Linus kernel?

I don't think i'll work on r128 driver as i am not that good
on driver devel, i am interested in fbdev/dri & fbdev/sysfs
for mach64/r128/radeon but from userspace perspective.

Thanks.

-solca



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
