From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Multiple drivers for same hardware:, was: DRM and pci_driver conversion
Date: Thu, 23 Oct 2003 20:47:01 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031024034701.16514.qmail@web14915.mail.yahoo.com>
References: <3F987E18.9080606@pobox.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACswZ-0001le-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Oct 2003 20:48:56 -0700
Received: from web14915.mail.yahoo.com ([216.136.225.228])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1ACsuv-00084Q-Cm
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Oct 2003 20:47:13 -0700
In-Reply-To: <3F987E18.9080606@pobox.com>
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
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>

What about the fundamental question? We have several pairs of device drivers
that want to control the same hardware. One example would be radeon DRM and
radeon Framebuffer. How should these drivers coordinate probing and claiming
resources?

What should be the policy for multiple drivers?
1) try new probe first and fall back to old scheme. First driver that loads
gets the new probe, second gets the old. First driver reserves resources.
2) Require a mini driver that handles probing. Then both drivers attach to the
mini driver.
3) Declare it illegal and make the drivers merge.
4) Declare it illegal and only allow first one loaded to run.

Right now radeonfb handles probing and resource reservation. DRM works in
stealth mode. DRM uses all of the resources and never tells the kernel, that's
how it avoids conflicting with framebuffer.

DRM and framebuffer trade off control at VT switch. 2D state is save and
restored. There is an assumption that framebuffer won't mess with the 3D state.
 I'm not sure that suspend/resume are coordinated in any way.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
