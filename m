From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 02/18] fbdev: Pan display fixes
Date: Sat, 10 Dec 2005 00:23:06 -0800
Message-ID: <20051210002306.7342f0c8.akpm@osdl.org>
References: <439A7126.7010107@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1El00r-0008DR-3z
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Dec 2005 00:23:25 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1El00p-0004OU-Pl
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Dec 2005 00:23:25 -0800
In-Reply-To: <439A7126.7010107@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
>  @@ -722,14 +722,30 @@ static void try_to_load(int fb)
>   int
>   fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
>   {
>  +	struct fb_fix_screeninfo *fix = &info->fix;
>           int xoffset = var->xoffset;
>           int yoffset = var->yoffset;
>  -        int err;
>  +        int err = 0, yres = info->var.yres;
>  +
>  +	if (var->yoffset > 0) {

Something horrid has happened to your whitespace.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
