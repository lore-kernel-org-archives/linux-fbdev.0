From: Knut_Petersen@t-online.de
Subject: Re: cyberblade patch
Date: Fri, 12 Aug 2005 06:17:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0508120553160.2252@linux.site>
References: <20050804102905.GE7605@ws-gradcol1.icm.edu.pl>
 <20050804151342.GB11179@ws-gradcol1.icm.edu.pl> <20050810131148.GC11962@ws-gradcol1.icm.edu.pl>
 <Pine.LNX.4.58.0508101938400.2328@linux.site> <20050811100108.GC1287@ws-gradcol1.icm.edu.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3aGp-0006hs-Vm
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Aug 2005 07:12:27 -0700
Received: from mailout01.sul.t-online.com ([194.25.134.80])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E3aGo-0000tL-HD
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Aug 2005 07:12:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by linux.site (Postfix) with ESMTP id 037F175F52
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Aug 2005 06:17:37 +0200 (CEST)
In-Reply-To: <20050811100108.GC1287@ws-gradcol1.icm.edu.pl>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net

At the end of 2003 I complained about a lot of serious bugs. Nobody cared
about that. Some people, even one of the linux gurus, just told me to use
epiafb (not included in the standard distribution), but that driver is 
even more broken. I then wrote a dirty hack and used it for some time ... 
a vesafb with integrated cyberblade acceleration. Not really clean enough 
for release ;-) At the end of 2005 I had some time and wrote cyblafb, based 
on tridentfb. Probably cyblafb will be extended to include support for 
cyberblade/i7 and another "Blade 3D" graphics cores. But fixing tridentfb 
for all chips without hardware access is a task too time consuming for me. 

cu,
 Knut



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
