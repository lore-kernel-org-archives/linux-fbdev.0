From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/8] lcd: allow lcd device to handle
 mode change events
Date: Fri, 5 Sep 2008 15:41:26 -0700
Message-ID: <20080905154126.fe3842b8.akpm@linux-foundation.org>
References: <f17812d70808290026y39163cccy2d4b1fa3b30c8625@mail.gmail.com>
	<20080831092009.69d2f56a.krzysztof.h1@poczta.fm>
	<f17812d70808311856u5ba27570kd490e05594ed455e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kbk0M-0004ZP-DD for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 15:42:14 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Kbk0L-0007kd-5P
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 15:42:14 -0700
In-Reply-To: <f17812d70808311856u5ba27570kd490e05594ed455e@mail.gmail.com>
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
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Mon, 1 Sep 2008 09:56:23 +0800
"Eric Miao" <eric.y.miao@gmail.com> wrote:

> On Sun, Aug 31, 2008 at 3:20 PM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> > On Fri, 29 Aug 2008 15:26:46 +0800
> > "Eric Miao" <eric.y.miao@gmail.com> wrote:
> >
> >> Some LCD panels are capable of different resolutions, and is allowed
> >> to change at run-time, so to make "struct lcd_device" to be able to
> >> handle mode change events here.
> >>
> >> Signed-off-by: Eric Miao <eric.miao@marvell.com>
> >> ---
> >
> > Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> >
> 
> OK, thanks. I'll queue this patch for next merge window then.
> 

It isn't in linux-next after eight days.  Where did this get queued?  

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
