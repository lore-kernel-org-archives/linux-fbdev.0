From: John Zielinski <grim@undead.cc>
Subject: radeon_pm.c locking problem
Date: Fri, 02 Jul 2004 13:29:38 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40E59B82.7000807@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgRrB-0007Rz-Qh
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 10:29:49 -0700
Received: from mail.undead.cc ([216.126.84.18])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BgRrB-0000Ab-Fv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 10:29:49 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

There's a post in the lkml from a Stanford researcher working on a tool 
to sniff out locking problems.  In his post he gave an example from the 
radeon_pm.c file.  Just want to make sure the appropriate people noticed 
the post.  It's subject is "[BUGS] [CHECKER] 99 synchronization bugs and 
a lock summary database".

John




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
