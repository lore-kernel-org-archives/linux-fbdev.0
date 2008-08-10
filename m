From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Bugme-new] [Bug 11258] New: fbcon cursor
 disappered after switch to 512 consolefont
Date: Sun, 10 Aug 2008 18:38:28 +0200
Message-ID: <20080810183828.d80c25bc.krzysztof.h1@poczta.fm>
References: <bug-11258-10286@http.bugzilla.kernel.org/>
	<20080806091204.25045807.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSDqf-0000Ts-JU for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Aug 2008 09:32:53 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSDqe-0004Mu-22
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Aug 2008 09:32:53 -0700
In-Reply-To: <20080806091204.25045807.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>, bunk@kernel.org
Cc: hanzelpeter@gmail.com, linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org

On Wed, 6 Aug 2008 09:12:04 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> 
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Wed,  6 Aug 2008 08:27:54 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=11258
> > 
> >            Summary: fbcon cursor disappered after switch to 512 consolefont

> 
> A regression.
> 


The patch for the issue is below. It is very similar to
Peter Hanzel's patch already posted to the bugzilla
but it honors vc_scrl_erase_char for scrolling.

Regards,
Krzysztof
----

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Adjust  and honor the vc_scrl_erase_char for
256 and 512 character fonts.

It fixes the issue with disappearing cursor during scrolling
(kernel bug #11258). The issue was reported and tracked
by Peter Hanzel.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-ref/drivers/video/console/fbcon.c linux-2.6.27/drivers/video/console/fbcon.c
--- linux-ref/drivers/video/console/fbcon.c	2008-08-09 19:00:06.000000000 +0200
+++ linux-2.6.27/drivers/video/console/fbcon.c	2008-08-09 19:04:44.000000000 +0200
@@ -2515,7 +2515,7 @@ static int fbcon_do_set_font(struct vc_d
 			c = vc->vc_video_erase_char;
 			vc->vc_video_erase_char =
 			    ((c & 0xfe00) >> 1) | (c & 0xff);
-			c = vc->vc_def_color;
+			c = vc->vc_scrl_erase_char;
 			vc->vc_scrl_erase_char =
 			    ((c & 0xFE00) >> 1) | (c & 0xFF);
 			vc->vc_attr >>= 1;
@@ -2548,7 +2548,7 @@ static int fbcon_do_set_font(struct vc_d
 			if (vc->vc_can_do_color) {
 				vc->vc_video_erase_char =
 				    ((c & 0xff00) << 1) | (c & 0xff);
-				c = vc->vc_def_color;
+				c = vc->vc_scrl_erase_char;
 				vc->vc_scrl_erase_char =
 				    ((c & 0xFF00) << 1) | (c & 0xFF);
 				vc->vc_attr <<= 1;


----------------------------------------------------------------------
Tylko dla detektywow! Konkurs na Smaker.pl
Kliknij >>> http://link.interia.pl/f1eb1


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
