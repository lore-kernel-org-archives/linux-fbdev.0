From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: struct fb_ops functions and sleeping
Date: Sat, 15 Jul 2006 07:33:57 +0800
Message-ID: <44B829E5.6050608@gmail.com>
References: <20060714204749.GA27737@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1XGl-0003MU-O2 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Jul 2006 16:40:27 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G1XGk-0004Kr-2D
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Jul 2006 16:40:27 -0700
Received: by py-out-1112.google.com with SMTP id c31so1072829pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 14 Jul 2006 16:40:24 -0700 (PDT)
In-Reply-To: <20060714204749.GA27737@localhost.localdomain>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Ondrej Zajicek <santiago@mail.cz>

Ondrej Zajicek wrote:
> Hello
> 
> I would like to ask whether there are any rules about context in which
> functions from struct fb_ops are called, particularly whether they can
> sleep

Most of the functions can be called in process context (can sleep), except
in some unlikely cases (printing an oops).

Of all the functions in there, make sure that fb_blank() cannot sleep.

 and which functions may be called only between some fb_open
> and fb_release (for example from fbcon).

It's guaranteed that none of the functions will get called before
an fb_open() or after a successful fb_release().

Tony


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
