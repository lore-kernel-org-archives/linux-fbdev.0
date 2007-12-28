From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH 1/7] sm501fb: Direct color visual
	does not work
Date: Fri, 28 Dec 2007 12:21:25 +0900
Message-ID: <aec7e5c30712271921q2ab3fa35s809f83c7b3afbaf8@mail.gmail.com>
References: <1196020892591-git-send-email-syrjala@sci.fi>
	<11960208921231-git-send-email-syrjala@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J85mq-0000Ax-A0 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Dec 2007 19:21:29 -0800
Received: from hs-out-0708.google.com ([64.233.178.249]
	helo=hs-out-2122.google.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J85mo-00034J-Uw
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Dec 2007 19:21:28 -0800
Received: by hs-out-2122.google.com with SMTP id 55so2246747hsc.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 27 Dec 2007 19:21:25 -0800 (PST)
In-Reply-To: <11960208921231-git-send-email-syrjala@sci.fi>
Content-Disposition: inline
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
Cc: ben@simtec.co.uk, vince@simtec.co.uk, Ville Syrjala <syrjala@sci.fi>

On Nov 26, 2007 5:01 AM, Ville Syrjala <syrjala@sci.fi> wrote:
> The sm501fb palette code clearly does not handle direct color
> so change the driver to use true color visual for 16bpp.
>
> Signed-off-by: Ville Syrjala <syrjala@sci.fi>
Acked-by: Magnus Damm <damm@igel.co.jp>

Heh, I cooked up the _exact_ same patch a little while ago. Sorry for
the late reply.

As Ville says, it's pretty obvious that direct color is not handled in
sm501fb_setcolreg(). WIthout this patch 16bpp fbcon ends up all black
apart from just a blinking cursor. X may or may work on top of this,
but that's not the issue here. fbcon doesn't display any text without
this patch. Just boot the kernel with 16bpp mode to reproduce with
2.6.24-rc6.

Please pick up this patch. Thank you.

/ magnus

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
