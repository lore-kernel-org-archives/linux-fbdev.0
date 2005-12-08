From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Frame swapping
Date: Fri, 09 Dec 2005 05:18:18 +0800
Message-ID: <4398A31A.70309@gmail.com>
References: <35786B99AB3FDC45A8215724617919736D9180@gbrwgceumf01.eu.xerox.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkTGD-0001Ou-9i
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 13:25:05 -0800
Received: from xproxy.gmail.com ([66.249.82.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EkTGA-0000ad-KN
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 13:25:05 -0800
Received: by xproxy.gmail.com with SMTP id s6so502454wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 08 Dec 2005 13:25:02 -0800 (PST)
In-Reply-To: <35786B99AB3FDC45A8215724617919736D9180@gbrwgceumf01.eu.xerox.net>
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
Cc: Clive.Jenkins@xerox.com

Jenkins, Clive wrote:
> How is frame swapping done, using the mechanisms provided
> by FB (in 2.4 and 2.6)?
> Can anyone point me to any good code examples in the
> existing FB device drivers?
> 
> ["Frame swapping" or "video page flipping" is switching
> to an alternate framebuffer memory area during the
> vertical blank period. This is a common technique to
> achieve animation or a single clean change of picture.]

Use the pan display ioctl, FBIOPAN_DISPLAY.  Basically, set
var->yres_virtual to be at least 2x var->yres so you can have
2 video buffers, one visible, one offscreen.  Then just do a
ypan ioctl to set which buffer becomes visible and which
becomes offscreen.

Doing it during vblank is a little difficult.  You can poll
the VGA registers (which is slow), or set up an interrupt
handler for the driver you are using that waits for vblank.

See www.directfb.org for code on how this can be done.  Also,
the directfb source have patches to some drivers that implements
the wating for vblank, such as in matroxfb.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
