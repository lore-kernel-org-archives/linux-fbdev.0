From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: dri fb drivers [was: Re: [Linux-fbdev-devel] Rage128 and Radeon patches]
Date: Thu, 14 Aug 2003 11:55:51 -0700 (PDT)
Sender: dri-devel-admin@lists.sourceforge.net
Message-ID: <20030814185551.41277.qmail@web14908.mail.yahoo.com>
References: <20030814182631.GC7862@guug.org>
Mime-Version: 1.0
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030814182631.GC7862@guug.org>
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Otto Solares <solca@guug.org>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- Otto Solares <solca@guug.org> wrote:
> nice work!
> 
> i know you are working with the dri fb drivers, is
> any progress and what is the current state?

I am working on embedded Mesa, which is another name
for standalone OpenGL. Embedded Mesa is based on the
3D DRI code but it handles 2D very differently.

Xfree/DRI scans the PCI bus and initializes hardware
in it's user space process.  Embedded Mesa instead
loads the framebuffer drivers and uses them to
initialize the hardware. This makes Embedded Mesa much
simpler since it relies on the framebuffer drivers for
a lot of things such as mode switching and PCI bus
scanning.

You can get a snapshot of my work with this:
bk clone bk://mesa3d.bkbits.net/jonsmirl local_name

Standalone OpenGL works for most all Radeon chips if
you also use the updated framebuffers. Rage128 and MGA
support and being worked on but they are not ready
yet. This is development level code and it is not
ready for testing.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
