From: Meelis Roos <mroos@linux.ee>
Subject: Re: atyfb and radeonfb
Date: Mon, 11 Nov 2002 11:16:40 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <E18BAgS-00009G-00@roos.tartu-labor>
References: <3DCBD804.8050109@ntlworld.com>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from tartu.cyber.ee ([193.40.6.68])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18BAe9-0000dJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 11 Nov 2002 01:14:17 -0800
Received: Message by Barricade tartu.cyber.ee  with ESMTP id gAB97M414889
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 11 Nov 2002 11:07:22 +0200
Received: from mroos by roos.tartu-labor with local (Exim 3.36 #1 (Debian))
	id 18BAgS-00009G-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 11 Nov 2002 11:16:40 +0200
In-Reply-To: <3DCBD804.8050109@ntlworld.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

SN> Is atyfb in 2.4 known to work with recent Mach64 chips like Rage XL? 

I did run a sparc64 with builtin Rage XL for about a year (2.4.18 time),
it worked fine. Don't remember the type of the RAM but it had 8M. At
first I had a problem with pixel clock frequency - the kernel new a
higer value for XL than the sparc64 implemented and so the description
of XL in kernel driver got changed for lower clock. But I doubt this
helps you :(

-- 
Meelis Roos (mroos@linux.ee)


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
