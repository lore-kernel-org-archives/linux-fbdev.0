From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH 4/4] pxafb: preliminary smart panel
	interface support
Date: Tue, 8 Apr 2008 17:47:14 +0800
Message-ID: <f17812d70804080247k584ecacbvef5ee883f432aa89@mail.gmail.com>
References: <f17812d70804072107k77c2642ah23c8f2ce9535159f@mail.gmail.com>
	<20080408012359.d0a7d0c8.akpm@linux-foundation.org>
	<f17812d70804080134kaeefa59tf4dc583afcc384e7@mail.gmail.com>
	<20080408091635.GA23165@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JjAQA-0006OO-3M for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Apr 2008 02:47:18 -0700
Received: from wr-out-0506.google.com ([64.233.184.228])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JjAQ8-000374-NW
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Apr 2008 02:47:17 -0700
Received: by wr-out-0506.google.com with SMTP id c48so1558205wra.1
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 08 Apr 2008 02:47:15 -0700 (PDT)
In-Reply-To: <20080408091635.GA23165@flint.arm.linux.org.uk>
Content-Disposition: inline
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel email list <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Mack <daniel@caiaq.de>, lkml <linux-kernel@vger.kernel.org>

On Tue, Apr 8, 2008 at 5:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Apr 08, 2008 at 04:34:05PM +0800, eric miao wrote:
>
> > >From 3b14d02739b98ed8be3904914dd8b9d4a39fff25 Mon Sep 17 00:00:00 2001
>  > From: Eric Miao <eric.miao@marvell.com>
>  > Date: Mon, 7 Apr 2008 15:57:56 +0800
>  > Subject: [PATCH] pxafb: preliminary smart panel interface support
>  >
>  > Signed-off-by: Daniel Mack <daniel@caiaq.de>
>  > Acked-by: Eric Miao <eric.miao@marvell.com>
>  > ---
>  > Andrew: please see if this modified version applies: FB_PXA_SMARTPANEL
>  > defaults to "n" and removed the cast to void *, thanks    - eric
>
>  No need to add an explicit "default n" - defaulting to 'n' is the
>  default unless otherwise set.
>

Yes, indeed. I'd like to address this issue in the next patch to abstract
the output interface.

-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
