From: James Simmons <jsimmons@infradead.org>
Subject: Latest Fbdev changes.
Date: Tue, 26 Nov 2002 20:43:28 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211262039590.30451-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18GmYu-0001J5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 26 Nov 2002 12:44:05 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=localhost)
	by phoenix.infradead.org with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.10)
	id 18GmYL-0007wk-00
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Nov 2002 20:43:29 +0000
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


Hi!

  Here is the patch I promised. It is against 2.5.49. Note fbcon is 
broken. I haven't found the problem yet since using modules is really  
broken. I started to work on making fbcon modular. Several driver have 
been updated to the latest changes in the api. THe api is pretty much rock 
solid now. You can grab the patch at 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Let me know how it goes.


P.S
   I didn't annouce it on lkml yet because fbcon is broken. Once it is 
fixed I will push what we have to linus.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
