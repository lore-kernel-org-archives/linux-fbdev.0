From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: 2.5 fbdev & driver initial mode
Date: 09 Jan 2003 11:39:09 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042108748.567.20.camel@zion.wanadoo.fr>
References: <Pine.GSO.4.21.0301091029140.25052-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Wa5o-0003YZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Jan 2003 02:39:20 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA11422
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 9 Jan 2003 11:38:41 +0100 (MET)
In-Reply-To: <Pine.GSO.4.21.0301091029140.25052-100000@vervain.sonytel.be>
ReSent-To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
ReSent-Message-ID: <Pine.GSO.4.21.0301091138380.25052@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>

On Thu, 2003-01-09 at 10:30, Geert Uytterhoeven wrote:
> Note: on some platforms graphics chips with VGA cores are _not_ initialized to
> VGA mode by the firmware. So great care should be taken when not explicitly
> switching to graphics mode on those platforms.

Yup. This is typically the case of PowerMacs where the VGA memory isn't
even reachable on the PCI/AGP bus. 

Ben.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
