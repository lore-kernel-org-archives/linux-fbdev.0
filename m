From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Merge of Luca and Ben's sysfs work for Radeon
Date: Thu, 25 Sep 2003 17:10:53 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030926001053.80602.qmail@web14904.mail.yahoo.com>
References: <20030925234817.GB9615@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2gCE-0002c7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 17:10:54 -0700
Received: from web14904.mail.yahoo.com ([216.136.225.56])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A2gCD-0006jE-Ox
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Sep 2003 17:10:53 -0700
In-Reply-To: <20030925234817.GB9615@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- Otto Solares <solca@guug.org> wrote:
> Good! is somewhere a plain diff as i don't know how to use bk?
> 
> -solca

If you are going to track this you need to use bitkeeper.
Go here and download it: http://www.bitkeeper.com/Products.Downloads.html
Don't worry about registering an email, they haven't sent out any email in two
years.

To get luca's code
bk clone bk://mesa3d.bkbits.net/fbdev-2.5 local_name
To get updates:
cd in to local_name, bk pull

benh's code is at:
bk://ppc.bkbits.net/linuxppc-2.5-benh

I just put a merged driver (luca+benh) up at:
bk://mesa3d.bkbits.net/radeon-2.5

You can browse these repositories via
http://www.bkbits.net/
http://mesa3d.bkbits.net/

If you want to work on an updated Rage128 driver I can make you a repository at
mesa3d.bkbits.net.

To edit a file:
bk edit file_name
To commit locally:
bk citool
To publish changes:
bk push


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
