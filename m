From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this one works ;-)
Date: Wed, 28 Apr 2004 08:47:55 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200404280818.49915.adaplas@pol.net>
References: <Pine.LNX.4.44.0404240035400.5826-100000@phoenix.infradead.org> <1083025364.11575.4.camel@gaston> <Pine.GSO.4.58.0404271050540.14434@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIdG3-0008OD-Su
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:49:03 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIdG3-0008WV-PU
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:49:03 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id 7D3AA70EBA
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Apr 2004 00:03:31 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.58.0404271050540.14434@waterleaf.sonytel.be>
Content-Disposition: inline
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
To: Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tuesday 27 April 2004 16:51, Geert Uytterhoeven wrote:
> On Tue, 27 Apr 2004, Benjamin Herrenschmidt wrote:
> > On Tue, 2004-04-27 at 10:19, James Simmons wrote:
> > > Okay. This is my first attempt to address this problem. There is not
> > > test for accelerated copyarea or image drawing as we lack the flag. I
> > > haven't figured where to put it yet. We have 3 choices.
> > >
> > >
> > > fb_var_screeninfo
> > > fb_fix_screeninfo
> > > fb_info
> >
> > Well... fix is what gets filled after a mode is set, let's put it in
> > there along with the linewidth etc...
>
> Indeed. BTW, no comments on my proposal to add
> fb_fix_screeninfo.capabilities?
>

Since accelerated drawing functions have no relevence whatsoever in userspace, 
placing it in fb_info is better.  But I won't disagree if it's placed in 
fb_fix_screeninfo.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
