From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Finding Aki M Laukkanen's VESAFBD project?
Date: Fri, 14 Mar 2003 15:22:54 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030314232254.8987.qmail@web14904.mail.yahoo.com>
References: <3E71EDDB.915.5AD977E@localhost>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14904.mail.yahoo.com ([216.136.225.56])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18tyVs-0005AP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Mar 2003 15:22:56 -0800
In-Reply-To: <3E71EDDB.915.5AD977E@localhost>
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

You can do it either way. With blocking IO you would
need one thread per adapter. With the signal method
you can be single threaded and sleep waiting for a
signal. Both styles will work.

With single threaded you make an array of handles for
the framebuffers. When you get a signal you do poll()
on the array. For each active poll you will need to do
the IOCTL. Keep looping on poll/IOCTL until the poll
goes inactive, then sleep waiting for a SIGIO.

--- Kendall Bennett <KendallB@scitechsoft.com> wrote:
> Jon Smirl <jonsmirl@yahoo.com> wrote:
> 
> > I noticed the email but I wasn't sure if you knew
> about the code
> > from the way your mail was worded. 
> 
> ;-)
> 
> > I used fasync and poll to implement user space
> communications in a
> > driver I just finished.  Use kill_fasync(&fasync,
> SIGIO) from the
> > device driver to signal the user app. The signal
> causes the app to
> > poll which the driver replies POLLIN to. Polling
> identifies which
> > device caused the signal. Now the user app knows
> it needs to IOCTL
> > the handle to do whatever the driver needs it to.
> It only takes
> > about 100 lines of code to implement the
> communication. 
> 
> Does the user space daemon block waiting to be woken
> up from the kernel 
> module? I think the way Aki had it done initially
> was to have the user 
> space daemon call into the kernel via an ioctl() or
> something, and the 
> kernel would block on that thread and when something
> needed to be done, 
> it would fill in the return structure for the
> ioctl() and then unblock 
> the thread. The user space daemon would process the
> ioctl() and and then 
> call it agin once the service was completed.
> 
> Does that system make sense at all?
> 
> Thanks!
> 
> ---
> Kendall Bennett
> Chief Executive Officer
> SciTech Software, Inc.
> Phone: (530) 894 8400
> http://www.scitechsoft.com
> 
> ~ SciTech SNAP - The future of device driver
> technology! ~
> 
> 
> 
>
-------------------------------------------------------
> This SF.net email is sponsored by:Crypto Challenge
> is now open! 
> Get cracking and register here for some mind
> boggling fun and 
> the chance of winning an Apple iPod:
>
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


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
