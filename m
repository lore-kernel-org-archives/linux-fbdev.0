From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [RFC] Video Mode Handling
Date: Mon, 9 Aug 2004 07:56:49 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040809145649.7829.qmail@web14925.mail.yahoo.com>
References: <200408091559.18436.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BuBZx-0001Lb-Ap
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 07:56:49 -0700
Received: from web14925.mail.yahoo.com ([216.136.225.11])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BuBZx-0007Ao-1C
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 07:56:49 -0700
In-Reply-To: <200408091559.18436.adaplas@hotpop.com>
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
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>

--- "Antonino A. Daplas" <adaplas@hotpop.com> wrote:
> I guess most people will agree that writing to the hardware belongs
> in the kernel, while choosing the correct values to write belongs to
> userspace.  The unanswered question is the middle part, who does the
> verification?

At OLS we talk about a system like this:
1) user owns graphics devices
2) user sets mode with string (or similar) format using ioctl common to
all drivers.
3) driver is locked to prevent multiple mode sets
4) common code takes this string and does a hotplug event with it.
5) hotplug event runs root context in user space 
6) mode is decoded and verified, this may involve a little process that
maintains the DDC database and reads a file of legal modes. Other
schemes are possible.
7a) mode is set using VBIOS and vm86, signal driver mode is set
7b) the register values needed to set the mode are passed into a root
priv ioctl.
8) driver is unlocked.

In this model all of the verification happens in user space. If you
want to set modes other than the ones from DDC you have to add them to
the config file. There is no need for DDC support and mode verification
in the kernel.

To give credit this is Alan Cox's design.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
