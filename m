From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [CONFIG_FB_NVIDIA] Mirrored characters on the console on a G5
Date: Fri, 22 Apr 2005 10:50:14 +0800
Message-ID: <200504221050.19922.adaplas@hotpop.com>
References: <1113298311.5465.159.camel@mac-francois> <200504151107.58081.adaplas@hotpop.com> <1114017690.24964.27.camel@mac-francois>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPuCy-0005Ds-VO
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 20:24:28 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DPuCx-0003mQ-8C
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 20:24:28 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id A8E00154CAA4
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Apr 2005 03:24:08 +0000 (UTC)
In-Reply-To: <1114017690.24964.27.camel@mac-francois>
Content-Disposition: inline
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
To: Francois <f.taiani@computer.org>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thursday 21 April 2005 01:21, Francois wrote:
> Hi Tony,
>
> > On Fri, 2005-04-15 at 11:07 +0800, Antonino A. Daplas wrote:
> > > > If it does, this is a problem with nvidia's imageblit function which
> > > > converts big-endian bitmaps to little endian?  Perhaps the help
> > > > reverse_order() is not needed for your arch.  Can you comment out
> > > > calls to reverse_order() in drivers/video/nvidia/nv_accel.c?
> > >
> > > I'll try this and I'll get back to you this the results.
> >
> > I'll wait, thanks.
>
> I've compiled a new kernel with those lines commented out, and this
> solves the console issue: no more mirrored characters. However the X
> display is now garbled in the same way as with the ribafb driver: it
> looks like some pixel columns are not used (fine vertical black lines
> repeated in a regular pattern (every 4 screen pixel ?)), and the whole
> screen is stretched horizontally as if an "X pixel" was represented as a
> 3x1 rectangle. If I move my mouse to the right border is re-appears on
> the left border and as I move it it overwrites the previous pixels there
> with what should be beyond the right border (as if multiple 'X pixels'
> were mapped to the same location on the screen in a kind of modulo
> operation). I can go through three and half whole horizontal screens
> like that.
>
> I guess this is quite fuzzy, but I don't know how to explain it better.
> It looks like reverse_order is not needed for in console mode but is
> needed in graphic mode. Could it make sense?

No, it does not make sense to me how reverse_order() can affect the output
of X.

Can you verify that it is really reverse_order() that affects X's output and not
if accel is on or off?

Tony
>
> Cheers
>
> Francois
>
> > On Fri, 2005-04-15 at 11:07 +0800, Antonino A. Daplas wrote:
> >
> > On Friday 15 April 2005 00:52, Francois wrote:
> > > Hi Tony,
> > >
> > > > Only characters are mirrored, and not the entire row (ie, row starts
> > > > at the left side, and not at the right)?
> > >
> > > Only the characters (so I can't look in a mirror and have a "normal"
> > > screen
> > >
> > > :-).
> > > :
> > > > Can you try fbset -accel false and see if it helps?
> > >
> > > Right on the spot! I can now switch between mirrored and not mirrored.
> >
> > You can also append this when you boot:
> >
> > video=nvidiafb:noaccel
> >
> > so you don't have to do an fbset -accel false each time.
> >
> > > > I think rivafb supports this particular chipset, but without
> > > > acceleration.
> > >
> > > Actually my X display is garbled with rivafb (with which console
> > > characters are fine). With fb_nvidia, X seems to work fine
> > > independently of whether the acceleration is switched on or off (some
> > > screen size and frequency issues needs tuning though).
> > >
> > > > If it does, this is a problem with nvidia's imageblit function which
> > > > converts big-endian bitmaps to little endian?  Perhaps the help
> > > > reverse_order() is not needed for your arch.  Can you comment out
> > > > calls to reverse_order() in drivers/video/nvidia/nv_accel.c?
> > >
> > > I'll try this and I'll get back to you this the results.
> >
> > I'll wait, thanks.
> >
> > Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
