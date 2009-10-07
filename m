From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: Ati Mobility FireGL V5250 support?
Date: Wed, 7 Oct 2009 00:58:58 -0400
Message-ID: <a728f9f90910062158r13d648a1w2731ab32857660f9@mail.gmail.com>
References: <20091006142017.GA31290@OpenWrt>
	<a728f9f90910060727q46c96f4bsb93fe7d5ae3351d4@mail.gmail.com>
	<20091007042516.GA11282@OpenWrt>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alexdeucher@gmail.com>) id 1MvOcJ-0007bI-EZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Oct 2009 04:59:11 +0000
Received: from mail-bw0-f211.google.com ([209.85.218.211])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MvOcD-0006qi-0R for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Oct 2009 04:59:11 +0000
Received: by bwz7 with SMTP id 7so7535bwz.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 06 Oct 2009 21:58:58 -0700 (PDT)
In-Reply-To: <20091007042516.GA11282@OpenWrt>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: thunder7@xs4all.nl
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, Oct 7, 2009 at 12:25 AM,  <thunder7@xs4all.nl> wrote:
> From: Alex Deucher <alexdeucher@gmail.com>
> Date: Tue, Oct 06, 2009 at 10:27:01AM -0400
>>
>> radeonfb doesn't support any avivo-based radeons and never will. =A0If
>> you want hi-res consoles, use the the new radeon drm with modesetting.
>> =A0It's available in 2.6.31 and supports all r1xx-r5xx radeons. =A0Suppo=
rt
>> for r6xx-r7xx is available in 2.6.32.
>>
> Thanks!
>
> It works, but I find the lack of documentation disturbing. As it is,
> adding radeon.modeset=3D1 to the commandline switches my screen to the
> correct resolution. This is partly because I have a TFT screen on this
> laptop. I've not been able to find anything about changing the
> resolution, so with a CRT monitor I don't know how you would go about
> that.
>
> Also, a hint or two somewhere in linux-2.6.23-rc3/Documentation/ would
> be nice. At the moment, the word 'KMS' is not used in any file there. No
> wonder I couldn't find it when I configured my kernel.
>
> So far, I've seen 5 good boots and one with a hang (garbage on screen,
> hanging laptop) - there's room for improvement yet.

DRM modesetting support is still a bit in flux (that's why it's in
staging).  Support for changing the console fb mode was only recently
added.  It could probably use more documentation though.

Alex

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
