From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RFC 2.6.26-rc3 0/5] am200epd, pxafb,
 metronomefb changes v2
Date: Sat, 31 May 2008 08:41:25 +0200
Message-ID: <20080531084125.ae345e14.krzysztof.h1@poczta.fm>
References: <1212208915-24544-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2KkP-0008AF-5V for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 23:39:25 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2KkN-0005ui-OZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 23:39:25 -0700
In-Reply-To: <1212208915-24544-1-git-send-email-jayakumar.lkml@gmail.com>
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

On Sat, 31 May 2008 00:41:50 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> 
> Hi Eric, arm and fbdev friends,
> 
> This is version 2 of this RFC and contains the following updates:
> - skip setting g_options to __initdata since it is used both by init and
>   probe functions 
> - fix ordering of iounmap/release_mem_region
> - fix setting of smem_len (thanks to Krzysztof for above feedback)
> - make user_wfm_size static as caught by sparse 
> 

Hey, slow down. I have intended to review all your patches, but I have not had
enough time yet. Please wait till Monday.

Also, if the am200epd changes are less then say 40% of the original
driver I would prefer to see an incremental patch, not replacement of
the driver as it is not clear what was changed.

Kind regards,
Krzysztof


----------------------------------------------------------------------
Mucha powraca!
Sprawdz >>> http://link.interia.pl/f1e0d


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
