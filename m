From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] i810fb: make probe of DDC3 optional
Date: Thu, 26 Jan 2006 14:37:48 +0800
Message-ID: <43D86E3C.5030805@gmail.com>
References: <20060125071718.GA7757@roarinelk.homelinux.net> <43D7278E.2030808@gmail.com> <20060125073052.GA7859@roarinelk.homelinux.net> <43D72D8E.9020609@gmail.com> <20060126060356.GA9730@roarinelk.homelinux.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F20lB-0008Ik-Gl
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Jan 2006 22:37:33 -0800
Received: from xproxy.gmail.com ([66.249.82.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F20lA-0008Nv-4a
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Jan 2006 22:37:33 -0800
Received: by xproxy.gmail.com with SMTP id s6so177301wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 25 Jan 2006 22:37:30 -0800 (PST)
In-Reply-To: <20060126060356.GA9730@roarinelk.homelinux.net>
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
> On Wed, Jan 25, 2006 at 03:49:34PM +0800, Antonino A. Daplas wrote:
>> Manuel Lauss wrote:
>>> On Wed, Jan 25, 2006 at 03:23:58PM +0800, Antonino A. Daplas wrote:
>>>> Manuel Lauss wrote:
>> Can you test this patch?
>>
>> Probing for the 3rd bus needs to be done explicitly:
>>
>> video=i810fb:ddc3; or
>>
>> modprobe i810fb i810fb.ddc3=1
> 
> Works as expected. Only built-in tested, though.
> 

Thanks.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
