From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: fbdev broken in current bk for PPC
Date: Sat, 11 Sep 2004 09:04:42 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409110904.42118.adaplas@hotpop.com>
References: <1094783022.2667.106.camel@gaston> <Pine.GSO.4.58.0409101004320.93@waterleaf.sonytel.be> <200409101635.25738.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5wKB-0007Mx-4d
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Sep 2004 18:05:07 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C5wK9-0001Uh-Iz
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Sep 2004 18:05:06 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 34F5F8083EB
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Sep 2004 01:04:57 +0000 (UTC)
In-Reply-To: <200409101635.25738.adaplas@hotpop.com>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Friday 10 September 2004 16:35, Antonino A. Daplas wrote:
>
> > > what about failing register_framebuffer for anything but offb ?
> >
> > Humm, indeed hackerish...
> >
> > But the advantage of this is that we can finally exercise the failure
> > path of many frame buffer device drivers in the wild ;-)
>
> Assuming, as I've mentioned in another thread, that info->fix.name ==
> to video=xxxfb.
>

Sorry Geert, I misinterpret.  And you are correct, but that will be scary :-)

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
