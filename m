From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: Ati Mobility FireGL V5250 support?
Date: Tue, 6 Oct 2009 10:27:01 -0400
Message-ID: <a728f9f90910060727q46c96f4bsb93fe7d5ae3351d4@mail.gmail.com>
References: <20091006142017.GA31290@OpenWrt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alexdeucher@gmail.com>) id 1MvB0U-0008VB-9P
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Oct 2009 14:27:14 +0000
Received: from mail-fx0-f221.google.com ([209.85.220.221])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MvB0O-00027S-0W for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Oct 2009 14:27:14 +0000
Received: by fxm21 with SMTP id 21so3263797fxm.33
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 06 Oct 2009 07:27:02 -0700 (PDT)
In-Reply-To: <20091006142017.GA31290@OpenWrt>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, Oct 6, 2009 at 10:20 AM, Jurriaan <thunder7@xs4all.nl> wrote:
> I'm wondering who I have to send pizza, beer or flowers to to get
> support for the videocard in my Thinkpad T60p - an Ati Mobility FireGL
> V5250. X.org works flawlessly with this card (using the opensource
> driver). Compiling in radeonfb leads to a dmesg output without any
> messages, since the pci-id is missing in the source core and the card is
> not recognized.
>
> Is anybody working on this?

radeonfb doesn't support any avivo-based radeons and never will.  If
you want hi-res consoles, use the the new radeon drm with modesetting.
 It's available in 2.6.31 and supports all r1xx-r5xx radeons.  Support
for r6xx-r7xx is available in 2.6.32.

Alex

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
