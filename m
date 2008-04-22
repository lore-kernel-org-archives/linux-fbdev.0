From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: deprecating fix->mmio_start and smem_start
Date: Tue, 22 Apr 2008 11:17:26 +1000
Message-ID: <1208827046.9640.73.camel@pasglop>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jo79K-0008U9-8E for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 18:18:23 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1+hAHbr0bfE/Eu5eqsbtJtvI6XHMbnqfU4=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jo79I-00028f-Ni
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 18:18:22 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>, "Antonino A. Daplas" <adaplas@gmail.com>

Hi !

We currently have a problem with those two members of struct
fb_fix_screeninfo. The struct contains an "unsigned long" which means
that:

- 64 bits kernels with 32 bits userspace can't pass a complete address
- 32 bits machines with 64 bits resource_size_t can't pass a complete
address
- The structure isn't even properly padded to be 32/64 bits neutral in
the first place.

We could define new versions of the struct with new get/set ioctls,
or we could try to just deprecate those fields. What do you guys think ?

If we do the later, we need another way to convey the informations.

For smem, I'm not sure it's very useful, we should just be able to mmap
the fbdev. The problem is more with mmio_start.

Thus the idea that we could do something to allow mmap'ing mmio via
mmap of /dev/fb via some specific offset... what do you think ?

Or we can just do a fb_fix_screeninfo2, with proper padding and u64
addresses, replace the kernel one with that, have translators for the
old ioctl's, and new ioctl's.

What do you guys think ?

Cheers,
Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
