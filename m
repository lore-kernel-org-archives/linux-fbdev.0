From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Subject: Re: Fw: Re: 2.6.8.1-mm2
Date: Fri, 20 Aug 2004 14:03:23 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <2a4f155d04082004035fb045ac@mail.gmail.com>
References: <20040820012902.55fb2aa6.akpm@osdl.org> <200408201711.07677.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By7B8-0003yp-BH
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Aug 2004 04:03:26 -0700
Received: from rproxy.gmail.com ([64.233.170.198] helo=mproxy.gmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1By7B7-00025B-V7
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Aug 2004 04:03:26 -0700
Received: by mproxy.gmail.com with SMTP id v18so15819rnb
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 20 Aug 2004 04:03:23 -0700 (PDT)
In-Reply-To: <200408201711.07677.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

On Fri, 20 Aug 2004 17:11:06 +0800, Antonino A. Daplas
<adaplas@hotpop.com> wrote:
> Try using the 16-color logo instead.  The correct fix is for vesafb to correctly determine
> the true capability of the hardware instead of arbitrarily setting the color depth at 6.

Yes this works as a workaround but the code should beter be fixed.


Cheers,
ismail


-- 
Time is what you make of it


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
