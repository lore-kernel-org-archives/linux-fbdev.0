From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [RFC] double buffering for atmel_lcdfb
Date: Thu, 7 Aug 2008 12:48:41 +0200
Message-ID: <20080807124841.50fbd9eb@hskinnemo-gx745.norway.atmel.com>
References: <200808061136.16783.stf_xl@wp.pl>
	<20080806141305.49e883a2@hskinnemo-gx745.norway.atmel.com>
	<200808061553.03706.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KR337-0002D3-Ft for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 03:48:53 -0700
Received: from smtpeu1.atmel.com ([195.65.72.27] helo=bagnes.atmel.com)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1KR335-0002bD-UD
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 03:48:53 -0700
In-Reply-To: <200808061553.03706.stf_xl@wp.pl>
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
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net

Stanislaw Gruszka <stf_xl@wp.pl> wrote:
> I think some video memory allocation control is also needed for users which 
> want to have frame buffer in main memory (this is a must with bigger LCDs)
> Currently I just increase smem_len just before dma_alloc_writecombine() is called.  

I think your patch makes sense, but I suspect we also need to check
that the user-requested mode is actually possible given the amount of
memory available. That can be a separate patch though.

If you resubmit with a proper signed-off-by line, feel free to add

Acked-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
