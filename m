From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH] i810fb: make probe of DDC3 optional
Date: Wed, 25 Jan 2006 08:30:52 +0100
Message-ID: <20060125073052.GA7859@roarinelk.homelinux.net>
References: <20060125071718.GA7757@roarinelk.homelinux.net> <43D7278E.2030808@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F1f7H-0001qE-8I
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Jan 2006 23:30:55 -0800
Received: from fnoeppeil48.netpark.at ([217.175.205.176] helo=roarinelk.homelinux.net)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1F1f7G-0007c2-V7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Jan 2006 23:30:55 -0800
Content-Disposition: inline
In-Reply-To: <43D7278E.2030808@gmail.com>
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
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, Jan 25, 2006 at 03:23:58PM +0800, Antonino A. Daplas wrote:
> Manuel Lauss wrote:
> > Some time before 2.6.15, a third DDC channel was added to i810fb.
> > On systems where these ddc pins are not connected, the probe
> > takes about 10 seconds.
> > 
> > Introduce a config option to disable the probe on ddc channel 3.
> > Reduces boot time on my i815 laptop by 10 seconds.
> 
> Thanks.  Would a boot option be preferable than config?  Default would
> be to skip probing the 3rd bus.

of course.
 
> If you agree, I'll do the patch myself.

fine with me, thanks.

> Tony

-- 
 Manuel Lauss


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
