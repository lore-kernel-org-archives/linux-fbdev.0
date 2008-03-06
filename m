From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: radeonfb: Please enable support for X850XT
Date: Wed, 5 Mar 2008 22:42:08 -0800
Message-ID: <20080305224208.81063f96.akpm@linux-foundation.org>
References: <20071206212809.GA8249@aragorn.home.lxtec.de>
	<68676e00712080518g6185e5d8oe74cca828d5f559d@mail.gmail.com>
	<20071209174346.GA18769@gandalf.home.lxtec.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JX9o7-0000Pk-Ex for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Mar 2008 22:42:23 -0800
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JX9o5-0006Ek-63
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Mar 2008 22:42:23 -0800
In-Reply-To: <20071209174346.GA18769@gandalf.home.lxtec.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Luca Tettamanti <kronos.it@gmail.com>


(cc's restored.  Please always do reply-to-all)

On Sun, 9 Dec 2007 18:43:46 +0100 Elimar Riesebieter <riesebie@lxtec.de> wrote:

> On Sat, 08 Dec 2007 the mental interface of
> Luca Tettamanti told:
> 
> > On Dec 6, 2007 10:28 PM, Elimar Riesebieter <riesebie@lxtec.de>
> > wrote:
> [...]
> > > So could you please tell me how support for the X850XT (AGP) can
> > > be applied?
> > 
> > Currently I rebase the patch against git-current for my own use,
> > but I really lack the time to properly cleanup, split and submit
> > for inclusion in mainline.
> 
> Attached patch applies to 2.6.23 and works with both radeonfb and
> Xorg on a X850XT. Others I can't test.
> 
> Elimar
> 
> 
> -- 
>   Numeric stability is probably not all that 
>   important when you're guessing;-)
> 
> 
> [r480.diff  text/plain (93.8KB)]

It no longer applies.  Could you please redo it against current Linux
mainline and resend, with a full changelog and signed-off-by:?  Thanks.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
