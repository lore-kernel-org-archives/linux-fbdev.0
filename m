From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Finding Aki M Laukkanen's VESAFBD project?
Date: Fri, 14 Mar 2003 12:11:52 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030314201152.76730.qmail@web14911.mail.yahoo.com>
References: <3E71C00A.24038.4FAA05B@localhost>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14911.mail.yahoo.com ([216.136.225.249])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18tvWy-0002WT-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Mar 2003 12:11:52 -0800
In-Reply-To: <3E71C00A.24038.4FAA05B@localhost>
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
Content-Transfer-Encoding: 7bit
To: Kendall Bennett <KendallB@scitechsoft.com>, linux-fbdev-devel@lists.sourceforge.net

I noticed the email but I wasn't sure if you knew
about the code from the way your mail was worded. 

I used fasync and poll to implement user space
communications in a driver I just finished.  Use
kill_fasync(&fasync, SIGIO) from the device driver to
signal the user app. The signal causes the app to poll
which the driver replies POLLIN to. Polling identifies
which device caused the signal. Now the user app knows
it needs to IOCTL the handle to do whatever the driver
needs it to. It only takes about 100 lines of code to
implement the communication.

google for: fasync sigio user


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Web Hosting - establish your business online
http://webhosting.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
