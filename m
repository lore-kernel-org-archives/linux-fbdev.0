From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] [Resend] fbcon : fix color
 generation for monochrome framebuffer
Date: Thu, 31 Jan 2008 14:18:56 -0800
Message-ID: <20080131141856.1cdcbdfb.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0801281052480.4385@lxtpfaff.pcs.ditec.de>
	<20080131140701.b584430e.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKhkS-0003Pg-DO for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jan 2008 14:19:08 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JKhkR-0001hL-3S
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jan 2008 14:19:08 -0800
In-Reply-To: <20080131140701.b584430e.akpm@linux-foundation.org>
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
To: tpfaff@pcs.com, adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net

On Thu, 31 Jan 2008 14:07:01 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> I'll queue the pastch up for testing as-is, but would like a de-macroed,
> de-inlined version please.

Please also pass the resulting patch through scripts/checkpatch.pl.  This
version generated 23 checkpatch errors.

Also, for some reason the patch didn't apply with `patch -p1': 100%
rejects.  It applied OK with patch's "-l" option.  I didn't investigate why
this happened, but I guess it's your email client playing games.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
