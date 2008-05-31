From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RFC 2.6.26-rc3 1/5] pxafb: module
 unloading support
Date: Sat, 31 May 2008 08:43:46 +0200
Message-ID: <20080531084346.30ca0f2a.krzysztof.h1@poczta.fm>
References: <1212208915-24544-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212208915-24544-2-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2Kma-0008Mh-OM for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 23:41:40 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2KmZ-00061c-AZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 23:41:40 -0700
In-Reply-To: <1212208915-24544-2-git-send-email-jayakumar.lkml@gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sat, 31 May 2008 00:41:51 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> This patch to pxafb adds:
>  - exit and remove handlers
>  - changes to use __devinit/exit for probe functions and __init/exit for
>    init/exit functions
>  - removes initdata from g_options since it is accessed both at init and probe
> 

The best solution is to leave it as __devinitdata as it is accessed only by __init
and __devinit functions.
Your previous error was to change the functions to __devinit while changing
the g_options to __initdata.

Regards,
Krzysztof


----------------------------------------------------------------------
Za co Doda nienawidzi Feel?
Sprawdz >>> http://link.interia.pl/f1e0b


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
