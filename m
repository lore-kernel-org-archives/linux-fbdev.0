From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Patch to framebuffer
Date: Thu, 24 Nov 2005 18:21:44 +0100
Message-ID: <4385F6A8.60808@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfKnD-0000MK-73
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Nov 2005 09:21:55 -0800
Received: from mailout06.sul.t-online.com ([194.25.134.19])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EfKn9-0000jy-Qr
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Nov 2005 09:21:55 -0800
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
To: nathan.cline@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel Development <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@gmail.com>

Hi Nathan,

Updating only one framebuffer console at a time is a real feature for me,
it allows a really quick developement cycle:

            compile vesafb into the kernel, cyblafb as a module
            start with vesafb
loop:    load cyblafb
            switch to cyblafb, test it
            correct bugs, compile new cyblafb module
            switch to vesafb
            unload vesafb
            goto loop
           
Although both vesafb and cyblafb control the same hardware, this is
possible because of the "feature" you want to remove.

On the other hand I do understand that your patch is valuable, if I had
two monitors attached I certainly would like to be able to use both at the
same time.

I believe that you should introduce your code either as a compile time
option or even better it should be possible to disable it via sysfs:

     /sys/class/graphics/fb?/update_mode

0 could be the default and would activate your new code
1 would restore the old "one active" mode.

Please  consider my arguments and join us at

linux-fbdev-devel@lists.sourceforge.net

cu,
 Knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
