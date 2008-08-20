From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] i.MX Framebuffer: Cleanup Coding
 style
Date: Wed, 20 Aug 2008 19:35:43 +0200
Message-ID: <20080820193543.ba08c191.krzysztof.h1@poczta.fm>
References: <1219158403-5180-1-git-send-email-s.hauer@pengutronix.de>
	<1219158403-5180-4-git-send-email-s.hauer@pengutronix.de>
	<20080820173501.e82dbc93.krzysztof.h1@poczta.fm>
	<20080820161521.GS4713@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVrV3-0004vL-KU for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Aug 2008 10:29:37 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KVrV0-0003MJ-Aq
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Aug 2008 10:29:35 -0700
In-Reply-To: <20080820161521.GS4713@pengutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 20 Aug 2008 18:15:21 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Wed, Aug 20, 2008 at 05:35:01PM +0200, Krzysztof Helt wrote:
> > On Tue, 19 Aug 2008 17:06:42 +0200
> > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/video/imxfb.c |   78 +++++++++++++++++++++++++------------------------
> > >  1 files changed, 40 insertions(+), 38 deletions(-)
> > > 
> > 
> > I don't like some of the changes like wrapping lines
> > which are not longer than 80 characters or removing
> > alignment vs previous line because it contains spaces.
> > There are also positive CS changes so not everything is bad.
> 
> Hm, this patch only wraps lines longer than 80 characters (in one case
> it even merges two lines to one because it's still shorter than 80
> chars).

The change around line 250 wraps 80 chars line.

@@ -250,7 +249,8 @@ imxfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 
 	case FB_VISUAL_STATIC_PSEUDOCOLOR:
 	case FB_VISUAL_PSEUDOCOLOR:
-		ret = imxfb_setpalettereg(regno, red, green, blue, trans, info);
+		ret = imxfb_setpalettereg(regno, red, green, blue, trans,
+				info);
 		break;
 	}


> It also does not remove alignment vs the previous line, instead
> it aligns some lines against the previous line. 


@@ -185,7 +184,7 @@ static inline u_int chan_to_field(u_int chan, struct fb_bitfield *bf)

 static int
 imxfb_setpalettereg(u_int regno, u_int red, u_int green, u_int blue,
-                      u_int trans, struct fb_info *info)
+               u_int trans, struct fb_info *info)
 {
        struct imxfb_info *fbi = info->par;
        u_int val, ret = 1;

The removed line was previously aligned to start after the "(" in the previous line.
One could move "static int" into the same line.

You have added spaces between sizeof operator and the opening parenthesis.
It is pointed out by the checkpatch script.

> Maybe reading whitespace
> changes in patches is a bit confusing because the +/- at line starts
> mess it up.
>
 
The changes I pointed above are ones I don't like. They are not
bringing any benefit (nor better CS conformance nor readability).

However, I recognize your patch does more positive changes then these
pointed above. Also, my feelings toward some changes are my personal
opinion and I won't block the patch you have posted. I would like
to see the mentioned changes dropped but it is up to you.

Friendly regards,
Krzysztof

---------------------------------------------------------------------- 
Igrzyska na Dzikim Zachodzie!
Sprawdz >> http://link.interia.pl/f1edc 
	


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
