From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: video dir reorg
Date: Tue, 14 Jan 2003 09:22:36 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030114172236.69468.qmail@web14905.mail.yahoo.com>
References: <20030114091308.GA17392@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14905.mail.yahoo.com ([216.136.225.57])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18YUlo-0002nr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Jan 2003 09:22:36 -0800
In-Reply-To: <20030114091308.GA17392@iliana>
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

--- Sven Luther <luther@dpt-info.u-strasbg.fr> wrote:
> I think Linus rejected this last time James
> submitted it.

Didn't the last patch just move the DRM directory from
driver/char into the video directory.?

This could be done in two steps. First split out the
fb console driver files into their own directory and
then sort out the hardware drivers more. Then if the
DRM merge gets ok'd everything will be ready.

In the config system I don't like how you have to
enable driver support for the same piece of hardware
in two different places. I also don't like looking in
two different places for the source to drivers for the
same hardware.

What is Linus' take on merging a card's fb and drm
drivers into a single module in the long run?

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
