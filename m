From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: fb and multiple adapters
Date: Fri, 3 Jan 2003 08:24:41 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030103162441.5146.qmail@web14904.mail.yahoo.com>
References: <1041589354.992.3.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14904.mail.yahoo.com ([216.136.225.56])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18UUcj-0004SD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 03 Jan 2003 08:24:41 -0800
In-Reply-To: <1041589354.992.3.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

--- Antonino Daplas <adaplas@pol.net> wrote:
> If I need too, I usually do this the hard way, I let
> X initialize the
> secondary card, exit X, then load the framebuffer
> driver module.

Alan Cox told me that it is almost impossible to run
the real mode initialization code from inside the
kernel.  Instead he pointed me to lrmi which is a
small app that can do it from the command line. I'm
looking into mod'ing lrmi so that it can coordinate
with the device driver and reset the secondary adapter
instead of the primary one.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
