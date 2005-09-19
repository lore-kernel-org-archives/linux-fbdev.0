From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: no cursor on nvidiafb console in
 2.6.14-rc1-mm1
Date: Tue, 20 Sep 2005 00:31:04 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0509200030280.611@pentafluge.infradead.org>
References: <20050919175116.GA8172@amd64.of.nowhere> <432F08C1.8010705@ppp0.net>
 <432F36B4.8030209@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHV6P-00051N-QI
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Sep 2005 16:31:13 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EHV6N-0001av-Fq
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Sep 2005 16:31:13 -0700
In-Reply-To: <432F36B4.8030209@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jan Dittmer <jdittmer@ppp0.net>, Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org


the hwcur module parameter is set to off by default. Should it be removed?

On Tue, 20 Sep 2005, Antonino A. Daplas wrote:

> Jan Dittmer wrote:
> > jurriaan wrote:
> >> After updating from 2.6.13-rc4-mm1 to 2.6.14-rc1-mm1 I see no cursor on
> >> my console.
> > 
> > Me too, 2.6.14-rc1-git4. Didn't try any kernel before with framebuffer,
> > sorry. No fb options on the kernel command line.
> > 
> 
> Can you try reversing this particular diff?
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff_plain;h=af99ea96012ec72ef57fd36655a6d8aaa22e809e;hp=30f80c23f934bb0a76719232f492153fc7cca00a
> 
> Tony
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. Download
> it for free - -and be entered to win a 42" plasma tv or your very own
> Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
