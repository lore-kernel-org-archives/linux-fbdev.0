From: jsimmons@pentafluge.infradead.org
Subject: Re: Sane behavior of fbset
Date: Wed, 23 Jun 2004 20:07:36 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0406232001200.27210@pentafluge.infradead.org>
References: <200406180945.12444.adaplas@hotpop.com>
 <Pine.GSO.4.58.0406181024180.11779@waterleaf.sonytel.be>
 <Pine.LNX.4.56.0406231945150.27210@pentafluge.infradead.org>
 <Pine.GSO.4.58.0406232057230.21847@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdD5v-000655-Nj
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 12:07:39 -0700
Received: from [213.146.154.40] (helo=pentafluge.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BdD5v-000760-5d
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 12:07:39 -0700
In-Reply-To: <Pine.GSO.4.58.0406232057230.21847@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > I have no problem adding in a notifier for fbset. I don't agree with
> > adding in per VC vars. The reason is that every VC, all 64, will have a
> > copy of struct fb_var_screeninfo. That is really heavy for embedded
> > devices. Instead with a modedb we have one copy of different kinds of
> > modes. What we need to do is add valid modes that are not present in
> > modedb.
> 
> If size matters, embedded devices can always disable virtual consoles
> completely, so only one var is needed.
> 
> Furthermore, what about making the maximum number of virtual consoles
> configurable, and/or handling them dynamically (most systems have only a few of
> them in active use)?

That is a 2.7.X issue. Even still having 2 VCs meanings having two 
identical vars. That is heavy. Having that mode stored in modedb is one 
copy for both VCs.



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
