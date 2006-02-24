From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 4/5] fbdev: Make BIOS EDID reading configurable
Date: Fri, 24 Feb 2006 13:24:40 +0800
Message-ID: <43FE9898.3030801@gmail.com>
References: <43FDA3C2.2010109@gmail.com>	<20060223163438.63ce04e8.akpm@osdl.org>	<43FE83DA.3050505@gmail.com> <20060223201030.d5a70121.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCVSG-0008An-Ca
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 21:25:24 -0800
Received: from pproxy.gmail.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FCVSE-0007vK-RD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 21:25:24 -0800
Received: by pproxy.gmail.com with SMTP id 57so278568pya
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Feb 2006 21:25:21 -0800 (PST)
In-Reply-To: <20060223201030.d5a70121.akpm@osdl.org>
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
>>> Also, is it not possible to defer this operation until we've parsed the
>>> command line, control it with a kernel boot parameter?
>>>
>> I thought of that, but it seems a bit complicated to me to parse boot
>> options in assembly so I left this for another time.
> 
> Well I'm wondering whether we can instead do this query later on, after
> we've entered start_kernel().

The query is done while machine is in real mode (in arch/i386/boot/video.S).

> 
>> The firmware EDID is only used as fallback, or if drivers have no DDC/I2C
>> support. Currently, all drivers that use the firmware EDID also have I2C
>> support in place. And chances are, if DDC transfers failed, the firmware
>> EDID will also be absent.
> 
> hm.  Don't you think `default y' would be better?  As it is, people's stuff
> will mysteriously stop working.

Hmm.  You're right, 'default y' looks better. Would you like me to send you
a patch, or would you rather take care of it?

Tony



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
