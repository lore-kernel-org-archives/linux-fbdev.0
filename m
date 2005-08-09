From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Regression: radeonfb: No synchronisation on CRT with linux-2.6.13-rc5
Date: Tue, 9 Aug 2005 22:13:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0508092140030.2096@be1.lrz>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz>  <1123195493.30257.75.camel@gaston>
  <Pine.LNX.4.58.0508051935570.2326@be1.lrz>  <1123401069.30257.102.camel@gaston>
  <3EF2003B-12DF-4EBB-B304-59614AEFAA09@mac.com>  <Pine.LNX.4.58.0508071921540.3495@be1.lrz>
  <1123451289.30257.118.camel@gaston>  <Pine.LNX.4.58.0508080158520.7822@be1.lrz>
 <1123489200.30257.133.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2c99-0006Ol-8V
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 15:00:31 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E2c99-0004kE-4M
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 15:00:31 -0700
Received: from mail-in-04.arcor-online.net ([151.189.21.44])
	by externalmx-1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1E2aW5-0002ER-DF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 13:16:06 -0700
In-Reply-To: <1123489200.30257.133.camel@gaston>
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

On Mon, 8 Aug 2005, Benjamin Herrenschmidt wrote:
> On Mon, 2005-08-08 at 02:06 +0200, Bodo Eggert wrote:

> > The wrong values are constant across reboots (see my first mail), and I 
> > have a CRT.
> > 
> > Can you tell me where the timing values are read?
> 
> radeon_write_mode() programs the mode. The monitor timing infos are read
> by the various bits of code in radeon_monitor.c
> 
> I'd be curious if you could identify what bit of code is misbehaving

I added preempt_*able around radeon_probe_i2c_connector, and now I get the 
output from below and still no sync. Obviously you shouldn't msleep in 
preempt-disabled code. I'll try voluntary preemption, but that will at 
best hide the error.

Maybe I can mess with the msleep()s like thorndike's cat, but any success 
will be an accident.

Aug  9 20:58:26 be1 __mod_timer+0xb4/0x100
Aug  9 20:58:27 be1  [<c04019b1>] schedule_timeout+0x51/0xa0
Aug  9 20:58:27 be1  [<c011ff60>] process_timeout+0x0/0x10
Aug  9 20:58:27 be1  [<c012031f>] msleep+0x2f/0x40
Aug  9 20:58:27 be1  [<c02a3aca>] radeon_probe_i2c_connector+0xaa/0x320
Aug  9 20:58:27 be1  [<c02a1da2>] radeon_probe_screens+0x482/0x5d0
Aug  9 20:58:27 be1  [<c0298689>] radeonfb_pci_register+0x309/0x570
...
Aug  9 20:58:27 be1 scheduling while atomic: swapper/0x00000001/1
Aug  9 20:58:27 be1  [<c0400ed9>] schedule+0x589/0x640
Aug  9 20:58:27 be1  [<c011f492>] lock_timer_base+0x32/0x70
Aug  9 20:58:27 be1  [<c011f584>] __mod_timer+0xb4/0x100
Aug  9 20:58:27 be1  [<c04019b1>] schedule_timeout+0x51/0xa0
Aug  9 20:58:27 be1  [<c011ff60>] process_timeout+0x0/0x10
Aug  9 20:58:27 be1  [<c012031f>] msleep+0x2f/0x40
Aug  9 20:58:27 be1  [<c02a3aca>] radeon_probe_i2c_connector+0xaa/0x320
Aug  9 20:58:27 be1  [<c02a1da2>] radeon_probe_screens+0x482/0x5d0
Aug  9 20:58:27 be1  [<c0298689>] radeonfb_pci_register+0x309/0x570
Aug  9 20:58:27 be1  [<c0281318>] __pci_device_probe+0x48/0x60



-- 
It is still called paranoia when they really are out to get you.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
