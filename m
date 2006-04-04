From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Fw: [KJ][Patch] fix kbuild warning in pm2fb.o
Date: Tue, 04 Apr 2006 20:30:10 +0800
Message-ID: <443266D2.2040700@gmail.com>
References: <20060403203515.4204b459.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQkgN-0000o9-UO
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 05:30:51 -0700
Received: from pproxy.gmail.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FQkgM-0001go-Hp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 05:30:52 -0700
Received: by pproxy.gmail.com with SMTP id x66so478504pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 04 Apr 2006 05:30:47 -0700 (PDT)
In-Reply-To: <20060403203515.4204b459.akpm@osdl.org>
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
Cc: Darren Jenkins <darrenrjenkins@gmail.com>

Andrew Morton wrote:
> Maybe pm2fb_set_par() should be __devinit?

No, Darren's patch is correct.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
