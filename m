From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Fix for wasted memory in rivafb?
Date: Wed, 12 Feb 2003 19:58:22 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302121957210.31435-100000@phoenix.infradead.org>
References: <1043623243.1307.16.camel@h9n1fls20o980.telia.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18j321-0005gN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Feb 2003 11:58:58 -0800
In-Reply-To: <1043623243.1307.16.camel@h9n1fls20o980.telia.com>
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
To: Fredrik Noring <noring@nocrew.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


> This patch fixes a problem with wasted memory in the rivafb driver.
> For some reason, only half the memory is currently allowed when 
> maximizing the virtual screen. The 2.5.x tree has the same problem.
> 
> Is this a reserve for something? I have not found any use for it 
> inside the driver.

I tried it out. It messed up my screen. I really wished I had the specs.
It would make life easier.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
