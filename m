From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: [ANNOUNCE]: VM86 Daemon
Date: Mon, 31 Mar 2003 16:27:11 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E886C5F.28140.1013B3CA@localhost>
References: <1049104351.1037.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70] helo=mail.scitechsoft.com)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1909ct-00079W-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 31 Mar 2003 16:27:43 -0800
Received: from KENDALLB (adsl-63-195-13-78.dsl.chic01.pacbell.net [63.195.13.78])
	by mail.scitechsoft.com (8.12.8/8.12.5) with ESMTP id h310SrPF015728
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 31 Mar 2003 16:28:53 -0800
In-reply-to: <20030401000746.44732.qmail@web14912.mail.yahoo.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Jon Smirl <jonsmirl@yahoo.com> wrote:

> I didn't read through the code yet, is this being implemented by
> adding some new IOCTLs to the fb interface? For example an IOCTL to
> get the legal modes or to reset the card. 

We definitely want some new IOCTL's to allow the apps to find out what 
modes are available, if this has not been added.

> Why does it need /dev/vm86, couldn't it just use the fb device and
> add some new IOCTLS? 

Yes, it could. However when Tony discussed this with me a week or so ago, 
he figured that since vesafb is just using basic vm86() functions from 
the kernel, it is a lot more modular and useful to make the daemon just a 
vm86() daemon for kernel code. Then it can be used for other stuff that 
has a need to make real mode BIOS calls that just the vesafb driver.

> I would expect to the end user app to only interact with the
> /dev/fb, it would be unaware of the daemon. This would allow these
> functions to be transparently added to the driver if the need
> hardware info becomes available. 

As I understand it the /dev/vm86 interface is there solely to implement 
the vm86() interfacing to the kernel, which is used by the modified 
vesafb driver. Userland apps only ever call the /dev/fb functions via the 
standard IOCTL's and never need to care that /dev/vm86 exists or not. It 
is clean separation, and as you said if the fb driver can drive the 
hardware directly without the need to use the vm86d daemon, it is 
transparently ignored by any and all fb console apps ;-)

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
