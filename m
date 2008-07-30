From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 3/5] am200epd: convert to
	shared fb and use gpio api
Date: Wed, 30 Jul 2008 10:45:01 +0800
Message-ID: <f17812d70807291945k521c0130u73a6e758a1303a77@mail.gmail.com>
References: <1217046774-13080-1-git-send-email-jayakumar.lkml@gmail.com>
	<1217046774-13080-4-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KO1gU-0002tg-Qe for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 19:45:02 -0700
Received: from qw-out-1920.google.com ([74.125.92.145])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KO1gU-0000Wb-9N
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 19:45:02 -0700
Received: by qw-out-1920.google.com with SMTP id 5so206802qwc.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 29 Jul 2008 19:45:01 -0700 (PDT)
In-Reply-To: <1217046774-13080-4-git-send-email-jayakumar.lkml@gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sat, Jul 26, 2008 at 12:32 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> The original am200epd driver was designed with bad assumptions. It
> manipulated GPSR/GPLR registers directly. It relied on direct access to the
> pxa LCDC registers which have since conflicted with commit
> ce4fb7b892a6d6c6a0f87366b26fd834d2923dd7 . This patch moves it into mach-pxa
> and overhauls it to use pxafb's fb. It now uses the generic GPIO api.

Is it possible for a separate patch for the GPIO conversion, which I'm
totally happy with. And that's going to make review and merging a bit
quicker.

Thanks.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
