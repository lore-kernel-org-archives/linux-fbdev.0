From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: Re: 2.6.8.1-mm2
Date: Fri, 20 Aug 2004 17:11:06 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408201711.07677.adaplas@hotpop.com>
References: <20040820012902.55fb2aa6.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By5Qh-0006xs-Jg
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Aug 2004 02:11:23 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1By5Qg-0005YC-07
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Aug 2004 02:11:23 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E0192108A38D
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 20 Aug 2004 08:40:35 +0000 (UTC)
In-Reply-To: <20040820012902.55fb2aa6.akpm@osdl.org>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Cc: ismail =?iso-8859-1?q?d=F6nmez?= <ismail.donmez@gmail.com>

On Friday 20 August 2004 16:29, Andrew Morton wrote:
> Begin forwarded message:
>
> Date: Fri, 20 Aug 2004 11:21:27 +0300
> From: ismail d=F6nmez <ismail.donmez@gmail.com>
> To: Andrew Morton <akpm@osdl.org>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.6.8.1-mm2
>
> On Thu, 19 Aug 2004 01:42:04 -0700, Andrew Morton <akpm@osdl.org> wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2=
=2E6
> >.8.1-mm2/
>
> Minor issue but still no penguin logo on framebuffer. Config attached in
> case.

The latest fbdev changes in the mm tree differentiates between bpp and colo=
r depth.
The vesafb driver at 8 bpp has a color depth of 6 only (try fbset -i) allow=
ing only for
64 colors.  So fbdev assumes that vesafb at this depth cannot draw a 224-co=
lor
logo.

Try using the 16-color logo instead.  The correct fix is for vesafb to corr=
ectly determine
the true capability of the hardware instead of arbitrarily setting the colo=
r depth at 6.

Tony=20




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
