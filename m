From: Miernik <miernik@ctnet.pl>
Subject: Re: vesafb on Savage4
Date: Tue, 3 Aug 2004 12:53:20 +0000 (UTC)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <ceo1s0$7c3$1@sea.gmane.org>
References: <cenq8o$lkv$1@sea.gmane.org> <200408032022.51173.adaplas@hotpop.com>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BrynG-0004yC-KZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Aug 2004 05:53:26 -0700
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BrynG-00022e-67
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Aug 2004 05:53:26 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1BrynD-0001Mo-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 03 Aug 2004 14:53:23 +0200
Received: from citynet-gw.man.poznan.pl ([212.126.28.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 03 Aug 2004 14:53:23 +0200
Received: from miernik by citynet-gw.man.poznan.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 03 Aug 2004 14:53:23 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas <adaplas@hotpop.com> wrote:
> On Tuesday 03 August 2004 18:43, Miernik wrote:
>>
>> Aug  3 13:52:19 localhost kernel: vesafb: probe of vesafb0 failed with
>> error -6
> 
> The error is -ENXIO and in vesafb it means that your graphics card 
> failed to go to graphics mode.
> 
> Can you post your dmesg and kernel config?


http://www.miernik.ctnet.pl/problems/savage4-fb/

It finally worked, when I added
vga=0x314 video=vesa:mtrr,ywrap 
to my kernel parameters. 

With only vga=8 as a kernel parameters, and then trying
modprobe vesafb
fbset
it didn't want to work, should it?

-- 
    Miernik         ________________________   xmpp:miernik@amessage.info
___________________/__ tel: +48888299997 __/      mailto:miernik@ctnet.pl
http://www.miernik.ctnet.pl/                               GPG:0xABC292D1



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
