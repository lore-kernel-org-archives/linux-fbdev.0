From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Help with Aki Laukkanen's vesafbd project?
Date: Wed, 19 Mar 2003 11:32:09 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E785539.23463.8FE8545@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70] helo=mail.scitechsoft.com)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18vjIc-0003qs-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 19 Mar 2003 11:32:30 -0800
Received: from KENDALLB (adsl-63-195-13-78.dsl.chic01.pacbell.net [63.195.13.78])
	by mail.scitechsoft.com (8.12.8/8.12.5) with ESMTP id h2JJWrPD030230
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 19 Mar 2003 11:32:53 -0800
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

I am re-posting this message here that I originally posted on the kernel 
mailing list. It is probably more appropriate to discuss the details of 
this project here:

Well I managed to finally dig up the old code that Aki Laukkanen 
developed sometime in early 2000. Unfortunately Aki died sometime in 
January 2001, so his work on the vesafbd daemon and patches to the vesafb 
device driver were lost - until now.   

I would like to revive this project, and the code I received from Matan 
Ziv-Av still configures and compiles correctly on Red Hat 8.0. I need to 
patch the latest kernel vesafb driver, but I think his patch is very old 
(probably around 2.2.14 timeframe). I am grabbing the 2.2.14 code to see 
if the patch will apply to that code, and then try to port the patch to 
the latest kernel release. Which brings up the first question. What 
kernel version should I patch against? 2.4.x or 2.5.x?  

However since I am not that familiar with the patching mechanism for the 
Linux kernel, would someone more familiar with this be willing to help 
out? I would like to modify the vesafb module in the kernel to optionally 
support the vesafbd daemon if it is present on the system, if not it will 
function as it does today. If vesafbd is present, it will be used to 
provide extended features to the default VESA framebuffer console driver. 
 I would also like to generalise the daemon module a bit such that it 
does not need to be a VESA specific daemon, but could in fact contain 
it's own hardware interfacing module. For instance the daemon could use 
XFree86 loadable driver modules to implement the functions rather than 
the VESA interface code, which would also open up the option of doing 
accelerated screen blits using the existing XFree86 driver modules. Hence 
I was thinking that the name 'vesafbd' for the daemon is a misnomer and 
should probably be changed to something else like 'fbcond' or something. 
Any suggestions? Or should we just leave it as 'vesafbd' even though it 
could be updated to support more than just the VESA BIOS interface?  

Also the code I have right now for the daemon relies on the /dev/vesafb 
special file to have been created, which is used as the communication 
mechanism between the modified vesafb kernel driver and the daemon code. 
The daemon simply constantly reads from /dev/vesafb for command packets 
to process and writes the results to /dev/vesafb. Some people suggested 
in the past that a better approach might be to either use extended 
ioctl()'s to the existing /dev/fb special file, and have the kernel 
module sleep until it needs to do something, or use other polling methods 
(of which I am not familiar). I would like some guidance here as to the 
best way to implement this daemon if people think it should be changed.  

Finally, before I embark on this project, will this patch will be 
accepted into the kernel source code tree? I would hate to spend my time 
on it only to find out that the kernel developers don't like it and won't 
accept it.  

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
