From: Eric Pretorious <eric@pretorious.net>
Subject: /usr/src/linux/Documentation/fb/aty128fb.txt
Date: Mon, 4 Oct 2004 15:03:26 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410041503.26441.eric@pretorious.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEb1z-0003le-SS
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 15:10:07 -0700
Received: from he.net ([216.218.186.2])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CEb1y-00023U-Tl
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 15:10:07 -0700
Received: from localhost ([216.218.186.2]) by he.net for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 4 Oct 2004 15:10:03 -0700
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
To: Brad Douglas <brad@neruo.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Hi, Brad:

One other nitpick: In the "Configuration" section you wrote...

>Accepted options:
>
><XxX@X>  - selects startup videomode. See modedb.txt for detailed
>           explanation. Default is 640x480x8bpp.

Should the values be enclosed - as illustrated - in brackets? (I've been 
passing the value using the "vga=0x317".) The framebuffer.txt file describes 
it like this...

>To specify a video mode at bootup, use the following boot options:
>    video=<driver>:<xres>x<yres>[-<bpp>][@refresh]

-- 
Eric P.,
Sunnyvale, CA


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
