From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] i810fb: Do not probe the third i2c bus by default
Date: Sun, 29 Jan 2006 18:39:44 +0800
Message-ID: <43DC9B70.3080004@gmail.com>
References: <43DC2236.4030900@gmail.com> <20060129001631.597a7766.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F39yX-00049p-42
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 29 Jan 2006 02:40:05 -0800
Received: from xproxy.gmail.com ([66.249.82.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F39yS-0002Gj-Tg
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 29 Jan 2006 02:40:02 -0800
Received: by xproxy.gmail.com with SMTP id h29so550465wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 29 Jan 2006 02:40:00 -0800 (PST)
In-Reply-To: <20060129001631.597a7766.akpm@osdl.org>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, mano@roarinelk.homelinux.net

Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>>
>>  Some time before 2.6.15, a third DDC channel was added to i810fb.
>>  On systems where these ddc pins are not connected, the probe
>>  takes about 10 seconds.
>>
>>  Add a boot/module  option for i810fb to explicitly probe for the 3rd
>>  ddc bus if needed.
> 
> argh.  We really shouldn't be adding options like this.  People just won't

Me too.

> know that the option exists and they'll sit there wondering why their
> kernel doesn't work right.  Or we invert the sense of the option and they
> sit there wondering why the bootup is so slow.

Well the 3rd i2c bus is undocumented, even by Intel. But it's supposed to
exist to allow attaching of daughter cards. I added support for this on the
prodding of Nicholas Boichat. As far as I know, nobody uses this 3rd bus.

> 
> Is there not any way in which to fix this so things just work?  A 10-second
> timeout sounds crazy.

The only way to know if this bus exists is to probe it, unfortunately. And
because it's undocumented, I don't which chipset type has it.  So anyone who
has knowledge of this undocumented feature will probably have the energy
to search for the proper boot option, or know where to mail me :-)

Tony
 




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
