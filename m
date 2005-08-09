From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Regression: radeonfb: No synchronisation on CRT with linux-2.6.13-rc5
Date: Wed, 10 Aug 2005 01:13:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0508100113100.2027@be1.lrz>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz>  <1123195493.30257.75.camel@gaston>
  <Pine.LNX.4.58.0508051935570.2326@be1.lrz>  <1123401069.30257.102.camel@gaston>
  <3EF2003B-12DF-4EBB-B304-59614AEFAA09@mac.com>  <Pine.LNX.4.58.0508071921540.3495@be1.lrz>
  <1123451289.30257.118.camel@gaston>  <Pine.LNX.4.58.0508080158520.7822@be1.lrz>
 <1123489200.30257.133.camel@gaston> <Pine.LNX.4.58.0508092140030.2096@be1.lrz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2dIQ-00034Q-Gy
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 16:14:10 -0700
Received: from mail-in-02.arcor-online.net ([151.189.21.42])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E2dIO-0006x7-Gq
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 16:14:10 -0700
In-Reply-To: <Pine.LNX.4.58.0508092140030.2096@be1.lrz>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bodo Eggert <7eggert@gmx.de>, LKML <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Tue, 9 Aug 2005, Bodo Eggert wrote:
> On Mon, 8 Aug 2005, Benjamin Herrenschmidt wrote:
> > On Mon, 2005-08-08 at 02:06 +0200, Bodo Eggert wrote:

> > > The wrong values are constant across reboots (see my first mail), and I 
> > > have a CRT.
> > > 
> > > Can you tell me where the timing values are read?
> > 
> > radeon_write_mode() programs the mode. The monitor timing infos are read
> > by the various bits of code in radeon_monitor.c
> > 
> > I'd be curious if you could identify what bit of code is misbehaving
> 
> I added preempt_*able around radeon_probe_i2c_connector, and now I get the 
> output from below and still no sync. Obviously you shouldn't msleep in 
> preempt-disabled code. I'll try voluntary preemption, but that will at 
> best hide the error.

Update: voluntary preemption does not cause bad readings.
-- 
Who is General Failure and why is he reading my disk? 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
