From: thunder7@xs4all.nl
Subject: Re: Ati Mobility FireGL V5250 support?
Date: Wed, 7 Oct 2009 04:25:17 +0000
Message-ID: <20091007042516.GA11282@OpenWrt>
References: <20091006142017.GA31290@OpenWrt>
	<a728f9f90910060727q46c96f4bsb93fe7d5ae3351d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <thunder7@xs4all.nl>) id 1MvO5o-0006Fc-Ca
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Oct 2009 04:25:36 +0000
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MvO5i-00050r-P1 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Oct 2009 04:25:36 +0000
Received: from rivierenland.xs4all.nl (onderneming10.xs4all.nl [80.101.89.5])
	by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with SMTP id n974POxq081442
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 7 Oct 2009 06:25:25 +0200 (CEST)
	(envelope-from thunder7@xs4all.nl)
Content-Disposition: inline
In-Reply-To: <a728f9f90910060727q46c96f4bsb93fe7d5ae3351d4@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, Oct 06, 2009 at 10:27:01AM -0400
> 
> radeonfb doesn't support any avivo-based radeons and never will.  If
> you want hi-res consoles, use the the new radeon drm with modesetting.
>  It's available in 2.6.31 and supports all r1xx-r5xx radeons.  Support
> for r6xx-r7xx is available in 2.6.32.
> 
Thanks!

It works, but I find the lack of documentation disturbing. As it is,
adding radeon.modeset=1 to the commandline switches my screen to the
correct resolution. This is partly because I have a TFT screen on this
laptop. I've not been able to find anything about changing the
resolution, so with a CRT monitor I don't know how you would go about
that.

Also, a hint or two somewhere in linux-2.6.23-rc3/Documentation/ would
be nice. At the moment, the word 'KMS' is not used in any file there. No
wonder I couldn't find it when I configured my kernel.

So far, I've seen 5 good boots and one with a hang (garbage on screen,
hanging laptop) - there's room for improvement yet.

Kind regards,
Jurriaan

-- 
It has a name, among the Voyani.
Lumina Arden. The light that burns.
You will feel its fire, Serra Diora.
	Michelle West - The Broken Crown

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
