From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Re: open messes up the screen
Date: Fri, 18 Mar 2005 05:05:09 +0800
Message-ID: <200503180505.10779.adaplas@hotpop.com>
References: <20050315150934.GA6687@tpapp.student.princeton.edu> <20050315173827.GA10301@pants.nu> <1110949031.14171.137.camel@gaston>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110949031.14171.137.camel@gaston>
Content-Disposition: inline
Resent-Message-ID: <wbNIoB.A.Md.5UfOCB@murphy>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:debian-powerpc@lists.debian.org>
List-Help: <mailto:debian-powerpc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=unsubscribe>
List-Archive: <http://lists.debian.org/debian-powerpc/>
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brad Boyer <flar@allandria.com>
Cc: Tamas K Papp <tpapp@Princeton.EDU>, Debian PPC <debian-powerpc@lists.debian.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wednesday 16 March 2005 12:57, Benjamin Herrenschmidt wrote:
> > Well, open is really openvt. It fiddles around with the console to
> > start up a program on a new virtual console. X doesn't always like
> > that, but it should work better than that. The vt change should
> > trigger X to properly cleanup the screen before the switch. I'd
> > say file a bug.
>
> It's not a VT change issue. It's an old bug of the fbcon code that
> causes opening a VT to reset the palette on the current fb even when not
> in front.
>

Can you try this patch?

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2005-03-16 07:39:24 +08:00
+++ b/drivers/video/console/fbcon.c	2005-03-18 04:58:31 +08:00
@@ -2331,6 +2331,9 @@
 	if (fbcon_is_inactive(vc, info))
 		return -EINVAL;
 
+	if (!CON_IS_VISIBLE(vc))
+		return 0;
+
 	depth = fb_get_color_depth(&info->var);
 	if (depth > 3) {
 		for (i = j = 0; i < 16; i++) {
