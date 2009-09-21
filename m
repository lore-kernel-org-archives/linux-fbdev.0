From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] aty128fb: move block to where it
 should be in function aty128_var_to_pll
Date: Tue, 22 Sep 2009 09:51:12 +1000
Message-ID: <1253577072.7103.168.camel@pasglop>
References: <1253434454.19515.10.camel@ht.satnam>
	<1253485182.7103.30.camel@pasglop> <1253537843.3207.5.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <benh@kernel.crashing.org>) id 1MptOG-0003SG-3X
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Sep 2009 00:37:56 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MptO7-0000jy-Nq
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Sep 2009 00:37:56 +0000
In-Reply-To: <1253537843.3207.5.camel@ht.satnam>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Paul Mackerras <paulus@samba.org>

On Mon, 2009-09-21 at 18:27 +0530, Jaswinder Singh Rajput wrote:
> Indentation is not an issue if I am not breaking any lines. I am
> moving
> the function where it should be and avoid unnecessary goto(break) and
> duplicate checking 'if (i == ARRAY_SIZE(post_dividers))'.

Where it "should be" is a matter of taste :-)

> > If you really want to silence that warning, just initialize the
> value
> > 
> 
> I am trying to save some CPU cycles and you are suggesting to add some
> more ;-)

Saving CPU cycles in the mode setting code ? :-)

Anyway, Paul maintains this driver afaik so it's his call :-)

Cheers,
Ben.


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
