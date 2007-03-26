From: David Miller <davem@davemloft.net>
Subject: Re: [Bugme-new] [Bug 8232] New: Creator3D Framebuffer (sparc64) on
 Sbus/UPA workstation
Date: Mon, 26 Mar 2007 16:12:15 -0700 (PDT)
Message-ID: <20070326.161215.74749546.davem@davemloft.net>
References: <200703191019.l2JAJVH5018137@fire-2.osdl.org>
	<20070319033425.b0be2d95.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20070319033425.b0be2d95.akpm@linux-foundation.org>
Sender: sparclinux-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: Text/Plain; charset="us-ascii"
To: akpm@linux-foundation.org
Cc: linux-fbdev-devel@lists.sourceforge.net, sparclinux@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, mt1@systella.fr

From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 19 Mar 2007 03:34:25 -0800

> On Mon, 19 Mar 2007 03:19:31 -0700 bugme-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=8232
> > 
> >            Summary: Creator3D Framebuffer (sparc64) on Sbus/UPA workstation
> >     Kernel Version: ALL 2.6
> >             Status: NEW
> >           Severity: normal
> >              Owner: jsimmons@infradead.org
> >          Submitter: mt1@systella.fr
> > 
> > 
> > Most recent kernel where this bug did *NOT* occur: 2.4.34.1
> > Distribution: Debian/testing
> > Hardware Environment: U1E/170 with Creator3D (UPA), U2 with creator3D
> > Software Environment: debian without X on U1E, debian with Xorg on U2
> > Problem Description: Console is white foreground and blanck background by
> > default. Sometimes, the screen is cut like this :
> > 
> > N | N | N | N
> > --+---+---+---
> > N | G | G | G
> > --+---+---+---
> > N | W | W | W
> > --+---+---+---
> > N | G | G | G
> > 
> > 
> > where N is a 'normal' console, 'G' a 'like grey' console (black and white pixels
> > like snow), and 'W' a white console (many white pixels). I have tested some
> > differents Creator3D fb and this trouble only occurs on Sbus/UPA workstation. On
> > a U60 (PCI/UPA), I never see it.
> > 
> > When I launch Xorg, problem goes away.

A quick audit found that we're using the ->dac_rev value before
setting it properly.  One difference between the older creator
cards and the newer ones is the DAC, so perhaps this was the
bug.

Can you test the following patch?  Thanks.  I'll fire up some of
my older systems to see if I can reproduce this one.

commit 2c4f1add7dd2747cd79c220c24e1dbc3dc4a315f
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon Mar 26 16:10:52 2007 -0700

    [FFB]: Initialize dac_rev before using it.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index 15854ae..3c01f45 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -948,8 +948,9 @@ static int ffb_init_one(struct of_device *op)
 	if ((upa_readl(&fbc->ucsr) & FFB_UCSR_ALL_ERRORS) != 0)
 		upa_writel(FFB_UCSR_ALL_ERRORS, &fbc->ucsr);
 
-	ffb_switch_from_graph(&all->par);
-
+	/* Determine the DAC revision, we must do this before calling
+	 * ffb_switch_from_graph().
+	 */
 	dac = all->par.dac;
 	upa_writel(0x8000, &dac->type);
 	all->par.dac_rev = upa_readl(&dac->value) >> 0x1c;
@@ -960,6 +961,8 @@ static int ffb_init_one(struct of_device *op)
 	if (all->par.flags & FFB_FLAG_AFB)
 		all->par.dac_rev = 10;
 
+	ffb_switch_from_graph(&all->par);
+
 	/* Unblank it just to be sure.  When there are multiple
 	 * FFB/AFB cards in the system, or it is not the OBP
 	 * chosen console, it will have video outputs off in
