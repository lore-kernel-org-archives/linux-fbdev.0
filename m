From: "Cheshire Cat Fish" <cat_fish@hotmail.com>
Subject: Re: Questions on more than one framebuffer device
Date: Wed, 14 May 2003 23:46:47 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Law15-F37Mp2nU8lg7300019065@hotmail.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from f37.law15.hotmail.com ([64.4.23.37] helo=hotmail.com)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19GCW8-00017R-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 14 May 2003 23:47:04 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net


> > I am wondering if it is even a problem with my driver now.   Xfree86 
>should
> > be able to run with multiple fbdev drivers, right?
>
>No :-( There exist a bunch of patches for this tho :-)

ugh. What patches?  Where do I get them from and how do I apply them?

Ok, here is what I have:
- Two graphics adapters, each of which supports two monitors (four screens 
total)
- a frame buffer driver that creates four frame buffer devices: /dev/fb0 and 
/dev/fb1 on the first card (PCI:0:10:0), and /dev/fb2 and /dev/fb3 on the 
second card (PCI:0:11:0).  It does this by calling "register_framebuffer" 
four times

I was hoping that I would be able to run X on these four monitors using the 
fvdev driver.  I have tried many combinations of options in my XF86Config 
file and have not hit upon the magic configuration.

I can run X on any one of the /dev/fb* devices and it works great.  As soon 
as I enable two or more things go wrong.

Now I have heard conflicting opinions on whether XFree86 and the fbdev 
driver even support such a thing...

Noel.
--
A precariously balanced mixture of myopic optimism and rampant paranoia.

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
