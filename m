From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: DRM and pci_driver conversion
Date: Thu, 23 Oct 2003 21:04:21 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031023190421.GA4567@dreamland.darkstar.lan>
References: <1066703516.646.24.camel@leguin>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACkl4-0007RM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Oct 2003 12:04:30 -0700
Received: from mail-3.tiscali.it ([195.130.225.149])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1ACkl3-00038x-L8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Oct 2003 12:04:29 -0700
Content-Disposition: inline
In-Reply-To: <1066703516.646.24.camel@leguin>
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
To: Eric Anholt <eta@lclark.edu>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@yahoo.com>

Il Mon, Oct 20, 2003 at 07:31:56PM -0700, Eric Anholt ha scritto: 
> I recently committed a change to the DRM for Linux in DRI CVS that
> converted it to use pci_driver and that probe system.  Unfortunately,
> we've found that there is a conflict between the DRM now and at least
> the radeon framebuffer.  Both want to attach to the same device, and
> with pci_driver, the second one to come along doesn't get probe called
> for that device.  Is there any way to mark things shared, or in some
> other way get the DRM to attach to a device that's already attached to,
> in the new model?

AFAIK no,  pci_dev only  stores one pointer  to the  driver. Two drivers
fiddling with the same hw can be dangerous. What will happen if radeonfb
starts using hw  accel, touching registers without  DRM knowing it? What
is (IMHO) needed is a common  layer that works with hardware and exposes
an interface to both radeonfb and DRM. I think that Jon Smirl is working
on something like this.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"Sei l'unica donna della mia vita".
(Adamo)


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
