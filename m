From: James Simmons <jsimmons@infradead.org>
Subject: Re: New API pm2fb driver
Date: Mon, 22 Sep 2003 22:18:38 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309222218300.6431-100000@phoenix.infradead.org>
References: <XFMail.20030921224400.jim.hague@acm.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1Y4y-0004TB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 14:18:44 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A1Y4x-0006hk-F2
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 14:18:43 -0700
In-Reply-To: <XFMail.20030921224400.jim.hague@acm.org>
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
To: Jim Hague <jim.hague@acm.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


Applied and in the fbdev BK tree.


On Sun, 21 Sep 2003, Jim Hague wrote:

> First crack at this - as a patch against 2.6.0-test5 - is at
> http://www.bear-cave.org.uk/linux/pm2fb/pm2fb-2.6.patch.gz.
> 
> Currently the driver only supports 'Generic PCI' cards on x86; that's the only
> hardware (Graphics Blaster Exxtreme) I have access to. It is also unaccelerated.
> I've been using it for a week in conjunction with the XFree Glint driver (via
> UseFBDev) and it seems to work but has received only the most cursory testing.
> 
> All reviews/advice/bug reports/etc. welcome.
> 
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
