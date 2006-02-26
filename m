From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: Re: atyfb, console, kernel 2.6.14 & Sony
 Vaio C1VE
Date: Mon, 27 Feb 2006 05:07:05 +0800
Message-ID: <44021879.7040806@gmail.com>
References: <83d4769a9bceb571796228cb5c7534c3@csi.com> <43FF7797.7040403@gmail.com> <2b6bda73c1ef8b8d6463bbe2de83a431@csi.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FDT79-0005EU-HT
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Feb 2006 13:07:35 -0800
Received: from wproxy.gmail.com ([64.233.184.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FDT79-00009r-2X
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Feb 2006 13:07:35 -0800
Received: by wproxy.gmail.com with SMTP id 50so697481wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 26 Feb 2006 13:07:33 -0800 (PST)
In-Reply-To: <2b6bda73c1ef8b8d6463bbe2de83a431@csi.com>
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
To: Fractallyte <fractallyte@csi.com>
Cc: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fractallyte wrote:

Putting back Ville and fbdev-devel back on the CC list.

> Thanks for the quick reply!
> 
> I tried what you suggested, but it has no effect.  The interesting thing
> is that the BIOS timings and geometry work perfectly in Xorg.  I've
> tried using SVGATextMode and FBSet using these values, but neither works.
> 
> Could it be that the display is correct (it fills up the screen, after
> all - just stretched out), but the console just doesn't recognise it?

I doubt it.  If you can run X over fbdev and you get a perfect display,
then I would agree with you that this is a bug in the console code.
 
> On 24 Feb 2006, at 21:16, Antonino A. Daplas wrote:
>>
>> Too many Mobility's that need xclk=62.  Try booting with:
>>
>> video=atyfb:xclk:62
>>
>> Tony
>>
>>
> 
> Thanks!
> 
> Amir
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
