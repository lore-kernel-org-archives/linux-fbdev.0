From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: Rivafb I2C problem, new patch
Date: Tue, 13 Jul 2004 09:58:12 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407130958.15483.adaplas@hotpop.com>
References: <20040712163942.672d4047.akpm@osdl.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BkCYw-0002Qg-Tl
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Jul 2004 18:58:30 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BkCYw-0008V8-Jt
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Jul 2004 18:58:30 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 88C886B1540
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 Jul 2004 01:12:48 +0000 (UTC)
In-Reply-To: <20040712163942.672d4047.akpm@osdl.org>
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net
Cc: Greg KH <greg@kroah.com>, Nicolas Boichat <nicolas@boichat.ch>

On Tuesday 13 July 2004 07:39, Andrew Morton wrote:
> Maybe Greg, or the linux-fbdev-devel denizens can comment upon
> this?
>
>
> Begin forwarded message:
>
> Date: Tue, 13 Jul 2004 01:24:02 +0200
> From: Nicolas Boichat <nicolas@boichat.ch>
> To: akpm@digeo.com
> Subject: Rivafb I2C problem, new patch
>
>
> Hello,
>
> I'm currently writing a DDC/CI tool for Linux (DDC/CI is the protocol which
> permits to modify monitor parameters without using the OSD), see
> http://www.boichat.ch/nicolas/ddcci .
>
> I use the new rivafb I2C support, but a problem appeared: the I2C bus is
> immediately deleted after the DDC2 EDID is read, but I need to access it
> from my application!
>
> I attached a patch which fixes this problem: the bus is deleted only when
> the driver is unloaded (please note that the atyfb behave like my patched
> version). Could you add it to the next -mm kernel release ?
>
> I also contacted the driver maintainer but he seems not to answer (I sent
> an e-mail to him about a week ago).

I'm not the maintainer of rivafb but I added the DDC2 support for it. The bus
was destroyed because there was no use for it after reading the EDID block,
and fbdev has no interface (yet) to re-read it again.

It doesn't matter to me whether the bus is immediately deleted or not, so the
patch is fine by me.

Tony 




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
