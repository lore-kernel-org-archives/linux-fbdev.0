From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Finding Aki M Laukkanen's VESAFBD project?
Date: Fri, 14 Mar 2003 14:57:31 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E71EDDB.915.5AD977E@localhost>
References: <3E71C00A.24038.4FAA05B@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70] helo=mail.scitechsoft.com)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ty7V-0005Ot-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Mar 2003 14:57:45 -0800
Received: from KENDALLB (adsl-63-195-13-78.dsl.chic01.pacbell.net [63.195.13.78])
	by mail.scitechsoft.com (8.12.8/8.12.5) with ESMTP id h2EMvrPD025638
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Mar 2003 14:57:53 -0800
In-reply-to: <20030314201152.76730.qmail@web14911.mail.yahoo.com>
Content-description: Mail message body
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
To: linux-fbdev-devel@lists.sourceforge.net

Jon Smirl <jonsmirl@yahoo.com> wrote:

> I noticed the email but I wasn't sure if you knew about the code
> from the way your mail was worded. 

;-)

> I used fasync and poll to implement user space communications in a
> driver I just finished.  Use kill_fasync(&fasync, SIGIO) from the
> device driver to signal the user app. The signal causes the app to
> poll which the driver replies POLLIN to. Polling identifies which
> device caused the signal. Now the user app knows it needs to IOCTL
> the handle to do whatever the driver needs it to. It only takes
> about 100 lines of code to implement the communication. 

Does the user space daemon block waiting to be woken up from the kernel 
module? I think the way Aki had it done initially was to have the user 
space daemon call into the kernel via an ioctl() or something, and the 
kernel would block on that thread and when something needed to be done, 
it would fill in the return structure for the ioctl() and then unblock 
the thread. The user space daemon would process the ioctl() and and then 
call it agin once the service was completed.

Does that system make sense at all?

Thanks!

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
