From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: fbmem: is bootup logo broken for monochrome
	LCD ?
Date: Mon, 13 Nov 2006 15:31:45 +0100
Message-ID: <cda58cb80611130631v1d560a2chcfcee904f6be317d@mail.gmail.com>
References: <45535C08.5020607@innova-card.com>
	<Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org>
	<cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com>
	<Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gjcqo-0005Yi-Gq for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 06:31:54 -0800
Received: from ug-out-1314.google.com ([66.249.92.175])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gjcql-0007ZA-QP
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 06:31:54 -0800
Received: by ug-out-1314.google.com with SMTP id z38so1080707ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Nov 2006 06:31:45 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org>
Content-Disposition: inline
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 11/13/06, James Simmons <jsimmons@infradead.org> wrote:
>
> >> There are quite a few bugs in the code. I have a patch I have been working
> >> on for some time. The patch does the following:
> >>
> >
> > I'd like to give your patch a try but have some trouble to apply it
> > cleanly. Care to resend it ?
>
> Which tree are you working off ?> The patch is against linus git tree.
>

I use the same tree. It seems that the patch get corrupted when it
reached me. Care to attach it next time ?

> >> I.
> >>         Merge slow_imageblit and color_imageblit into one function.
> >> II.
> >>         The same code works on both big endian and little endian machines
> >
> > Does this suppose to fix this issue I encountered:
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=116315548626875&w=2
>
> This should fix the problems you reported. I tested this patch on a big
> endian and little endian framebuffer on a little endian machine.
>

Something I'm still missing hope you can shed some light there. Why
does the current code work on Rafael's machine (little endian one
using vesa driver) but not on mine which is a little endian one as
well ?

Thanks
-- 
               Franck

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
