From: Antonino Daplas <adaplas@pol.net>
Subject: Re: vesafb problem with 1GB Ram and possible
	fix
Date: 30 Mar 2003 05:39:10 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048973887.1014.16.camel@localhost.localdomain>
References: <3E8329D2.7040909@comcast.net>
	<20030327190222.GA4060@middle.of.nowhere> <3E837ADD.9080209@comcast.net>
	<3E84B7CB.1010604@comcast.net>
	<1048910026.1000.17.camel@localhost.localdomain> 
	<3E860111.1040207@comcast.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18zO3d-0007Wt-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 29 Mar 2003 13:40:10 -0800
In-Reply-To: <3E860111.1040207@comcast.net>
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
To: Walt H <waltabbyh@comcast.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-03-30 at 04:24, Walt H wrote:
> > 
> <Patch snipped>
> 
> One question I've been wondering about with either one of these 
> approaches has to do with mode changes. I might be mistaken, but if I 
> remember correctly, video mode changes aren't supported for vesa 
> framebuffers. Would you ever need to allocate additional memory other 
> than that allocated at startup? I'm thinking that in the small tweak 
> that I did, you can perhaps not allocate enough memory for some 
> unforseen future event, although I can't think of any off hand. Then 
> again, I'm not a kernel programmer, I could be way off base here.
> 

True, vesafb does not support mode changes.  However, the extra graphics
memory is useful for some framebuffer-based applications that implement
multi-buffering. DirectFB, for instance, takes advantage of this since
it uses a frontbuffer and a backbuffer (display the frontbuffer, render
to the backbuffer, swap the front and backbuffer pointers, then display
the new frontbuffer).  Xine and mplayer using the framebuffer backend
are probably using similar setups. 

Tony  



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
