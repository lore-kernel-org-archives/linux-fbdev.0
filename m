From: Kevin Hilman <khilman@mvista.com>
Subject: Use of 'reserved' fields in var_screeninfo
Date: Mon, 14 Nov 2005 11:17:31 -0800
Message-ID: <4378E2CB.3080902@mvista.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ebjph-0001Js-Ec
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 11:17:37 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158] helo=hermes.mvista.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ebjpf-0001lk-Sx
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 11:17:37 -0800
Received: from [127.0.0.1] (godzilla.mvista.com [10.0.0.2])
	by hermes.mvista.com (Postfix) with ESMTP id 11FB71A9BC
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Nov 2005 11:17:32 -0800 (PST)
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

Hello,

I've got a question about the purpose of the reserved fields in the
var_screeninfo struct:

struct fb_var_screeninfo {
	[ ... ]
	__u32 reserved[5];		/* Reserved for future compatibility */
};

What are these reserved for?  Is it appropriate for drivers to use these for
additional, HW-specific values that are then made available to the VSCREENINFO
ioctls?

If a driver does store state here, or attempt to pass info using an ioctl, the
data is promptly overwritten by fbcon during an fbcon_switch(), when it creates
a var_screeninfo struct, memsets it to zero, copies a couple fields and passes
it to fb_set_var().

I have a patch to copy the 'reserved' fields during an fbcon_switch() that
solves the problem but I'm not sure if this is the right thing to do.

-- 
Kevin Hilman
MontaVista Software -- http://www.mvista.com/



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
