From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Rage1128
Date: Tue, 14 Jan 2003 13:59:47 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030114215947.28884.qmail@web14908.mail.yahoo.com>
References: <1042579023.20959.14.camel@12-235-123-161.client.attbi.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14908.mail.yahoo.com ([216.136.225.60])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18YZ64-0000JA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Jan 2003 13:59:48 -0800
In-Reply-To: <1042579023.20959.14.camel@12-235-123-161.client.attbi.com>
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
To: Brad Douglas <brad@neruo.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

--- Brad Douglas <brad@neruo.com> wrote:
> ATI does not give out initialization information
> about their chipsets.

I got one email from them offering me the Rage128 SDK.
Since then I haven't heard anything.  I don't know if
the SDK has the needed info.

I see that the cards can vary in type and amount of
VRAM. But this info must be in the ROM or a register
somewhere.  The ROM code needs to read this info from
somewhere at boot time.  I was hoping the the
protected mode code could  get this info out of the
ROM too.

I found this at Rage Underground:
The simple answer is that you should NOT flash your
Rage128 BIOS! The reason is that there are over 50
revisions of the Rage 128 card.

Do you think ATI can provide the info needs for
writing an init routine that can handle the 50
variations? Has ATI written a unified Rage128 BIOS
that will work in all the cards? I have a hard time
imagining that they are keeping 50 separate source
code projects for the BIOS.

Another solution to this would be to modify the kernel
to initialize secondary video cards via Int10 very
early in the boot process; before it gets so hard to
get into vm86 mode. This would still leave DDC without
a solution. Has anyone tried this approach?

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
