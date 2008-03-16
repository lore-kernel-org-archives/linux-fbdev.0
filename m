From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] uvesafb: don't treat valid modes returned by
	fb_find_mode() as errors
Date: Sun, 16 Mar 2008 12:23:38 +0100
Message-ID: <20080316112338.GA4788@spock.one.pl>
References: <20080127113456.GA17976@spock.one.pl> <20080305225412.ad1d3bb5.akpm@linux-foundation.org>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752788AbYCPLYF@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080305225412.ad1d3bb5.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Michal Januszewski <spock@gentoo.org>

Don't treat valid modes returned by fb_find_mode() (best-fit modes,
default modes or the first valid mode) as errors.

Currently, when fb_find_mode() finds a valid mode belonging to one
of the above-mentioned classes, uvesafb will ignore it and will try
to set a 640x480 video mode.  The expected behaviour (introduced by
this patch) would be to use the valid mode returned by fb_find_mode()
instead.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
As requested, this patch contains an expanded changelog message.  The
bug is by no means critical and should have no impact on the large
majority of users, so it's definitely not 2.6.24 material.

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index a14ef89..fc68b3e 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -885,7 +885,7 @@ static int __devinit uvesafb_vbe_init_mode(struct fb_info *info)
 	}
 
 	/* fb_find_mode() failed */
-	if (i == 0 || i >= 3) {
+	if (i == 0) {
 		info->var.xres = 640;
 		info->var.yres = 480;
 		mode = (struct fb_videomode *)
