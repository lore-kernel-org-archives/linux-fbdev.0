From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i810fb: Do not probe the third i2c bus by default
Date: Sun, 29 Jan 2006 00:16:31 -0800
Message-ID: <20060129001631.597a7766.akpm@osdl.org>
References: <43DC2236.4030900@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F37jy-0003XL-9x
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 29 Jan 2006 00:16:54 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1F37jx-0007hc-PF
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 29 Jan 2006 00:16:54 -0800
In-Reply-To: <43DC2236.4030900@gmail.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, mano@roarinelk.homelinux.net

"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
> 
>  Some time before 2.6.15, a third DDC channel was added to i810fb.
>  On systems where these ddc pins are not connected, the probe
>  takes about 10 seconds.
> 
>  Add a boot/module  option for i810fb to explicitly probe for the 3rd
>  ddc bus if needed.

argh.  We really shouldn't be adding options like this.  People just won't
know that the option exists and they'll sit there wondering why their
kernel doesn't work right.  Or we invert the sense of the option and they
sit there wondering why the bootup is so slow.

Is there not any way in which to fix this so things just work?  A 10-second
timeout sounds crazy.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
