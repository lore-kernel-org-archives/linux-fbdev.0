From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 11/13 v3] viafb: viafbdev.c
Date: Wed, 27 Aug 2008 06:54:10 +0200
Message-ID: <20080827065410.d40b28a2.krzysztof.h1@poczta.fm>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB807A42C06@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYCwg-0006eB-Ft for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 21:47:50 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYCwg-0002l8-4i
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 21:47:50 -0700
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB807A42C06@exchtp03.taipei.via.com.tw>
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
To: JosephChan@via.com.tw
Cc: geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, 26 Aug 2008 17:51:47 +0800
<JosephChan@via.com.tw> wrote:

> Remove the marco MMIO_OUT32, and replace it with writel() function.
> And replace "u32" with "unsigned long" in writel() function (original 
> MMIO_OUT32 marco) for avoiding warning message in 64bit OS.
> 
> 
> Signed-off-by: Joseph Chan <josephchan@via.com.tw>
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

----------------------------------------------------------------------
Tylko u nas - swieza krew w rozsadnych cenach!
>> http://link.interia.pl/f1eed


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
