From: Walt H <waltabbyh@comcast.net>
Subject: Re: vesafb problem with 1GB Ram and possible
 fix
Date: Sun, 30 Mar 2003 15:16:29 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E877ACD.2070002@comcast.net>
References: <3E8329D2.7040909@comcast.net> <20030327190222.GA4060@middle.of.nowhere> <3E837ADD.9080209@comcast.net> <3E84B7CB.1010604@comcast.net> <1048910026.1000.17.camel@localhost.localdomain> <3E860111.1040207@comcast.net> <1048973887.1014.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [12.242.165.185] (helo=waltsathlon.localhost.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18zm2W-0002Wm-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 30 Mar 2003 15:16:36 -0800
In-Reply-To: <1048973887.1014.16.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino Daplas wrote:

> True, vesafb does not support mode changes.  However, the extra graphics
> memory is useful for some framebuffer-based applications that implement
> multi-buffering. DirectFB, for instance, takes advantage of this since
> it uses a frontbuffer and a backbuffer (display the frontbuffer, render
> to the backbuffer, swap the front and backbuffer pointers, then display
> the new frontbuffer).  Xine and mplayer using the framebuffer backend
> are probably using similar setups. 
> 
> Tony  
> 
> 

Thanks for the info Tony. Sounds like my setup wouldn't be ideal for 
mass consumption. I don't use vesafb for anything other than the 
graphical console with large number of columns and rows, so it shouldn't 
affect me. I just needed a quick hack for a fix since I got a new MP 
system with lots 'o ram and no penguins :(  It's all good now though..

-Walt



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
