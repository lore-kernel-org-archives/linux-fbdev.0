From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbmem: is bootup logo broken for monochrome
 LCD ?
Date: Mon, 13 Nov 2006 14:17:58 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org>
References: <45535C08.5020607@innova-card.com> 
	<Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org>
	<cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GjcdV-0004EE-Tn for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 06:18:09 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GjcdT-0003MF-9C
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 06:18:09 -0800
In-Reply-To: <cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


>> There are quite a few bugs in the code. I have a patch I have been working
>> on for some time. The patch does the following:
>> 
>
> I'd like to give your patch a try but have some trouble to apply it
> cleanly. Care to resend it ?

Which tree are you working off ?> The patch is against linus git tree.

>> I.
>>         Merge slow_imageblit and color_imageblit into one function.
>> II.
>>         The same code works on both big endian and little endian machines
>
> Does this suppose to fix this issue I encountered:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116315548626875&w=2

This should fix the problems you reported. I tested this patch on a big 
endian and little endian framebuffer on a little endian machine.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
