From: Alex Pavloff <apavloff@eason.com>
Subject: National Geode drivers
Date: Wed, 21 Aug 2002 16:35:39 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <D3AF5F134D627243993F2F2FC32EE4D20CE1B9@mailman.eason.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from a.smtp-out.sonic.net ([208.201.224.38])
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17hf0o-00079g-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 21 Aug 2002 16:35:42 -0700
Received: from mailman.eason.com (adsl-209-204-139-80.sonic.net [209.204.139.80])
	by ultra.sonic.net (8.11.6/8.8.5) with ESMTP id g7LNZeD07168
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 21 Aug 2002 16:35:40 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'linux-fbdev-devel@lists.sourceforge.net'" <linux-fbdev-devel@lists.sourceforge.net>


Hello folks,

I figure this is a good place to put a message about this so people will be
able find this in the future.  I have sucessfully compiled National
Semiconductor's 1.1.7 Geode kernel framebuffer driver for Linux 2.4.19, and
had the screen come up.  The files are at www.eason.com/linux.    They work,
but they aren't pretty.  (They ARE for multiple OSes/chipsets though).

The drivers are chock-full of features that are commented out and for
different platforms.  This specific configuration works on an Advantech
PCM-5820 board, and I suspect it would work on most of the similar boards
out there.  

Later 1.2.0 drivers are also available on the above mentioned site, but it
appears all they do is add more hooks for National's custom framebuffer
acceleration.

Alex Pavloff
Software Engineer
Eason Technology
 


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
