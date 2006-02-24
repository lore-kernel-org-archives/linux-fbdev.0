From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 4/5] fbdev: Make BIOS EDID reading configurable
Date: Fri, 24 Feb 2006 11:56:10 +0800
Message-ID: <43FE83DA.3050505@gmail.com>
References: <43FDA3C2.2010109@gmail.com> <20060223163438.63ce04e8.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCXvj-0007dE-0G
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Feb 2006 00:03:59 -0800
Received: from pproxy.gmail.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FCXvh-0007CO-OB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Feb 2006 00:03:59 -0800
Received: by pproxy.gmail.com with SMTP id s49so310075pyc
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Feb 2006 00:03:56 -0800 (PST)
In-Reply-To: <20060223163438.63ce04e8.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>> DDC reading via the Video BIOS may take several tens of seconds with
>>  some combination of display cards and monitors.
>>
>>  Make this option configurable and select only for drivers that need it.
> 
> But that's not what the patch actually does - it requires that the user
> select the option.

You got me there :-).  Initially, I had:

select FB_FIRMWARE_EDID if ...

in Kconfig on selected drivers, but in the end removed it.  And, I forgot
to change the changelog.

The reason I removed the "select ..." part is because the user won't be
able to deselect this option.
 
> 
> Also, is it not possible to defer this operation until we've parsed the
> command line, control it with a kernel boot parameter?
> 

I thought of that, but it seems a bit complicated to me to parse boot
options in assembly so I left this for another time.

The firmware EDID is only used as fallback, or if drivers have no DDC/I2C
support. Currently, all drivers that use the firmware EDID also have I2C
support in place. And chances are, if DDC transfers failed, the firmware
EDID will also be absent.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
