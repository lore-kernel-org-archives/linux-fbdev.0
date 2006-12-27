From: "Chris Stones" <chris.stones@gmail.com>
Subject: Framebuffer newbie looking for documentation.
Date: Wed, 27 Dec 2006 02:14:05 +0000
Message-ID: <8d502f960612261814l6c219339ifa7a0c1467ef4401@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0724870309=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GzOIw-0002zG-Ab for Linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Dec 2006 18:14:06 -0800
Received: from nz-out-0506.google.com ([64.233.162.229])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GzOIv-0000gv-WD
	for Linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Dec 2006 18:14:06 -0800
Received: by nz-out-0506.google.com with SMTP id i11so2855978nzi
	for <Linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 26 Dec 2006 18:14:05 -0800 (PST)
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
To: Linux-fbdev-devel@lists.sourceforge.net

--===============0724870309==
Content-Type: multipart/alternative; 
	boundary="----=_Part_63472_13644456.1167185645451"

------=_Part_63472_13644456.1167185645451
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings.....

As this is my first post, i will intorduce myself... my name is Chris, and i
work for a small games company.
I am attempting to write a small simple 2d game engine for fairly limited
embedded x86 hardware running the linux kernel.

Unfortunatly, I am having a little trouble with the basics ( this is the
first time I have coded uside of an X11 environment )

My Problems are mainly image tearing / flickering.
Obviously I need to implement double buffering.

The First step, is  to wait for a suitable time to page flip ( VBLANC ? )

I am strugling to find documentation, but from reading linux/fb.h it seems
the only way to do this is with the FBIOGET_VBLANK ioctl.... however, for
unknown reasons, this is always returning -1 ( ERROR ! )

I'm sorry to say im a complete beginner in frame buffers, and after spending
a few hours crawling through SDL_fbvideo.c
source code, I can think of nothing else but to cower before ye' olde Frame
Buffer gods... and ask for enlightenment.

Thanks in advance for any advice / links / documentation / code snippets /
anything that may be of use to me.

Farewell.

------=_Part_63472_13644456.1167185645451
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings.....<br><br>As this is my first post, i will intorduce myself... my name is Chris, and i work for a small games company.<br>I am attempting to write a small simple 2d game engine for fairly limited embedded x86 hardware running the linux kernel.
<br><br>Unfortunatly, I am having a little trouble with the basics ( this is the first time I have coded uside of an X11 environment )<br><br>My Problems are mainly image tearing / flickering.<br>Obviously I need to implement double buffering.
<br><br>The First step, is&nbsp; to wait for a suitable time to page flip ( VBLANC ? )<br><br>I
am strugling to find documentation, but from reading linux/fb.h it
seems the only way to do this is with the FBIOGET_VBLANK ioctl....
however, for unknown reasons, this is always returning -1 ( ERROR ! )
<br><br>I&#39;m sorry to say im a complete beginner in frame buffers, and after spending a few hours crawling through SDL_fbvideo.c<br>source code, I can think of nothing else but to cower before ye&#39; olde Frame Buffer gods... and ask for enlightenment.
<br><br>Thanks in advance for any advice / links / documentation / code snippets / anything that may be of use to me.<br><br>Farewell.

------=_Part_63472_13644456.1167185645451--


--===============0724870309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0724870309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0724870309==--
