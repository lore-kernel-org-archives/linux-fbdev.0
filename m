From: "Sottek, Matthew J" <matthew.j.sottek@intel.com>
Subject: RE: Framebuffer with banked memory
Date: Thu, 31 Oct 2002 13:18:33 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <2B4461BF89BAD511A86100508B66D53804E4FA69@fmsmsx112.fm.intel.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from petasus.ch.intel.com ([143.182.124.5])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 187Mi9-0005R0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 31 Oct 2002 13:18:41 -0800
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by petasus.ch.intel.com (8.11.6/8.11.6/d: solo.mc,v 1.48 2002/10/16 23:47:34 dmccart Exp $) with SMTP id g9VLJv413093
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 31 Oct 2002 21:19:57 GMT
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
To: 'James Simmons' <jsimmons@infradead.org>
Cc: 'alain volmat' <avolmat@yahoo.fr>, linux-fbdev-devel@lists.sourceforge.net


>:-( Even with providing your own mmap function you still couldn't get it
>to work.

Is that a question?
I did make it work. It worked just fine however when a client accesses a
bank via the mmap you have to fault in that bank and _unmap_ the other
bank from the client's mmap. This isn't something the kernel lets you
do from a module (for good reason).

The problem is that when one instruction accesses two banks at the same
time there is no possible way to have both banks present and the fault
handler would get stuck trying to satisfy the impossible. It doesn't
happen in normal aligned accesses (I had XFree running on it) but it
is a timebomb waiting to go off so I stopped pursuing it.

-Matt




-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
