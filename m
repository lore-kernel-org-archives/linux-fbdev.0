From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: dri fb drivers [was: Re: [Linux-fbdev-devel] Rage128 and Radeon patches]
Date: Thu, 14 Aug 2003 14:45:48 -0700 (PDT)
Sender: dri-devel-admin@lists.sourceforge.net
Message-ID: <20030814214548.54199.qmail@web14903.mail.yahoo.com>
References: <20030814201854.GD7862@guug.org>
Mime-Version: 1.0
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030814201854.GD7862@guug.org>
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
> good! IMO this is the future for linux!
> i would like to see this work merged with the
> dri.sf.net folks and a unified set of drivers for 
> both fb and Xfree. Is this possible, is this your
> objective? or embedded mesa will always be an 
> standalone project...

The long term plan is for a single OpenGL shared
object that runs standalone, with DirectFB or under
XFree/DRI. There is nothing technical stopping this,
it just a matter of adjusting bunches of code. 

3D drivers from DRI work in the embedded version with
minor changes mostly having to do with removing GLX
code from the drivers. 2D is a different story.
Significant code needs to be adjusted for each driver.
I am working on the Rage128 driver currently. Radeon
and MGA are done. Nothing else has been started yet.

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
