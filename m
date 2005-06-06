From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Re: USB mouse hiccups (was RFD: Kernel
 release numbering)
Date: Mon, 6 Jun 2005 20:01:12 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0506062000510.16950@pentafluge.infradead.org>
References: <pan.2005.03.20.21.53.36.929746@brick.flying-brick.caverock.net.nz>
 <20050321202546.GA7281@flying-brick.caverock.net.nz> <20050321124426.53d75b3e.akpm@osdl.org>
 <200503220645.08821.adaplas@hotpop.com> <20050525165122.1a62e232.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfMqb-0002KP-80
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Jun 2005 12:01:17 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DfMqZ-0005xX-Bu
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Jun 2005 12:01:17 -0700
In-Reply-To: <20050525165122.1a62e232.akpm@osdl.org>
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
Cc: adaplas@pol.net, adaplas@hotpop.com, viking@flying-brick.caverock.net.nz


> > If not the same, do:
> > 
> > fbset -vyres n
> > 
> > where n: is equal to the vertical resolution
> > 
> > 2. If you still get a non-clearing display, then check if
> > CONFIG_FB_TRIDENT_ACCEL is set to y.  If it is, set it to n. Recompile and
> > reboot.
> > 
> > 3. Please send your .config, dmesg, lspci -vvv, and fbset -i.
> > 
> > 4. What is the last kernel version where tridentfb worked for you?
> > 
> > BTW, there are no major changes in tridentfb for months, so I'm surprised
> > about this regression.
> > 
> 
> Guys, is this problem still present in 2.6.12-rc5?

Anyone with a trident card out there?



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
