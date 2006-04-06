From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Bug in vga16fb?
Date: Fri, 07 Apr 2006 00:44:46 +0800
Message-ID: <4435457E.3010208@gmail.com>
References: <20060404204002.GB2251@localhost.localdomain> <44344950.9090703@vc.cvut.cz> <20060406073713.GA3051@localhost.localdomain> <44351E1A.8050404@gmail.com> <20060406143901.GA9683@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRXc0-0007vi-Aq
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Apr 2006 09:45:36 -0700
Received: from pproxy.gmail.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FRXc0-0005TD-81
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Apr 2006 09:45:36 -0700
Received: by pproxy.gmail.com with SMTP id o67so246338pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Apr 2006 09:45:32 -0700 (PDT)
In-Reply-To: <20060406143901.GA9683@localhost.localdomain>
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
> On Thu, Apr 06, 2006 at 09:56:42PM +0800, Antonino A. Daplas wrote:
>> Ondrej Zajicek wrote:
>>> On Thu, Apr 06, 2006 at 12:48:48AM +0200, Petr Vandrovec wrote:
>>>> Ondrej Zajicek wrote:
>>> Even if we find some possibility to autodetect what hardware does (or in
>>> case of another, non-VGA hardware using CFB4 mode) there would be
>>> problem that driver cannot say it to userspace (or generic kernel
>>> functions like cfb_imageblit). Maybe there should be some flag in
>>> type_aux specifying whether given packed pixel mode is LSB-first or
>>> MSB-first (relevant only for bpp % 8 != 0) ?
>>>
>> var->{red|green|blue|transp}.msb_right
> 
> I think that this bit says something different - ordering of bits inside
> one color component. This is OK for all VGA (MSB bit of color index is
> left), i hope.
> 
> Problem is in ordering of pixels inside a byte, which is completely
> orthogonal to bitplane.msb_right-ness.
> 
> But maybe i misunderstood of meaning of 
> var->{red|green|blue|transp}.msb_right ...
> 
> 

I know, but since it is completely unused, you can use that to tell userspace
what the format is.  Or if you want something less specific, use var->nonstd.
Or if you want to standardize, add another FB_VISUAL_* entry.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
