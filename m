From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: [wx-dev] Linux GUI considerations
Date: Wed, 5 Feb 2003 14:03:33 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030205220333.34483.qmail@web14914.mail.yahoo.com>
References: <3E416980.2B2F85@bluewin.ch>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14914.mail.yahoo.com ([216.136.225.241])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18gXdl-0000kr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Feb 2003 14:03:33 -0800
In-Reply-To: <3E416980.2B2F85@bluewin.ch>
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
Content-Transfer-Encoding: 7bit
To: otto.wyss@bluewin.ch
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

--- Otto Wyss <otto.wyss@bluewin.ch> wrote:
> What alternatives are there?

Use OpenGL as your base API.  
http://fbdri.sourceforge.net/

Framebuffer would be used to initialize the hardware
and handle VT switches. DRM would coordinate with FB
on the VT swtiches so that X could also be run if you
want it.

OpenGL contains a fine 2D API in addition to the 3D
one everyone knows about. 


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
