From: Risto Suominen <risto.suominen@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] fb: hide cursor in graphics mode
Date: Sat, 24 Jan 2009 11:09:05 +0200
Message-ID: <46e1c7760901240109m5a0f3a85p788aa3ce35b49fa9@mail.gmail.com>
References: <46e1c7760901230433i3045f273oa109ce97e790bca3@mail.gmail.com>
	 <Pine.LNX.4.64.0901240951110.13803@anakin>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757238AbZAXJJ1@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0901240951110.13803@anakin>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

2009/1/24 Geert Uytterhoeven <geert@linux-m68k.org>:
> On Fri, 23 Jan 2009, Risto Suominen wrote:
>> Xserver Xfbdev (kdrive) uses linux framebuffer in graphics mode. It doesn't
>> need the text mode cursor, it's a bit annoying to have it there sitting in a
>> corner. This patch disables the cursor even when in graphics mode.
>>
>> Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
>> ---
>> The testing is done on kernel version 2.6.18.
>
> Which is well... quite old.
>
> Does it also (still) happen with 2.6.28?
>
Well, I don't really know, but I assume it will: fbcon_is_inactive()
still returns true if vc->vc_mode != KD_TEXT, and thus hinders
fbcon_cursor() from doing anything in graphics mode.

Risto
