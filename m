From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb
Date: 10 Aug 2003 22:36:06 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1060547765.595.32.camel@gaston>
References: <bgvbcu$7fa$1@main.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-6-8.w80-11.abo.wanadoo.fr ([80.11.137.8] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19lww5-0004hj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 10 Aug 2003 13:37:06 -0700
In-Reply-To: <bgvbcu$7fa$1@main.gmane.org>
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
To: Warren Turkal <wturkal@cbu.edu>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2003-08-08 at 07:11, Warren Turkal wrote:
> Does the benh patchset include any fixes for radeonfb on non-powerpc archs?
> I have a laptop with a Radeon M7 that turns the screen solid white if I use
> the fb at all. This includes the fbset or any sdl game on the console.

Try the version I merged in 2.4.22-pre and let me know.
I'll have some patches for the 2.6 version soon.

Ben.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
