From: James Simmons <jsimmons@infradead.org>
Subject: softcursor updates and stuff.
Date: Tue, 30 Mar 2004 19:40:48 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403301912040.29836-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8OAP-0000GO-7n
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Mar 2004 10:40:53 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B8OAO-0001dd-Tg
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Mar 2004 10:40:53 -0800
Received: from localhost ([127.0.0.1])
	by phoenix.infradead.org with esmtp (Exim 4.30 #5 (Red Hat Linux))
	id 1B8OAK-0007yy-OF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Mar 2004 19:40:48 +0100
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi folks!!!

   I managed to fix most of the bugs in the new softcursor code. I have a 
cute little test program to try it out. 

http://phoenix.infradead.org:~/jsimmons/cursor.c

The only bug left is the the flashing. I'm going to try a experiment today 
for that. If it fixes the problem then I will submit the new cursor code 
to Andrew Morton. 

Note. 
   The softcursor expect the framebuffer layout to be packed pixels. This 
is not the case for vga16fb and amifb.c. I know amifb is broken because of 
the monitor detection code changes. As for vga16fb can anyone tell me 
where I can find docs on how to read the framebuffer for a image?
 




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
