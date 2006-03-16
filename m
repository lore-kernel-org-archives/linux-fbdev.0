From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Framebuffer questions
Date: Fri, 17 Mar 2006 05:26:39 +0800
Message-ID: <4419D80F.9030806@gmail.com>
References: <20060315211022.GA4474@localhost.localdomain> <4418BD6A.9080600@gmail.com> <20060316101744.GA3034@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJzzZ-0002pL-Co
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Mar 2006 13:26:45 -0800
Received: from xproxy.gmail.com ([66.249.82.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FJzzY-00066K-V2
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Mar 2006 13:26:45 -0800
Received: by xproxy.gmail.com with SMTP id s6so318334wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Mar 2006 13:26:44 -0800 (PST)
In-Reply-To: <20060316101744.GA3034@localhost.localdomain>
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
Cc: santiago@mail.cz

Ondrej Zajicek wrote:
> Thank you for answers. Perhaps i found some time to write
> some API documentation.
> 
> On Thu, Mar 16, 2006 at 09:20:42AM +0800, Antonino A. Daplas wrote:
>>> - If i have to supply complete mode timings for videomode change
>>>   why there is modedb.c and mode lines stored inside drivers?
>> Usually, these entries are used only on startup. Some drivers support
>> built-in internal mode tables, some use standard algo's (GTF, CVT) to
>> compute the mode timings. With these drivers, passing xres and yres is
>> usually enough. 
> 
> So with these drivers it is not possible to set non-standard timings
> (because other timing arguments are always ignored)?

As long as the modeline is valid, drivers tend to accept them. It is only
when you passed invalid timings that drivers will

a. reject;
b. compute with GTF/CVT; or
c. get the nearest modeline from its internal table.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
