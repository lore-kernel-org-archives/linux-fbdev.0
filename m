From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH][FBDEV]: fb_putcs() and fb_setfont() methods
Date: Sat, 4 Jan 2003 21:08:43 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301042107390.24903-100000@phoenix.infradead.org>
References: <20030104140058.GA10918@middle.of.nowhere>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18UvXh-0004MQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 04 Jan 2003 13:09:18 -0800
In-Reply-To: <20030104140058.GA10918@middle.of.nowhere>
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
To: Jurriaan <thunder7@xs4all.nl>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>


> > Attached is a patch against 2.5.54 in an attempt to add putcs() and
> > setfont() methods for fbdev drivers that require them:
> > 
> And those drivers would be the matrox framebuffer drivers, for example?
> 
> That would be really great!

I'm porting this driver to the new api. I'm alomst finished with the 
nvidia driver. Once I'm done on that the matrox driver is next. Sorry it 
is taking so long but I have alot of drivers to deal with.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
