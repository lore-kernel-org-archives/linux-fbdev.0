From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc9 0/2] metronomefb and am200epd
	fixes v9
Date: Sat,  2 Aug 2008 09:08:18 -0400
Message-ID: <1217682500-31503-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KPHig-0005x0-5N for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Aug 2008 07:04:30 -0700
Received: from wx-out-0506.google.com ([66.249.82.227])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KPHid-00043D-R7
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Aug 2008 07:04:30 -0700
Received: by wx-out-0506.google.com with SMTP id h29so810192wxd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Aug 2008 07:04:27 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net


This is version 9 of this RFC and contains the following updates:
- switched to using fb notifiers. The benefit of this is that it avoids
  the need to add any custom callbacks in pxafb. Basically, using this
  mechanism there are no changes needed from the underlying host video driver.
- eliminates one patch. So we just have the new am200epd and changes to
  metronomefb.

I think this is much cleaner and more generic. Please let me know if there
are any issues that need to be resolved.

Thanks,
jaya


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
