From: James Simmons <jsimmons@infradead.org>
Subject: Re: help with consolupdate on modechange in
 driver
Date: Mon, 22 Sep 2003 19:50:50 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309221945250.6431-100000@phoenix.infradead.org>
References: <20030922181651.GA22713@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1VmW-0001RK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 11:51:32 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A1VmV-0002nK-AF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 11:51:31 -0700
Received: from localhost.localdomain ([127.0.0.1] helo=localhost)
	by phoenix.infradead.org with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A1Vlr-0007Tt-J9
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 19:50:51 +0100
In-Reply-To: <20030922181651.GA22713@guug.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > I have just implemented modechange in my driver and while it
> > works, the consol *still* thinks we working in the old mode.
> > 
> > How do I inform the console layer that the driver (through fbset)
> > have changed the actual mode on the screen?
> 
> rivafb has this same problem.

stty is the program you want to use to change the resolution on a tty. At 
present fbset is not functioning. Patches are in the works to restore 
this.






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
