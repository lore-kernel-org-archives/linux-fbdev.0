From: "Linux  PPC" <linuxppc@rediffmail.com>
Subject: bits_per_pixel query
Date: 8 Sep 2002 16:39:36 -0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020908163936.31266.qmail@webmail30.rediffmail.com>
Reply-To: "Linux  PPC" <linuxppc@rediffmail.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from webmail30.rediffmail.com ([202.54.124.145])
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17o56u-0006A1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 08 Sep 2002 09:40:33 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain;
	format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hello there,

I had some doubts regarding the framebuffer struct
usage.

As I understand, the buffer is at fb_info.screen_base
and the size of the buffer is (hres * vres *
bits_per_pixel )/8. The state of the pixel at
location (x,y), would be represented by the value of
byte at screen_base + ((y*hres + x) * bits_per_pixel)/8.

If the display is 8 bit, then it would require only
a byte to represent the value of the pixel. If it were 24 bit, 
then it would require 3 bytes, and so
on. Is that right? What would happen, to the size required for the 
buffer, if the display
requires, say 12 bits per pixel, or 18 bits?

So, if I were to set all the bytes after screen_base
uptil screen_base + (hres*vres*bits_per_pixel/8) to
zeros, then I would get a black screen. Is that right?

I'm asking cos, I'm workin on a framebuffer support
for an LCD panel, and am making the above assumption
which doesn't seem happening.

- navin.

__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
