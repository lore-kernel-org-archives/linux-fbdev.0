From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] i810fb: make probe of DDC3 optional
Date: Wed, 25 Jan 2006 15:23:58 +0800
Message-ID: <43D7278E.2030808@gmail.com>
References: <20060125071718.GA7757@roarinelk.homelinux.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F1f0J-0001NQ-A7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Jan 2006 23:23:43 -0800
Received: from xproxy.gmail.com ([66.249.82.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F1f0H-0005i5-SJ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Jan 2006 23:23:43 -0800
Received: by xproxy.gmail.com with SMTP id s6so27209wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 24 Jan 2006 23:23:40 -0800 (PST)
In-Reply-To: <20060125071718.GA7757@roarinelk.homelinux.net>
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
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

Manuel Lauss wrote:
> Some time before 2.6.15, a third DDC channel was added to i810fb.
> On systems where these ddc pins are not connected, the probe
> takes about 10 seconds.
> 
> Introduce a config option to disable the probe on ddc channel 3.
> Reduces boot time on my i815 laptop by 10 seconds.

Thanks.  Would a boot option be preferable than config?  Default would
be to skip probing the 3rd bus.

If you agree, I'll do the patch myself.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
