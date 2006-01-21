From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [BUG] X and/or intelfb and/or input: lockup
Date: Sat, 21 Jan 2006 13:26:02 +0100
Message-ID: <43D2285A.8090806@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F0Hon-0005rp-59
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Jan 2006 04:26:09 -0800
Received: from mailout09.sul.t-online.com ([194.25.134.84])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F0Hom-0005OI-PJ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Jan 2006 04:26:09 -0800
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
Cc: linux-kernel@vger.kernel.org

System description:
   - AOpen i915GMm-HFS, Pentium M 750
   - The software once was a SuSE 9.2, Xorg is updated to 6.9
   - intelfb

Occasionally the system locks up while switching from X
to the framebuffer console. The keyboard is completely
dead, monitor turns black. Shutdown by pressing the
power button works, but the logs contain no indication
of a problem.

Any ideas?

cu,
 Knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
