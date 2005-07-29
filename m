From: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: framebuffer blitting performance loss 
 2.6.12 -> 2.6.13-rc3
Date: Fri, 29 Jul 2005 00:17:35 -0700
Message-ID: <20050729001735.5934622f.akpm@osdl.org>
References: <20050715033912.1cd9b6c3.akpm@osdl.org>
	<200507221158.23454.adaplas@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyP92-0007BD-PM
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 00:19:00 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1DyP90-0005V8-AW
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 00:19:00 -0700
In-Reply-To: <200507221158.23454.adaplas@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@gmail.com, Knut_Petersen@t-online.de

"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
> On Friday 15 July 2005 18:39, Andrew Morton wrote:
> > Begin forwarded message:
> >
> > Date: Fri, 15 Jul 2005 12:14:37 +0200
> > From: Knut Petersen <Knut_Petersen@t-online.de>
> > To: linux-kernel@vger.kernel.org
> > Subject: framebuffer blitting performance loss  2.6.12 -> 2.6.13-rc3
> >
> >
> > Hi everybody!
> >
> > There is a serious performance loss between 2.6.12 and 2.6.13-rc3
> > affecting _all_ framebuffer devices, especially those with fast
> > bitblit functions.
> >
> 
> I haven't seen any significant performance penalty, between 2.6.12-rc5-mm1
> and 2.6.13-rc3-mm1.
> 
> Based on your results, I would pinpoint the culprit to be in
> video/console/bitblit.c.  However, the changes there are minor, and should not
> alter the peformance.
> 

So.. what happened here?  Is the problem still present in 2.6.13-rc4?


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
