From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH][RIVAFB]: Updates to rivafb driver
Date: Thu, 17 Jun 2004 06:29:09 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406170629.09691.adaplas@hotpop.com>
References: <200406160406.07060.adaplas@hotpop.com> <200406161353.51195.adaplas@hotpop.com> <20040616173429.GA8601@havoc.gtf.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Baito-0007CB-PX
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 15:28:52 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Baito-0006H5-E1
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 15:28:52 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 5802E60C807
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Jun 2004 21:50:46 +0000 (UTC)
In-Reply-To: <20040616173429.GA8601@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>, adaplas@pol.net
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thursday 17 June 2004 01:34, David Eger wrote:
> On Wed, Jun 16, 2004 at 01:53:51PM +0800, Antonino A. Daplas wrote:
> > > On Wednesday 16 June 2004 06:17, David Eger wrote:
> > > > hey tony,
> > > >
> > > > your patch against drivers/video/riva/fbdev.c chokes on hunk 2 when
> > > > applied to 2.6.7-rc3-mm2.  resend, and i'll test it on my TNT2 :)
> > >
> > > Ok.  Patch against 2.6.7-rc3-mm2.
>
> Applying your rivafb and fbmode patches work great on my TNT2.
> I get a console with 160 columns and 60 rows :-)

That's great.

>
> And yes, the capabilities patch makes your driver slow.
> But setting the proper flags makes it fast again ;-)

Do you mind submitting a patch yourself?  It's probably a 1 liner patch, unless
we also modify rivafb to use cfb_* drawing functions depending on
the setting of var->accel_flags.

>
> The driver still doesn't play nice with the evil binary nvidia drivers,
> but then, that's expected.  (It'd be nice if changing from X to a console
> didn't *crash my machine* though.)
>

Yeah, even with XOrg/Free86 nv driver, it hangs.  Don't really know the exact
solution, probably a complete re-initialization of the hardware when switching from
X.  But this will require that fbcon recognizes a switch from X itself which it
currently doesn't (unless I'm mistaken).

Tony




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
