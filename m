From: Otto Solares <solca@guug.org>
Subject: dri fb drivers [was: Re: Rage128 and Radeon patches]
Date: Thu, 14 Aug 2003 12:26:31 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030814182631.GC7862@guug.org>
References: <20030814034338.25567.qmail@web14907.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030814034338.25567.qmail@web14907.mail.yahoo.com>
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

On Wed, Aug 13, 2003 at 08:43:38PM -0700, Jon Smirl wrote:
> Hopefully these is the last versions. They implement:
> 1) add every know PCI ID
> 2) access ROM directly instead of relying on copy in
> low RAM. This allows multiple cards. Required
> MPP_TB_CONFIG fix in driver.
> 3) implemented kernel 2.6 module parameters
> 4) Cleaned up error paths and made sure resources are
> released on errors. Both build without compiler
> warnings now. You can ins/rm mod multiple times
> without problem. Just don't do it from a window in
> your X server.
> 5) Driver marks both primary and secondary devices as
> being in use.

nice work!

i know you are working with the dri fb drivers, is any
progress and what is the current state?

-solca



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
