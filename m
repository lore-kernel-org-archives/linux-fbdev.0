From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 02/18] fbdev: Pan display fixes
Date: Sat, 10 Dec 2005 22:24:53 +0800
Message-ID: <439AE535.1010608@gmail.com>
References: <439A7126.7010107@gmail.com> <20051210002306.7342f0c8.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1El5f3-0008HT-Pc
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Dec 2005 06:25:17 -0800
Received: from zproxy.gmail.com ([64.233.162.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1El5f2-0006eF-9G
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Dec 2005 06:25:17 -0800
Received: by zproxy.gmail.com with SMTP id z3so1088570nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 10 Dec 2005 06:25:10 -0800 (PST)
In-Reply-To: <20051210002306.7342f0c8.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>>  @@ -722,14 +722,30 @@ static void try_to_load(int fb)
>>   int
>>   fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
>>   {
>>  +	struct fb_fix_screeninfo *fix = &info->fix;
>>           int xoffset = var->xoffset;
>>           int yoffset = var->yoffset;
>>  -        int err;
>>  +        int err = 0, yres = info->var.yres;
>>  +
>>  +	if (var->yoffset > 0) {
> 
> Something horrid has happened to your whitespace.
> 

It's the original that is using spaces instead of tabs. I did
not notice it though until you mentioned it.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
