From: Otto Solares <solca@guug.org>
Subject: Re: dri fb drivers [was: Re: Rage128 and Radeon patches]
Date: Thu, 14 Aug 2003 14:18:54 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030814201854.GD7862@guug.org>
References: <20030814182631.GC7862@guug.org> <20030814185551.41277.qmail@web14908.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030814185551.41277.qmail@web14908.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Aug 14, 2003 at 11:55:51AM -0700, Jon Smirl wrote:
> --- Otto Solares <solca@guug.org> wrote:
> > nice work!
> > 
> > i know you are working with the dri fb drivers, is
> > any progress and what is the current state?
> 
> I am working on embedded Mesa, which is another name
> for standalone OpenGL. Embedded Mesa is based on the
> 3D DRI code but it handles 2D very differently.
> 
> Xfree/DRI scans the PCI bus and initializes hardware
> in it's user space process.  Embedded Mesa instead
> loads the framebuffer drivers and uses them to
> initialize the hardware. This makes Embedded Mesa much
> simpler since it relies on the framebuffer drivers for
> a lot of things such as mode switching and PCI bus
> scanning.

good! IMO this is the future for linux!
i would like to see this work merged with the dri.sf.net
folks and a unified set of drivers for both fb and Xfree.
Is this possible, is this your objective? or embedded
mesa will always be an standalone project...

-solca



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
