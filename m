From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger@gmx.at>
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 22 Oct 2004 14:57:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410221457.41542.stefandoesinger@gmx.at>
References: <88056F38E9E48644A0F562A38C64FB6003287A2A@scsmsx403.amr.corp.intel.com>
Reply-To: stefandoesinger@gmx.at
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S271318AbUJVNIH@vger.kernel.org>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6003287A2A@scsmsx403.amr.corp.intel.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Kendall Bennett <KendallB@scitechsoft.com>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

> Right now I am using call_usermodehelper() to call the
> emulator during resume and the video comes back just fine on this
> system where Ole's patch didn't work.
Can you explain me how you do this? call_usermodehelper() doesn't work =
for me=20
at resume time.

BTW, I had a look at the radeon card's resume code at 0xc000:3 and atte=
mpted=20
to implement it in a kernel module. The code is pretty simple, but it's=
 quite=20
long. My module isn't finished, it only turns off the display and reset=
s the=20
memory. I had to stop because I've a lot of things to do for school now=
=2E

Ole Rohne meant that the code is potentially dangerous because it pokes=
 around=20
with undocumented PLL registers, so I will not send it to the list: I w=
ill=20
send it only to those who explicitly ask for it.

Stefan D=F6singer
