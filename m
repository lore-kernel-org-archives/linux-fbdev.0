From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/5] fbdev: Make BIOS EDID reading configurable
Date: Thu, 23 Feb 2006 20:10:30 -0800
Message-ID: <20060223201030.d5a70121.akpm@osdl.org>
References: <43FDA3C2.2010109@gmail.com>
	<20060223163438.63ce04e8.akpm@osdl.org>
	<43FE83DA.3050505@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCUHs-0008Cq-PW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 20:10:36 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1FCUHs-0005hy-F6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 20:10:36 -0800
In-Reply-To: <43FE83DA.3050505@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
> > 
> > Also, is it not possible to defer this operation until we've parsed the
> > command line, control it with a kernel boot parameter?
> > 
> 
> I thought of that, but it seems a bit complicated to me to parse boot
> options in assembly so I left this for another time.

Well I'm wondering whether we can instead do this query later on, after
we've entered start_kernel().

> The firmware EDID is only used as fallback, or if drivers have no DDC/I2C
> support. Currently, all drivers that use the firmware EDID also have I2C
> support in place. And chances are, if DDC transfers failed, the firmware
> EDID will also be absent.

hm.  Don't you think `default y' would be better?  As it is, people's stuff
will mysteriously stop working.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
