From: James Simmons <jsimmons@infradead.org>
Subject: Re: Need advice on blitting to dword alignment
Date: Fri, 12 Sep 2003 22:26:33 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309122225100.5017-100000@phoenix.infradead.org>
References: <20030912195842.GA25986@zensonic.dk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xvR7-0002Oj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 14:26:37 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xvR6-0007Hh-Ik
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 14:26:36 -0700
In-Reply-To: <20030912195842.GA25986@zensonic.dk>
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
To: "Thomas S. Iversen" <zensonic@zensonic.dk>
Cc: linux-fbdev-devel@lists.sourceforge.net


> instead of 
> 
> 	if(image->depth!=1)
> 		return cfb_imageblit(info,image);
> 
> 	.... accelerated depth==1 code

No hardware support to draw color images :-(
 
> That gave me my tux back. My curser however is still broken. 

Cursor broken in 2.5.73.

> I have also
> tried to do a software blitt with both the alignemnt options set to 4 and
> it does not appear to work :-/

You mean a cfb_copyarea call? 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
