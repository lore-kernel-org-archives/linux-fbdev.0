From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Linux 2.6.16: Cursor trouble on Matrox Millenium
 II framebuffer
Date: Fri, 24 Mar 2006 07:25:38 +0800
Message-ID: <44232E72.5090203@gmail.com>
References: <20060323231503.72390.qmail@web52906.mail.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMZCg-0003Ql-Ez
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 15:26:54 -0800
Received: from xproxy.gmail.com ([66.249.82.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMZCf-0003uN-28
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 15:26:54 -0800
Received: by xproxy.gmail.com with SMTP id t4so494437wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 15:26:05 -0800 (PST)
In-Reply-To: <20060323231503.72390.qmail@web52906.mail.yahoo.com>
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
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, vandrove@vc.cvut.cz

Chris Rankin wrote:
> --- "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>> Someone reported a similar problem, with a different driver.  It seems to be related to
>> an init script running kbd.
>> Don't bother then, just check first if it's related to an rc script running kbd.
> 
> I do have this line in my rc.S script:
> 
> loadkeys uk < /dev/console > /dev/console
> 
> However, I need this line (don't I?).

Not saying you don't :-)  However, if this particular line is really causing the
cursor problem, you can workaround it by doing an stty cols <value> rows <value>
immediately after.

In the meantime, and if you can confirm that kbd is indeed the cause, I'll try to
duplicate this and find the underlying  cause.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
