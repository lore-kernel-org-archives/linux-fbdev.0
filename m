From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: monitor detection through ddc/edid stuff.
Date: Sat, 11 Sep 2004 12:52:20 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <9e4733910409110952639e654b@mail.gmail.com>
References: <20040910111627.GA14811@pegasos>
	 <20040911153625.GA3507@dreamland.darkstar.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6B6r-0000oc-FC
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Sep 2004 09:52:21 -0700
Received: from rproxy.gmail.com ([64.233.170.199] helo=mproxy.gmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C6B6q-0003dI-Ra
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Sep 2004 09:52:21 -0700
Received: by mproxy.gmail.com with SMTP id 77so179251rnl
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Sep 2004 09:52:20 -0700 (PDT)
In-Reply-To: <20040911153625.GA3507@dreamland.darkstar.lan>
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
To: linux-fbdev-devel@lists.sourceforge.net, Kronos <kronos@people.it>

On Sat, 11 Sep 2004 17:36:25 +0200, Kronos <kronos@people.it> wrote:
> Oh, radeon_probe_i2c_connector contains some "black magic" to wakeup
> some older boards/monitor. An ATI developer confirmed that it's needed
> to cover some corner case, probably you don't need that on your board.

That radeon "black magic" is not in the correct place for an I2C
driver. It's suposed to be on a different driver hook. If it was moved
it wouldn't be so messy. I've forgotten which hook it belongs on, the
conversation is in the I2C email archive.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
