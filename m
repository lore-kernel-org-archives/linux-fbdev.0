From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Adding overlays
Date: Thu, 10 Feb 2005 06:56:34 -0800 (PST)
Message-ID: <20050210145634.34525.qmail@web53606.mail.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzFkH-00047R-JQ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Feb 2005 06:56:41 -0800
Received: from web53606.mail.yahoo.com ([206.190.37.39])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CzFkG-0002IO-2H
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Feb 2005 06:56:41 -0800
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi All,

I am a newbie into this overlay stuff. Let me explain
my confusion first:

1. I have a display controller hardware which support
"primary buffer window", "video1 window", "video2
window". video2 on top of -> video 1 on top of ->
primary.

Now primay buffer window is used by /dev/fb for normal
framebuffer support. 

2. Now I want to utilize overlay support given by
"video1 and 2", to have two playbacks/previews.

What should I do/use the interface to get this overlay
support given my video1 and video2 windows?? Ofcourse
I need to get around by setting lots of hardware
specific values...

1. Should I modify the frambuffer driver and adding
new ioctl to implement this overlay. 

2. Should I implement separate character device driver
and "mmap", "write" on the same?? e.g /dev/overlay1
/dev/overlay2 . 

So that a user application can give/write YUV 422 to
the driver and overlay will handle its conversion to
RGB 565 and display on the LCD in my case.

3. Should I implement /dev/video0 interace?? Here I am
confused a much, because I am already having capture
device - camera driver(v4l2), which implements the
overlay stuff for previewing while capture. Means it
supports the overlay and capture but *no* playback. 

Any pointers or drivers source code which will help me
to device strategy and the get the implementation
done. I am having working framebuffer and camera
driver. 

Let me know if you want more information. 

Thanx.

=====
---Komal Shah


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
