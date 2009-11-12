From: Pavel Machek <pavel@ucw.cz>
Subject: Re: drivers/video/msm: update to new kernel
Date: Thu, 12 Nov 2009 11:19:02 +0100
Message-ID: <20091112101902.GA11980@elf.ucw.cz>
References: <20091022085639.GA30548@elf.ucw.cz>
	<20091103161733.970b885f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pavel@ucw.cz>) id 1N8cXr-0002mk-PQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Nov 2009 16:29:15 +0000
Received: from artax.karlin.mff.cuni.cz ([195.113.26.195])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N8cXe-0002g8-Gg for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Nov 2009 16:29:10 +0000
Content-Disposition: inline
In-Reply-To: <20091103161733.970b885f.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Swetland <swetland@google.com>, Arve Hj?nnev?g <arve@android.com>, linux-fbdev-devel@lists.sourceforge.net, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Tue 2009-11-03 16:17:33, Andrew Morton wrote:
> On Thu, 22 Oct 2009 10:56:39 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> > TASK_INTERRUPTIBLE and friends are now only available after including
> > <linux/sched.h>, so include it when needed.
> > 
> > bus_id is no longer available/neccessary, so remove that.
> > 
> > Android pmem driver is not available in mainline, so remove its hooks
> > from drivers/video.
> > 
> 
> What is the impact of these changes?
> 
> #2 looks like it's a build fix.  #3 looks like it isn't a build fix. 
> #1 is a mystery.

Well, it now compiles. #1... I guess something changed in arm headers
and explicit include of <linux/sched.h> became neccessary. #3 not all
usages of pmem were protected with #ifdef ...PMEM, breaking
compilation. And as PMEM is not in mainline, it seemed right to just
remove it.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
