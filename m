From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 1/7] pxafb: module
	unloading support
Date: Wed, 11 Jun 2008 21:36:04 -0700
Message-ID: <45a44e480806112136j7f96cc68ga4c92d796f64b057@mail.gmail.com>
References: <1212814166-10313-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212814166-10313-2-git-send-email-jayakumar.lkml@gmail.com>
	<18510.8821.785915.671710@ipc1.ka-ro> <484E30E6.8090204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6eXf-0003b8-0y for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Jun 2008 21:36:07 -0700
Received: from wf-out-1314.google.com ([209.85.200.172])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K6eXd-0006PG-OX
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Jun 2008 21:36:06 -0700
Received: by wf-out-1314.google.com with SMTP id 27so3430338wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 11 Jun 2008 21:36:05 -0700 (PDT)
In-Reply-To: <484E30E6.8090204@gmail.com>
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
To: Eric Miao <eric.y.miao@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk, =?ISO-8859-1?Q?Lothar_Wa=DFmann?= <LW@karo-electronics.de>

On Tue, Jun 10, 2008 at 12:44 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> Lothar Wa=DFmann wrote:
>> Jaya Kumar wrote:
>>> @@ -1587,7 +1587,7 @@ static int __init pxafb_parse_options(struct devi=
ce *dev, char *options)
>>>  static char g_options[256] __devinitdata =3D "";
>>>
>>>  #ifndef CONFIG_MODULES
>>            ^^^^^^^^^^^^^^
>>> -static int __devinit pxafb_setup_options(void)
>>> +static int __init pxafb_setup_options(void)
>>>
>> That should be '#ifndef MODULE'.
>> Otherwise support for cmdline options for the built-in driver will
>> only be enabled if the kernel is compiled without module support.
>>
>
> Yes, indeed. It requires another fix patch for this.
>

Hi Eric, Lothar,

That CONFIG_MODULES is from the pxafb code. It is not part of the
changes that I made to pxafb.

Since it is a small ifndef change, I'll go ahead and follow your
suggestion and add a separate patch to fix that issue and add it to
this series of patches. That said, I think I would like to keep this
patchset focused on resolving the am200epd/pxafb sharing issues rather
than other issues that may be there in pxafb.

Thanks,
jaya

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
