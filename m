From: Andrew Morton <akpm@linux-foundation.org>
Subject: Fw: [Bugme-new] [Bug 8129] New:
 kyrofb_check_var misses x-resolution and y-resolution setting?
Date: Sun, 4 Mar 2007 22:21:19 -0800
Message-ID: <20070304222119.13da738b.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HO6ZX-0004sc-HD for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Mar 2007 22:21:23 -0800
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1HO6ZV-0003SN-V8
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Mar 2007 22:21:23 -0800
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l256LKq8011096
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 4 Mar 2007 22:21:20 -0800
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l256LJ0p011547
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 4 Mar 2007 22:21:19 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net



Begin forwarded message:

Date: Sun, 4 Mar 2007 22:12:42 -0800
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 8129] New: kyrofb_check_var misses x-resolution and y-resolution setting?


http://bugzilla.kernel.org/show_bug.cgi?id=8129

           Summary: kyrofb_check_var misses x-resolution and y-resolution
                    setting?
    Kernel Version: Linux 2.6.20
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: shanlu@cs.uiuc.edu


Distribution: Linux 2.6.20
Problem Description:

kyrofb_check_var (the function supposed to set up based video mode) seems to
forget set two framebuffer parameters: x-resolution and y-resolution.

The function is in File drivers/video/kyro/fbdev.c
399 static int kyrofb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
400 {
401  	struct kyrofb_info *par = info->par;
...

In above function, almost every display-related fields (upper-margin,
left-margin, sync, etc.) are set for var based on info->par. But var->x_res and
var->y_res (x-resolution and y-resolution) are not. Why not use par->XRES and
par->YRES to set it?

Also the par->X_RES and par->Y_RES do get set in kyrofb_set_par (in the same
file), together with other field like par->HFP (right margin), HBP
(left_margin). I think check_var should take x,y-resolution from par.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
