From: Brad Douglas <brad@neruo.com>
Subject: Re: Rage1128
Date: 14 Jan 2003 13:17:03 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042579023.20959.14.camel@12-235-123-161.client.attbi.com>
References: <20030109193447.78391.qmail@web14906.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 12-235-107-98.client.attbi.com ([12.235.107.98] helo=12-235-123-161.client.attbi.com)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18YYRO-0000cp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Jan 2003 13:17:46 -0800
In-Reply-To: <20030109193447.78391.qmail@web14906.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Sorry for replying so late...

ATI does not give out initialization information about their chipsets.

They expect that we initialize by either BIOS call (x86 - This is how MS
initializes their dual displays) or probing initialization settings from
OpenFirmware on the architectures that have it.

Part of the reason is because ATI claims that each revision of the
chipset can have different initialization parameters, etc (which is
certainly possible, but has not been my experience).

I will approach developer relations again and see if they are willing to
part with more information now that they have moved on to the Radeon.

If I successfully get any information from them, I post a message to the
list...


Brad Douglas
brad@neruo.com


On Thu, 2003-01-09 at 11:34, Jon Smirl wrote:
> Does anyone on this list have a Rage128 manual? 
> 
> Can anyone point me to source code for directly
> reseting a Rage128? I already have the emulate real
> mode and call C000:3 method.
> 
> =====
> Jon Smirl
> jonsmirl@yahoo.com



-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
