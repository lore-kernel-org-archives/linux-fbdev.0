From: Daniel Drake <dsd@gentoo.org>
Subject: Framebuffer display corruption on 2.6.12
Date: Fri, 12 Aug 2005 17:41:06 +0100
Message-ID: <42FCD122.4070705@gentoo.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3cYR-0007bf-FZ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Aug 2005 09:38:47 -0700
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E3cYO-00041z-Nn
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Aug 2005 09:38:47 -0700
Received: from aamta10-winn.ispmail.ntl.com ([81.103.221.35])
          by mta08-winn.ispmail.ntl.com with ESMTP
          id <20050812163833.CSTV23002.mta08-winn.ispmail.ntl.com@aamta10-winn.ispmail.ntl.com>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Fri, 12 Aug 2005 17:38:33 +0100
Received: from zog.reactivated.net ([81.99.81.161])
          by aamta10-winn.ispmail.ntl.com with ESMTP
          id <20050812163833.SPAU12116.aamta10-winn.ispmail.ntl.com@zog.reactivated.net>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Fri, 12 Aug 2005 17:38:33 +0100
Received: from [192.168.0.2] (dsd [192.168.0.2])
	by zog.reactivated.net (Postfix) with ESMTP id A49847BFA20
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Aug 2005 18:07:45 +0100 (BST)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

This looks like a userspace issue, but apparently it only appears after 
upgrading from 2.6.11 to 2.6.12...

Some Gentoo users have reported display corruption when using the framebuffer, 
easily visible in dialog-based applications. Sample screenshot:

https://bugs.gentoo.org/attachment.cgi?id=63264

Although the screenshot shows a framebuffer running on top of gentoo's 
"framebuffer splash", the same issue exists if you use plain old vesafb with 
no splash.

The issue has been reproduced in 2.6.13-rc5-mm1.

Any pointers in the right direction would be appreciated. Should I get this 
reported to the kernel bugzilla?

The original bug URL:

https://bugs.gentoo.org/show_bug.cgi?id=98804

Thanks,
Daniel


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
