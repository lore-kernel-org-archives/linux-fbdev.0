From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Detecting if the mode can be changed?
Date: Tue, 18 Mar 2003 13:46:06 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E77231E.31612.452CB5F@localhost>
References: <Pine.GSO.4.21.0303171436170.17453-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70] helo=mail.scitechsoft.com)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18vOuk-0004Au-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Mar 2003 13:46:30 -0800
Received: from KENDALLB (adsl-63-195-13-78.dsl.chic01.pacbell.net [63.195.13.78])
	by mail.scitechsoft.com (8.12.8/8.12.5) with ESMTP id h2ILkqPD016342
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Mar 2003 13:46:52 -0800
In-reply-to: <1047911032.2684.79.camel@localhost.localdomain>
Content-description: Mail message body
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Hi Guys,

I am working on implementing code to use the framebuffer console, and I 
want to know in advance of calling FBIOPUT_VSCREENINFO if the screen 
resolution and color depth can actually be changed at runtime or not. If 
the VESA driver is running, this ioctl() displays an error message on the 
screen, and I want to avoid this error message by knowing in advance if 
the ioctl() will work or not.

Is there a flag or way to determine this?

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
