From: Walt H <waltabbyh@comcast.net>
Subject: Re: vesafb problem with 1GB Ram and possible
 fix
Date: Sat, 29 Mar 2003 12:24:49 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E860111.1040207@comcast.net>
References: <3E8329D2.7040909@comcast.net> <20030327190222.GA4060@middle.of.nowhere> <3E837ADD.9080209@comcast.net> <3E84B7CB.1010604@comcast.net> <1048910026.1000.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 12-229-131-201.client.attbi.com ([12.229.131.201] helo=waltsathlon.localhost.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18zMsq-0001LW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 29 Mar 2003 12:24:56 -0800
In-Reply-To: <1048910026.1000.17.camel@localhost.localdomain>
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

> I've submitted a similar patch to address problems such as the one
> you're encountering.  It just adds an extra boot option to specify
> amount of memory to remap.  Some applications will need more graphics
> memory than the minimum required to display a particular mode (such as
> for buffer flipping, offscreen caching, etc).  Attached is the message I
> sent to the list a few days ago.
> 
> Tony
> 
<Patch snipped>

One question I've been wondering about with either one of these 
approaches has to do with mode changes. I might be mistaken, but if I 
remember correctly, video mode changes aren't supported for vesa 
framebuffers. Would you ever need to allocate additional memory other 
than that allocated at startup? I'm thinking that in the small tweak 
that I did, you can perhaps not allocate enough memory for some 
unforseen future event, although I can't think of any off hand. Then 
again, I'm not a kernel programmer, I could be way off base here.

-Walt



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
