From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: aty128fb problems on iMac, kernel 2.8.1
	(fwd)
Date: Sun, 26 Sep 2004 18:27:15 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1096187234.537.303.camel@gaston>
References: <Pine.GSO.4.61.0409231022110.7127@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBUOj-0005uF-7A
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Sep 2004 01:28:45 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CBUOi-0001Or-Ga
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Sep 2004 01:28:45 -0700
In-Reply-To: <Pine.GSO.4.61.0409231022110.7127@waterleaf.sonytel.be>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Theodore Kilgore <kilgota@banach.math.auburn.edu>



> So, when I do make modules it says that it compiled the aty128fb module,
> but it gives two error messages:
> 
> mac_find_mode  undefined
> 
> and
> 
> mac_vmode_to_var  undefined.

Build the fbdev in the kernel, not as a module, there are a number of
issues with fbdev's as module, especially on Macs where offb (the
default 8 bits framebuffer) will take over, preventing you from loading
the specific ATI driver on top of it anyway.

Then, use X "ati" driver with Option "UseFBDev" "true" in the "Device"
section.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
