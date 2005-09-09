From: Zack Smith <fbui@comcast.net>
Subject: can't access video memory?
Date: Fri, 09 Sep 2005 11:18:46 -0400
Message-ID: <4321A7D6.9070702@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EDkeE-0000Ai-Mq
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Sep 2005 08:18:38 -0700
Received: from sccrmhc11.comcast.net ([63.240.76.21])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EDkeC-00044W-Cg
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Sep 2005 08:18:38 -0700
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

Hi all,

As an experiment I tried accessing a part of (shared) video memory
on my system that is not being used for display data, and this caused the
kernel to crash. I have 6 megs of space and the display is using only half,
but accessing above the 3 meg mark causes the problem. Accessing
the lower 3 megs works fine.

Does anyone know what might cause this?

Thanks,
Zack Smith



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
