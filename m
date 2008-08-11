From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH 0/13 v2] viafb: VIA Frame Buffer
	Device Driver
Date: 11 Aug 2008 11:17:46 +0200
Message-ID: <20080811091747.045A66D605@f09.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSTXK-0005Wm-6a for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 02:17:58 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSTXI-00024T-On
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 02:17:58 -0700
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
To: "JosephChan@via.com.tw" <JosephChan@via.com.tw>, "krzysztof.h1@poczta.fm" <krzysztof.h1@poczta.fm>
Cc: "geert@linux-m68k.org" <geert@linux-m68k.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> Hi Krzysztof,
> 
> Thanks to remind, but after I checked the patches in linux-fbdev-devel
> mailing list.
> It seems there is no missing lines as you mentioned. 
> 

There are 3 lines missing at the end of each file. I assume they are empty one
so no content is missing but the command:

patch -p1 < viafb3.patch

ends with:
patch: **** malformed patch at line 259: diff -Nurp a/drivers/video/via/accel.h b/drivers/video/via/accel.h

If one adds three lines "+" at the line 259, the patch command ends with:

patching file drivers/video/via/accel.h
patch: **** malformed patch at line 446:

Adding three lines "+" at the mentioned file solves the problem.

Kind regards,
Krzysztof

----------------------------------------------------------------------
Taniej na zagraniczne komorki!
Sprawdz >>> http://link.interia.pl/f1ece


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
