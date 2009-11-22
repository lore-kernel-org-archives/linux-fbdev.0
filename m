From: Dan Carpenter <error27@gmail.com>
Subject: [patch] fix oops with no /proc
Date: Sun, 22 Nov 2009 16:21:11 +0200
Message-ID: <20091122142111.GA28155@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <error27@gmail.com>) id 1NCDJp-00005l-VZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 22 Nov 2009 14:21:37 +0000
Received: from mail-ew0-f211.google.com ([209.85.219.211])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NCDJl-0001hk-EL for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 22 Nov 2009 14:21:37 +0000
Received: by ewy3 with SMTP id 3so1683560ewy.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 22 Nov 2009 06:21:26 -0800 (PST)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: JosephChan@via.com.tw, ScottFang@viatech.com.cn

Fixed a typo:  missing *.  This would lead to a kernel oops if the kernel
was compiled without support for the /proc file system.

Found with a static checker.  Compile tested.

regards,
dan carpenter

Signed-off-by: Dan Carpenter <error27@gmail.com>

--- orig/drivers/video/via/viafbdev.c	2009-11-21 14:44:33.000000000 +0200
+++ devel/drivers/video/via/viafbdev.c	2009-11-21 14:44:43.000000000 +0200
@@ -1797,7 +1797,7 @@ static const struct file_operations viaf
 static void viafb_init_proc(struct proc_dir_entry **viafb_entry)
 {
 	*viafb_entry = proc_mkdir("viafb", NULL);
-	if (viafb_entry) {
+	if (*viafb_entry) {
 		proc_create("dvp0", 0, *viafb_entry, &viafb_dvp0_proc_fops);
 		proc_create("dvp1", 0, *viafb_entry, &viafb_dvp1_proc_fops);
 		proc_create("dfph", 0, *viafb_entry, &viafb_dfph_proc_fops);

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
