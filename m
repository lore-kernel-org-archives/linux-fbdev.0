From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] fb/intelfb: conflict with DRM_I915
	and hide by default
Date: Sat, 18 Jul 2009 13:34:34 +1000
Message-ID: <21d7e9970907172034x40cbc65emb627ebc58b91a483@mail.gmail.com>
References: <20090703112446.5a69971b@jbarnes-g45>
	<20090717171326.4a71d8e3.akpm@linux-foundation.org>
	<20090717182212.4675d0e1@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <airlied@gmail.com>) id 1MS0h8-0007r0-R8
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 18 Jul 2009 03:34:42 +0000
Received: from mail-gx0-f220.google.com ([209.85.217.220])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MS0h0-0007AJ-LN for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 18 Jul 2009 03:34:42 +0000
Received: by gxk20 with SMTP id 20so5669140gxk.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 17 Jul 2009 20:34:34 -0700 (PDT)
In-Reply-To: <20090717182212.4675d0e1@jbarnes-g45>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: airlied@linux.ie, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sat, Jul 18, 2009 at 11:22 AM, Jesse Barnes<jbarnes@virtuousgeek.org> wr=
ote:
> On Fri, 17 Jul 2009 17:13:26 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
>
>> On Fri, 3 Jul 2009 11:24:46 -0700
>> Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
>>
>> > Users get confused by this driver. =A0It's really a special purpose
>> > embedded driver, and causes a lot of problems if enabled. =A0So hide
>> > it under EMBEDDED by default, and make sure it doesn't get enabled
>> > with the i915 DRM driver.
>> >
>> > Dave, I'm hoping you can feed this to Linus through your tree. =A0It's
>> > appropriate for 2.6.31 I think.
>> >
>> > Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
>> >
>> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>> > index d6d65ef..ec12f7a 100644
>> > --- a/drivers/video/Kconfig
>> > +++ b/drivers/video/Kconfig
>> > @@ -1117,12 +1117,13 @@ config FB_CARILLO_RANCH
>> >
>> > =A0config FB_INTEL
>> > =A0 =A0 tristate "Intel
>> > 830M/845G/852GM/855GM/865G/915G/945G/945GM/965G/965GM support
>> > (EXPERIMENTAL)"
>> > - =A0 depends on EXPERIMENTAL && FB && PCI && X86 && AGP_INTEL
>> > + =A0 depends on EXPERIMENTAL && FB && PCI && X86 && AGP_INTEL
>> > && EMBEDDED select FB_MODE_HELPERS
>> > =A0 =A0 select FB_CFB_FILLRECT
>> > =A0 =A0 select FB_CFB_COPYAREA
>> > =A0 =A0 select FB_CFB_IMAGEBLIT
>> > =A0 =A0 select FB_BOOT_VESA_SUPPORT if FB_INTEL =3D y
>> > + =A0 depends on !DRM_I915
>> > =A0 =A0 help
>> > =A0 =A0 =A0 This driver supports the on-board graphics built in to
>> > the Intel
>> > 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/965G/965GM
>> > chipsets.
>>
>> Nothing happened?
>>
>> I'll merge this next week(ish) unless given a reason not to.
>
> It's in Dave's tree, pull requested to Linus already, so it should land
> soon.
>

I suspect Linus isn't pulling from me post -rc2 anymore, or maybe
he just missed it.

Dave.

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize=
  =

details at: http://p.sf.net/sfu/Challenge
