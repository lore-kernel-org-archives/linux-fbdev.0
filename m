From: Greg KH <greg@kroah.com>
Subject: Re: Fw: Rivafb I2C problem, new patch
Date: Mon, 12 Jul 2004 16:43:35 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040712234334.GA18296@kroah.com>
References: <20040712163942.672d4047.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BkAdn-0001Z1-L2
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Jul 2004 16:55:23 -0700
Received: from mail.kroah.org ([69.55.234.183] helo=perch.kroah.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BkAdn-00033u-AJ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Jul 2004 16:55:23 -0700
Content-Disposition: inline
In-Reply-To: <20040712163942.672d4047.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Nicolas Boichat <nicolas@boichat.ch>

On Mon, Jul 12, 2004 at 04:39:42PM -0700, Andrew Morton wrote:
> 
> Maybe Greg, or the linux-fbdev-devel denizens can comment upon
> this?
> 
> 
> Begin forwarded message:
> 
> Date: Tue, 13 Jul 2004 01:24:02 +0200
> From: Nicolas Boichat <nicolas@boichat.ch>
> To: akpm@digeo.com
> Subject: Rivafb I2C problem, new patch
> 
> 
> Hello,
> 
> I'm currently writing a DDC/CI tool for Linux (DDC/CI is the protocol
> which permits to modify monitor parameters without using the OSD), see
> http://www.boichat.ch/nicolas/ddcci .
> 
> I use the new rivafb I2C support, but a problem appeared: the I2C bus
> is immediately deleted after the DDC2 EDID is read, but I need to
> access it from my application!
> 
> I attached a patch which fixes this problem: the bus is deleted only
> when the driver is unloaded (please note that the atyfb behave like my
> patched version). Could you add it to the next -mm kernel release ?

Well, you shouldn't comment out those calls, just delete them.

Other than that, from an i2c standpoint, the patch looks sane, but I
would check with the maintainer, as there might be some reason they
delete the bus right after using it.

thanks,

greg k-h


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
