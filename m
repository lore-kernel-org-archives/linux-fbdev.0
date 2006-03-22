From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Linux 2.6.16: Cursor trouble on Matrox Millenium
 II framebuffer
Date: Thu, 23 Mar 2006 07:25:11 +0800
Message-ID: <4421DCD7.6010908@gmail.com>
References: <20060322000855.5556.qmail@web52901.mail.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMCoY-0005M3-QH
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Mar 2006 15:32:30 -0800
Received: from pproxy.gmail.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMCoX-0001yY-7l
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Mar 2006 15:32:30 -0800
Received: by pproxy.gmail.com with SMTP id b36so246467pyb
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 22 Mar 2006 15:32:27 -0800 (PST)
In-Reply-To: <20060322000855.5556.qmail@web52901.mail.yahoo.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: vandrove@vc.cvut.cz, rankincj@yahoo.com

Chris Rankin wrote:
> Hi,
> 
> I have just booted vanilla 2.6.16, and am having trouble with the cursor on my framebuffer
> console. The cursor tracks the column correctly, but appears on a line too high up the screen.

How high? Is the offset constant?

> 
> All kernels up to 2.6.15 work correctly.

Can you try booting with video=matroxfb:noaccel?

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
