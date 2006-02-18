From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Bug#353310: linux-image-2.6.15-1-686: CONFIG_FB_ATY_XL_INIT
 should be set to n because it is broken
Date: Sat, 18 Feb 2006 08:08:57 +0800
Message-ID: <43F66599.9070204@gmail.com>
References: <20060217133617.4550.32757.reportbug@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FAZ3L-0007cE-Tq
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 18 Feb 2006 12:51:39 -0800
Received: from pproxy.gmail.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FAZ3I-0008TB-Hg
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 18 Feb 2006 12:51:40 -0800
Received: by pproxy.gmail.com with SMTP id n25so739998pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 18 Feb 2006 12:51:32 -0800 (PST)
In-Reply-To: <20060217133617.4550.32757.reportbug@localhost.localdomain>
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Debian Bug Tracking System <submit@bugs.debian.org>

Miernik wrote:
> Package: linux-image-2.6.15-1-686
> Version: 2.6.15-6
> Severity: normal
> 
> Please set CONFIG_FB_ATY_XL_INIT=n in the Debian kernel build, because
> this option is broken, and for example on ATI Rage XL / Mach64GM makes
> the system hang. For details please read this thread:
> http://thread.gmane.org/gmane.linux.fbdev.user/518

This option has already been removed for quite some time now.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
