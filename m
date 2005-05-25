From: Andrew Morton <akpm@osdl.org>
Subject: Re: Re: USB mouse hiccups (was RFD: Kernel
 release numbering)
Date: Wed, 25 May 2005 16:51:22 -0700
Message-ID: <20050525165122.1a62e232.akpm@osdl.org>
References: <pan.2005.03.20.21.53.36.929746@brick.flying-brick.caverock.net.nz>
	<20050321202546.GA7281@flying-brick.caverock.net.nz>
	<20050321124426.53d75b3e.akpm@osdl.org>
	<200503220645.08821.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Db5e5-0005wU-09
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 16:50:41 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Db5e3-0006LW-AH
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 16:50:40 -0700
In-Reply-To: <200503220645.08821.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net, viking@flying-brick.caverock.net.nz

"Antonino A. Daplas" <adaplas@hotpop.com> wrote:
>
> On Tuesday 22 March 2005 04:44, Andrew Morton wrote:
> > Guys, we seem to have a tridentfb regression in 2.6.12-rc1.
> >
> > viking <viking@flying-brick.caverock.net.nz> wrote:
> > > Also (and this is something I've noticed since I tried tridentfb) the
> > > video buffer never seems to get cleared, except when I change virtual
> > > terminals, then change back to the terminal concerned. THEN it's cleared.
> > > So for the moment, I've gone back to using VESAfb.
> >
> 
> Smells like a fillrect problem.
> 
> 1. First, can you do an fbset and make sure that yres_virtual and yres are
> the same? If you run fbset -i, in the line that starts with 'geometry', the
> 2nd and 4th number should be the same (or have a difference not more than
> 7). This disables ypan.
> 
> mode "800x600-85"
>     # D: 56.252 MHz, H: 53.676 kHz, V: 85.065 Hz
>     geometry 800 600 832 32767 8
>                  ^^^      ^^^    <- same number
> 
> If not the same, do:
> 
> fbset -vyres n
> 
> where n: is equal to the vertical resolution
> 
> 2. If you still get a non-clearing display, then check if
> CONFIG_FB_TRIDENT_ACCEL is set to y.  If it is, set it to n. Recompile and
> reboot.
> 
> 3. Please send your .config, dmesg, lspci -vvv, and fbset -i.
> 
> 4. What is the last kernel version where tridentfb worked for you?
> 
> BTW, there are no major changes in tridentfb for months, so I'm surprised
> about this regression.
> 

Guys, is this problem still present in 2.6.12-rc5?

Thanks.


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
