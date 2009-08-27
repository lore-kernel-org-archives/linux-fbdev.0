From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: radeonfb cannot map FB
Date: Thu, 27 Aug 2009 10:01:06 -0400
Message-ID: <a728f9f90908270701j5611a4f9p4b40cb46ddd44648@mail.gmail.com>
References: <4A92EDDB.6040806@grupopie.com> <1251280465.1379.64.camel@pasglop>
	<4A96685A.5060404@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alexdeucher@gmail.com>) id 1MgfXR-0005VD-Az
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Aug 2009 14:01:17 +0000
Received: from mail-fx0-f211.google.com ([209.85.220.211])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MgfXN-0008Sw-1X for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Aug 2009 14:01:17 +0000
Received: by fxm7 with SMTP id 7so939273fxm.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 27 Aug 2009 07:01:07 -0700 (PDT)
In-Reply-To: <4A96685A.5060404@grupopie.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Rui Santos <rsantos@grupopie.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux FB-Devel <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Aug 27, 2009 at 7:04 AM, Rui Santos<rsantos@grupopie.com> wrote:
> Benjamin Herrenschmidt wrote:
>> On Mon, 2009-08-24 at 20:45 +0100, Rui Santos wrote:
>>
>>> Dear Benjamin Herrenschmidt, dear mailing list subscribers,
>>>
>>> =A0 =A0 =A0I'm trying to load radeonfb for an RV100 QY chipset. Whateve=
r I
>>> type in the modprobe I always get:
>>> =A0 =A0 =A0 =A0radeonfb (0000:01:0c.0): cannot map FB
>>> =A0 =A0 =A0 =A0radeonfb: probe of 0000:01:0c.0 failed with error -5
>>>
>>
>> I suspect your BIOS isn't initializing the secondary card, radeonfb is
>> thus unable to use it.
>>
>> However, you probably don't need radeonfb. X.org should be able to get
>> it going as a secondary just fine, but your text consoles will have to
>> remain on the intel.
>>
>> In the long run (though it might already work with latest upstream), the
>> new radeon KMS should be able to initialize those.
>>
> Hi Ben, sorry for the late reply ( Motherboard crash),
>
> The system I'm trying to setup is an IBM SurePOS 500. It is supposed to
> work on a FB console (no X) in order to play some Videos :)
> I'm able to use a usb to vga in order to accomplish this but, using the
> integrated Radeon was preferable.
> So, you're saying that it is probably a BIOS related issue, not
> initializing the secondary Video card. Is there anyway I can make sure
> of it? If the BIOS is not initializing it properly, I may be able to
> contact IBM about it.

x86 bioses only post the primary VGA card.  For secondary cards you'll
either need to use a driver that can initialize the card itself, or
use something like vgaarb and vbetool to post the secondary card
before loading the driver.  If you would prefer to use the radeon
card, there may be an option in the bios to use the radeon card as the
primary rather than the integrated card, however, that would probably
make the integrated card unusable.

Alex

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
