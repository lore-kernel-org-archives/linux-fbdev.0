From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Enumerating available display modes?
Date: Tue, 18 Mar 2003 15:50:00 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E774028.13863.4C43924@localhost>
References: <1047911032.2684.79.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70] helo=mail.scitechsoft.com)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18vQqf-0006iX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Mar 2003 15:50:25 -0800
Received: from KENDALLB (adsl-63-195-13-78.dsl.chic01.pacbell.net [63.195.13.78])
	by mail.scitechsoft.com (8.12.8/8.12.5) with ESMTP id h2INojPD018078
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Mar 2003 15:50:45 -0800
In-reply-to: <3E77231E.31612.452CB5F@localhost>
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

Hi Again,

In working with the framebuffer console interface, it does not appear to 
support enumerating what display modes are available to be set via the 
/dev/fb interface. Am I right in thinking this, or am I missing something 
in the API? I am going to take a look at the source code, but some high 
level programming information would be well received at this end ;-)

Also I can't seem to find any code related to acceleration via /dev/fb. 
Is this not possible for user land apps to call the acceleration 
functions in /dev/fb? I guess I can check the XFree86 module to see how 
it does it....

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
