From: Fractallyte <fractallyte@csi.com>
Subject: Re: Re: Re: atyfb, console, kernel 2.6.14 & Sony Vaio C1VE
Date: Fri, 3 Mar 2006 19:04:24 +0000
Message-ID: <60b1aebf4e1937a06ebff8cd92a8f4b3@csi.com>
References: <83d4769a9bceb571796228cb5c7534c3@csi.com> <20060303150123.GA27401@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v622)
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FFFZk-0003OK-8e
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 03 Mar 2006 11:04:28 -0800
Received: from anchor-post-36.mail.demon.net ([194.217.242.86])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FFFZi-0003s9-Ur
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 03 Mar 2006 11:04:28 -0800
Received: from serendip.demon.co.uk ([80.176.90.177] helo=[192.168.0.4])
	by anchor-post-36.mail.demon.net with esmtp (Exim 4.42)
	id 1FFFZg-0009px-LY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 03 Mar 2006 19:04:24 +0000
In-Reply-To: <20060303150123.GA27401@sci.fi>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net


On 3 Mar 2006, at 15:01, Ville Syrj=E4l=E4 wrote:

>> It's only *seems* to be a success...  The console is correctly set to
>> 128x30, however the timings are apparently not passed from the BIOS =
to
>> the console driver.  =46rom this point on the screen becomes =
unreadable
>> and unusable: white blooms from the edges and spreads inward.
>
> IIRC my OmniBook 500 did the same thing in the past. I don't remember
> what (if anything) I did to fix it. I tried to fiddle around with the
> BIOS 'video expansion' option and tried passing various modes to atyfb
> but I just can't reproduce it.
>
> --=20
> Ville Syrj=E4l=E4
> syrjala@sci.fi
> http://www.sci.fi/~syrjala/

Unfortunately, the BIOS options on a Vaio C1VE are rather limited!  I'm=20=

still trying various atyfb options...

Amir=



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
